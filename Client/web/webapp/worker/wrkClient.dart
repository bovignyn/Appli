import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:convert' show JSON;
import 'package:polymer_expressions/polymer_expressions.dart';



@CustomTag('x-page')
class Page extends PolymerElement {
  Element afficheProduit;
  Element afficheAccueil;
 
  String exp = "none";
  
  @observable
  String getText;
  @observable
  String getMessage;
  @observable
  String getnom;
  @observable
  String getdes;
  @observable
  String getprix;
  @observable
  String gettype;
  @observable
  List jsonlist;
  @observable
  int currentIndex = 0;

  Page.created(): super.created();


  /**
   * Cette methode est appelee au lancement de l'application
   */

  @override
  void enteredView() {
    super.enteredView();
    afficheProduit = $["afficheProduit"];
    afficheProduit.hidden=true;
    afficheAccueil = $["afficheAccueil"];
    afficheAccueil.hidden=false;
    accueil();
  }

  /**
   * Methode lancee apres l'event du bouton accueil
   * Cette methode sert a afficher le message d'accueil
   */

  void accueil() {
    afficheProduit.hidden=true;
    afficheAccueil.hidden=false;
    getMessage = "Bienvenue sur cette application. Si vous avez des vespas ou des accessoires de vespas à vendre ou à acheter vous êtes au bon endroit. Bonne visite!";
    getText = "Bienvenue sur la nouvelle application de vente et d'achat des vespas!";
    
  }
  

  
  /**
   * Cette methode sert a decoder la liste json
   */

  void onDataLoaded(String responseText) {
    List<Map> produits = JSON.decode(responseText);
    jsonlist = produits;
    getnom = "Nom";
    getdes = "Description";
    getprix = "Prix";
    gettype = "Type";
  }

  /**
   * Methode lancee apres l'event du bouton produits
   * Cette methode sert a recuperer les la liste des produits sur le serveur et l'affiche
   */

  void produits() {
    afficheProduit.hidden=false;
    afficheAccueil.hidden=true;
    var url = 'http://127.0.0.1:8080/produits';
    HttpRequest.getString(url).then(onDataLoaded);
    getText = "Liste des produits";
  }

  void getvespa() {
    var url = 'http://127.0.0.1:8080/produitsVespa';
    HttpRequest.getString(url).then(onDataLoaded);
    getText = "Liste des produits";
  }

  void getaccessoire() {
    var url = 'http://127.0.0.1:8080/produitsAccessoire';
    HttpRequest.getString(url).then(onDataLoaded);
    getText = "Liste des produits";
  }

  void change(event, details, Element target) {
    if (currentIndex == 0) {
      produits();
    } else if (currentIndex == 1) {
      getvespa();
    } else if (currentIndex == 2) {
      getaccessoire();
    }
  }

}
