class Islamic {
  int id;
  String title;
  String subject;

  User(int id, String name, String subject) {
    this.id = id;
    this.title = title;
    this.subject = subject;
  }

  Islamic.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        subject = json['subject'];

  Map toJson() {
    return {'id': id, 'title': title, 'subject': subject};
  }
}
class Gellary {
  int id;
  String title;
  String typedesign;
  String path;

  Gellary(int id, String name, String typedesign, String path) {
    this.id = id;
    this.title = title;
    this.typedesign = typedesign;
    this.path = path;
  }

  Gellary.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        typedesign = json['typedesign'],
        path = json['path'];

  Map toJson() {
    return {'id': id, 'title': title, 'typedesign': typedesign, 'path': path};
  }
}
class Cash {
  int id;
  int cash;
  String killo;

  Cash(int id, int cash , String killo) {
    this.id = id;
    this.cash = cash;
    this.killo = killo;

  }

  Cash.fromJson(Map json)
      : id = json['id'],
        cash = json['cash'],
        killo = json['killo'];

  Map toJson() {
    return {'id': id,'cash': cash,'killo': killo};
  }
}

class Orders {
  int id;
  int typeorder;
  String title;
  String state;
  String numberhome;
  String cash;
  String build;
  String area;
  String description;
  String fileimage;
  String filepdf;
  String username;
  String phone;
  int level;
  String money;


  Orders(int id, int typeorder, String title, String state, String numberhome, String cash
      ,String build, String area, String description, String fileimage, String filepdf, String username
      ,String phone, int level, String money
      ) {
    this.id = id;
    this.typeorder = typeorder;
    this.title = title;
    this.state = state;
    this.numberhome = numberhome;
    this.cash = cash;
    this.build = build;
    this.area = area;
    this.description = description;
    this.fileimage = fileimage;
    this.filepdf = filepdf;
    this.username = username;
    this.phone = phone;
    this.level = level;
    this.money = money;
  }

  Orders.fromJson(Map json)
      :id = json["id"],
        typeorder = json["typeorder"],
        title = json["title"],
        state = json["state"],
        numberhome = json["numberhome"],
        cash = json["cash"],
        build = json["build"],
        area = json["area"],
        description = json["description"],
        fileimage = json["fileimage"],
        filepdf = json["filepdf"],
        username = json["username"],
        phone = json["phone"],
        level = json["level"],
        money = json["money"];

  Map toJson() {
    return {'id':id,  'typeorder':typeorder,  'title':title,  'state':state,  'numberhome':numberhome,  'cash':cash
      , 'build':build,  'area':area,  'description':description,  'fileimage':fileimage,  'filepdf':filepdf,  'username':username
      , 'phone':phone,  'level':level,  'money':money};
  }
}

class Admins {
  int id;
  String email;
  String password;
  String realname;
  String phone;
  String address;
  int role;

  Admins(int id, String email, String password, String realname, String phone, String address, int role) {
    this.id = id;
    this.email = email;
    this.password = password;
    this.realname = realname;
    this.phone = phone;
    this.address = address;
    this.role = role;
  }

  Admins.fromJson(Map json)
      : id = json['id'],
        email = json['email'],
        password = json['password'],
        realname = json['realname'],
        phone = json['phone'],
        address = json['address'],
        role = json['role'];

  Map toJson() {
    return {'id': id, 'email': email, 'password': password, 'realname,': realname,'phone,': phone,'address,': address,'role,': role};
  }
}


class Carttable {
  int id;
  int userid;
  String killo;
  int number;
  int cash;
  int total;
  int level;
  String away;
  String adminname;
  String dateorder;
  String notice;

  Carttable(int id, int userid, String killo, int number,
      int cash, int total, int level,
      String away, String adminname, String dateorder, String notice) {
    this.id = id;
    this.userid = userid;
    this.killo = killo;
    this.number = number;
    this.cash = cash;
    this.total = total;
    this.level = level;
    this.away = away;
    this.adminname = adminname;
    this.dateorder = dateorder;
    this.notice = notice;
  }

  Carttable.fromJson(Map json)
      : id = json['id'],
        userid = json['userid'],
        killo = json['killo'],
        number = json['number'],
        cash = json['cash'],
        total = json['total'],
        level = json['level'],
        away = json['away'],
        adminname = json['adminname'],
        dateorder = json['dateorder'],
        notice = json['notice'];

  Map toJson() {
    return {'id': id,  'userid': userid, 'killo,': killo,'number,': number,
      'cash,': cash, 'total,': total,'level,': level ,'away,': away,'adimname,': adminname
      ,'dayorder,': dateorder,'notice,': notice};
  }
}

class Totalcart {
  int id;
  int total;
  int userid;
  String adminname;
  String dateorder;
  int level;
  String username;
  String address;
  String phone;

  Totalcart(int id, int total, int userid,
      String adminname, String dateorder,
      int level, String username, String address , String phone) {
    this.id = id;
    this.total = total;
    this.userid = userid;
    this.adminname = adminname;
    this.dateorder = dateorder;
    this.level = level;
    this.username = username;
    this.address = address;
    this.phone = phone;
  }

  Totalcart.fromJson(Map json)
      : id = json['id'],
        total = json['total'],
        userid = json['userid'],
        adminname = json['adminname'],
        dateorder = json['dateorder'],
        level = json['level'],
        username = json['username'],
        address = json['address'],
        phone = json['phone'];
  Map toJson() {
    return {'id': id,  'total': total, 'userid,': userid,'adminname,': adminname,
      'dateorder,': dateorder, 'level,': level,'username,': username ,'address,': address,'phone,': phone};
  }
}