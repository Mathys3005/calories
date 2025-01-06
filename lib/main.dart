import 'package:calories/services/adaptive_plateform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('fr', 'FR'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CaloriesHome(),
    );
  }
}

class CaloriesHome extends StatefulWidget {
  const CaloriesHome({super.key});

  @override
  State<CaloriesHome> createState() => _CaloriesHomeState();
}

class _CaloriesHomeState extends State<CaloriesHome> {
  int calorieBase = 0;
  int calorieAvecActivite = 0;
  bool genre = true;
  int? age;
  String? poids;
  //slider
  double sliderValue = 100.0;
  //radio
  Activite activite = Activite.faible;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AdaptivePlatform.scaffold(
      title: 'Calcul de Calories',
      backgroundColor: getColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdaptivePlatform.text(
                'Remplissez tout les champs pour calculer vos calories et '
                    'obtenir votre besoin journalier',
              ),
            ),
            Card(
              elevation: 10.0,
              color: Colors.white,
              shadowColor: getColor(),
              child: Container(
                height: size.height / 2,
                width: size.width / 1.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AdaptivePlatform.text("Femme", color: Colors.pink),
                          AdaptivePlatform.myswitch(
                            value: genre,
                            onChanged: (bool b){
                              setState(() {
                                genre = b;
                              });
                            },
                          ),
                          AdaptivePlatform.text("Homme", color: Colors.blue),
                        ],
                      ),
                      AdaptivePlatform.button(
                          onPressed: _selectionDate,
                          child: AdaptivePlatform.text((age == null)?
                          'Appuyez pour entrer age': 'Votre age est de $age ans'),
                           backgroundColor: getColor(),
                      ),
                      AdaptivePlatform.text(color: getColor(),'Taille : ${sliderValue.toInt()} cm'),
                      AdaptivePlatform.slider(
                          value: sliderValue,
                          min: 100,
                          max: 230,
                          activeColor: getColor(),
                          onChanged: (double value) {
                            setState(() {
                              sliderValue = value;
                            });
                          }
                      ),
                      AdaptivePlatform.textField(
                        keyboardType: TextInputType.text,
                        onChanged: (String value) {
                          setState(() {
                            poids = value;
                          });
                        }, placeHolder: 'Poids(kg)',
                      ),
                      AdaptivePlatform.text('Quel est votre activité sportive ?', color: getColor()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                            Radio(
                                value: Activite.faible,
                                groupValue: activite,
                                onChanged: (Activite? a){
                                  setState(() {
                                    activite = a!;
                                  });
                                }
                            ),
                              AdaptivePlatform.text('Faible', color: getColor()),
                            ],
                          ),
                          Column(
                            children: [
                              Radio(
                                  value: Activite.moderee,
                                  groupValue: activite,
                                  onChanged: (Activite? a){
                                    setState(() {
                                      activite = a!;
                                    });
                                  }
                              ),
                              AdaptivePlatform.text('Modérée', color: getColor()),
                            ]
                          ),
                          Column(
                            children: [
                              Radio(
                                  value: Activite.forte,
                                  groupValue: activite,
                                  onChanged: (Activite? a){
                                    setState(() {
                                      activite = a!;
                                    });
                                  }
                              ),
                              AdaptivePlatform.text('Forte', color: getColor()),
                            ]
                          ),
                        ],
                      )
                    ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: calculerNombreDeCalories,
                child: AdaptivePlatform.text('Calculer', color: Colors.white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: getColor(),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(){
    //Genre est à true alors homme sinon femme
    if(genre) {
      return Colors.blue;
    }else{
      return Colors.pink;
    }
  }

  Text TextAvecStyle(String data, {color = Colors.black, fontSize = 15.0}){
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color,
          fontSize: fontSize
      ),
    );
  }


  Future<void> _selectionDate() async {
    DateTime? _dateChoisie = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (_dateChoisie != null) {
      //calcul de l'age en fonction de la date de naissance
      age = DateTime.now().year - _dateChoisie.year;
      if (DateTime.now().month < _dateChoisie.month) {
        age = age! - 1;
      } else if (DateTime.now().month == _dateChoisie.month) {
        if (DateTime.now().day < _dateChoisie.day) {
          age = age! - 1;
        }
      }
      setState(() {
        age = age;
      });
    }
  }

  void calculerNombreDeCalories() {
    if (age != null && poids != null && poids!.isNotEmpty) {
      double poidsDouble = double.tryParse(poids!) ?? 0.0; // Convertir le poids en double
      if (poidsDouble > 0) {
        // Calcul des calories de base
        if (genre) {
          calorieBase = (66.4730 + (13.7516 * poidsDouble) + (5.0033 * sliderValue) - (6.7550 * age!)).toInt();
        } else {
          calorieBase = (655.0955 + (9.5634 * poidsDouble) + (1.8496 * sliderValue) - (4.6756 * age!)).toInt();
        }

        // Multiplicateur en fonction de l'activité
        switch (activite) {
          case Activite.faible:
            calorieAvecActivite = (calorieBase * 1.2).toInt();
            break;
          case Activite.moderee:
            calorieAvecActivite = (calorieBase * 1.5).toInt();
            break;
          case Activite.forte:
            calorieAvecActivite = (calorieBase * 1.8).toInt();
            break;
        }

        print("Calories de base : $calorieBase");
        print("Calories avec activité : $calorieAvecActivite");
        setState(() {
          // Met à jour les résultats
          _afficherResultat();
        });
      } else {
        _alerteErreur("Veuillez entrer un poids valide.");
      }
    } else {
      _alerteErreur("Tous les champs doivent être remplis.");
    }
  }

  void _afficherResultat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextAvecStyle('Votre besoin en calories', color: getColor()),
          content: Text('Votre besoin de base est : \n$calorieBase\n'
              'Votre besoin avec activité sportive est : \n $calorieAvecActivite',
            textAlign: TextAlign.center,),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextAvecStyle('OK', color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor:  getColor(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _alerteErreur(String erreur) {
    AdaptivePlatform.dialog(
      context: context,
      title: "Erreur",
      messages: [erreur],
    );
  }

}



enum Activite {faible, moderee, forte}
