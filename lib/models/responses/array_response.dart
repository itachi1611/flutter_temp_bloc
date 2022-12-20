import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class ArrayResponse<T> extends Equatable {
  final int? page;
  final int? pageSize;
  final int? totalPages;
  final List<T>? results;
  final int? total;
  final int? code;
  final int? sum;
  final bool? isJoinAnyGroup;

  const ArrayResponse({
    this.page,
    this.pageSize,
    this.totalPages,
    this.results,
    this.total,
    this.code,
    this.sum,
    this.isJoinAnyGroup,
  });

  ArrayResponse<T> copyWith({
    int? page,
    int? pageSize,
    int? totalPages,
    List<T>? results,
    int? total,
    int? code,
    int? sum,
    bool? isJoinAnyGroup,
  }) {
    return ArrayResponse<T>(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      results: results ?? this.results,
      total: total ?? this.total,
      code: code ?? this.code,
      sum: sum ?? this.sum,
      isJoinAnyGroup: isJoinAnyGroup ?? this.isJoinAnyGroup,
    );
  }

  factory ArrayResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    ArrayResponse<T> resultGeneric = ArrayResponse<T>(
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 1,
      totalPages: json['totalPages'] as int? ?? 1,
      total: json['total'] as int? ?? 1,
      code: json['code'] as int? ?? 1,
      sum: json['sum'] as int? ?? 1,
      isJoinAnyGroup: json['isJoinAnyGroup'] as bool? ?? false,
    );
    if (json['rows'] != null) {
      if (json['rows'] is List?) {
        return resultGeneric.copyWith(
          results: (json['rows'] as List).map(fromJsonT).toList(),
        );
      }
    } else if (json['data'] != null) {
      if (json['data'] is List?) {
        return resultGeneric.copyWith(
          results: (json['data'] as List).map(fromJsonT).toList(),
        );
      }
    }
    return resultGeneric;
  }

  @override
  List<Object?> get props => [
        page,
        pageSize,
        totalPages,
        results,
        code,
        sum,
        isJoinAnyGroup,
      ];
}
