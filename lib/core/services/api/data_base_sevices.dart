abstract class DataBaseServices {

  Future<dynamic> getData({required String path, String? token});

  Future<dynamic> postData({required String path,required Map<String,dynamic>data,String?token});

  Future<dynamic> patchData({required String path, required Map<String, dynamic> data, String? token});

  Future<dynamic> deleteData({required String path, Map<String, dynamic>? data, String? token});
}
