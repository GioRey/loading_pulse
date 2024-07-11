import 'package:flutter/material.dart';
import 'package:loading_pulse/loading_pulse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<LoadingPulseState> loadingPulseKey =
        GlobalKey<LoadingPulseState>();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: const Center(
            child: Text('Widget que oculta la carga'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              loadingPulseKey.currentState!.startAnimation();
              await Future.delayed(const Duration(seconds: 3));
              loadingPulseKey.currentState!.reverseAnimation();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
        LoadingPulse(
          key: loadingPulseKey,
        ),
      ],
    );
  }
}
