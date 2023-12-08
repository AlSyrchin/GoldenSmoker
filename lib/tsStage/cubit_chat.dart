import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state_chat.dart';

class CubitChat extends Cubit<StateChat> {
  CubitChat() : super(StateChat());

  double tp = 0;
  double tb = 0;
  int step = 0;
  bool lamp = false;
  double mb = 0;
  int mt = 0;
  bool water = false;
  bool smoke = false;
  bool air = false;
  int timePeriod = 0;
  int timeNow = 0;
  bool nextEtap = false;
  int whisEtap = 0;
  bool isWater = false;

  double _fCommand(String command) => int.parse(command.substring(2)) / 10;

  void parseData(Uint8List data) {
    String dataString = utf8.decode(data).trim();
    if (dataString.isEmpty) return;

    print(dataString);

    // listMsg.add(dataString);
    // if (listMsg.length > 30) listMsg.removeAt(0);
    List<String> listALL = dataString.split('_');
    air = false; smoke = false; water = false;
    for (var command in listALL) {
      switch (command.substring(0, 2)) {
        case 'TP': tp = _fCommand(command); break;
        case 'TB': tb = _fCommand(command);break;
        case 'R*': step = int.parse(command.substring(2));break;
        case 'L-': lamp = false;break;
        case 'L+': lamp = true;break;
        case 'W*': isWater = true;break;
        case 'W!': isWater = false;break;
        case 'RM': _listRM(command);break;
        case 'MT': _listMT(command);break; //MT8/0>MP240/240~M!TFW
        case 'RN': whisEtap = int.parse(command.substring(2));break; //этапы
        case 'RF': whisEtap = 0; nextEtap = true; break; // конец
        default:
      }
    }
    emit(state.copyWith(tp: tp, tb: tb, step: step, lamp: lamp, a: air, s: smoke, w: water, mb: mb, mt: mt, timePeriod: timePeriod, timeNow: timeNow, whisEtap: whisEtap, nextEtap: nextEtap, isWater: isWater));
  }

  void _listMT(String comm) {
    List<String> listMT = comm.substring(0).split('>');
    for (var mt in listMT){
      switch (mt.substring(0, 2)) {
        case 'MT': 
        List<String> list = mt.split('/'); 
        timePeriod = int.parse(list[0].substring(2));
        timeNow = int.parse(list[1]);
        break;
        case 'MP': _listRM(mt);break;
        default: 
      }
    }
  }

  void _listRM(String comm) {
    List<String> listRM = comm.substring(3).split('~');
    for (var rm in listRM){
      switch (rm.substring(0, 2)) {
        case 'MB': mb = _fCommand(rm);break;
        case 'MP':
          List<String> listMP = rm.substring(2).split('/');
          if (listMP.isNotEmpty) {
            tp = int.parse(listMP[0]) / 10;
            if (listMP.length > 1)  tb = int.parse(listMP[1]) / 10;
          }
        break;
        case 'MT':
          List<String> listMT = rm.substring(2).split('/');
          if (listMT.isNotEmpty) {
            timePeriod = int.parse(listMT[0]);
            if (listMT.length > 1) timeNow = int.parse(listMT[1]);
          }
        break;
        case 'M!': _listM(rm);break;
        default: 
      }
    }
  }

  void _listM(String str) {
    List<String> listM = str.substring(2).split('');
    for (var i in listM) {
      switch (i) {
        case 'A': air = true;break;
        case 'S': smoke = true;break;
        case 'W': water = true;break;
        default:
      }
  }
  }

}