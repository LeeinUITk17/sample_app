### Câu 1: How does `form_for` build an HTML form with PUT/PATCH method?

Khi sử dụng `form_for` (hoặc `form_with model: @user`), nếu đối tượng đã tồn tại trong cơ sở dữ liệu (ví dụ: `@user` không phải là bản ghi mới), Rails sẽ coi form đó là để cập nhật (update).  
Vì HTML form chỉ hỗ trợ phương thức GET và POST, Rails mô phỏng PUT hoặc PATCH bằng cách:

- Tạo thẻ `<form>` với thuộc tính `method="post"`.
- Thêm một input ẩn: `<input type="hidden" name="_method" value="patch">`.

Khi form được submit, Rails sẽ đọc trường `_method` và xử lý request như một PATCH (hoặc PUT), định tuyến đến action update.

---

### Câu 2: Why use `allow_nil: true`?

Thêm `allow_nil: true` vào xác thực mật khẩu (ví dụ: `validates :password, ..., allow_nil: true`) cho phép người dùng cập nhật các thuộc tính khác (như tên hoặc email) mà không cần nhập lại mật khẩu.  
Nếu không có `allow_nil: true`, mỗi lần cập nhật bất kỳ thông tin gì cũng sẽ yêu cầu phải điền mật khẩu, nếu không sẽ bị lỗi “Password can't be blank”.  
`allow_nil: true` sẽ bỏ qua xác thực mật khẩu chỉ khi trường mật khẩu là nil (không được gửi từ form).

---

### Câu 3: Why define `redirect_back_or` and `store_location` methods?

Các phương thức này dùng để triển khai tính năng Friendly Forwarding (chuyển hướng thân thiện):

- `store_location`: Lưu URL người dùng muốn truy cập (`request.original_url`) vào `session[:forwarding_url]` khi người dùng chưa đăng nhập cố gắng truy cập trang yêu cầu đăng nhập.
- `redirect_back_or(default_url)`: Sau khi đăng nhập thành công, kiểm tra xem có `session[:forwarding_url]` hay không:
    - Nếu có, chuyển hướng đến URL đã lưu.
    - Nếu không, chuyển hướng đến URL mặc định (ví dụ: trang hồ sơ người dùng).

**Mục đích:** Cải thiện trải nghiệm người dùng bằng cách giúp họ quay lại đúng trang đã định sau khi đăng nhập.
