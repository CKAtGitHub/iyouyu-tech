#!/bin/bash

# Step 1: Execute hugo command
hugo

# Step 2: Find all HTML files in the public directory and its subdirectories
find public -type f -name "*.html" | while read -r file; do
    # Step 3: Check if the file contains a footer tag and does not contain the powerby section
    if grep -q '</footer>' "$file" && grep -q '<section class="powerby">' "$file"; then
        # Step 4: Insert the specified HTML content before the last footer tag
        awk '{a[NR]=$0} END {last_footer=0; for(i=1;i<=NR;i++) {if(a[i] ~ /<\/footer>/) {last_footer=i}} for(i=1;i<=NR;i++) {if(i==last_footer) {print "<section class=\"powerby\"><a href=\"http://beian.miit.gov.cn/\" class=\"hover:text-primary-hover mx-1\" target=\"_blank\">粤ICP备2025390666号-1</a></section>";} print a[i]}}' "$file" > temp && mv temp "$file"
    fi
done
