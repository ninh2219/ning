cat <<'EOF' > generate-index.sh
#!/bin/bash
# generate-index.sh

# Dừng lại ngay nếu có lỗi
set -e

echo "--- Starting index.html generation script ---"

# Bắt đầu file HTML và ghi vào thư mục public
cat <<ECHO_EOF > public/index.html
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Repo của $GITHUB_REPOSITORY_OWNER</title><link rel="stylesheet" href="style.css"><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"></head><body><div class="container"><header><h1>${GITHUB_REPOSITORY#*/}</h1><p>Kho lưu trữ APT được host trên GitHub Pages.</p></header><main><section class="installation"><h2>Hướng dẫn cài đặt</h2><pre><code># Thêm GPG Key
curl -sS --compressed "https://$GITHUB_REPOSITORY_OWNER.github.io/${GITHUB_REPOSITORY#*/}/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/${GITHUB_REPOSITORY#*/}.gpg >/dev/null
# Thêm Repo
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/${GITHUB_REPOSITORY#*/}.gpg] https://$GITHUB_REPOSITORY_OWNER.github.io/${GITHUB_REPOSITORY#*/}/ /" | sudo tee /etc/apt/sources.list.d/${GITHUB_REPOSITORY#*/}.list
# Cập nhật
sudo apt update</code></pre></section><section class="packages"><h2>Danh sách các gói</h2><div class="package-list">
ECHO_EOF

# Kiểm tra xem có file .deb nào không trước khi chạy vòng lặp
if [ -n "$(ls -A debs/*.deb 2>/dev/null)" ]; then
  # Vòng lặp an toàn để xử lý tên file
  find debs -name "*.deb" -print0 | while IFS= read -r -d '' deb; do
    echo "Processing file: '$deb'"
    PACKAGE_NAME=$(dpkg-deb -f "$deb" Package)
    VERSION=$(dpkg-deb -f "$deb" Version)
    DESCRIPTION=$(dpkg-deb -f "$deb" Description | head -n 1)
    cat <<ECHO_EOF >> public/index.html
<div class="package-item"><div class="package-info"><h3>$PACKAGE_NAME</h3><p style="color: #aaa; font-size: 0.9em;">Phiên bản: $VERSION</p><p>$DESCRIPTION</p></div></div>
ECHO_EOF
  done
else
  echo "<p>Chưa có gói nào trong kho lưu trữ.</p>" >> public/index.html
fi

# Đóng file HTML
cat <<ECHO_EOF >> public/index.html
</div></section></main><footer><p>&copy; $(date +%Y) $GITHUB_REPOSITORY_OWNER. Hosted on GitHub Pages.</p></footer></div></body></html>
ECHO_EOF

echo "--- Finished index.html generation ---"
EOF