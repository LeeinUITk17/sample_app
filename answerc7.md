Phần 1:

**Câu 1: Sự khác biệt giữa `find` và `find_by`**
- `find(id)`: Tìm bản ghi theo id. Nếu không tìm thấy, sẽ ném lỗi `ActiveRecord::RecordNotFound` (lỗi 404).
- `find_by(attribute: value)`: Tìm bản ghi đầu tiên khớp điều kiện. Nếu không tìm thấy, trả về `nil` (không lỗi).

**Câu 2: Strong Parameter là gì?**
- Là cơ chế bảo mật của Rails, chỉ cho phép các thuộc tính được chỉ định rõ ràng được cập nhật vào model từ người dùng, ngăn chặn gán thuộc tính hàng loạt không mong muốn (ví dụ: `admin: true`).

**Câu 3: Sự khác biệt giữa `resources` và `resource`**
- `resources :photos`: Tạo 7 routes chuẩn cho tập hợp đối tượng (index, show, new, create, edit, update, destroy), ví dụ: `/photos/1`.
- `resource :geocoder`: Tạo routes cho một tài nguyên duy nhất, không có route index, URL không cần id, ví dụ: `/geocoder/edit`.

**Câu 4: Nested Resource là gì?**
- Là cách định nghĩa routes lồng nhau, ví dụ: bài viết thuộc về người dùng. Sử dụng:  
    ```ruby
    resources :users do
        resources :posts
    end
    ```
    Tạo URL dạng: `/users/1/posts/5`.

**Câu 5: Sự khác biệt giữa `form_for` và `form_with`**
- `form_for`: Helper cũ, phổ biến ở Rails 4.x.
- `form_with`: Helper mới, linh hoạt hơn, dùng cho cả model và URL tùy ý, mặc định sử dụng AJAX (`remote: true`).

**Câu 6: Sự khác biệt giữa `redirect_to` và `render`**
- `render`: Hiển thị view cụ thể, không tạo request mới, URL không đổi, dùng được biến instance.
- `redirect_to`: Gửi HTTP response yêu cầu browser chuyển sang URL khác, tạo request mới, URL thay đổi, biến instance bị mất.