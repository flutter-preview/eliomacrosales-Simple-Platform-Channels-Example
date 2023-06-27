# Platform Channels Example

The example shown in the repository is about retrieving the version of the operating system where the application is running.


### Documentation

* [Writing custom platform-specific code](https://docs.flutter.dev/platform-integration/platform-channels)




### Send data from client (Flutter) to host

Only the data types specified in the documentation can be sent. These are:
null, bool, int, double, String, Float, List, Map

```dart

await _methodChannel.invokeMethod(
          "version",
          {
          "product":"Apple pie",
          "amount":2,
          "price":3.5,
          "currency":"USD"
          }
      );

```

### Receiving data on host ( iOS / Swift)

```swift

let data : [String:Any] = call.arguments as! [String:Any]
let product : String = data["product"]

```

### Receiving data on host ( Android / Java)

```java

HashMap<String,Object> data = (HashMap<String,Object>) call.arguments;
String product = (String) data.get("product");

```


## Presentation


   | iOS | Android |
  | ------------- | ------------- |
  |![evidence3](https://github.com/eliomacrosales/Simple-Platform-Channels-Example/assets/58376042/70f5ed8c-3a28-4273-94af-a3111ed28f40)|![evidence3.3](https://github.com/eliomacrosales/Simple-Platform-Channels-Example/assets/58376042/f6be1e27-52a1-4f3f-82ab-c52c32c5c876)|  

### Built With

To communicate the client (Flutter) with the hosts (Android/iOS), Java was used for Android and Swift was used for iOS.

* [![Flutter][Flutter.image]][Flutter-url]
* [![Java][Java.image]][Java-url]
* [![Swift][Swift.image]][Swift-url]





[Flutter.image]: https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white
[Flutter-url]: https://docs.flutter.dev/platform-integration/platform-channels
[Java.image]: https://img.shields.io/badge/Java-ffca28?style=for-the-badge&logo=openjdk&logoColor=white
[Java-url]: https://www.java.com/en/
[Swift.image]: https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white
[Swift-url]: https://www.swift.org/documentation/



