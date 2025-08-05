## Phần 1: Lý thuyết

### 1. Sự khác biệt giữa `build` và `new` trong Rails

- **Giống nhau:** Cả hai đều tạo ra một đối tượng mới trong bộ nhớ, chưa lưu vào database. Ví dụ: `user.microposts.new(...)` và `user.microposts.build(...)` là tương đương.
- **Khác nhau:**
    - `new` (ví dụ: `Micropost.new`): Tạo đối tượng độc lập, chưa gán `user_id`. Cần gán thủ công: `micropost.user_id = user.id`.
    - `build` (ví dụ: `user.microposts.build`): Được gọi qua association, tự động gán `user_id` cho đối tượng mới.

### 2. Sự khác biệt giữa `scope` và class method

- **Chainable:** Cả hai đều có thể nối chuỗi, nhưng `scope` luôn trả về `ActiveRecord::Relation` nên an toàn hơn khi chain.
- **Lambda:** `scope` yêu cầu logic phải nằm trong lambda, chỉ thực thi khi gọi, phù hợp với điều kiện động (ví dụ: thời gian).
- **Ngữ nghĩa:** `scope` dùng để định nghĩa truy vấn lọc/sắp xếp, class method có thể làm bất cứ việc gì.

### 3. Association trong Rails và các loại

- **Association:** Kết nối giữa hai model ActiveRecord, giúp thao tác dữ liệu liên quan dễ dàng hơn.
- **Các loại chính:**
    - `belongs_to`: Một-một (phía "nhiều"), ví dụ: `Micropost belongs_to User`.
    - `has_one`: Một-một (phía "một"), ví dụ: `User has_one Profile`.
    - `has_many`: Một-nhiều, ví dụ: `User has_many Microposts`.
    - `has_many :through`: Nhiều-nhiều qua model trung gian.
    - `has_one :through`: Một-một qua model trung gian.
    - `has_and_belongs_to_many`: Nhiều-nhiều không qua model trung gian.

### 4. Vì sao không nên dùng `default_scope`

- `default_scope` tự động áp dụng cho mọi truy vấn trên model.
- **Lý do không nên dùng:**
    - Có thể gây hành vi không mong muốn ở các truy vấn đặc biệt.
    - Khó ghi đè, phải dùng `Model.unscoped`.
    - Ảnh hưởng đến khởi tạo đối tượng mới.
    - Khó debug khi có lỗi truy vấn.

### 5. So sánh `count`, `size`, `length`

- **count:** Luôn thực hiện truy vấn `SELECT COUNT(*)` tới database, hiệu quả nếu collection chưa nạp.
- **length:** Nạp toàn bộ collection vào bộ nhớ rồi đếm, kém hiệu quả nếu chỉ cần đếm.
- **size:** 
    - Nếu chưa nạp collection, hoạt động như `count`.
    - Nếu đã nạp, hoạt động như `length`.

---

## Phần 2: Thực hành

### 1. N+1 Query là gì? Cách tránh

- **Vấn đề N+1:** Khi lặp qua danh sách và mỗi vòng lặp lại truy vấn database.
- **Cách tránh:** Dùng `includes`, `preload`, hoặc `eager_load` để nạp trước dữ liệu liên quan (Eager Loading).

### 2. Delegate trong Rails

- `delegate` giúp tạo phương thức ủy quyền, cho phép đối tượng gọi phương thức của đối tượng liên quan.
- Giúp code ngắn gọn, tuân thủ Law of Demeter.

### 3. Transaction trong Rails

- **Transaction:** Nhóm các thao tác database thành một đơn vị công việc. Nếu một thao tác thất bại, toàn bộ bị rollback.
- **Sử dụng:** `ActiveRecord::Base.transaction do ... end`
