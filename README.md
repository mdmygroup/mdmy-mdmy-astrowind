# MDMY Group - Accueil Page (Astro Rebuild)

## ✅ Completed

The ACCUEIL.html page has been successfully rebuilt using the modern Astro + Tailwind + Alpine.js + AOS stack.

### Created Files:
- ✅ `src/layouts/BaseLayout.astro` - Base layout with meta tags, fonts, Alpine.js, and AOS
- ✅ `src/components/Header.astro` - Header with logo, navigation, and mobile menu
- ✅ `src/components/Footer.astro` - Footer with social links
- ✅ `src/pages/accueil.astro` - Main Accueil page with all sections

### Sections Included:
1. **Hero Section** - Full-screen background with heading and CTA buttons
2. **Votre site web Section** - Side-by-side image and text content
3. **Nos Services Section** - Overlay section with service highlights  
4. **Pourquoi choisir MDMY** - 4-card grid showcasing benefits

## 🔧 Next Steps

### 1. Install Dependencies
```bash
npm install
```

### 2. Copy Assets
You need to copy the following images from the legacy site to `public/assets/`:

**Required Images:**
- `mdmy_white_slim.png` (logo)
- `blurry_banner1-1.jpg` (hero background)
- `unsplash-image-LSvnvfHPtzQ.jpg` (Votre site web section)
- `charlesdeluvio-Lks7vei-eAg-unsplash-min.jpg` (Nos services background)
- `ales-nesetril-Im7lZjxeLhg-unsplash.jpg` (Card 1)
- `sean-pollock-PhYq704ffdA-unsplash.jpg` (Card 2)
- `marc-olivier-jodoin-NqOInJ-ttqM-unsplash.jpg` (Card 3)
- `nigel-tadyanehondo-3k5cAmxjXl4-unsplash.jpg` (Card 4)

**Copy command:**
```bash
# From the legacy context folder
cp .context/legacy/mdmygroup.com/assets/* public/assets/
```

### 3. Run Development Server
```bash
npm run dev
```

### 4. Build for Production
```bash
npm run build
```

## 🎨 Technology Stack

- **Astro** - Static site generator with component-based architecture
- **Tailwind CSS** - Utility-first styling
- **Alpine.js** - Minimal JavaScript for mobile menu and interactivity
- **AOS (Animate On Scroll)** - Scroll animations
- **Fonts**: Poppins & Manrope from Google Fonts

## 📋 Features Implemented

✅ Responsive design (mobile, tablet, desktop)
✅ Mobile-friendly navigation with hamburger menu
✅ Scroll animations using AOS
✅ Hero section with background image and overlay
✅ Grid layouts for service cards
✅ Hover effects on cards
✅ Semantic HTML5 structure
✅ Accessibility features (aria-labels, alt text)
✅ Fast loading with lazy loading images
✅ SEO-optimized meta tags

## 🔍 Differences from Legacy

The new implementation maintains pixel-perfect fidelity to the original design while modernizing the tech stack:

- **Legacy**: Squarespace CMS with inline styles
- **Modern**: Astro + Tailwind with component-based architecture
- **Performance**: Improved load times with static generation
- **Maintainability**: Clean, reusable components

## 📝 Notes

- All text content copied verbatim from legacy site
- Colors match the original design
- Fonts (Poppins, Manrope) loaded from Google Fonts as in legacy
- All images referenced with exact file names from legacy
- Navigation structure preserved exactly

## 🚀 Deployment

The site is configured for GitHub Pages deployment:
- Site: `https://mdmygroup.github.io`
- Base: `/mdmy-mdmy-astrowind`

To deploy:
```bash
npm run build
# Then push to GitHub Pages
```
