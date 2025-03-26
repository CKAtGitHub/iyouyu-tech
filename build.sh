#!/bin/bash

# Step 1: Execute hugo command
hugo

# Step 2: Find all HTML files in the public directory and its subdirectories
find public -type f -name "*.html" | while read -r file; do
    # Step 3: Check if the file contains a footer tag
    if grep -q '</footer>' "$file"; then
        # Step 4: Insert the specified HTML content before the footer tag
        sed -i '' '/<\/footer>/i\
<section class="powerby"><a href="http://beian.miit.gov.cn/" class="hover:text-primary-hover mx-1" target="_blank">粤ICP备2025390666号-1</a></section>' "$file"
    fi
done