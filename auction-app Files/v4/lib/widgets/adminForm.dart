import 'package:Auction_App/provider/adminServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminForm extends StatefulWidget {
  static const routeName = '/adminForm';

  final String playerInfoId;
  AdminForm(this.playerInfoId);

  static final _form = GlobalKey<FormState>();
  @override
  _AdminFormState createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  final _messageController = TextEditingController();
  String _text;

  void _saveForm() async {
    // validate
    final isValid = AdminForm._form.currentState.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return null;
    }
    AdminForm._form.currentState.save();
    Navigator.of(context).pop();
    print(_messageController.value);
    // add admin messages
    await Provider.of<AdminServices>(context, listen: false)
        .addAdminMsg(widget.playerInfoId, _text);

    print('Working Admin Message');

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("Admin Sheet",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
          SizedBox(height: 20),
          Form(
            key: AdminForm._form,
            child: TextFormField(
                decoration: InputDecoration(labelText: "Enter a flash message"),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: _messageController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a message";
                  }
                  return null;
                },
                onSaved: (value) {
                  _text = value;
                }),
          ),
          RaisedButton(
            child: Text('Flash Now'),
            onPressed: _saveForm,
          )
        ],
      ),
    );
  }
}
