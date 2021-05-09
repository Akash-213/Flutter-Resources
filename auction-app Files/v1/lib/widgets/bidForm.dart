import 'package:flutter/material.dart';

class BidForm extends StatefulWidget {
  static final _form = GlobalKey<FormState>();
  // form key is to be made static else keyboard closes automatically
  final String playerId;
  final String collectionPath;
  final Function addNewBid;
  final int lastBid;
  final Function getLastBid;

  BidForm(this.playerId, this.collectionPath, this.addNewBid, this.lastBid,
      this.getLastBid);

  @override
  _BidFormState createState() => _BidFormState();
}

class _BidFormState extends State<BidForm> {
  final _bidAmountController = TextEditingController();

  var _bidAmount = 0;

  _buildIconButton(String text, int value) {
    return RaisedButton(
      child: Text(text),
      onPressed: () {
        _bidAmount = value;

        widget.addNewBid(
            widget.playerId, _bidAmount, widget.collectionPath, context);
        Navigator.of(context).pop();
      },
      color: Colors.green,
    );
  }

  Future<void> _saveForm() async {
    // validate
    final isValid = BidForm._form.currentState.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    BidForm._form.currentState.save();
    widget.getLastBid(widget.playerId, widget.collectionPath);

    if (widget.lastBid < _bidAmount) {
      widget.addNewBid(
          widget.playerId, _bidAmount, widget.collectionPath, context);
    } else {
      print("Please Check Current Price");
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _bidAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: BidForm._form,
            child: TextFormField(
                decoration: InputDecoration(labelText: "Enter a bid Amount"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: _bidAmountController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter a Bid";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please Enter a valid number!";
                  }
                  if (int.tryParse(value) == 0) {
                    return "Bid cant be Zero";
                  }
                  if (int.parse(value) <= widget.lastBid) {
                    return "Bid cant be smaller than current Bid.\nPlease Check the current Bid Amount.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _bidAmount = int.parse(value);
                }),
          ),
          RaisedButton(
            child: Text("Add Bid"),
            onPressed: () {
              // print("Last Bid " + widget.lastBid.toString());
              _saveForm();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton('1 Lakh', 100000),
              _buildIconButton('2 Lakh', 200000),
              _buildIconButton('5 Lakh', 500000),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton('10 Lakh', 1000000),
              _buildIconButton('20 Lakh', 2000000),
              _buildIconButton('50 Lakh', 5000000),
            ],
          ),
        ],
      ),
    );
  }
}
