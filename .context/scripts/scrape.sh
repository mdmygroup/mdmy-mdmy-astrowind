#!/usr/bin/env zsh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to extract domain from URL
extract_domain() {
    local url="$1"
    # Remove protocol
    domain=$(echo "$url" | sed -e 's|^[^/]*//||' -e 's|/.*$||')
    # Remove port if present
    domain=$(echo "$domain" | sed 's/:.*//')
    # Remove www. prefix if present
    domain=$(echo "$domain" | sed 's/^www\.//')
    echo "$domain"
}

# Function to normalize URL
normalize_url() {
    local url="$1"
    local base_url="$2"
    
    # If URL starts with //, add protocol
    if [[ "$url" =~ ^// ]]; then
        url="https:$url"
    # If URL starts with /, make it absolute
    elif [[ "$url" =~ ^/ ]]; then
        url="${base_url}${url}"
    # If URL doesn't start with http, make it absolute
    elif [[ ! "$url" =~ ^https?:// ]]; then
        url="${base_url}/${url}"
    fi
    
    echo "$url"
}

# Function to get path from URL for file structure
get_path_from_url() {
    local url="$1"
    # Remove protocol and domain
    path=$(echo "$url" | sed 's|^[^/]*//[^/]*||')
    # If empty or just /, use index
    if [ -z "$path" ] || [ "$path" = "/" ]; then
        path="/index"
    fi
    # Remove trailing slash
    path=$(echo "$path" | sed 's|/$||')
    # Remove query parameters and fragments
    path=$(echo "$path" | sed 's/[?#].*//')
    echo "$path"
}

# Function to extract links from HTML
extract_links() {
    local html_file="$1"
    local base_url="$2"
    local domain="$3"
    
    # Extract all href links, remove duplicates (macOS compatible)
    grep -o 'href="[^"]*"' "$html_file" 2>/dev/null | sed 's/href="//;s/"$//' | while read -r link; do
        # Skip empty links, anchors, mailto, tel, javascript
        if [ -z "$link" ] || [[ "$link" =~ ^# ]] || [[ "$link" =~ ^mailto: ]] || [[ "$link" =~ ^tel: ]] || [[ "$link" =~ ^javascript: ]]; then
            continue
        fi
        
        # Normalize the URL
        full_url=$(normalize_url "$link" "$base_url")
        
        # Only include links from the same domain
        link_domain=$(extract_domain "$full_url")
        if [ "$link_domain" = "$domain" ]; then
            echo "$full_url"
        fi
    done | sort -u
}

# Function to extract image URLs from HTML
extract_images() {
    local html_file="$1"
    
    # Extract src from img tags (macOS compatible)
    grep -o 'src="[^"]*"' "$html_file" 2>/dev/null | sed 's/src="//;s/"$//' | grep -iE '\.(jpg|jpeg|png|gif|svg|webp|bmp|ico)(\?|$)' || true
    
    # Extract srcset attributes (macOS compatible)
    grep -o 'srcset="[^"]*"' "$html_file" 2>/dev/null | sed 's/srcset="//;s/"$//' | tr ',' '\n' | awk '{print $1}' | grep -iE '\.(jpg|jpeg|png|gif|svg|webp|bmp|ico)(\?|$)' || true
    
    # Extract from picture source tags (simplified for macOS)
    grep -o '<source[^>]*' "$html_file" 2>/dev/null | grep -o 'src="[^"]*"' | sed 's/src="//;s/"$//' | grep -iE '\.(jpg|jpeg|png|gif|svg|webp|bmp|ico)(\?|$)' || true
}

# Prompt for URL
echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}   Website Scraper Script${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""
read -p "Enter the URL to scrape: " START_URL

# Validate URL
if [[ ! "$START_URL" =~ ^https?:// ]]; then
    echo -e "${RED}Error: Please provide a valid URL starting with http:// or https://${NC}"
    exit 1
fi

# Extract domain and create folder structure
DOMAIN=$(extract_domain "$START_URL")
LEGACY_DIR="../legacy"
OUTPUT_DIR="${LEGACY_DIR}/${DOMAIN}"

echo ""
echo -e "${GREEN}Domain extracted: ${DOMAIN}${NC}"
echo -e "${GREEN}Output directory: ${OUTPUT_DIR}${NC}"
echo ""

# Create legacy directory if it doesn't exist
mkdir -p "$LEGACY_DIR"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Get base URL (protocol + domain)
BASE_URL=$(echo "$START_URL" | sed 's|^\([^/]*//[^/]*\).*|\1|')

# Initialize tracking files
VISITED_FILE="${OUTPUT_DIR}/.visited_urls"
QUEUE_FILE="${OUTPUT_DIR}/.url_queue"
IMAGE_LIST="${OUTPUT_DIR}/.image_list"

# Clean up previous runs
rm -f "$VISITED_FILE" "$QUEUE_FILE" "$IMAGE_LIST"

# Add start URL to queue
echo "$START_URL" > "$QUEUE_FILE"

echo -e "${YELLOW}Starting to scrape pages...${NC}"
echo ""

# Counter for progress
page_count=0

# Process URLs from queue
while [ -s "$QUEUE_FILE" ]; do

    # Get next URL from queue
    CURRENT_URL=$(head -n 1 "$QUEUE_FILE")
    
    # Remove it from queue
    tail -n +2 "$QUEUE_FILE" > "${QUEUE_FILE}.tmp"
    mv "${QUEUE_FILE}.tmp" "$QUEUE_FILE"
    
    # Skip if already visited
    if grep -Fxq "$CURRENT_URL" "$VISITED_FILE" 2>/dev/null; then
        continue
    fi
    
    # Mark as visited
    echo "$CURRENT_URL" >> "$VISITED_FILE"
    
    # Get path for file structure
    URL_PATH=$(get_path_from_url "$CURRENT_URL")
    
    # Create directory structure
    FILE_DIR="${OUTPUT_DIR}$(dirname "$URL_PATH")"
    mkdir -p "$FILE_DIR"
    
    # Output file
    OUTPUT_FILE="${OUTPUT_DIR}${URL_PATH}.html"
    
    # Download the page
    ((page_count++))
    echo -e "${BLUE}[$page_count] Scraping:${NC} $CURRENT_URL"
    
    # Use curl to get the page with user agent and follow redirects
    if curl -L -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
         -s -o "$OUTPUT_FILE" "$CURRENT_URL"; then
        echo -e "${GREEN}    ✓ Saved to: ${OUTPUT_FILE##*/}${NC}"
        
        # Extract all links from the page
        extract_links "$OUTPUT_FILE" "$BASE_URL" "$DOMAIN" | while read -r link; do
            # Add to queue if not already visited
            if ! grep -Fxq "$link" "$VISITED_FILE" 2>/dev/null && \
               ! grep -Fxq "$link" "$QUEUE_FILE" 2>/dev/null; then
                echo "$link" >> "$QUEUE_FILE"
            fi
        done
        
        # Extract image URLs and add to list
        extract_images "$OUTPUT_FILE" >> "$IMAGE_LIST"
        
    else
        echo -e "${RED}    ✗ Failed to download${NC}"
    fi
    
    # Small delay to be respectful to the server
    sleep 0.5
done

echo ""
echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}HTML scraping complete!${NC}"
echo -e "${GREEN}Total pages scraped: ${page_count}${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""

# Now download images
if [ -f "$IMAGE_LIST" ] && [ -s "$IMAGE_LIST" ]; then
    echo -e "${YELLOW}Starting to download images...${NC}"
    echo ""
    
    # Create assets directory
    ASSETS_DIR="${OUTPUT_DIR}/assets"
    mkdir -p "$ASSETS_DIR"

    # Remove duplicates from image list
    sort -u "$IMAGE_LIST" -o "$IMAGE_LIST"
    
    # Process images
    image_count=0
    sort -u "$IMAGE_LIST" | while read -r img_url; do
    
        # Skip empty lines
        [ -z "$img_url" ] && continue
        
        # Normalize image URL
        img_url=$(normalize_url "$img_url" "$BASE_URL")
        
        # Extract filename from URL
        img_filename=$(basename "$img_url" | sed 's/[?#].*//')
        
        # Skip if no filename
        [ -z "$img_filename" ] && continue
        
        # Create unique filename if it already exists
        output_img="${ASSETS_DIR}/${img_filename}"

        # Skip if file already exists
        if [ -f "$output_img" ]; then
            echo -e "${YELLOW}    ⊘ Already exists, skipping${NC}"
            continue
        fi
        
        # if [ -f "$output_img" ]; then
        #     # Add hash to make unique (macOS uses md5 not md5sum)
        #     hash=$(echo -n "$img_url" | md5 | cut -c1-8)
        #     name="${img_filename%.*}"
        #     ext="${img_filename##*.}"
        #     output_img="${ASSETS_DIR}/${name}_${hash}.${ext}"
        # fi
        
        ((image_count++))
        echo -e "${BLUE}[$image_count] Downloading:${NC} $img_filename"
        
        # Download image
        if curl -L -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
             -s -o "$output_img" "$img_url" 2>/dev/null; then

            # Verify it's actually an image (has content)
            if [ -s "$output_img" ]; then
                echo -e "${GREEN}    ✓ Saved${NC}"
            else
                rm -f "$output_img"
                echo -e "${RED}    ✗ Empty file${NC}"
            fi
        else
            echo -e "${RED}    ✗ Failed${NC}"
        fi
        
        sleep 0.3
    done
    
    echo ""
    echo -e "${GREEN}======================================${NC}"
    echo -e "${GREEN}Image download complete!${NC}"
    echo -e "${GREEN}======================================${NC}"
else
    echo -e "${YELLOW}No images found to download.${NC}"
fi

# Clean up tracking files
rm -f "$VISITED_FILE" "$QUEUE_FILE" "$IMAGE_LIST"

echo ""
echo -e "${GREEN}✓ All done! Website content saved to:${NC}"
echo -e "${GREEN}  ${OUTPUT_DIR}${NC}"
echo ""
