class EventResult<T> {
  T result;
  String error;
  int errorCode, responseError;
  bool isLoading, isSuccess, isError, isMaintenance;
  bool isHandled = false; //always false when init
  String errorMsgId;

  EventResult(
      {this.result,
      this.error,
      this.errorCode,
      this.isLoading = false,
      this.isSuccess = false,
      this.isError = false,
      this.isMaintenance = false,
      this.errorMsgId});

  EventResult.loading() : this(isLoading: true);

  EventResult.success(T result) : this(result: result, isSuccess: true);

  EventResult.failure(int errorCode, String error, String errorMsgId, int responseError)
      : this(
          errorCode: errorCode,
          error: error,
          isError: true,
          errorMsgId: errorMsgId,
        );

  EventResult.maintenance(T result) : this(result: result, isMaintenance: true);
}
