import 'package:flutter/material.dart';
import 'package:conversor_moeda/main.dart';
import 'package:intl/intl.dart';

class ScreenInfomation extends StatefulWidget {
  const ScreenInfomation({Key? key}) : super(key: key);

  @override
  State<ScreenInfomation> createState() => _ScreenInfomationState();
}

class _ScreenInfomationState extends State<ScreenInfomation> {

  double? dolar;
  double? variationDolar;
  double? euro;
  double? variationEuro;
  double? bitcoinBitsTamp;
  String? nameBitcoinBitsTamp;
  double? variationBitcoinBitsTamp;
  double? bitcoinMercadoBitcoin;
  String? nameBitcoinMercadoBitcoin;
  double? variationBitcoinMercadoBitcoin;
  double? cdi;
  double? selic;
  String? dateTaxes;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          '\$ Informações \$',
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Carregando Dados :)',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Erro ao Carregar os Dados :(',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  final Map data = snapshot.data!;
                  dolar = data["results"]["currencies"]["USD"]["buy"];
                  variationDolar = data["results"]["currencies"]["USD"]["variation"];
                  euro = data["results"]["currencies"]["EUR"]["buy"];
                  variationEuro = data["results"]["currencies"]["EUR"]["variation"];
                  bitcoinBitsTamp = data["results"]["bitcoin"]["bitstamp"]["last"];
                  bitcoinMercadoBitcoin = data["results"]["bitcoin"]["mercadobitcoin"]["last"];
                  variationBitcoinBitsTamp = data["results"]["bitcoin"]["bitstamp"]["variation"];
                  variationBitcoinMercadoBitcoin = data["results"]["bitcoin"]["mercadobitcoin"]["variation"];
                  nameBitcoinBitsTamp = data["results"]["bitcoin"]["bitstamp"]["name"];
                  nameBitcoinMercadoBitcoin = data["results"]["bitcoin"]["mercadobitcoin"]["name"];
                  String? bitcoinMercadoBitcoinString = bitcoinMercadoBitcoin?.toStringAsFixed(2);
                  cdi = data["results"]["taxes"][0]["cdi"];
                  selic = data["results"]["taxes"][0]["selic"];
                  dateTaxes = data["results"]["taxes"][0]["date"];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                        child: Text(
                          '${DateFormat('dd/MMM/yyyy').format(DateTime.now())}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(5),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: <Widget>[
                            buildContainerCurrency('Dólar', dolar, variationDolar),
                            buildContainerCurrency('Euro', euro, variationEuro),
                            buildContainerBitcoin('Bitcoin \$', nameBitcoinBitsTamp, bitcoinBitsTamp, variationBitcoinBitsTamp),
                            buildContainerBitcoin('Bitcoin R\$', nameBitcoinMercadoBitcoin, bitcoinMercadoBitcoinString, variationBitcoinMercadoBitcoin),
                            buildContainerTaxes('CDI', dateTaxes, cdi),
                            buildContainerTaxes('SELIC', dateTaxes, selic),
                          ],
                        ),
                      ),
                    ],
                  );
                }
            }
          }),
    );
  }

  buildContainerCurrency(String currency, value, variation) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.amber.shade200,
      child: Column(
        children: [
           Text(
            currency,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
          Divider(),
          Divider(),
          Text(
            'Valor: ${value}',
            style: const TextStyle(color: Colors.black, fontSize:25),
          ),
          Text(
            'Variação: ${variation} %',
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
  buildContainerBitcoin(String currency, nameBitcoin, value, variation) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.amber.shade200,
      child: Column(
        children: [
          Text(
            currency,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
          Divider(),
          Text(
            '${nameBitcoin}',
            style: const TextStyle(color: Colors.black, fontSize:20),
          ),
          Divider(),
          Text(
            'Valor: ${value}',
            style: const TextStyle(color: Colors.black, fontSize:20),
          ),
          Text(
            'Variação: ${variation} %',
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }

  buildContainerTaxes(String currency, Data, value) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.amber.shade200,
      child: Column(
        children: [
          Text(
            currency,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
          Divider(),
          Divider(),
          Text(
            'Data: ${Data} ',
            style: const TextStyle(color: Colors.black, fontSize:25),
          ),
          Text(
            'Taxa: ${value} %',
            style: const TextStyle(color: Colors.black, fontSize: 25),
          ),
        ],
      ),
    );
  }
}
