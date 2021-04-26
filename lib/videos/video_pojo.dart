class VideoPojo{
  Data data;

  VideoPojo({this.data});

  VideoPojo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Links links;
  Meta meta;
  List<Orders> orders;
  String welcomeVideo;
  String message;

  Data({this.links, this.meta, this.orders, this.welcomeVideo, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
    welcomeVideo = json['welcome_video'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['welcome_video'] = this.welcomeVideo;
    data['message'] = this.message;
    return data;
  }
}

class Links {
  String first;
  String last;
  String prev;
  String next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first']!=null?json['first']:"";
    last = json['last']!=null?json['last']:"";
    prev = json['prev']!=null?json['prev']:"";
    next = json['next']!=null?json['next']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Orders {
  String id;
  String userId;
  String baseUrl;
  String videoThumbImage;
  String videoFile;
  String videoRecording;
  String videoTitle;
  String videoDescription;
  String stateId;
  String citiId;
  String videoLocality;
  String videoTag;
  String videoCategory;
  String headLine;
  String categoryId;
  String metaTitle;
  String metaKeywords;
  String metaDescription;
  String stateName;
  String cityName;
  String country;
  String lat;
  String lng;
  String pincode;
  String videoFrom;
  String approve;
  String status;
  String isReporter;
  String shareCount;
  String createdAt;
  String updatedAt;
  String reporterName;
  String reporterImage;
  String channelName;
  String likesCount;
  String achchaCount;
  String theekHaiCount;
  String dislikesCount;
  String viewsCount;
  String commentCount;
  String shareLink;
  String likes;
  String dislike;

  Orders(
      {this.id,
        this.userId,
        this.baseUrl,
        this.videoThumbImage,
        this.videoFile,
        this.videoRecording,
        this.videoTitle,
        this.videoDescription,
        this.stateId,
        this.citiId,
        this.videoLocality,
        this.videoTag,
        this.videoCategory,
        this.headLine,
        this.categoryId,
        this.metaTitle,
        this.metaKeywords,
        this.metaDescription,
        this.stateName,
        this.cityName,
        this.country,
        this.lat,
        this.lng,
        this.pincode,
        this.videoFrom,
        this.approve,
        this.status,
        this.isReporter,
        this.shareCount,
        this.createdAt,
        this.updatedAt,
        this.reporterName,
        this.reporterImage,
        this.channelName,
        this.likesCount,
        this.achchaCount,
        this.theekHaiCount,
        this.dislikesCount,
        this.viewsCount,
        this.commentCount,
        this.shareLink,
        this.likes,
        this.dislike});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id']!=null?json['id'].toString():"";
    userId = json['user_id']!=null?json['user_id'].toString():"";
    baseUrl = json['base_url']!=null?json['base_url'].toString():"";
    videoThumbImage = json['video_thumb_image']!=null?json['video_thumb_image'].toString():"";
    videoFile = json['video_file']!=null?json['video_file'].toString():"";
    videoRecording = json['video_recording']!=null?json['video_recording'].toString():"";
    videoTitle = json['video_title']!=null?json['video_title'].toString():"";
    videoDescription = json['video_description']!=null?json['video_description'].toString():"";
    stateId = json['state_id']!=null?json['state_id'].toString():"";
    citiId = json['citi_id']!=null?json['citi_id'].toString():"";
    videoLocality = json['video_locality']!=null?json['video_locality'].toString():"";
    videoTag = json['video_tag']!=null?json['video_tag'].toString():"";
    videoCategory = json['video_category']!=null?json['video_category'].toString():"";
    headLine = json['head_line']!=null?json['head_line'].toString():"";
    categoryId = json['category_id']!=null?json['category_id'].toString():"";
    metaTitle = json['meta_title']!=null?json['meta_title'].toString():"";
    metaKeywords = json['meta_keywords']!=null? json['meta_keywords'].toString():"";
    metaDescription = json['meta_description']!=null?json['meta_description'].toString():"";
    stateName = json['state_name']!=null?json['state_name'].toString():"";
    cityName = json['city_name']!=null? json['city_name'].toString():"";
    country = json['country']!=null?json['country'].toString():"";
    lat = json['lat']!=null?json['lat'].toString():"";
    lng = json['lng']!=null?json['lng'].toString():"";
    pincode = json['pincode']!=null?json['pincode'].toString():"";
    videoFrom = json['video_from']!=null?json['video_from'].toString():"";
    approve = json['approve']!=null?json['approve'].toString():"";
    status = json['status']!=null?json['status'].toString():"";
    isReporter = json['is_reporter']!=null? json['is_reporter'].toString():"";
    shareCount = json['share_count']!=null?json['share_count'].toString():"";
    createdAt = json['created_at']!=null?json['created_at'].toString():"";
    updatedAt = json['updated_at']!=null?json['updated_at'].toString():"";
    reporterName = json['reporter_name']!=null?json['reporter_name'].toString():"";
    reporterImage = json['reporter_image']!=null?json['reporter_image'].toString():"";
    channelName = json['channel_name']!=null?json['channel_name'].toString():"";
    likesCount = json['likes_count']!=null?json['likes_count'].toString():"";
    achchaCount = json['achcha_count']!=null?json['achcha_count'].toString():"";
    theekHaiCount = json['theek_hai_count']!=null?json['theek_hai_count'].toString():"";
    dislikesCount = json['dislikes_count']!=null?json['dislikes_count'].toString():"";
    viewsCount = json['views_count']!=null?json['views_count'].toString():"";
    commentCount = json['comment_count']!=null?json['comment_count'].toString():"";
    shareLink = json['share_link']!=null?json['share_link'].toString():"";
    likes = json['likes']!=null?json['likes'].toString():"";
    dislike = json['dislike']!=null?json['dislike'].toString():"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['base_url'] = this.baseUrl;
    data['video_thumb_image'] = this.videoThumbImage;
    data['video_file'] = this.videoFile;
    data['video_recording'] = this.videoRecording;
    data['video_title'] = this.videoTitle;
    data['video_description'] = this.videoDescription;
    data['state_id'] = this.stateId;
    data['citi_id'] = this.citiId;
    data['video_locality'] = this.videoLocality;
    data['video_tag'] = this.videoTag;
    data['video_category'] = this.videoCategory;
    data['head_line'] = this.headLine;
    data['category_id'] = this.categoryId;
    data['meta_title'] = this.metaTitle;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['pincode'] = this.pincode;
    data['video_from'] = this.videoFrom;
    data['approve'] = this.approve;
    data['status'] = this.status;
    data['is_reporter'] = this.isReporter;
    data['share_count'] = this.shareCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reporter_name'] = this.reporterName;
    data['reporter_image'] = this.reporterImage;
    data['channel_name'] = this.channelName;
    data['likes_count'] = this.likesCount;
    data['achcha_count'] = this.achchaCount;
    data['theek_hai_count'] = this.theekHaiCount;
    data['dislikes_count'] = this.dislikesCount;
    data['views_count'] = this.viewsCount;
    data['comment_count'] = this.commentCount;
    data['share_link'] = this.shareLink;
    data['likes'] = this.likes;
    data['dislike'] = this.dislike;
    return data;
  }
}