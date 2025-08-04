### Phần lý thuyết

**Câu 1:** Sau khi nhấp vào liên kết, chúng ta sẽ được chuyển đến trang đặt lại mật khẩu đúng không?  
Đúng vậy. Liên kết trong email chứa `reset_token` và email. Khi nhấp vào, sẽ gọi đến action `edit` của `PasswordResetsController`. Action này sẽ thực hiện các bước kiểm tra (tìm user, xác thực token, kiểm tra hết hạn). Nếu tất cả đều hợp lệ, sẽ render ra view `edit.html.erb`, đây chính là trang để người dùng nhập mật khẩu mới.
