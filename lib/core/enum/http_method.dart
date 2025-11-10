// ignore_for_file: camel_case_types, constant_identifier_names

enum HTTP_METHOD { GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD }

HTTP_METHOD httpMethodConvertFromString({required String value}) {
  switch (value) {
    case 'GET':
      return HTTP_METHOD.GET;
    case 'POST':
      return HTTP_METHOD.POST;
    case 'PUT':
      return HTTP_METHOD.PUT;
    case 'PATCH':
      return HTTP_METHOD.PATCH;
    case 'DELETE':
      return HTTP_METHOD.DELETE;
    case 'OPTIONS':
      return HTTP_METHOD.OPTIONS;
    case 'HEAD':
      return HTTP_METHOD.HEAD;
    default:
      return HTTP_METHOD.GET;
  }
}
