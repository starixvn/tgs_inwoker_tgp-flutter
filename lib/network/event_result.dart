class EventResult<T> {
  T result;
  String error;
  int errorCode;
  bool isLoading, isSuccess, isError;
  bool isHandled = false; //always false when init

  EventResult(
      {this.result,
      this.error,
        this.errorCode,
      this.isLoading = false,
      this.isSuccess = false,
      this.isError = false});

  EventResult.loading() : this(isLoading: true);
  EventResult.success(T result) : this(result: result, isSuccess: true);
  EventResult.failure(int errorCode, String error) : this(errorCode: errorCode, error: error, isError: true);
}
