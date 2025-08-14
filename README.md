# Template Repo cho Debian APT Repository trên GitHub

Repo này host .deb packages như APT repo trên GitHub Pages, với tự động index khi push.

## Hướng dẫn sử dụng
1. Upload .deb vào `debs/`.
2. Push lên main.
3. Workflow sẽ deploy lên gh-pages, generate Packages/Release/InRelease.

## Thêm nguồn APT
```
curl -s --compressed "https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/my_repo.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/my_repo.list "https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/my_repo.list"
sudo apt update
```
(Tạo `my_repo.list` thủ công với nội dung: `deb [arch=amd64] https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/repo noble main` – thay noble bằng version.)

## Browse
- Danh sách: https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/index.html
- Repo đầy đủ: https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/repo/

Lưu ý: Nếu không dùng GPG, dùng `[trusted=yes]` trong sources.list.
