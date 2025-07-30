## Phần 1: Lý thuyết

### Câu 1: Sự khác biệt giữa member và collection trong file routes

- **Member route**:  
    Tạo ra một route hoạt động trên một thành viên cụ thể của resource.  
    Yêu cầu phải có `:id` trong URL.

- **Collection route**:  
    Tạo ra một route hoạt động trên toàn bộ tập hợp của resource.  
    Không yêu cầu `:id` trong URL.

---

### Câu 2: Các thuộc tính trong Association của Rails

- **class_name**: Chỉ định tên Model mà association này trỏ tới. Dùng khi tên association không trùng với tên Model.
- **foreign_key**: Chỉ định tên cột khóa ngoại trong database. Dùng khi tên cột không theo quy ước (tên_model_id).
- **source**: Dùng trong association `has_many :through`, chỉ định tên association nguồn trong model trung gian.
- **dependent: :destroy**: Khi một user bị xóa, tất cả các relationship liên quan (cả active và passive) cũng bị xóa theo.

---

### Câu 3: Khi nào khai báo class_name, foreign_key trong association?

- Dùng **class_name** khi tên association không giúp Rails suy ra được tên Model tương ứng.  
    *Ví dụ*: `has_many :microposts` sẽ tự động tìm model tên `Micropost`.

- Dùng **foreign_key** khi tên cột khóa ngoại trong bảng database không theo quy ước của Rails.  
    *Ví dụ*: Model `User` có `has_many :relationships` sẽ tìm kiếm cột `user_id` trong bảng `relationships`.
