
class EventResult<T> {
  T result;
  String error;
  bool isLoading, isSuccess,isError;

  EventResult({this.result, this.error, this.isLoading = false,this.isSuccess = false,this.isError = false });

  EventResult.loading() : this(isLoading : true);
  EventResult.success(T result) : this(result : result, isSuccess : true );
  EventResult.failure(String error) : this(error : error, isError : true );
}