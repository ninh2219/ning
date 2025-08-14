#!/bin/bash
set -e
echo "--- Generating index.html ---"

# Nếu Pages serve từ ROOT của nhánh gh-pages:
OUT=index.html
# Nếu bạn cố tình serve từ /public, nhớ cấu hình Pages -> gh-pages /root và dùng:
# OUT=public/index.html && mkdir -p public

cat > "$OUT" <<'HTML'
<!doctype html>
<html lang="vi">
<head><meta charset="utf-8"><title>APT Repo</title><link rel="stylesheet" href="style.css"></head>
<body>
  <h1>APT Repo</h1>
  <p>Danh sách gói: <a href="packages.html">packages.html</a></p>
  <p>File Packages: <a href="repo/Packages">repo/Packages</a></p>
</body>
</html>
HTML

echo "--- Done ---"
