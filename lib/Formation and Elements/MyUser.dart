//Mit dieser Klasse kann die UserID global gespeichert werden, so muss diese nicht von Seite zu Seite übertragen werden
class MyUser {
  static final MyUser _instance = MyUser._internal();
  factory MyUser()=> _instance;

  MyUser._internal(){
    _myUserId = 0;
  }

  int? _myUserId;

  int get myUserId => _myUserId!;

  set myUserId(int value) => _myUserId = value;
}
