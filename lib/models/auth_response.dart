class AuthResponse {
  Response response;

  AuthResponse({this.response});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class Response {
  String status;
  List<Messages> messages;
  String token;
  String tokenExpiration;

  Response({this.status, this.messages, this.token, this.tokenExpiration});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['messages'] != null) {
      messages = new List<Messages>();
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
    token = json['token'];
    tokenExpiration = json['tokenExpiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    data['tokenExpiration'] = this.tokenExpiration;
    return data;
  }
}

class Messages {
  String message;

  Messages({this.message});

  Messages.fromJson(Map<String, dynamic> json) {
   message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
