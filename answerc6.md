Phần 1:

**Câu 1: Uniqueness kết hợp với scope là gì?**  
`uniqueness: true` đảm bảo một thuộc tính là duy nhất trên toàn bộ bảng. Khi dùng thêm `scope`, tính duy nhất chỉ được kiểm tra trong phạm vi một hoặc nhiều cột khác. Ví dụ:  
`validates :name, uniqueness: { scope: :year }` nghĩa là `name` chỉ cần duy nhất trong từng `year`.

**Câu 2: Tác dụng của gem bcrypt**  
Gem bcrypt cung cấp thuật toán hash an toàn để mã hóa mật khẩu. Nó lưu chuỗi đã băm (digest) thay vì mật khẩu gốc, giúp bảo vệ mật khẩu người dùng ngay cả khi database bị lộ.

**Câu 3: Tác dụng của phương thức has_secure_password**  
- Lưu mật khẩu an toàn vào cột `password_digest` trong DB.  
- Tạo hai virtual attribute: `password` và `password_confirmation`.  
- Thêm validation yêu cầu mật khẩu tồn tại và khớp với `password_confirmation` khi tạo/cập nhật.  
- Cung cấp phương thức `authenticate` để kiểm tra mật khẩu với digest đã lưu.

**Câu 4: Callback là gì? Một số loại callback?**  
Callback là các phương thức tự động được gọi tại các thời điểm nhất định trong vòng đời của đối tượng Active Record (ví dụ: trước/sau khi tạo, lưu, cập nhật, xóa...).

**Câu 5: Phân biệt after_save và after_commit**  
- `after_save`: Chạy bên trong transaction DB, ngay sau khi create/update, trước khi commit. Nếu có lỗi, transaction có thể bị rollback.  
- `after_commit`: Chỉ chạy sau khi transaction đã commit thành công, dữ liệu đã ghi vĩnh viễn. Thường dùng cho các tác vụ không nên rollback (gửi email, gọi API).

**Câu 6: Phân biệt downcase và downcase!**  
- `downcase`: Trả về chuỗi mới đã chuyển thành chữ thường, không thay đổi chuỗi gốc.  
- `downcase!`: Chuyển đổi trực tiếp chuỗi gốc thành chữ thường.

**Câu 7: Vì sao dùng migration?**  
Migration giúp quản lý thay đổi schema database nhất quán, có phiên bản.

Phần 2:

**Câu 2: Phương thức "has_secure_password" ở đâu? Được cung cấp bởi gì? Hoạt động thế nào?**  
- Là phương thức của module `ActiveModel::SecurePassword`.  
- Module này được include vào `ActiveRecord::Base`, nên mọi model Rails đều dùng được.  
- Chỉ hoạt động khi đã thêm gem bcrypt vào Gemfile.  
- Cách hoạt động:  
    - Lưu mật khẩu an toàn vào cột `password_digest` trong DB.  
    - Tạo hai virtual attribute: `password` và `password_confirmation`.  
    - Thêm validation yêu cầu mật khẩu tồn tại và khớp với `password_confirmation` khi tạo/cập nhật.  
    - Cung cấp phương thức `authenticate` để kiểm tra mật khẩu với digest đã lưu.
    