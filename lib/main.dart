import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Maior palavra - Justa',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maior palavra - Justa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: myController,
          decoration:
              const InputDecoration(label: Text('Digite a frase desejada')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(children: [
                  const Text('A maior palavra da frase digitada é: '),
                  Text(
                    longestWord(myController.text),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28),
                  )
                ]),
              );
            },
          );
        },
        tooltip: 'Aperte para descobrir a maior palavra da frase:',
        child: const Icon(Icons.text_fields),
      ),
    );
  }

  // Verifica se o caractere em um dado index da String é uma letra do alfabeto
  bool isLetterAtIndex(String str, int index) {
    return ('a'.codeUnitAt(0) <= str.codeUnitAt(index) &&
        'z'.codeUnitAt(0) >= str.codeUnitAt(index));
  }

  String longestWord(String sen) {
    // Essas 3 variaveis serão as responsáveis por retornar a maior palavra da frase. Nelas, eu guardo o index no qual a maior palavra começa,
    // o tamanho 'válido' dessa palavra (ou seja, sem contar os caracteres especiais da mesma) e a quantidade de caracteres especiais da mesma, para então
    // ser possível devolver a palavra completa no final de tudo.
    int longestWordStartIndex = 0;
    int longestWordSize = 0;
    int longestWordSpecialCharsCount = 0;

    // Minimizando a String para facilitar o uso da função isLetterAtIndex
    String senFormatted = sen.toLowerCase();
    int i = 0;

    // Loop para percorrer a frase inteira buscando a maior palavra
    while (i < sen.length) {
      // Se o caracter atual que estou verificando é um espaço em branco, apenas continuo o loop para o próximo caractere.
      if (sen[i] == ' ') {
        i += 1;
        continue;
      }

      // Caso não, então estou no começo de uma nova palavra.
      int j = i;
      int currentWordSize = 0;
      int currentWordSpecialCharsCount = 0;

      // Loop para percorrer a palavra atual e verificar seu tamanho 'válido' e a quantidade de caracteres especiais da mesma.
      while (j < sen.length && sen[j] != ' ') {
        // Caso o caractere nesse index seja uma letra, somo ao tamanho 'válido' da palavra atual.
        if (isLetterAtIndex(senFormatted, j)) {
          currentWordSize += 1;
        } else {
          // Caso não, somo a contagem de caracteres especiais da palavra atual.
          currentWordSpecialCharsCount += 1;
        }
        j += 1;
      }

      // Se a palavra atual tem um tamanho 'válido' maior do que a maior encontrada até então, então atualizo as variáveis necessárias
      // com os dados da palavra atual.
      if (currentWordSize > longestWordSize) {
        longestWordStartIndex = i;
        longestWordSize = currentWordSize;
        longestWordSpecialCharsCount = currentWordSpecialCharsCount;
      }

      // Pulo o loop da frase para o final da palavra atual, para então procurar uma nova palavra na frase.
      i = j;
    }

    return sen.substring(longestWordStartIndex,
        longestWordStartIndex + longestWordSize + longestWordSpecialCharsCount);
  }
}
