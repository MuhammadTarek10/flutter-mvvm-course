import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "notifications")
  int? numberOfNotifications;
  CustomerResponse(this.id, this.name, this.numberOfNotifications);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(this.phone, this.email, this.link);

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer, this.contacts);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgetPasswordResponse(this.support);

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  ServiceResponse(this.id, this.title, this.image);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'link')
  String? link;

  BannerResponse(this.id, this.title, this.image, this.link);

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  StoreResponse(this.id, this.title, this.image);

  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  List<ServiceResponse>? services;
  @JsonKey(name: 'banners')
  List<BannerResponse>? banners;
  @JsonKey(name: 'stores')
  List<StoreResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse(this.data);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class StoreDetailsDataResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'about')
  String? about;
  @JsonKey(name: 'service')
  String? service;

  StoreDetailsDataResponse(
    this.id,
    this.title,
    this.image,
    this.details,
    this.about,
    this.service,
  );

  factory StoreDetailsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsDataResponseToJson(this);
}
