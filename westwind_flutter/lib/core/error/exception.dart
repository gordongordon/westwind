

class ServerException implements Exception {

    final String message;
    const ServerException([this.message = "a problem occured! "]);


   @override
    String toString() {
      return message;
    }

}