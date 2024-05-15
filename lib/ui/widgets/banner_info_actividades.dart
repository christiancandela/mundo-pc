import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';

class BannerInfoActividades extends StatelessWidget {
  final String titulo;
  final bool isDiagnostico;
  final List<int> habilidades;
  const BannerInfoActividades(
      {super.key,
      required this.titulo,
      required this.isDiagnostico,
      required this.habilidades});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            10.0), // Bordes redondos para la imagen de fondo
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.9,
              child: Image.asset(
                'assets/fondos/FondoInicio.png',
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Título
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TitleText(
                    text: titulo,
                    color: Colors.white,
                  ),
                ),
                //si la pantalla es menor a 880 es un dispositivo movil y el padding no se visualiza
                MediaQuery.of(context).size.width < 768 || isDiagnostico
                    ? Container()
                    : (
                        // Lista de mini tarjetas con tags
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            TagMiniCard(
                                text: 'Patrones',
                                color: blueColor,
                                opacidad: habilidades[0] == 0 ? 0.4 : 1),
                            TagMiniCard(
                                text: 'Descomposición',
                                color: orangeColor,
                                opacidad: habilidades[1] == 0 ? 0.4 : 1),
                            TagMiniCard(
                                text: 'Abstracción',
                                color: greenColor,
                                opacidad: habilidades[2] == 0 ? 0.4 : 1),
                            TagMiniCard(
                                text: 'Algoritmo',
                                color: yellowColor,
                                opacidad: habilidades[3] == 0 ? 0.4 : 1),
                          ],
                        ),
                      )),
                // Icono informativo
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TagMiniCard extends StatelessWidget {
  final String text;
  final Color color;
  final double opacidad;

  const TagMiniCard(
      {Key? key,
      required this.text,
      required this.color,
      required this.opacidad})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: color.withOpacity(opacidad), // Color azul con opacidad del 50%
      elevation: 5, // Elevación de la card
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    );
  }
}
