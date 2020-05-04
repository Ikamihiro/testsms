import 'package:flutter/material.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/generated/i18n.dart';
import 'package:sms_maintained/globals.dart';
import 'package:sms_maintained/sms.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> sms = ["SMS"];
  String address = "65998139190";

  void pegarSms() async {
    // Instancia a classe SmsQuerry
    SmsQuery query = SmsQuery();
    // Pega todas os SMS do celular
    List<SmsMessage> messages = await query.getAllSms;
    // Verificando se volta nulo
    if (messages != null) {
      print("Pegando os SMS...");
      // Limpa a lista de string sms
      sms.clear();
      // Laço for em todos os sms com o mesmo contato pra onde foi enviado
      for (var message in messages.where((l) => l.address == address)) {
        sms.add(message.body);
      }
      // Renderiza os widgets da tela
      setState(() {
        print("Pegou os SMS...");
      });
    }
  }

  void enviarSms() {
    // Instancia a classe SmsSender
    SmsSender sender = SmsSender();
    // Instancia a classe SmsMessafe com o contato
    // para onde o SMS será enviado e a mensagem
    SmsMessage message = SmsMessage(address, 'Hello flutter!');
    // Método que verifica o status do SMS
    message.onStateChanged.listen((state) {
      // Se o status for "Enviado"
      if (state == SmsMessageState.Sent) {
        print("SMS foi enviado");
        // Se o status for "Entregue"
      } else if (state == SmsMessageState.Delivered) {
        print("SMS foi entregue");
      }
    });
    // Envia o SMS
    sender.sendSms(message);
  }

  @override
  void initState() {
    super.initState();
    pegarSms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Botão para Enviar SMS
            RaisedButton(
              color: Colors.orange,
              elevation: 0,
              onPressed: enviarSms,
              child: Text(
                "Enviar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Botão para Pegar SMS
            RaisedButton(
              color: Colors.orange,
              elevation: 0,
              onPressed: pegarSms,
              child: Text(
                "Pegar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  "SMSs:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // Lista renderizado dos SMS
            Expanded(
              child: ListView.builder(
                  itemCount: sms.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.sms),
                      dense: true,
                      title: Text("Receptor: " + address),
                      subtitle: Text("Messagem: " + sms[index]),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
