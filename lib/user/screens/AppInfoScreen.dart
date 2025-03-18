import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoPage extends StatefulWidget {
  @override
  _AppInfoPageState createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  String appName = "Đang tải...";
  String appVersion = "Đang tải...";
  String buildNumber = "Đang tải...";

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    try {
      // Lấy thông tin từ package_info_plus
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      setState(() {
        appName = packageInfo.appName;
        appVersion = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    } catch (e) {
      setState(() {
        appName = "Không thể tải thông tin";
        appVersion = "Lỗi: $e";
        buildNumber = "Lỗi: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin ứng dụng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên ứng dụng: $appName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Phiên bản: $appVersion', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Số bản build: $buildNumber', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
