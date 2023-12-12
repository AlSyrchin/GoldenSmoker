//Этап
abstract class Stage {
  String name = '';
  double tempB = 0; // Температура камеры
  double tempP = 0; // Температура продукта
  int time = 0; //Время
  bool extractor = false; //Вытяжка
  bool smoke = false; //Дымоген
  bool water = false; //Пароген
  bool flap = false; //Заслонка
  bool tens = false; //Тен
  bool get isNext; // условие перехода
  String get command; // Генерация командной строки
}

class Related extends Stage {
  Related(double b, double p) {
    name = 'Отепление';
    tempB = b;
    tempP = p;
    tens = true;
  }
  @override
  String get command => 'R+>MP${convertDoubFromStr(tempP)}/${convertDoubFromStr(tempB)}~M!TF';
  @override
  bool get isNext => false;
}

class Drying extends Stage {
  Drying(double b, double p, int t) {
    name = 'Сушка';
    tempB = b;
    tempP = p;
    time = t;
    extractor = true;
    flap = true;
    tens = true;
  }
  @override
  String get command => 'R+>MT$time>MP${convertDoubFromStr(tempP)}/${convertDoubFromStr(tempB)}~M!TFA';
  @override
  bool get isNext => false;
}

class Boiling extends Stage {
  Boiling(double b, double p, int t) {
    name = 'Варка';
    tempB = b;
    tempP = p;
    time = t;
    water = true;
    tens = true;
  }
  @override
  String get command => 'R+>MT$time>MP${convertDoubFromStr(tempP)}/${convertDoubFromStr(tempB)}~M!WTF';
  @override
  bool get isNext => false;
}

class Smoking extends Stage {
  Smoking(double b, double p, int t) {
    name = 'Копчение';
    tempB = b;
    tempP = p;
    time = t;
    extractor = true;
    smoke = true;
    tens = true;
  }
  @override
  String get command => 'R+>MT$time>MP${convertDoubFromStr(tempP)}/${convertDoubFromStr(tempB)}~M!TFS';
  @override
  bool get isNext => tempB == 10 ? true : false;// Приоритет на B
}

class Frying extends Stage {
  Frying(double b, double p) {
    name = 'Жарка';
    tempB = b;
    tempP = p;
    tens = true;
  }
  @override
  String get command => 'R+>MP${convertDoubFromStr(tempP)}/${convertDoubFromStr(tempB)}~M!TF';
  @override
  bool get isNext => tempB == 10 ? true : false;// Приоритет на B
}

class Unique extends Stage {
  Unique(String n, double b, double p, int t, bool ex, bool sm, bool wa, bool fl, bool te) {
    name = n;
    tempB = b;
    tempP = p;
    time = t;
    extractor = ex;
    smoke = sm;
    water = wa;
    flap = fl;
    tens = te;
  }
  @override
  String get command {
    String sMT = time != 0 ? 'MT$time>' : '';
    String sTF = tens != false ? 'TF' : '';
    String sEx = extractor != false ? 'E' : '';
    String sSm = smoke != false ? 'S' : '';
    String sWa = water != false ? 'W' : '';
    String sFl = flap != false ? 'A' : '';
    String sMaster = sTF != '' || sEx != '' || sSm != '' || sWa != '' || sFl != '' ? '~M!' : '';
    return 'R+>${sMT}MP${convertDoubFromStr(tempB)}/${convertDoubFromStr(tempP)}$sMaster$sTF$sEx$sSm$sWa$sFl';
  }
  @override
  bool get isNext => false;
}

//Рецепт
class Recipe {
  final String name;
  final String image; // Картинка
  final String info; // Инфо о рецепте
  final List<Stage> stages; // Лист этапов

  Recipe(this.name, this.image, this.info, this.stages);

  int calculateRecipe(){ // Расчёт времени приготовления рецепта
    int sum = 0;
    for (var e in stages) {
      sum = sum + e.time;
    }
    return sum;
  }
}

String convertDoubFromStr(double param) {
  return '${(param * 10).toInt()}';
}

class Cooking { //Готовка (управление одним рецептом)
  final Recipe stage;
  Cooking(this.stage);
  
void startCooking(){ //метод, который запускает процесс приготовления рецепта

}

void performSteps(){ //метод, который последовательно выполняет все шаги приготовления рецепта. Этот метод может принимать в качестве аргумента объект рецепта (Recipe), из которого можно получить список шагов (steps) и выполнить каждый из них последовательно.
  
}

void finishCooking(){ //метод, который заканчивает процесс приготовления рецепта. Например, может уведомлять пользователя о завершении приготовления или проводить финальные действия

}

int calculateRecipe(){ // Расчёт времени приготовления рецепта
  int sum = 0;
  for (var e in stage.stages) {
    sum = sum + e.time;
  }
  return sum;
}

void addRecipe(Recipe recipe){ // Добавление рецепта
  listRecipe.add(recipe);
} 

void removeRecipe(int index_){ // Удаление рецепта
  listRecipe.removeAt(index_);
}

void saveRecipe(){ // Сохранение рецепта
  
}

void loadRecipe(){ // Загрузка рецепта

}

  void goNext(){
    int index = 0;
    if (stage.stages[index].isNext) index++;
  }
}

class DataPlata{
  bool cL = false;
  double cTP = 0.0;
  double cTB = 0.0;
  double cMB = 0.0;
  double cMP = 0.0;
  bool smoke = false;
  bool flap = false;
  bool parogen = false;
  bool vit = true;
  //общение с платой
}

final listRecipe = [
  Recipe('Курица', 'img', 'info Курица', [Related(24,49), Boiling(54, 34, 10), Frying(43, 87)]),
  Recipe('Мясо', 'img', 'info Мясо', [Related(14,41), Drying(42, 43, 23), Smoking(51, 53, 24), Frying(53, 44)]),
  Recipe('Колбаса', 'img', 'info Колбаса', [Related(54,63), Drying(16, 16, 54), Smoking(53, 52, 33), Frying(66, 68)]),
  Recipe('Котлеты', 'img', 'info Котлеты', [Related(63,69), Boiling(45, 48, 15), Frying(54, 44)])
];