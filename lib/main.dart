import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterDemo',
      theme: ThemeData(
          primaryColor: Colors.white
      ),
      home: RandomWord()
    );
  }

}
class RandomWordState extends State<RandomWord> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<prefix0.WordPair>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Start up num generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions()
    );
  }

  void _pushSaved() {

//    runUsingFuture() {
//      // ...
//      findEntryPoint().then((entryPoint) {
//        return runExecutable(entryPoint, args);
//      }).then(flushThenExit);
//    }


    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              final Iterable<ListTile> tiles = _saved.map(
                      (prefix0.WordPair pair) {
                    return ListTile(
                      title: Text(
                          pair.asPascalCase,
                          style: _biggerFont
                      ),
                    );
                  }
              );
              final divided = ListTile.divideTiles(
                  context: context,
                  tiles: tiles
              ).toList();

              return Scaffold(
                  appBar: AppBar(
                    title: Text('Saved Sugesstio'),
                  ),
                  body: ListView(children: divided)
              );
            }
        )

    );
  }


  Widget _buildSuggestions(){
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context,i){
          if(i.isOdd) return Divider();

          final index = i ~/2;
          if(index>=_suggestions.length){
            _suggestions.addAll(prefix0.generateWordPairs().take(10));
          }
          return _buildNow(_suggestions[index]);
        }
    );
  }

  Widget _buildNow(prefix0.WordPair pair) {
    final alreadyAdd = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadyAdd?Icons.favorite:Icons.favorite_border,
        color: alreadyAdd?Colors.red:null
      ),
      onTap: (){
        setState(() {
          if(alreadyAdd){
            _saved.remove(pair);
          }else {
            _saved.add(pair);
          }
        });
      }
    );
  }

}



class RandomWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordState();
  }


}