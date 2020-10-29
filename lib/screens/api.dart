import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://www.semicolon-sd.com";

class API {
  static Future getUsers() async {
    var url = baseUrl + "/covid19/islamic";
    return http.get(url);
  }
}

class DOAA {
  static Future getDoaa() async {
    var urldoaa = baseUrl + "/covid19/doaa";
    return await http.get(urldoaa);
  }
}

class Groupsdata {
  static Future getGroups() async {
    var urlgroups = baseUrl + "/covid19/groups";
    return http.get(urlgroups);
  }
}
class Azkar {

  static Future getZekr(String type) async {
    var urlazkar = baseUrl + "/covid19/azkar/$type";
    return http.get(urlazkar);
  }
}
  class Designs {

  static Future getDesigns(String type) async {
  var urldesigns = baseUrl + "/covid19/studio/$type";
  return http.get(urldesigns);
  }

}

class Cashdata {
  static Future getCashdata() async {
    var urldatacash ="http://semicolon-sd.com//covid19/datacash";
    return http.get(urldatacash);
  }
}
  class Inbox {
    static Future getInbox() async {
      var urlinbox = baseUrl + "/covid19/inbox";
      return http.get(urlinbox);
    }
  }
  class Outbox {

  static Future getOutbox() async {
  var urloutboxa = baseUrl + "/covid19/outbox";
  return http.get(urloutboxa);
  }
}

class Admin {
  static Future getUsers(int role) async {
    var urladmin = baseUrl + "/covid19/usersmeat/$role";
    return http.get(urladmin);
  }
}

class Userdata {
  static Future getUsersdata() async {
    var urlusers = baseUrl + "/covid19/usersmeat/1";
    return http.get(urlusers);
  }
}
class Studiogellary {

  static Future getstudio() async {
    var urlstudio = baseUrl + "/covid19/studiogellary";
    return http.get(urlstudio);
  }
}
class Studioold {

  static Future getold() async {
    var urlold = baseUrl + "/covid19/studioold";
    return http.get(urlold);
  }
}

  class Cart {

  static Future getCart(String id , int level) async {
  var urlcart = baseUrl + "/covid19/mycart/$id/$level";
  return http.get(urlcart);
  }

  static Future getOrders(int level) async {
    var urlcart = baseUrl + "/covid19/mycartorders/$level";
    return http.get(urlcart);
  }
  static Future cartOrders() async {
    var urlcartorders= baseUrl + "/covid19/cartorders/";
    return http.get(urlcartorders);
  }

}

