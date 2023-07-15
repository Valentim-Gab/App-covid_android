class Patient {
  final int _id;
  String _nome;
  String _email;
  String _cartao;
  int _idade;
  String _senha;

  Patient(this._id, this._nome, this._email, this._cartao, this._idade,
      this._senha);

  int get id => _id;
  String get nome => _nome;
  String get email => _email;
  String get cartao => _cartao;
  int get idade => _idade;
  String get senha => _senha;

  set nome(String nome) {
    _nome = nome;
  }

  set email(String email) {
    _email = email;
  }

  set cartao(String cartao) {
    _cartao = cartao;
  }

  set idade(int idade) {
    _idade = idade;
  }

  set senha(String senha) {
    _senha = senha;
  }
}
