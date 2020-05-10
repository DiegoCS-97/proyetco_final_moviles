import 'package:flutter/material.dart';

class EdicionPage extends StatelessWidget {
  const EdicionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: Color(0xff000000),
          title: new Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.assessment),
                onPressed: () {},
              ),
              SizedBox(
                width: 95,
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Color(0xff000000),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.save),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 105,
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 105,
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
