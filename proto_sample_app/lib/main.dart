import 'package:flutter/material.dart';
import 'package:proto_sample/generated/sign_in.pb.dart';

import 'api_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController? usernameController, passController;
  SignInResponse? signInResponse;
  bool loading = false;
  String? res;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passController = TextEditingController();
  }

  void nodeSignIn(SignIn signIn) {
    setState(() {
      loading = true;
      signInResponse = null;
    });

    ApiCalls().signIn(ApiCalls.nodeBaseUrl, signIn).then((value) {
      setState(() {
        signInResponse = value;
        loading = false;
        res = signInResponse.toString();
      });
    }).catchError((error) {
      setState(() {
        loading = false;
        res = error;
      });
    });
  }

  void pythonSignIn(SignIn signIn) {
    setState(() {
      loading = true;
      signInResponse = null;
    });

    var signIn = SignIn(username: usernameController?.text, password: passController?.text);

    ApiCalls().signIn(ApiCalls.pythonBaseUrl, signIn).then((value) {
      setState(() {
        signInResponse = value;
        loading = false;
        res = signInResponse.toString();
      });
    }).catchError((error) {
      setState(() {
        loading = false;
        res = error;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passController,
                decoration: const InputDecoration(hintText: 'password'),
              ),
              const SizedBox(height: 20),
              Text(
                'Status:',
                style: Theme.of(context).textTheme.headline6,
              ),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      (res ?? 'Null').toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
              TextButton(
                onPressed: () => nodeSignIn(SignIn(username: usernameController?.text, password: passController?.text)),
                child: const Text('Node SignIn'),
              ),
              TextButton(
                onPressed: () => pythonSignIn(SignIn(username: usernameController?.text, password: passController?.text)),
                child: const Text('Python SignIn'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
