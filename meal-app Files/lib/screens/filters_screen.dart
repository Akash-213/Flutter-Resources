import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currFilters;

  FiltersScreen(this.saveFilters, this.currFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;

  @override
  initState() {
    _glutenFree = widget.currFilters['gluten'];
    _lactoseFree = widget.currFilters['lactose'];
    _vegan = widget.currFilters['vegan'];
    _vegetarian = widget.currFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool currVal, Function updateVal) {
    return SwitchListTile(
      title: Text(title),
      activeColor: Theme.of(context).primaryColor,
      value: currVal,
      subtitle: Text(subtitle),
      onChanged: updateVal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meals as per your needs",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  "Gluten-Free",
                  "Only include gluten free meals",
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile("Lactose-Free",
                    "Only include lactose free meals", _lactoseFree, (newVal) {
                  setState(() {
                    _lactoseFree = newVal;
                  });
                }),
                _buildSwitchListTile(
                    "Vegan", "Only include vegan meals", _vegan, (newVal) {
                  setState(() {
                    _vegan = newVal;
                  });
                }),
                _buildSwitchListTile(
                    "Vegetarian", "Only include vegetarian meals", _vegetarian,
                    (newVal) {
                  setState(() {
                    _vegetarian = newVal;
                  });
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Save these filters"),
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        final selectedFilters = {
                          'gluten': _glutenFree,
                          'lactose': _lactoseFree,
                          'vegan': _vegan,
                          'vegetarian': _vegetarian,
                        };
                        widget.saveFilters(selectedFilters);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
