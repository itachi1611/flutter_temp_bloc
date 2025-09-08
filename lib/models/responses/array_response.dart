import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class ArrayResponse<T> extends Equatable {
  final String? message;
  final int? status;
  final List<T>? data;

  /// Pagination
  final int? pageNumber;
  final int? pageSize;
  final int? totalRecords;
  final int? totalPages;

  const ArrayResponse({
    this.message,
    this.status,
    this.data,
    this.pageNumber,
    this.pageSize,
    this.totalRecords,
    this.totalPages,
  });

  ArrayResponse<T> copyWith({
    String? message,
    int? status,
    List<T>? data,
    int? pageNumber,
    int? pageSize,
    int? totalRecords,
    int? totalPages,
  }) {
    return ArrayResponse<T>(
      message: message ?? this.message,
      status: status ?? this.status,
      data: data ?? this.data,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      totalRecords: totalRecords ?? this.totalRecords,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  factory ArrayResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    ArrayResponse<T> resultGeneric = ArrayResponse<T>(
      message: json['message'] as String?,
      status: json['status'] as int?,
      pageNumber: json['pageNumber'] as int?,
      pageSize: json['pageSize'] as int?,
      totalRecords: json['totalRecords'] as int?,
      totalPages: json['totalPages'] as int?,
    );

    if (json['data'] != null) {
      if (json['data'] is List?) {
        return resultGeneric.copyWith(
          data: (json['data'] as List).map(fromJsonT).toList(),
        );
      }
    }

    return resultGeneric;
  }

  @override
  List<Object?> get props => [
    message,
    status,
    data,
    pageSize,
    pageNumber,
    totalPages,
    totalRecords,
  ];
}
