import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Fazer o controle do mapa
  ///o Completer serve para fazer requisisções para APIS
  Completer<GoogleMapController> _controller = Completer();

  //Lista de marcadores
  Set<Marker> _marcadores ={ //Numa lista de "sets" se define apenas valores (sem indices, diferente do Map)
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas e geolocalização"),
      ),

      //Localizaçao do botão flutuante de ação
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      //Botão flutuante de ação
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: _movimentarCamera,
      ),

      body: Container(
        child: GoogleMap(

          //Tipo de mapa
            mapType: MapType.normal, // ( o normal é o que é usado no app do google Maps)

          initialCameraPosition: CameraPosition( //Onde a camera vai iniciar

          target: LatLng(-15.794388, -47.882178), //latitude e longitude

          zoom: 16,

          //Angulo de visão da camera (padrão é 0)
          tilt:0,

          // Rotação da câmera (padrão é 0)
          bearing:0

          ),

          ///documentação sobre a camera
           //https://developers.google.com/maps/documentation/android-sdk/views

          onMapCreated: _onMapCreated,

          //Marcador no mapa
          markers: _marcadores,
        ),
      ),
    );
  }



  ///Métodos

  //Carregamentos de inicialização
  @override
  void initState() {
    super.initState();

    //carregar os marcadores
    _carregarMarcadores();
  }

  //Metodo para carregar os marcadores do mapa
  _carregarMarcadores(){
    Set<Marker> marcadorLocal = {};
    Marker marcador1 = Marker(
      markerId: MarkerId("marcador-01"),
      position: LatLng(-15.798339, -47.875526),

      //Exibir infomações ao clicar em cima do marcador
      infoWindow: InfoWindow(
        title: "Catedral de Brasília"
      )
    );

    marcadorLocal.add(marcador1);

    setState(() {
      //Atualizar a lista principal de marcadores com a lista local
      _marcadores = marcadorLocal;
    });
  }

  //Metodo para movimentar a camera
  _movimentarCamera() async{

    //(retorna o google maps controller)
    GoogleMapController googleMapController = await _controller.future;

    //Animação de movimentação de camera
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(-15.804388, -47.882178),
            zoom: 16,
            tilt: 0
        )
      )
    );
  }



  //Metodo de controle do mapa
  _onMapCreated(GoogleMapController googleMapController) {

    //Dizendo que o mapa foi criado
    _controller.complete(googleMapController);

    //Recuperar o objeto e permite alterar o mapa (substituindo o setState)
    //_controller.future
  }


}
