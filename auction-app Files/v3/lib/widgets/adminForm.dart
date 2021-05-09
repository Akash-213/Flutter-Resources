import 'package:flutter/material.dart';

class AdminForm extends StatefulWidget {
  static const routeName = '/adminForm';
  static final _form = GlobalKey<FormState>();
  @override
  _AdminFormState createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  final _messageController = TextEditingController();

  void _saveForm() async {
    // validate
    final isValid = AdminForm._form.currentState.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return null;
    }
    AdminForm._form.currentState.save();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("This is your Bid Sheet",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
          SizedBox(height: 20),
          Form(
            key: AdminForm._form,
            child: TextFormField(
                decoration: InputDecoration(labelText: "Enter a message"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: _messageController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter a message";
                  }

                  return null;
                },
                onSaved: (value) {
                  _saveForm();
                }),
          ),
        ],
      ),
    );
  }
}
