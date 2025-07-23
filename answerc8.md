Phần 1: Câu hỏi lý thuyết

**Câu 1: What is a session?**  
Session là cơ chế duy trì trạng thái người dùng, được Rails triển khai qua cookies. Nó giúp ứng dụng nhận diện người dùng qua nhiều request.

**Câu 2: How is the session life cycle?**  
Session bắt đầu khi người dùng đăng nhập (`session[:user_id]`), tồn tại trong suốt phiên làm việc, và kết thúc khi người dùng đăng xuất (`reset_session`) hoặc đóng trình duyệt.

**Câu 3: Why need to use session?**  
Session dùng để xác thực người dùng, cho phép truy cập các trang yêu cầu đăng nhập, và nâng cao trải nghiệm (ví dụ: hiển thị "Chào, + tên người dùng"). Nếu không có session, người dùng phải đăng nhập lại mỗi lần tải trang.

**Câu 4: What is the difference between GET vs. POST?**  
- GET: Lấy dữ liệu, gửi qua URL, giới hạn độ dài, không an toàn cho dữ liệu nhạy cảm, có thể bookmark.  
- POST: Gửi dữ liệu để tạo/cập nhật tài nguyên, dữ liệu nằm trong body, an toàn hơn, không giới hạn độ dài.

**Câu 5: What is the difference between PUT vs. PATCH?**  
- PUT: Thay thế toàn bộ tài nguyên, gửi một vài thuộc tính có thể làm mất các thuộc tính còn lại.  
- PATCH: Cập nhật một phần tài nguyên, chỉ gửi các thuộc tính cần thay đổi, thường dùng trong form "Edit".

Phần 2: Câu hỏi thực hành

**Câu 1: What is the difference between GET /login path and POST /login path?**  
- GET /login: Map tới `sessions#new`, hiển thị form đăng nhập.  
- POST /login: Map tới `sessions#create`, xử lý dữ liệu đăng nhập và tạo session mới.

**Câu 2: Log in with a valid user and inspect your browser's cookies. What is the value of the session content?**  
- name: `_rails_tutorial_session`  
- Cookie Value: `"0ND2MICcDsH%2FPznZULKpLQt3cUUhuRIzdixKrjUKlUbsfKKEUE5o6HzlHLpnswpSgIqDiGBK%2B%2FuzcSgEa0nU4GJiIBwnJ%2BCRMDpbFXlOoBUP%2BBDixB6k5wR9oUEta%2Bsq%2BHTPuyjilpq6tKnjj3DiceKt%2BQUqoGfGcHu3rG8qKcKez1Ks3A6k3PDOekRVJCUbSTswTWgA2%2FQDtCyaGaPclzavFvDjEbHmANrp6hm1B1gN5hKW2%2F5uBetCS51KCVcp8tc%2BR0r4%2F34An5idiEqpnoTI0E0PlwGE3qFcWRB%2FozyyqJaFMW1UrJ96Q%2FQCap4%3D--LrL3D%2BNHd%2FngOisS--1A3ntx2ziSeFFipGF7FpNw%3D%3D"`
