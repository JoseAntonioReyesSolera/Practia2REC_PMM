import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = [];
  ScrollController _scrollController = ScrollController();

  Color _textColor = Colors.white;  // Color inicial del texto

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController);
      // Cambiar el color del texto cuando el scroll avance
      setState(() {
        if (_scrollController.offset > 120) {  // Cuando el offset sea mayor a 120, cambia el color
          _textColor = Colors.black;
        } else {
          _textColor = Colors.white;
        }
      });
    });
  }

  void _addItem() {
    final newItem = "AnimatedList ${_items.length + 1}";
    _items.insert(0, newItem);
    _listKey.currentState?.insertItem(0);
  }

  void _removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      final removedItem = _items[index];
      _items.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildItem(removedItem, animation),
      );
    }
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
        Tween(begin: Offset(-1, 0), end: Offset(0, 0))
            .chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: ListTile(
        title: Text(item),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            final index = _items.indexOf(item);
            if (index >= 0) _removeItem(index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,  // Asignamos el controlador para el scroll
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.blue,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'SliverAppBar',
                style: TextStyle(color: _textColor),  // Cambia el color del texto dinámicamente
              ),
              background: Image.asset(
                'assets/imgWallPaper.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index, animation) {
                return _buildItem(_items[index], animation);
              },
            ),
          ),
        ],
      ),
    );
  }
}
