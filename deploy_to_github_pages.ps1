# Deploy Flutter Web App to GitHub Pages
# This script builds your Flutter web app with the correct base-href for GitHub Pages

Write-Host "🚀 Building Flutter Web App for GitHub Pages..." -ForegroundColor Cyan

# Get the repository name from git remote (assumes origin is set)
$repoUrl = git config --get remote.origin.url
if ($repoUrl -match '/([^/]+)\.git$') {
    $repoName = $Matches[1]
    Write-Host "📦 Repository detected: $repoName" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not detect repository name. Using default..." -ForegroundColor Yellow
    $repoName = "bunny_love_app"
}

# Build with base-href for GitHub Pages
Write-Host "🔨 Building with base-href: /$repoName/" -ForegroundColor Cyan
flutter build web --release --base-href "/$repoName/"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📝 Next steps:" -ForegroundColor Yellow
    Write-Host "1. Copy the contents of 'build/web' folder to your GitHub Pages repository"
    Write-Host "2. Or if you're using gh-pages branch:"
    Write-Host "   - git checkout gh-pages"
    Write-Host "   - Copy contents from build/web to root"
    Write-Host "   - git add . && git commit -m 'Deploy' && git push"
    Write-Host ""
    Write-Host "🌐 Your app will be available at: https://YOUR_USERNAME.github.io/$repoName/" -ForegroundColor Cyan
} else {
    Write-Host "❌ Build failed! Please check the errors above." -ForegroundColor Red
    exit 1
}
