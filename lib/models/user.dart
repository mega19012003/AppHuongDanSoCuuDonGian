
class User {
  int id; // ID duy nhất cho mỗi người dùng
  String email; // Tên đăng nhập
  String fullName; // Họ và tên
  int age; // Tuổi
  int gender; // Giới tính (Nam/Nữ/Khác)
  String phoneNumber; // Số điện thoại
  String? password; // Mật khẩu
  String role;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    this.password,
    required this.role,
  });

  // Phương thức chuyển đổi từ Map (Firebase) thành đối tượng User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      password: map['password'],
      role: map['role'] ?? 'user',
    );
  }

  // Phương thức chuyển đổi đối tượng User thành Map (để lưu vào Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'phoneNumber': phoneNumber,
      if (password != null) 'password': password, // Chỉ lưu mật khẩu nếu không null
      'role' : role
    };
  }
}
