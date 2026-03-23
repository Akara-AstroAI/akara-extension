#!/bin/bash

# Chrome Extension Packaging Script for KeyEZ
# This script packages the extension for Chrome Web Store upload

echo "🎯 KeyEZ Chrome Extension Packaging Script"
echo "=========================================="

# Set variables
EXTENSION_DIR="/home/kosol/AstroAI/chrome_extension"
OUTPUT_DIR="/home/kosol/AstroAI"
PACKAGE_NAME="keyez-extension-v1.0.zip"

# Files to include in the package
FILES=(
    "manifest.json"
    "background.js"
    "popup.js"
    "popup.css"
    "popup_inline.css"
    "settings.html"
    "settings.js"
    "settings.css"
    "icon.png"
    "LogK.png"
)

echo ""
echo "📦 Creating package: $PACKAGE_NAME"
echo ""

# Navigate to extension directory
cd "$EXTENSION_DIR" || exit 1

# Remove old package if exists
if [ -f "$OUTPUT_DIR/$PACKAGE_NAME" ]; then
    echo "🗑️  Removing old package..."
    rm "$OUTPUT_DIR/$PACKAGE_NAME"
fi

# Create zip package
echo "📦 Packaging files..."
zip -r "$OUTPUT_DIR/$PACKAGE_NAME" "${FILES[@]}"

# Check if packaging was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Package created successfully!"
    echo "📍 Location: $OUTPUT_DIR/$PACKAGE_NAME"
    echo ""
    
    # Show package size
    SIZE=$(du -h "$OUTPUT_DIR/$PACKAGE_NAME" | cut -f1)
    echo "📊 Package size: $SIZE"
    echo ""
    
    # List contents
    echo "📋 Package contents:"
    unzip -l "$OUTPUT_DIR/$PACKAGE_NAME"
    echo ""
    
    echo "✨ Ready for Chrome Web Store upload!"
    echo ""
    echo "Next steps:"
    echo "1. Go to: https://chrome.google.com/webstore/devconsole"
    echo "2. Click 'New Item'"
    echo "3. Upload: $OUTPUT_DIR/$PACKAGE_NAME"
    echo "4. Fill in store listing details"
    echo "5. Submit for review"
else
    echo ""
    echo "❌ Packaging failed!"
    exit 1
fi
