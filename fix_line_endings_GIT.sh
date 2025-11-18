#!/bin/bash
# ==================================================
# fix_line_endings.sh
# 修正指定目錄下檔案的換行問題 (CRLF -> LF)
# 並強制 Git 不要再轉回 CRLF
# ==================================================

TARGET_DIR="${1:-.}"
echo "Fixing line endings in directory: $TARGET_DIR"

# 遍歷指定目錄與子目錄
find "$TARGET_DIR" -type f \( \
    -name "*.sh" -o -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.cc" -o -name "Makefile" \
\) | while read -r file; do
    if file "$file" | grep -q text; then
        sed -i 's/\r$//' "$file"
        echo "Fixed: $file"
    else
        echo "Skipped (binary): $file"
    fi
done

# 建立/覆蓋 .gitattributes，強制 LF
cat > "$TARGET_DIR/.gitattributes" <<EOF
*.sh text eol=lf
*.c text eol=lf
*.h text eol=lf
*.cpp text eol=lf
*.cc text eol=lf
Makefile text eol=lf
EOF

echo ".gitattributes updated to force LF endings."

# 修改 git 設定，避免自動轉換
git config core.autocrlf false
git config core.eol lf

echo "Git config updated: core.autocrlf=false, core.eol=lf"
echo "All done! Now run:"
echo "  git rm --cached -r ."
echo "  git add ."
echo "  git commit -m 'Fix line endings to LF'"
