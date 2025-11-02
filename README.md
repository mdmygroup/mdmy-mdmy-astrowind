# Bizot Paysagistes - Astro Website

This project has been migrated from vanilla HTML to Astro framework following modern web development best practices.

## 🚀 Project Structure

```
/
├── public/
│   └── assets/          # Static assets (images, logos, etc.)
├── src/
│   ├── components/      # Reusable Astro components
│   │   ├── Header.astro
│   │   └── Footer.astro
│   ├── layouts/         # Layout templates
│   │   └── BaseLayout.astro
│   └── pages/           # Page routes
│       ├── index.astro
│       ├── services.astro
│       ├── realisations.astro
│       ├── a-propos.astro
│       └── contact.astro
├── astro.config.mjs     # Astro configuration
├── tailwind.config.mjs  # Tailwind CSS configuration
└── package.json         # Project dependencies
```

## 🛠️ Installation & Setup

1. **Install Node.js** (if not already installed):
   - Download from https://nodejs.org/ (LTS version recommended)
   - Or use Homebrew: `brew install node`

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Start development server**:
   ```bash
   npm run dev
   ```
   The site will be available at `http://localhost:4321`

4. **Build for production**:
   ```bash
   npm run build
   ```
   The static site will be generated in `dist/` folder

5. **Preview production build**:
   ```bash
   npm run preview
   ```

## 📝 Migration Status

### ✅ Completed
- ✅ Astro project structure created
- ✅ Tailwind CSS integration configured
- ✅ BaseLayout with SEO meta tags
- ✅ Header component with navigation
- ✅ Footer component
- ✅ All page routes fully migrated with complete content
- ✅ index.astro: Hero, Reviews, Services, Portfolio, Newsletter
- ✅ services.astro: All 3 services with detailed sections
- ✅ realisations.astro: Portfolio grid with filters and stats
- ✅ a-propos.astro: Story, values, team, certifications
- ✅ contact.astro: Contact form and FAQ
- ✅ Assets moved to public folder
- ✅ AOS (Animate On Scroll) integration
- ✅ Alpine.js integration for interactivity
- ✅ GitHub Pages deployment workflow configured

## 🎨 Tech Stack

- **Framework**: Astro 4.x
- **Styling**: Tailwind CSS 3.4
- **Interactivity**: Alpine.js (for dropdowns, modals)
- **Animations**: AOS (Animate On Scroll)
- **Icons**: Heroicons (inline SVG)
- **Fonts**: Google Fonts (Inter)

## 🎯 Key Features

### Astro Benefits
- ⚡ **Zero JS by default**: Ships minimal JavaScript to the client
- 🔧 **Component-based**: Reusable Header, Footer, and Layout components
- 📦 **Static Site Generation**: Fast load times and great SEO
- 🎨 **Tailwind Integration**: Utility-first CSS with custom theme
- 🔄 **Hot Module Replacement**: Instant updates during development

### Design System
Custom Tailwind theme with brand colors:
- `brand`: #80ab97 (main green)
- `brandLight`: #cbecdd (light green)
- `brandDark`: #386D56 (dark green)
- `accent`: #F97316 (orange)
- `textColor`: #102611 (dark text)
- `bgColor`: #FFFFFF (background)

## � Deployment to GitHub Pages

This project is configured to automatically deploy to GitHub Pages when you push to the `main` branch.

### Initial Setup (One-time)

1. **Push your code to GitHub**:
   ```bash
   git add .
   git commit -m "Initial Astro migration"
   git push -u origin main
   ```

2. **Enable GitHub Pages**:
   - Go to your repository on GitHub
   - Navigate to **Settings** → **Pages**
   - Under "Build and deployment":
     - **Source**: Select "GitHub Actions"
   - Save the settings

3. **Wait for deployment**:
   - Go to the **Actions** tab in your repository
   - You'll see the "Deploy to GitHub Pages" workflow running
   - Once complete (✅), your site will be live!

4. **Access your site**:
   - Your site will be available at: `https://mdmygroup.github.io/mdmy-bp-astrowind`
   - The URL will also be shown in the Actions workflow completion

### Automatic Deployments

Every time you push to the `main` branch, GitHub Actions will automatically:
1. Build your Astro site
2. Deploy it to GitHub Pages
3. Your changes will be live in 1-2 minutes

### Manual Deployment

You can also trigger a deployment manually:
- Go to **Actions** tab
- Select "Deploy to GitHub Pages"
- Click "Run workflow" → "Run workflow"

### Custom Domain (Optional)

To use a custom domain like `www.bizot-paysagistes.com`:

1. Add your domain in **Settings** → **Pages** → **Custom domain**
2. Update `astro.config.mjs`:
   ```js
   site: 'https://www.bizot-paysagistes.com',
   base: '/',
   ```
3. Configure DNS records with your domain provider:
   - Add a CNAME record pointing to `mdmygroup.github.io`

## 📂 Next Steps

1. ✅ **Complete page content**: ✅ DONE - All pages fully migrated
2. **Add real images**: Replace placeholder emojis with actual project photos
3. **Create reusable components**: Extract repeated patterns (service cards, project cards, etc.)
4. **Add image optimization**: Use Astro's Image component for better performance
5. **Connect contact form**: Add backend/service for form submissions (Formspree, Netlify Forms, etc.)
6. **Test responsiveness**: Verify all pages work on mobile, tablet, desktop
7. **SEO optimization**: Add sitemap, robots.txt, and optimize meta tags

## 🔧 Development Tips

- Use `src/components/` for reusable UI elements
- Use `src/layouts/` for page templates
- Use `src/pages/` for routes (file-based routing)
- Static assets go in `public/` (accessible at `/assets/...`)
- Use Astro props for component customization

## 📖 Documentation

- [Astro Documentation](https://docs.astro.build)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [Alpine.js](https://alpinejs.dev)
- [AOS (Animate On Scroll)](https://michalsnik.github.io/aos/)

## 🤝 Contributing

To continue development:
1. Complete the page content from original HTML
2. Extract repeated sections into components
3. Add responsive images
4. Test across browsers
5. Optimize for performance

---

**Made with ❤️ using Astro + Tailwind CSS**
