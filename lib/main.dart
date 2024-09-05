import 'package:flutter/material.dart';

void main() {
  runApp(const PizzaApp());
}

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Bella Napoli',
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      home: const PizzaHomePage(),
    );
  }
}

class PizzaHomePage extends StatefulWidget {
  const PizzaHomePage({super.key});

  @override
  State<PizzaHomePage> createState() => _PizzaHomePageState();
}

class _PizzaHomePageState extends State<PizzaHomePage> {
  bool isVegetarian = false;
  String selectedIngredient = '';
  final List<String> vegetarianIngredients = ['Pimiento', 'Tofu'];
  final List<String> nonVegetarianIngredients = ['Peperoni', 'Jamón', 'Salmón'];
  final String baseIngredients = 'Mozzarella, Tomate';

  void setPizzaType(bool vegetarian) {
    setState(() {
      isVegetarian = vegetarian;
      selectedIngredient = ''; // Resetear la selección de ingredientes
    });
  }

  void chooseIngredient(String ingredient) {
    setState(() {
      selectedIngredient = ingredient;
    });
  }

  void showSummary() {
    String pizzaType = isVegetarian ? 'vegetariana' : 'no vegetariana';
    String ingredients = '$baseIngredients, $selectedIngredient';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🍕 Tu Pedido'),
        content: Text(
          'Has seleccionado una pizza $pizzaType con los ingredientes: $ingredients.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍕 Bella Napoli'),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selecciona el tipo de pizza:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            ToggleButtons(
              isSelected: [isVegetarian, !isVegetarian],
              selectedColor: Colors.white,
              color: Colors.black54,
              fillColor: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(30),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('Vegetariana', style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('No Vegetariana', style: TextStyle(fontSize: 16)),
                ),
              ],
              onPressed: (int index) {
                setPizzaType(index == 0);
              },
            ),
            const SizedBox(height: 30),
            Text(
              isVegetarian
                  ? 'Elige un ingrediente vegetariano:'
                  : 'Elige un ingrediente no vegetariano:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: (isVegetarian
                      ? vegetarianIngredients
                      : nonVegetarianIngredients)
                  .map((ingredient) {
                return ChoiceChip(
                  label: Text(ingredient, style: const TextStyle(fontSize: 16)),
                  selected: selectedIngredient == ingredient,
                  onSelected: (bool selected) {
                    chooseIngredient(ingredient);
                  },
                  selectedColor: Colors.orangeAccent,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: selectedIngredient == ingredient ? Colors.white : Colors.black87,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: selectedIngredient.isNotEmpty ? showSummary : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedIngredient.isNotEmpty
                    ? Colors.orangeAccent
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              icon: const Icon(Icons.check_circle),
              label: const Text('Confirmar Pedido', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
