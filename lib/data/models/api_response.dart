class ApiResponse<T> {
  final int code;
  final String? message;
  final T? data;

  ApiResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }
}
