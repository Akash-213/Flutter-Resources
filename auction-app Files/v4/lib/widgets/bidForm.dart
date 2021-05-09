import 'package:Auction_App/provider/bidServices.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BidForm extends StatefulWidget {
  static final _form = GlobalKey<FormState>();
  // form key is to be made static else keyboard closes automatically
  final String playerId;
  final String collectionPath;

  BidForm(this.playerId, this.collectionPath);

  @override
  _BidFormState createState() => _BidFormState();
}

class _BidFormState extends State<BidForm> {
  final _bidAmountController = TextEditingController();

  var _bidAmount = 0;
  var lastBid;
  bool isBiddingStatus;
  var walletAmt;
  final user = FirebaseAuth.instance.currentUser;

  _buildIconButton(String text, int value) {
    return RaisedButton(
      child: Text(text),
      onPressed: () {
        // _bidAmount = value;
        _bidAmountController.text = value.toString();
      },
      color: Colors.green,
    );
  }

  void _saveForm() async {
    // validate
    final isValid = BidForm._form.currentState.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return null;
    }
    var bidServiesData = Provider.of<BidServices>(context, listen: false);
    BidForm._form.currentState.save();
    lastBid =
        await bidServiesData.getLastBid(widget.playerId, widget.collectionPath);
    // print("Save Form : " + lastBid.toString());

    isBiddingStatus = await bidServiesData.getBiddingStatus(
        widget.playerId, widget.collectionPath);

    walletAmt = await bidServiesData.getwalletAmt(user.uid);

    if (walletAmt >= _bidAmount) {
      if (lastBid < _bidAmount && isBiddingStatus == true) {
        await bidServiesData.addNewBid(
            widget.playerId, _bidAmount, widget.collectionPath, context);
        await bidServiesData.showErrorDialog(
            context, "Bid Successful !!", "Your bid was added successfully!!");
      } else if (isBiddingStatus == false) {
        await bidServiesData.showErrorDialog(context, "An Error Occured !!",
            "Bidding has been Stopped By the Admin.\nFor further query contact Admin");
      } else {
        await bidServiesData.showErrorDialog(context, "An Error Occured!",
            "You were slow !!.\nCheck the current Bid Price");
      }
    } else {
      await bidServiesData.showErrorDialog(context, "An Error Occured!",
          'Wallet Amount not sufficient!! \nCheck your Wallet Amount');
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lastBid = Provider.of<BidServices>(context, listen: false)
        .getLastBid(widget.playerId, widget.collectionPath);
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
        children: [
          Text("This is your Bid Sheet",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
          SizedBox(height: 20),
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
                  return null;
                },
                onSaved: (value) {
                  _bidAmount = int.parse(value);
                }),
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text("Add Bid"),
            onPressed: () {
              _saveForm();
            },
          ),
          SizedBox(height: 10),
          // Row(
          //   children: [
          //     Text('Increase Bid By : '),
          //     DropdownButton(
          //       icon: Icon(Icons.arrow_circle_down),
          //       items: [
          //         DropdownMenuItem(
          //           child: Text(' + 100 '),
          //           value: '100',
          //         )
          //       ],
          //       onChanged: (itemIdentifier) {
          //         if (itemIdentifier == '100') {
          //           _bidAmountController.text =
          //               (int.parse(lastBid.to) + 100) as String;
          //         }
          //       },
          //     )
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton('50 Thousand', 50000),
              _buildIconButton('1 Lakh', 100000),
              _buildIconButton('2 Lakh', 200000),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton('5 Lakh', 500000),
              _buildIconButton('10 Lakh', 1000000),
              _buildIconButton('20 Lakh', 2000000),
            ],
          ),
        ],
      ),
    );
  }
}
