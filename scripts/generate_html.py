# scripts/generate_html.py

import os

# --- Cấu hình ---
# Đường dẫn đến file Packages được tạo ra bởi workflow
# Thường thì repo sẽ được checkout vào thư mục gốc, và file Packages nằm trong thư mục con 'repo'
PACKAGES_FILE_PATH = 'repo/Packages' 
# Tên file HTML sẽ được xuất ra
OUTPUT_HTML_PATH = 'packages.html'
# Tiêu đề của trang HTML
HTML_TITLE = "Danh sách tất cả các gói"
# Link tới file CSS đã tạo ở bước trước để giao diện được đồng bộ
CSS_PATH = "style.css"

def parse_packages_file(file_path):
    """
    Hàm này đọc file 'Packages' và chuyển đổi nó thành một danh sách các gói.
    Mỗi gói là một dictionary chứa thông tin như 'Package', 'Version', 'Description'.
    """
    packages = []
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            current_package = {}
            for line in f:
                line = line.strip()
                if not line and current_package:
                    packages.append(current_package)
                    current_package = {}
                elif ': ' in line:
                    key, value = line.split(': ', 1)
                    current_package[key] = value
            if current_package:
                packages.append(current_package)
    except FileNotFoundError:
        print(f"Lỗi: Không tìm thấy file '{file_path}'. Hãy đảm bảo script này chạy sau khi file Packages được tạo.")
        return None
    return packages

def generate_html_page(packages):
    """
    Tạo nội dung HTML từ danh sách các gói.
    """
    # Phần đầu của file HTML
    html_content = f"""
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{HTML_TITLE}</title>
    <link rel="stylesheet" href="{CSS_PATH}">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <header>
            <h1>{HTML_TITLE}</h1>
            <p>Tổng cộng có {len(packages)} gói trong kho lưu trữ.</p>
            <p><a href="index.html" style="color: #00aaff;">&larr; Quay lại trang chủ</a></p>
        </header>

        <main>
            <section class="packages">
    """

    # Lặp qua từng gói và tạo một mục trong danh sách
    for pkg in sorted(packages, key=lambda p: p.get('Package', '').lower()):
        package_name = pkg.get('Package', 'N/A')
        version = pkg.get('Version', 'N/A')
        description = pkg.get('Description', 'Không có mô tả.')
        
        html_content += f"""
                <div class="package-item">
                    <div class="package-info">
                        <h3>{package_name}</h3>
                        <p style="color: #aaa; font-size: 0.9em;">Phiên bản: {version}</p>
                        <p>{description}</p>
                    </div>
                </div>
        """

    # Phần cuối của file HTML
    html_content += """
            </section>
        </main>
        <footer>
            <p>&copy; 2025 NinhPC. Hosted on GitHub Pages.</p>
        </footer>
    </div>
</body>
</html>
    """
    return html_content

def main():
    """
    Hàm chính điều khiển toàn bộ quá trình.
    """
    print("Bắt đầu quá trình tạo trang HTML danh sách gói...")
    packages = parse_packages_file(PACKAGES_FILE_PATH)
    
    if packages is not None:
        print(f"Đã tìm thấy và phân tích {len(packages)} gói.")
        html_output = generate_html_page(packages)
        
        with open(OUTPUT_HTML_PATH, 'w', encoding='utf-8') as f:
            f.write(html_output)
        
        print(f"Đã tạo thành công file '{OUTPUT_HTML_PATH}'.")
    else:
        print("Không thể tạo file HTML do lỗi ở bước phân tích.")

if __name__ == "__main__":
    main()