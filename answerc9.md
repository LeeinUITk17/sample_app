Phần 1: Lý thuyết

**Câu 1: Chức năng của `attr_accessor` là gì?**  
`attr_accessor` tạo ra thuộc tính ảo cho đối tượng, không tạo cột trong database. Nó tự động sinh cả phương thức "getter" và "setter" để đọc/gán giá trị cho thuộc tính. Ví dụ: `attr_accessor :remember_token` giúp lưu và truy cập `user.remember_token` tạm thời trước khi băm và lưu vào `remember_digest`.

**Câu 2: Phân biệt instance method và class method?**  
- *Instance method*: Được gọi trên một đối tượng cụ thể (ví dụ: `user.remember`), thao tác trên dữ liệu của đối tượng đó (`self.id`, `@name`).
- *Class method*: Được gọi trực tiếp trên lớp (ví dụ: `User.new_token`), không truy cập dữ liệu của đối tượng cụ thể, thường dùng cho các tác vụ chung như tạo đối tượng mới hoặc truy vấn toàn bộ bảng.

**Câu 3: Cookies là gì? Trình bày vòng đời của cookies**  
Cookies là dữ liệu nhỏ server gửi và lưu trên trình duyệt người dùng, được gửi lại server trong các request tiếp theo.

*Lifecycle:*
- **Tạo:** Server gửi cookie qua header `Set-Cookie` trong HTTP response (có giá trị, ngày hết hạn, domain, path).
- **Lưu trữ:** Trình duyệt nhận và lưu cookie.
- **Gửi lại:** Mỗi request đến cùng domain, trình duyệt tự động đính kèm cookie vào header `Cookie`.
- **Hết hạn/Xóa:** Cookie bị xóa khi đến ngày hết hạn, đóng trình duyệt, hoặc server gửi cookie với ngày hết hạn.

Phần 2: Thực hành

**Câu 1: Kiểm tra cookie trong trình duyệt sau khi đăng nhập**  
Sau khi đăng nhập, có các cookie sau:
- `name: _rails_tutorial_session`
- `value: "VN26cwUadKda5cvSedRHYyRKEblcojZO3B3084U6un%2Fv9LlpNdi3Dn6ab152xGpJrxdubv5XMD%2Bvpxsq%2F8JWAXZVxXSOGtsTMpWfple%2FmCLmLnaq3pShJLkNs%2Bg5iOgcbwhy%2BZzeaAh%2BTALupSOTTks7nRsWUa5TvyWR78yUw6m%2FbxJGGxOqLqjR06UXyB6vetTNkrX9V3e4Kz%2B%2BtvSZkTG3voAjge2h93Y0Ro%2B3Rx%2BadGgKxVqFIif%2BYWDENZefgblyuYIEevLevmRgdlO2X60lETxwkB5dIshMG8LYmExmhMOy1RJnabJch1MwlBM%3D--YeeJPkn4Q5rIn1PD--rxH6rR3ukFlafDrt05h5Jg%3D%3D"`
- `name: remember_token`
- `value: "6B-VfsNZzeweMRauqBlZtg"`
- `name: user_id`
- `value: "eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik1UQT0iLCJleHAiOm51bGwsInB1ciI6ImNvb2tpZS51c2VyX2lkIn19--42cc55452368a518a09de60dc0ee5ac041202882"`

**Câu 2: Kiểm tra cookie sau khi đăng xuất**  
Sau khi logout, các token liên quan đến xác thực đều bị xóa, chỉ còn lại:
- `name: _rails_tutorial_session`
- `value: "%2FrEcPxSobvvJFs3%2FKY5T7V8Ni%2Fk1v1vFV%2F4D25sl8vz6agnarZw9FtFmb5a0rocLrRPPz%2B1gYtlwjrRPX9YlWUMOPkSrGb71fMDx%2BxkUnY7YsRBQXras2OGAFcB12LIEiHlsNGLy%2FR8kkb9VNNKDWvdEAIMsUB1JB0ohDJ3yockRc2CxadLP%2BQyeLCvnO6HWyUgiDdrEFJ2Vt4Evf1Cn66ksCmkyOWu4bsfjb9DTINBIptS2qMTK%2FFwkEI3aMqV68WVc3%2BkcreQICmqpip7chrgcLpqa5F8kvwKcqBotcg%3D%3D--js2b14TAR8rjwm%2Fi--joPkMUSlIY0U%2BDiSWG3rKQ%3D%3D"`
