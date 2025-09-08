import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class ErrorResponse extends Equatable {
  final int? statusCode;
  final String? message;
  final dynamic errors;

  const ErrorResponse({
    this.message,
    this.statusCode,
    this.errors
  });

  String get errMess {
    if (errors != null) {
      if (errors is List<String> && errors.isNotEmpty) {
        final messNumbs = errors.length;
        if (messNumbs == 1) {
          return errors.first;
        } else {
          return ''; // Or concatenate the messages if needed
        }
      } else if (errors is Map<String, dynamic>) {
        // Handle Map<String, dynamic> case
        return errors.values.map((e) {
          if (e is List) {
            return e.join(', ');
          }
          return e.toString();
        }).join(', ');
      }
    }
    return '';
  }

  ErrorResponse copyWith({
    String? message,
    int? statusCode,
    dynamic errors,
  }) => ErrorResponse(
    message: message ?? this.message,
    statusCode: statusCode ?? this.statusCode,
    errors: errors ?? this.errors,
  );

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
      errors: _parseErrors(json['errors']),
    );
  }

  static dynamic _parseErrors(dynamic errorsField) {
    if (errorsField is List<dynamic>) {
      return errorsField.cast<String>(); // Parse as List<String>
    } else if (errorsField is Map<String, dynamic>) {
      // Handle Map<String, List<String>> or Map<String, String>
      return errorsField.map((key, value) {
        if (value is List<dynamic>) {
          return MapEntry(key, value.cast<String>());
        }
        return MapEntry(key, value.toString());
      });
    } else {
      return null; // Return null if type is unexpected
    }
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'errors': errors,
    };
  }

  @override
  List<Object?> get props => [message, statusCode, errors];
}
