class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.string :password_digest
      # Khi tạo tài khoản thành công, mật khẩu sẽ được hash và lưu dưới dạng:
      # "$2a$12$KIXob78sdajfNl6CvPCOCO2vYkJYYVvg9aQcEFvsfjAGJQhGuRWnK"
      # "$2a$" là thuật toán bcrypt
      # "12" là cost (độ phức tạp)
      # "KIXob78sdajfNl6CvPCOCO" là salt (22 ký tự)
      # "2vYkJYYVvg9aQcEFvsfjAGJQhGuRWnK" là body
      # Khi xác thực, server lấy phần salt và cost từ mật khẩu lưu trong database để hash với mật khẩu người dùng nhập để so sánh
      t.timestamps
    end
  end
end
