#!/bin/bash

# Common pandoc options
COMMON_OPTIONS="--css epub-resources/style.css"

# Function to generate epub
function build_book() {
    local name=$1
    local base_fn="${name}/${name}"
    pandoc -o ${base_fn}.epub ${base_fn}.md --epub-embed-font='epub-resources/fonts/*.ttf' --epub-cover-image ${base_fn}.jpg $COMMON_OPTIONS
    # pandoc -s -o ${base_fn}.html ${base_fn}.epub
    pandoc -o ${base_fn}.txt ${base_fn}.md -t plain+GUTENBERG
}

# Array of all book base names
BOOKS=("the-walls-of-jericho" "dark-princess" "home-to-harlem" "quicksand")

# Check the input option
case "$1" in
    walls)
        build_book "the-walls-of-jericho"
        ;;
    dark)
        build_book "dark-princess"
        ;;
    home)
        build_book "home-to-harlem"
        ;;
    quicksand)
        build_book "quicksand"
        ;;
    # Add additional cases for new books here
    all)
        for book in "${BOOKS[@]}"; do
            build_book "$book"
        done
        ;;
    *)
        echo "Usage: $0 {walls|dark|all|other_book_base_names...}"
        exit 1
esac
