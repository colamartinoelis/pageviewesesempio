import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroPagine {
  String title;
  String subtitle;
  Color colore;

  IntroPagine(
      {@required this.title, @required this.subtitle, @required this.colore});
}

final List<IntroPagine> _listaPagine = [
  new IntroPagine(
      title: 'WELCOME!!',
      subtitle:
          'is simply dummy text of the printing and typesetting industry. '
          'Lorem Ipsum has been the industry s standard dummy text ever '
          'Lorem Ipsum has been the industry s standard dummy text ever ',
      colore: Colors.blue),
  new IntroPagine(
      title: 'SECONDA PAGINA',
      subtitle:
          'is simply dummy text of the printing and typesetting industry. '
          'Lorem Ipsum has been the industry s standard dummy text ever ',
      colore: Colors.indigo),
  new IntroPagine(
      title: 'TERZA PAGINA',
      subtitle:
          'is simply dummy text of the printing and typesetting industry. '
          'Lorem Ipsum has been the industry s standard dummy text ever '
          'since the 1500s, when an unknown printer took a galley of type ',
      colore: Colors.teal),
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _lastPage = 2;
  int _paginaSelezionata = 0;
  final PageController _pageController = new PageController();

  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeyRegistrazione = GlobalKey<FormState>();

  final TextEditingController _pswController = new TextEditingController();
  final TextEditingController _pswConfermaController =
      new TextEditingController();

  String username;
  String mail;

  String usernameLogin;
  String pswLogin;

  void onPageSelezionata(int i) {
    setState(() {
      _paginaSelezionata = i;
    });
  }

  @override
  void dispose() {
    _pswController.clear();
    _pswConfermaController.clear();
    super.dispose();
  }

  void nextPage() {
    print('avanti');
    _pageController.animateToPage(_paginaSelezionata + 1,
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
  }

  void tornaIndietro() {
    _pageController.animateToPage(_paginaSelezionata - 1,
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
    print('indietro');
  }

  bool isLastPage() {
    return _paginaSelezionata == _listaPagine.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: _listaPagine[_paginaSelezionata].colore,
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: _paginaSelezionata == 0
              ? new Container(
                  color: Colors.transparent,
                )
              : new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: tornaIndietro,
                ),
          title: new Text(
            _listaPagine[_paginaSelezionata].title,
            style:
                new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            isLastPage()
                ? new IconButton(
                    icon: new Icon(Icons.check_circle),
                    onPressed: apreDialogRegistrazione,
                  )
                : new IconButton(
                    icon: new Icon(Icons.arrow_forward),
                    onPressed: nextPage,
                  )
          ]),
      body: new PageView.builder(
          itemCount: _listaPagine.length,
          onPageChanged: onPageSelezionata,
          controller: _pageController,
          itemBuilder: (context, index) {
            return new IntroPageView(_listaPagine[index]);
          }),
    );
  }

  void login() {
    showDialog(
      context: context,
      builder: (context) {
        return new Dialog(
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: new Container(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: new Form(
              key: _formKeyLogin,
              child: new SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Login',
                      style: new TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    new SizedBox(height: 32),
                    new TextFormField(
                        style: new TextStyle(
                          color: Colors.teal,
                        ),
                        cursorWidth: 4,
                        cursorColor: Colors.teal,
                        decoration: new InputDecoration(
                          hintText: 'inserire Username',
                          labelText: 'Username',
                          prefixIcon: new Icon(
                            Icons.account_circle,
                            color: Colors.teal,
                          ),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.teal, width: 1.8),
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.teal, width: 1.8),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.blue, width: 1.8),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Inserire username';
                          }
                          if (value.length < 3) {
                            return 'username troppo corta: almeno 3 lettere';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usernameLogin = value;
                        }),
                    new SizedBox(height: 16),
                    new TextFormField(
                        controller: _pswController,
                        //validator:,
                        obscureText: true,
                        style: new TextStyle(
                          color: Colors.teal,
                        ),
                        cursorWidth: 4,
                        cursorColor: Colors.teal,
                        decoration: new InputDecoration(
                          hintText: 'inserisci Password',
                          labelText: 'Password',
                          prefixIcon: new Icon(
                            Icons.lock,
                            color: Colors.teal,
                          ),
                          suffixIcon: new Icon(
                            Icons.visibility_off,
                            color: Colors.teal,
                          ),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.teal, width: 1.8),
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.teal, width: 1.8),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.blue, width: 1.8),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Inserire una psw';
                          }
                          /* r'^
                                          (?=.*[A-Z])       // should contain at least one upper case
                                          (?=.*[a-z])       // should contain at least one lower case
                                          (?=.*?[0-9])          // should contain at least one digit
                                         (?=.*?[!@#\$&*~]).{8,}  // should contain at least one Special character
                                         $' */

                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return 'inserire psw valida';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          pswLogin = value;
                        }),
                    new SizedBox(height: 32),
                    new MaterialButton(
                      height: 45,
                      shape: new RoundedRectangleBorder(
                          side: new BorderSide(color: Colors.teal, width: 1.8),
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        if (_formKeyLogin.currentState.validate()) {
                          print('tutto ok');
                          /* new  SnackBar(
                                              content:
                                                  Text('Processing Data')));*/
                        }
                      },
                      textColor: Colors.white,
                      minWidth: double.infinity,
                      child: new Text(
                        'submit',
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      color: Colors.teal,
                    ),
                    new SizedBox(height: 16),
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          new InkWell(
                              child: new Text(
                                '* Dimenticato password?',
                                style: new TextStyle(color: Colors.red),
                              ),
                              onTap: () => print(''))
                        ]),
                    new SizedBox(height: 22),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        new InkWell(
                          child: new Text(
                            '* Non sei Registrato? REGISTRATI!',
                            style: new TextStyle(
                                color: Colors.teal,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void apreDialogRegistrazione() {
    showDialog(
        context: context,
        builder: (_) => new Dialog(
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: new Container(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: new SingleChildScrollView(
                    child: new Form(
                        key: _formKeyRegistrazione,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  new InkWell(
                                    child: new Text(
                                      'Hai già un account? LOG IN!',
                                      style: new TextStyle(
                                          color: Colors.teal,
                                          decoration: TextDecoration.underline),
                                    ),
                                    onTap: login,
                                  ),
                                ],
                              ),
                              new SizedBox(height: 40),
                              new Text(
                                'Registrazione',
                                style: new TextStyle(
                                    fontSize: 32,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                              new SizedBox(height: 32),
                              new TextFormField(
                                  style: new TextStyle(
                                    color: Colors.teal,
                                  ),
                                  cursorWidth: 4,
                                  cursorColor: Colors.teal,
                                  decoration: new InputDecoration(
                                    hintText: 'inserire Username',
                                    labelText: 'Username',
                                    prefixIcon: new Icon(
                                      Icons.account_circle,
                                      color: Colors.teal,
                                    ),
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.teal, width: 1.8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    enabledBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.teal, width: 1.8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.blue, width: 1.8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Inserire username';
                                    }
                                    if (value.length < 3) {
                                      return 'username troppo corta: almeno 3 lettere';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    username = value;
                                    print(username);
                                    return username;
                                  }),
                              new SizedBox(height: 16),
                              new TextFormField(
                                style: new TextStyle(
                                  color: Colors.teal,
                                ),
                                cursorWidth: 4,
                                cursorColor: Colors.teal,
                                decoration: new InputDecoration(
                                  hintText: 'inserire email',
                                  labelText: 'Email',
                                  prefixIcon: new Icon(
                                    Icons.mail,
                                    color: Colors.teal,
                                  ),
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                  enabledBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.blue, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Inserire email';
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return 'email non valida';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  mail = value;
                                  print(mail);
                                  return mail;
                                },
                              ),
                              new SizedBox(height: 16),
                              new TextFormField(
                                  controller: _pswController,
                                  //validator:,
                                  obscureText: true,
                                  style: new TextStyle(
                                    color: Colors.teal,
                                  ),
                                  cursorWidth: 4,
                                  cursorColor: Colors.teal,
                                  decoration: new InputDecoration(
                                    hintText: 'inserisci Password',
                                    labelText: 'Password',
                                    prefixIcon: new Icon(
                                      Icons.lock,
                                      color: Colors.teal,
                                    ),
                                    suffixIcon: new Icon(
                                      Icons.visibility_off,
                                      color: Colors.teal,
                                    ),
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.teal, width: 1.8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    enabledBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.teal, width: 1.8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.blue, width: 1.8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Inserire una psw';
                                    }
                                    /* r'^
                                          (?=.*[A-Z])       // should contain at least one upper case
                                          (?=.*[a-z])       // should contain at least one lower case
                                          (?=.*?[0-9])          // should contain at least one digit
                                         (?=.*?[!@#\$&*~]).{8,}  // should contain at least one Special character
                                         $' */

                                    if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(value)) {
                                      return 'inserire psw valida';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _pswController.text = value;
                                    print(_pswController.text);
                                  }),
                              new SizedBox(height: 12),
                              new TextFormField(
                                controller: _pswConfermaController,
                                //validator:,
                                obscureText: true,
                                style: new TextStyle(
                                  color: Colors.teal,
                                ),
                                cursorWidth: 4,
                                cursorColor: Colors.teal,
                                decoration: new InputDecoration(
                                  hintText: 'ripeti password',
                                  labelText: 'ripeti password',
                                  prefixIcon: new Icon(
                                    Icons.lock,
                                    color: Colors.teal,
                                  ),
                                  suffixIcon: new Icon(
                                    Icons.visibility_off,
                                    color: Colors.teal,
                                  ),
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                  enabledBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.teal, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.blue, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Inserire psw valida';
                                  }
                                  if (value != _pswController.text) {
                                    return 'psw non corretta';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _pswConfermaController.text = value;
                                  print(
                                      'questa è la psw confermata: ${_pswConfermaController}');
                                },
                              ),
                              new SizedBox(height: 32),
                              new MaterialButton(
                                  height: 45,
                                  shape: new RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Colors.teal, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                  textColor: Colors.white,
                                  minWidth: double.infinity,
                                  child: new Text(
                                    'submit',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.teal,
                                  onPressed: () {
                                    if (_formKeyRegistrazione.currentState
                                        .validate()) {
                                      print('tutto ok');
                                      /* new  SnackBar(
                                              content:
                                                  Text('Processing Data')));*/
                                    }
                                  }),
                              new SizedBox(height: 32),
                              new InkWell(
                                child: new Text(
                                  'Entra senza Account!',
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ]))))));
  }
}

class IntroPageView extends StatelessWidget {
  IntroPageView(this.intropage);

  final IntroPagine intropage;

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new SafeArea(
          child: ListTile(
              title: new Text(
                _listaPagine[0].title,
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              contentPadding: EdgeInsets.only(top: 20),
              subtitle: new Padding(
                  padding: EdgeInsets.all(20),
                  child: new Text(
                    _listaPagine[2].subtitle,
                    style: new TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ))),
        )
      ],
    );
  }
}
