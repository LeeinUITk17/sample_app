
# Bài tập 3: Trả lời Câu hỏi Lý thuyết

## 1. Research gem config

- **Nó là gì?**: `gem config` là lệnh để xem và sửa cấu hình chung cho RubyGems. Các cài đặt này được lưu trong file `~/.gemrc`.
- **Dùng để làm gì?**: Mục đích chính là để tùy chỉnh hành vi mặc định khi cài gem.
- **Case study kinh điển**: Tắt cài đặt document để `bundle install` nhanh hơn. Chỉ cần chạy lệnh này một lần:

```bash
gem config --global install "--no-document"
```

## 2. Research I18n, I18n lazy lookup

### I18n (Internationalization)

- **Nó là gì?**: Là framework tích hợp sẵn của Rails để làm ứng dụng đa ngôn ngữ.
- **Cách hoạt động**: Tách hết text ra khỏi code, cho vào các file YAML trong `config/locales` (ví dụ: `en.yml`, `vi.yml`). Trong view, dùng helper `t()` để gọi text.

### I18n Lazy Lookup

- **Nó là gì?**: Là một cách viết tắt của `t()` trong view. Thay vì viết đường dẫn dài, chỉ cần dùng dấu chấm `.` ở đầu.

```erb
<%= t('users.show.title') %>  # Cách thường
<%= t('.title') %>           # Lazy Lookup
```

## 3. What is Attack CSRF, XSS? and How prevent to them in Rails?

### CSRF (Cross-Site Request Forgery)

- **Là gì?**: Lừa người dùng đã đăng nhập thực hiện một hành động mà họ không muốn (ví dụ: chuyển tiền, xóa tài khoản) bằng cách click vào một link giả mạo.
- **Rails chống thế nào?**: Rails tự động thêm một `authenticity_token` vào tất cả các form (trừ GET). Khi submit, Rails sẽ kiểm tra token này. Nếu không khớp, request sẽ bị hủy. Tính năng này được bật mặc định trong `ApplicationController` qua dòng `protect_from_forgery`.

### XSS (Cross-Site Scripting)

- **Là gì?**: Chèn code độc (thường là JavaScript) vào trang web thông qua các input như comment, form... Khi người dùng khác xem trang, code độc sẽ chạy trên trình duyệt của họ.
- **Rails chống thế nào?**: Rails tự động "escape" HTML. Bất cứ chuỗi nào được in ra bằng `<%= ... %>` đều được chuyển đổi thành văn bản thuần túy. Ví dụ, `<script>` sẽ trở thành `&lt;script&gt;` và không thể thực thi.

## 4. Distinguish some methods: nil?, empty?, blank?, present?

- `nil?`: Chỉ true khi đối tượng là `nil`.
- `empty?`: true khi chuỗi/array/hash rỗng (`""`, `[]`, `{}`). Báo lỗi với `nil`.
- `blank?` (của Rails): "Trùm cuối". true cho `nil`, chuỗi rỗng `""`, và chuỗi chỉ có dấu cách `" "`.
- `present?` (của Rails): Là phủ định của `blank?`.

## 5. Presenting the effect of helper folder, what case of using it

- **Tác dụng**: Thư mục `app/helpers` dùng để chứa các method giúp giữ cho file View (ERB) sạch sẽ, tránh viết logic phức tạp trong View. Nó giúp tách biệt giữa logic hiển thị (presentation logic) và cấu trúc HTML.
- **Khi nào nên dùng?**
  - Khi bạn thấy mình đang viết code Ruby phức tạp bên trong `<% ... %>` ở file view.
  - **Định dạng dữ liệu**: Ví dụ, tạo helper `format_date(date)` để hiển thị ngày tháng theo chuẩn "dd/mm/YYYY".
  - **Logic hiển thị có điều kiện**: Ví dụ, helper `user_status_tag(user)` để trả về một thẻ `<span>` với class CSS khác nhau tùy theo trạng thái `active`/`inactive` của user.
  - **Tạo các thành phần HTML phức tạp**: Ví dụ, tạo một helper để render một button với icon và nhiều class CSS.
