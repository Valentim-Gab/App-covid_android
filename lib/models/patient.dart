class Patient {
  int? _id;
  String _nome;
  String _email;
  String _card;
  int _years;
  String _password;
  String _photo;

  Patient(this._nome, this._email, this._card, this._years, this._password,
      this._photo,
      {int? id})
      : _id = id;

  Map<String, dynamic> toMap() {
    return {
      'nome': _nome,
      'email': _email,
      'card': _card,
      'years': _years,
      'password': _password,
      'photo': _photo
    };
  }

  @override
  String toString() {
    return 'Patient(id: $_id, nome: $_nome, email: $_email, card: $_card, years: $_years, password: $_password, photo: $_photo)';
  }

  int? get id => _id;
  String get nome => _nome;
  String get email => _email;
  String get card => _card;
  int get years => _years;
  String get password => _password;
  String get photo => _photo;

  set id(int? id) {
    _id = id;
  }

  set nome(String nome) {
    _nome = nome;
  }

  set email(String email) {
    _email = email;
  }

  set card(String card) {
    _card = card;
  }

  set years(int years) {
    _years = years;
  }

  set password(String password) {
    _password = password;
  }

  set photo(String photo) {
    _photo = photo;
  }
}
