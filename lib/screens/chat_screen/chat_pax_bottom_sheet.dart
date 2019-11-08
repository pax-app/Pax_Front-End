import 'dart:io';
import 'dart:convert';
import 'package:Pax/components/base_bottom_sheet/base_bottom_sheet.dart';
import 'package:Pax/components/button%20/button.dart';
import 'package:Pax/components/disabled_outline_input/disabled_outline_input.dart';
import 'package:Pax/components/text_input/text_input.dart';

import 'package:http/http.dart' as http;
import 'package:Pax/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPaxBottomSheet extends StatefulWidget {
  final int chatId;
  final int providerId;
  final int userId;

  ChatPaxBottomSheet({
    this.chatId,
    this.providerId,
    this.userId,
  });

  @override
  _ChatPaxBottomSheetState createState() => _ChatPaxBottomSheetState();
}

class _ChatPaxBottomSheetState extends State<ChatPaxBottomSheet> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController(
      text: 'Endereço do usuário bla bla bla 123 123 123 123 3331313 ');
  final _priceController = TextEditingController();

  DateTime initialDate = DateTime(2019, 01, 01);
  String pickedDate;
  final formatDate = DateFormat("dd MMMM yyyy", "pt-BR");

  bool isPaxLoading = false;

  int addressId;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).viewInsets.bottom);
    return BaseBottomSheet(
      curveAnimation: Curves.linear,
      duration: Duration(milliseconds: 200),
      modalHeight: MediaQuery.of(context).viewInsets.bottom + 540,
      sheetBody: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1,
              ),
              child: Text(
                'Preencha o que falta para enviar o seu PAX',
                style: Theme.of(context).textTheme.title.copyWith(height: 1.3),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            TextInput(
              'Nome',
              'Nome do serviço a ser prestado...',
              false,
              null,
              TextInputType.text,
              1,
              controller: _nameController,
            ),
            SizedBox(height: 3),
            TextInput(
              'Descrição',
              'Descreva o que irá fazer...',
              false,
              null,
              TextInputType.text,
              1,
              controller: _descriptionController,
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.2),
              child: DisabledOutlineInput(
                labelText: 'Endereço',
                textController: _addressController,
              ),
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 142,
                  child: TextInput(
                    'Preço',
                    'Total a pagar',
                    true,
                    null,
                    TextInputType.number,
                    1,
                    controller: _priceController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FlatButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    splashColor: secondaryColorDimmed,
                    onPressed: _presentDatePicker,
                    child: Text(
                      initialDate == DateTime(2019, 01, 01)
                          ? 'ESCOLHA A DATA'
                          : formatDate.format(initialDate),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Button(
              isLoading: isPaxLoading,
              buttonText: 'Enviar',
              tapHandler: _nameController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      _addressController.text.isNotEmpty &&
                      _priceController.text.isNotEmpty
                  ? _createPax
                  : null,
            )
          ],
        ),
      ),
    );
  }

  Future _createPax() async {
    setState(() {
      isPaxLoading = true;
    });

    var pax = {
      "date": pickedDate.toString(),
      "description": _descriptionController.text,
      "name": _nameController.text,
      "price": double.parse(_priceController.text),
      "user_id": 1,
      "provider_id": 1,
      "chat_id": widget.chatId,
      "address_id": 8,
    };

    var body = json.encode(pax);

    var response = await http.post(
      'http://192.168.1.12:5003/pax/upCreate_pax',
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    setState(() {
      isPaxLoading = false;
    });

    // var response =
    //     await http.get('http://192.168.1.12:5003/pax/consult_pax?chat_id=17');

    print('Response body: ${response.body}');
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019, DateTime.now().month),
      lastDate: DateTime(2025),
    ).then((date) {
      if (date == null) return;
      setState(() {
        String formattedDate = DateFormat("yyyy-MM-dd").format(date);
        pickedDate = formattedDate;
        initialDate = date;
        print(pickedDate);
      });
    });
  }
}
