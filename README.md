

you an check te demo in example folder

##### DEMO
![alt Loading pulse](https://raw.githubusercontent.com/GioRey/loading_pulse/master/demo.gif)
## Usage

```dart

// import
import 'package:loading_pulse/loading_pulse.dart';
// Define
final GlobalKey<LoadingPulseState> loadingPulseKey =
        GlobalKey<LoadingPulseState>();

// use stack
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
              // start loading animation
              loadingPulseKey.currentState!.startAnimation();
              
              // simulate loading 
              await Future.delayed(const Duration(seconds: 3));

              // ned loading animation
              loadingPulseKey.currentState!.reverseAnimation();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
        // add the final of your stack
        LoadingPulse(
          key: loadingPulseKey,
        ),
      ],
    );        
```
