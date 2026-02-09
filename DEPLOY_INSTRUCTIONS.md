# GitHub Pages Deployment Instructions

## Problem
Assets (images, videos, animations) don't load when deployed to GitHub Pages because the base path isn't configured correctly.

## Solution

### Option 1: Use the Deploy Script (Recommended)

Run the PowerShell script:
```powershell
.\deploy_to_github_pages.ps1
```

This will automatically build your app with the correct base-href.

### Option 2: Manual Build

If your repository name is `bunny_love_app`, build with:
```bash
flutter build web --release --base-href /bunny_love_app/
```

**Important:** Replace `bunny_love_app` with your actual GitHub repository name!

### Option 3: Deploy to Root Domain

If you're deploying to `username.github.io` (root, not a repository subfolder), build with:
```bash
flutter build web --release --base-href /
```

## After Building

1. Your built files will be in the `build/web` folder
2. Copy these files to your GitHub Pages branch (usually `gh-pages`)
3. Push to GitHub

## Verify Deployment

After deployment, check:
- ✅ Background video plays (after tapping if needed)
- ✅ Animated bunny appears
- ✅ Return button (arrow) is visible
- ✅ Weather icons load
- ✅ Speech bubble appears

If images still don't load, you may see fallback icons (this means assets aren't loading but the app still functions).

## Alternative: Deploy to Root

If you want to avoid the base-href issue entirely, deploy to:
- `username.github.io` (your GitHub Pages user site)
- Or use a custom domain

Then build with: `flutter build web --release`

## Current Fix Applied

The code now includes fallback UI elements:
- 🐰 Bunny emoji if webp doesn't load
- ↩️ Back arrow icon if return button image doesn't load  
- ☀️ Weather emoji if weather icons don't load
- White bubble container if speech bubble image doesn't load

This ensures your app works even if assets fail to load!
