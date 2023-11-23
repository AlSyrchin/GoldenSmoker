/// Символ разделения команд
const SPLIT_COMMAND = '_';
/// Символ ввода процесса приготовления
const ACTION_INPUT = '>';
/// Символ разделения этапа приготовления
const ACTION_SPLIT = '~';
/// Символ ввода следующего параметра
const NEXT_PARAM = '/';

///  Изменить этапа рецепта под номером
const RECIPE_INDEX =  "R:";
///  Добавить этап в рецепт 
const RECIPE_ADD =    "R+";
///  Удалить этап из рецепта
const RECIPE_SUB =    "R-";
///  Узнать количество элементов
const RECIPE_SIZE =   "R*";
///  Текущий этап рецепта
const RECIPE_COUNT =  "R.";
///  Начать приготовеление
const RECIPE_START =  "RC";
///  Останвить приготовление рецепта
const RECIPE_STOP =   "RS";
///  Приостановить приготовление рецепта
const RECIPE_PAUSE =  "RP";
///  Продолжить приготовление рецепта
const RECIPE_CONTINUE = "RG";
///  Вывести рецепт
const RECIPE_WRITE =  "RW";
///  Приготовление рецепта заверешенно
const RECIPE_FINISH = "RF";
///  Перейти к этапу под номером
const RECIPE_NUMBER = "RN";
///  Очистить рецепт
const RECIPE_CLEAR =  "R!";
///  Перейти на следующий этап
const RECIPE_NEXT =   "R^";
///  Ручное управление вне рецепта
const RECIPE_MANUAL = "RM";
///  Выключить ручной режим
const RECIPE_AUTO =   "RA";


///  Включить свет
const HARDWARE_LAMP_ON = "L+";
///  Выключить свет
const HARDWARE_LAMP_OFF = "L-";

/// Вывести информацию
const INFO_WRITE = "??";
///;  СТОП кнопка нажата
const INFO_STOP_BUTTON_PRESS =   "B!";
///  СТОП кнопка не нажата
const INFO_STOP_BUTTON_RELEASE = "B*";
///  Нет воды в парогенераторе
const INFO_WATER_ERROR =    "W!";
///  Есть вода в парогенераторе
const INFO_WATER_FULL =     "W*";
///  Температура молока
const INFO_TEMP_PRODUCT =      "TP";
///  Текмпература воды
const INFO_TEMP_BOX =     "TB";
///  Вывод неоткалиброванных значений с датчика
const INFO_RAW_TEMPERATURE = "T?";

///  Калибровка датчиков по строке
const CALIBRATE_STRING =    "S:";
///  Калибровка верхней границы датчика молока 
const CALIBRATE_MILK_HIGH = "S1";
///  Калибровка нижней границы датчика молока
const CALIBRATE_MILK_LOW =  "S2";
///  Калибровка верхней границы датчика воды
const CALIBRATE_WATER_HIGH =  "S3";
///  Калибровка нижней границы датчика воды
const CALIBRATE_WATER_LOW =   "S4";
///  Сбросить калибровку датчиков
const CALIBRATE_RESET =       "SR";
///  Вывести значения калибровки
const CALIBRATE_WRITE =       "S?";

///  Настроить пид параметр
const PID_SETTINGS = "P:";
///  Настроить пид параметр
const PID_WRITE = "P?";
/// Сохранить пид параметры в EEPROM
const PID_SAVE = "PS";
/// Сбросить настройки PID
const PID_RESET = "PR";