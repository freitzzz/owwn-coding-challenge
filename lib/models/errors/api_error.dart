class APIError {
  final String message;

  final String type;

  bool get isInvalidRequest => type == 'InvalidRequest';

  const APIError({
    required this.message,
    required this.type,
  });

  APIError.fromJson(
    final Map<String, dynamic> json,
  )   : message = json['message'] as String,
        type = json['error_type'] as String;
}
