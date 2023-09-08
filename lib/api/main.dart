import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldensmoker/api/post.dart';
import 'api_client.dart';

// Авторизация с Firebase с безопасностью
// Геолокация
// Сервис данных
// Подгрузка данных заранее, для оффлайн
// Логика на GetX
// Адаптивность
// key api: 66c896dbf01a66c1d84849e6192470f0
// name: test
// log: cfif.3.v@gmail.com
// pass: 12345678

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Example()),
    );
  }
}



class StateWidget extends GetxController{
 RxList<Post> _posts = <Post>[].obs;
 List<Post> get posts => _posts;
 final apiClient = ApiClient();

 Future<void> reloadPosts() async{
  final posts = await apiClient.getPosts();
  _posts += posts;
  update();
 }
 Future<void> createPost() async{
  final posts = await apiClient.createPost(title: 'my_title', body: 'ffffff');
  _posts.add(posts);
  update();
 }
}




class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    StateWidget stWid = Get.put(StateWidget());
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () => stWid.reloadPosts(),
              child: const Text('Обновить посты'),
            ),

            ElevatedButton(
              onPressed: () => stWid.createPost(),
              child: const Text('Создать пост'),
            ),

            Obx(()=> 
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: stWid.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _PostsRowWidget(index: index);
                    },
                  ),
                ),
              ),
            ),

          ],
        );
  }
}


class _PostsRowWidget extends StatelessWidget {
  final int index;
  const _PostsRowWidget({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  StateWidget stWid = Get.put(StateWidget());
    final post = stWid.posts[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.id.toString()),
        const SizedBox(height: 10),
        Text(post.title),
        const SizedBox(height: 10),
        Text(post.body),
        const SizedBox(height: 40),
      ],
    );
  }
}







// class Pist {
// //   void getUrl(){
// //     fetch('http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=YOUR_API_KEY')
// // .then(response => response.json())
// // .then(data => console.log(data))
// // .catch(error => console.error(error))
// //   }
// }

// Map<String, String> apiConstants = {
//   "openweather": "https://api.openweathermap.org/data/2.5",
//   "auth": "https://reqres.in/api"
// };

// String appId = "66c896dbf01a66c1d84849e6192470f0";
// String lat = "58.5742668";
// String lon = "49.6281048";

// static getWeatherforCity(String lat, String lon) async {
//     final response = await RestApiHandlerData.getData(
//         '${apiConstants["openweather"]}/weather?lat=$lat&lon=$lon&appid=$appId');
//     return response;
//   }

// class WeatherApiRepository {
//   Future fetchWeather(String city) async {
//     final response = await ApiSdk.getWeatherforCity(city);
//     return response;
//   }
// }

// class WeatherModel {
//   dynamic lon;
//   dynamic lat;
//   String mainWeather;
//   String description;
//   String temp;
//   String minTemp;
//   String maxTemp;
//   dynamic windSpeed;
//   String countryCode;
//   String cityName;
//   String icon;

//   WeatherModel.fromJson(Map<String, dynamic> parsedJson)
//       : lon = parsedJson['coord']['lon'],
//         lat = parsedJson['coord']['lat'],
//         mainWeather = parsedJson['weather'][0]['main'],
//         description = parsedJson['weather'][0]['description'],
//                 // Converted temperature to celcius, you can do this in **a*pp*** also.
//         temp = (parsedJson['main']['temp'] - 273.15).toStringAsFixed(2),
//         minTemp = (parsedJson['main']['temp_min'] - 273.15).toStringAsFixed(2),
//         maxTemp = (parsedJson['main']['temp_max'] - 273.15).toStringAsFixed(2),
//         windSpeed = parsedJson['wind']['speed'],
//         countryCode = parsedJson['sys']['country'],
//         cityName = parsedJson['name'],
//         icon = parsedJson["weather"][0]["icon"];
// }

// final response = await weatherApiRepository.fetchWeather(event.city);
//         if (response["cod"] != 200) {
//           yield FailureState(
//             message: response['message'],
//             cod: response['cod'],
//           );
//         } else {
//           WeatherModel weatherModel = WeatherModel.fromJson(response);
//           yield SearchSuccessState(weatherModel: weatherModel);
//         }
//       } catch (e) {
//         FailureState(message: e);
//       }
