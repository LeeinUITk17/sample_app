## Phần lý thuyết

### Câu 1: What is the difference between `_path` vs. `_url`?

- **_path** (Relative path): Tạo ra đường dẫn tương đối, không bao gồm tên miền.  
    Ví dụ: `/users/1`. Thường dùng cho các liên kết nội bộ trong ứng dụng, như:  
    `link_to "Profile", user_path(@user)`.
- **_url** (Full URL): Tạo ra đường dẫn tuyệt đối, bao gồm cả protocol (http/https) và tên miền.  
    Ví dụ: `http://www.domain/users/1`. Bắt buộc dùng khi liên kết cần truy cập từ bên ngoài ứng dụng, như trong email hoặc redirect.

---

### Câu 2: When should you use the `send` method?

- `send` là phương thức cho phép gọi một phương thức khác bằng cách truyền tên dưới dạng chuỗi hoặc symbol.
- Dùng `send` để tổng quát hóa các phương thức, ví dụ như `authenticated?`. Thay vì viết riêng cho từng thuộc tính (`remember`, `activation`), ta viết một phương thức chung nhận vào tên thuộc tính.  
    Ví dụ: `digest = send("#{attribute}_digest")` sẽ gọi động `remember_digest` hoặc `activation_digest` tùy giá trị `attribute`.
- Dùng `send` khi cần gọi phương thức một cách linh động, thường trong metaprogramming hoặc để tránh lặp code.

---

### Câu 3: What is the difference between `deliver_now` vs. `deliver_later`?

- Cả hai đều dùng để gửi email trong Action Mailer.
- **deliver_now**: Gửi email ngay lập tức (đồng bộ). Request của người dùng bị chặn cho đến khi email gửi xong.
- **deliver_later**: Gửi email bất đồng bộ. Email được đưa vào queue và xử lý bởi background job (Active Job). Request trả về ngay, không cần chờ gửi email.
