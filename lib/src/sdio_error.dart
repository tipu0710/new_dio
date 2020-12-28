import 'options.dart';
import 'response.dart';

enum SDioErrorType {
  /// It occurs when url is opened timeout.
  CONNECT_TIMEOUT,

  /// It occurs when url is sent timeout.
  SEND_TIMEOUT,

  ///It occurs when receiving timeout.
  RECEIVE_TIMEOUT,

  /// When the server response, but with a incorrect status, such as 404, 503...
  RESPONSE,

  /// When the request is cancelled, sDio will throw a error with this type.
  CANCEL,

  /// Default error type, Some other Error. In this case, you can
  /// use the SDioError.error if it is not null.
  DEFAULT,
}

/// SDioError describes the error info  when request failed.
class SDioError implements Exception {
  SDioError({
    this.request,
    this.response,
    this.type = SDioErrorType.DEFAULT,
    this.error,
  });

  /// Request info.
  RequestOptions request;

  /// Response info, it may be `null` if the request can't reach to
  /// the http server, for example, occurring a dns error, network is not available.
  Response response;

  SDioErrorType type;

  /// The original error/exception object; It's usually not null when `type`
  /// is SDioErrorType.DEFAULT
  dynamic error;

  String get message => (error?.toString() ?? '');

  @override
  String toString() {
    var msg = 'SDioError [$type]: $message';
    if (error is Error) {
      msg += '\n${error.stackTrace}';
    }
    return msg;
  }
}
