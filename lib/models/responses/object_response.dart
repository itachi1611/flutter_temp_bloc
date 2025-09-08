import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class ObjectResponse<T> extends Equatable {
  final String? message;
  final int? status;
  final T? data;

  /// Pagination
  final int? pageNumber;
  final int? pageSize;
  final int? totalRecords;

  const ObjectResponse({
    this.message,
    this.status,
    this.data,
    this.pageNumber,
    this.pageSize,
    this.totalRecords,
  });

  ObjectResponse<T> copyWith({
    String? message,
    int? status,
    T? data,
    int? pageNumber,
    int? pageSize,
    int? totalRecords,
  }) => ObjectResponse<T>(
    message: message ?? this.message,
    status: status ?? this.status,
    data: data ?? this.data,
    pageNumber: pageNumber ?? this.pageNumber,
    pageSize: pageSize ?? this.pageSize,
    totalRecords: totalRecords ?? this.totalRecords,
  );

  factory ObjectResponse.fromJson(Map<String, dynamic> json, T Function(Object json) fromJsonT) {
    ObjectResponse<T> resultGeneric = ObjectResponse<T>(
      message: json['message'] as String?,
      status: json['status'] as int?,
      pageNumber: json['pageNumber'] as int?,
      pageSize: json['pageSize'] as int?,
      totalRecords: json['totalRecords'] as int?,
    );

    if (json['data'] != null) {
      return resultGeneric.copyWith(
        data: fromJsonT(json['data']),
      );
    }
    return resultGeneric;
  }

  @override
  List<Object?> get props => [this.message, this.status, this.data];
}
