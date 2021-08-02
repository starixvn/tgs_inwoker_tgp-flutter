class EventResult<T> {
  T result;
  String error;
  int errorCode;
  bool isLoading, isSuccess, isError;
  bool isHandled = false; //always false when init
  String errorMsgId;

  EventResult(
      {this.result,
      this.error,
        this.errorCode,
      this.isLoading = false,
      this.isSuccess = false,
      this.isError = false,
      this.errorMsgId});

  EventResult.loading() : this(isLoading: true);
  EventResult.success(T result) : this(result: result, isSuccess: true);
  EventResult.failure(int errorCode, String error, String errorMsgId) : this(errorCode: errorCode, error: error, isError: true, errorMsgId: errorMsgId);
}
