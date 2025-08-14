#!/bin/bash
# generate-index.sh

# Dừng lại ngay nếu có lỗi
set -e

echo "--- Starting index.html generation script ---"

# Bắt đầu file HTML và ghi vào thư mục public
cat <<EOF > public/index.html
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Repo của $GITHUB_REPOSITORY_OWNER</title><link rel="stylesheet" href="style.css"><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"></head><body><div class="container"><header><h1>${GITHUB_REPOSITORY#*/}</h1><p>Kho lưu trữ APT được host trên GitHub Pages.</p></header><main><section class="installation"><h2>Hướng dẫn cài đặt</h2><pre><code># Thêm GPG Key
curl -sS --compressed "https://$GITHUB_REPOSITORY_OWNER.github.io/${GITHUB_REPOSITORY#*/}/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/${GITHUB_REPOSITORY#*/}.gpg >/dev/null
# Thêm Repo
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/${GITHUB_REPOSITORY#*/}.gpg] https://$GITHUB_REPOSITORY_OWNER.github.io/${GITHUB_REPOSITORY#*/}/ /" | sudo tee /etc/apt/sources.list.d/${GITHUB
