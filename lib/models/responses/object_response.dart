import 'package:equatable/equatable.dart';

class ObjectResponse<T> extends Equatable {
  final String? message;
  final T? data;

  const ObjectResponse({this.message, this.data});

  ObjectResponse<T> copyWith({
    String? message,
    T? data,
  }) =>
      ObjectResponse<T>(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ObjectResponse.fromJson(
      Map<String, dynamic> json, T Function(Object json) fromJsonT) {
    ObjectResponse<T> resultGeneric = ObjectResponse<T>(
      message: json['message'] as String,
    );
    if (json['data'] != null) {
      return resultGeneric.copyWith(
        data: fromJsonT(json['data']),
      );
    }
    return resultGeneric;
  }

  @override
  List<Object?> get props => [message, data];
}
