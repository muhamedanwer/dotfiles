#!/usr/bin/env bash
# Format code file with appropriate formatter
# Usage: ./format-code.sh <file_path>

FILE_PATH="$1"

if [[ ! -f "$FILE_PATH" ]]; then
    echo "Error: File not found: $FILE_PATH"
    exit 1
fi

# Determine formatter based on file extension
case "${FILE_PATH##*.}" in
    py)
        if command -v black &> /dev/null; then
            black "$FILE_PATH" 2>/dev/null && echo "✓ Formatted with black: $FILE_PATH"
        elif command -v autopep8 &> /dev/null; then
            autopep8 -i "$FILE_PATH" && echo "✓ Formatted with autopep8: $FILE_PATH"
        fi
        ;;
    js|jsx|ts|tsx)
        if command -v prettier &> /dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null && echo "✓ Formatted with prettier: $FILE_PATH"
        fi
        ;;
    json|jsonc)
        if command -v jq &> /dev/null; then
            jq . "$FILE_PATH" > "$FILE_PATH.tmp" && mv "$FILE_PATH.tmp" "$FILE_PATH" && echo "✓ Formatted with jq: $FILE_PATH"
        fi
        ;;
    sh|bash)
        if command -v shfmt &> /dev/null; then
            shfmt -i 4 -w "$FILE_PATH" && echo "✓ Formatted with shfmt: $FILE_PATH"
        fi
        ;;
    *)
        echo "ℹ No formatter configured for: ${FILE_PATH##*.}"
        ;;
esac

exit 0
