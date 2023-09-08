import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constData.dart';
import 'mask/mask_text_input_formatter.dart';
import 'state/stateControl.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'SF Pro Display'),
      home: CardOne(),
    );
  }
}

class CardOne extends StatelessWidget {
  CardOne({Key? key}) : super(key: key);
  final StateData dataState = Get.put(StateData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Отель', style: titleName),
          centerTitle: true,
          backgroundColor: kWhite,
          bottomOpacity: 0.0,
          elevation: 0.0),
      backgroundColor: kInputBack,
      body: SafeArea(
        child: Obx(() => dataState.connect
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        decoration: decor,
                        padding: const EdgeInsets.only(bottom: pad16, left: pad16, right: pad16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SliderImage(dataState.data.imageUrls!),
                            const SizedBox(height: pad16),
                            Rating(rating: dataState.data.rating!,ratingName: dataState.data.ratingName!),
                            const SizedBox(height: pad8),
                            Text('${dataState.data.name}',style: headTitle),
                            const SizedBox(height: pad8),
                            Text('${dataState.data.adress}',style: titleblue),
                            const SizedBox(height: pad16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('от ${formRu.format(dataState.data.minimalPrice)} ₽',style: titlePrice),
                                const SizedBox(width: pad8),
                                SizedBox(
                                  height: 21.5,
                                  child: Text('${dataState.data.priceForIt}'.toLowerCase(),style: titleGrey),
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(height: pad8),
                    Container(
                        decoration: decor,
                        padding: padAll16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Об отеле', style: headTitle),
                            const SizedBox(height: pad16),
                            InfoHitel(
                                dataState.data.aboutHotel!.peculiarities),
                            const SizedBox(height: 12),
                            Text(dataState.data.aboutHotel!.description,
                                style: litleTitle),
                            const SizedBox(height: pad16),
                            const ListButton(),
                          ],
                        )),
                    const SizedBox(height: 12),
                    ButtonEnd(dataState.data.name!)
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    required this.rating,
    required this.ratingName,
  }) : super(key: key);
  final int rating;
  final String ratingName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kOrange02,
        borderRadius: borderRad5,
      ),
      width: 149,
      height: 29,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, size: 15, color: kOrange),
          const SizedBox(width: 2),
          Text('$rating $ratingName',
              style: const TextStyle(color: kOrange, fontSize: 16))
        ],
      ),
    );
  }
}

class InfoHitel extends StatelessWidget {
  const InfoHitel(
    this.peculiarities, {
    Key? key,
  }) : super(key: key);
  final List<String> peculiarities;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: peculiarities
          .map(
            (e) => Container(
              decoration: const BoxDecoration(
                color: kLightGrey,
                borderRadius: borderRad5,
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(e, style: titleGreyH),
            ),
          )
          .toList(),
    );
  }
}

class ListButton extends StatelessWidget {
  const ListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: const BoxDecoration(
        color: kInputBack,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: ListTile.divideTiles(
                context: context,
                tiles: listTit
                    .map(
                      (e) => ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        horizontalTitleGap: 12,
                        leading: SizedBox(width: 24, height: 24, child: e.leading,),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.title, style: litleTitleH),
                            const Text('Самое необходимое', style: title14),
                          ],
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                    )
                    .toList())
            .toList(),
      ),
    );
  }
}

class ButtonEnd extends StatelessWidget {
  const ButtonEnd(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padSym1612,
      decoration: const BoxDecoration(
        color: kWhite,
        border: Border(top: BorderSide(color: kLine)),
      ),
      child: SizedBox(
        height: 48,
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            onPressed: () => Get.to(() => CardTwo(name)),
            child: const Text('К выбору номера', style: litleTitleH)),
      ),
    );
  }
}

class SliderImage extends StatelessWidget {
  const SliderImage(this.imageList, {super.key});
  final List<String> imageList;
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return ObxValue((pages) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          width: double.infinity,
          height: 257,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index) => pages.value = index,
            pageSnapping: true,
            itemCount: imageList.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(imageList[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text('Error load image'))),
            ),
          ),
        ),
        Positioned(
          bottom: pad8,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 7.5),
            decoration:
                const BoxDecoration(color: kWhite, borderRadius: borderRad5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(imageList.length, (index) {
                return Container(
                  margin: const EdgeInsets.all(2.5),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                      color: pages.value == index ? kBlack : kBlack02,
                      shape: BoxShape.circle),
                );
              }),
            ),
          ),
        ),
      ],
    ), 0.obs);
  }
}

class CardTwo extends StatelessWidget {
  CardTwo(this.name, {super.key});
  final String name;
  final StateRoom roomState = Get.put(StateRoom());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, name),
      backgroundColor: kInputBack,
      body: SafeArea(
        child: Obx(
          () => roomState.connect
          ? SingleChildScrollView(
            child: Column(
                children: roomState.room.rooms!
                    .map((e) => RoomItem(
                        imageList: e.imageUrls!,
                        pageImg: roomState.p,
                        name: e.name!,
                        peculir: e.peculiarities!,
                        price: e.price!,
                        toPrice: e.pricePer!))
                    .toList()),
          )
          : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class RoomItem extends StatelessWidget {
  const RoomItem({
    Key? key,
    required this.imageList,
    required this.pageImg,
    required this.name,
    required this.peculir,
    required this.price,
    required this.toPrice,
  }) : super(key: key);
  final List<String> imageList;
  final int pageImg;
  final String name;
  final List<String> peculir;
  final int price;
  final String toPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: padTop8,
        decoration: decor,
        padding: padAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderImage(imageList),
            const SizedBox(height: pad8),
            Text(name, style: headTitle),
            const SizedBox(height: pad8),
            InfoHitel(peculir),
            const SizedBox(height: pad8),
            InkWell(
              onTap: () {},
              child: Container(
                  width: 192,
                  height: 29,
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  decoration: const BoxDecoration(
                      color: kBlue01, borderRadius: borderRad5),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Подробнее о номере',style: titleblue16),
                      Icon(Icons.keyboard_arrow_right, size: 24, color: kBlue)
                    ],
                  )),
            ),
            const SizedBox(height: pad16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${formRu.format(price)} ₽', style: titlePrice),
                const SizedBox(width: pad8),
                SizedBox(
                    height: 21.5,
                    child: Text(toPrice.toLowerCase(), style: titleGrey)),
              ],
            ),
            const SizedBox(height: pad16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onPressed: () => Get.to(() => CardThree()),
                  child: const Text('Выбрать номер', style: litleTitleH)),
            ),
          ],
        ));
  }
}


class CardThree extends StatelessWidget {
  CardThree({super.key});
  final StateBron bronState = Get.put(StateBron());
  final UserCard userCard = Get.put(UserCard());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Бронирование'),
      backgroundColor: kInputBack,
      body: SafeArea(
        child: Obx(() => bronState.connect
            ? SingleChildScrollView(
              child: Column(
                  children: [
                    const SizedBox(height: pad8),
                    Container(
                        width: double.infinity,
                        decoration: decor,
                        padding: padAll16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Rating(rating: bronState.bron.horating!,ratingName: bronState.bron.ratingName!),
                            const SizedBox(height: pad8),
                            Text('${bronState.bron.hotelName}',style: headTitle),
                            const SizedBox(height: pad8),
                            Text('${bronState.bron.hotelAdress}',style: titleblue),
                          ],
                        )),
                    const SizedBox(height: pad8),
                    Container(
                      decoration: decor,
                      padding: padAll16,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: listBron.map(
                                (e) => ListTile(
                                  dense: true,
                                  horizontalTitleGap: 40,
                                  minLeadingWidth: 101,
                                  leading: Text(e.title, style: titleGrey),
                                  title: Text(
                                    e.body,
                                    textAlign: TextAlign.left,
                                    style: litleTitle,
                                    softWrap: true,
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                    const SizedBox(height: pad8),
            
                    Form(
                      key: formKey,
                      child: Container(
                        decoration: decor,
                        padding: padAll16,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Информация о покупателе', style: headTitle),
                            SizedBox(height: 20),
                            TextInput('Номер телефона', TextInputType.phone),
                            SizedBox(height: 8),
                            TextInput('Почта', TextInputType.emailAddress),
                            SizedBox(height: 8),
                            Text('Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту',style: title14sm)
                          ],
                        ),
                      ),
                    ),
                    Obx(() => Column(children: userCard.cardUsers.map((element) => Container(margin: const EdgeInsets.only(top: 8),child: element)).toList(),)),           
                    const SizedBox(height: pad8),           
                    Container(
                        decoration: decor,
                        padding: padSym1613,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Добавить туриста', style: headTitle),
                            Container(
                              decoration: const BoxDecoration(
                                  color: kBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: IconButton(
                                onPressed: () => userCard.addCard(),
                                icon: const Icon(
                                  Icons.add,
                                  color: kWhite,
                                  size: 24,//32
                                ),
                              ),
                            )
                          ],
                        )),
                    const SizedBox(height: pad8),
            
                    /// new bloc
                    Container(
                      decoration: decor,
                      padding: padAll16,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: listPrice
                              .map(
                                (e) => ListTile(
                                  dense: true,
                                  leading: Text(e.title, style: titleGrey),
                                  title: Text(
                                    '${e.body} ₽',
                                    textAlign: TextAlign.right,
                                    style: e.title == 'К оплате' ? titleblue16L : litleTitle,
                                    softWrap: true,
                                  ),
                                ),
                              ).toList()),
                    ),
                    const SizedBox(height: pad8),

                    Container(
                      width: double.infinity,
                      padding: padSym1613,
                      decoration: const BoxDecoration(
                          color: kWhite,
                          border: Border(top: BorderSide(color: kLine))),
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              final isValid = formKey.currentState!.validate();
                              if (isValid) {Get.to(() => const CardFour());} else {
                                const snackBar = SnackBar(content: Text('Не все поля заполнены',style: TextStyle(fontSize: 20)),backgroundColor: Colors.redAccent); //Color.fromRGBO(235, 87, 87, 0.15)
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }                             
                            },
                            child: Text('Оплатить ${formRu.format(bronState.getSum())} ₽',style: litleTitleH)),
                      ),
                    )
                  ],
                ),
            )
            : const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}

class CardInputUser extends StatelessWidget {
const CardInputUser(this.title, {super.key});
final String title;
  @override
  Widget build(BuildContext context) {
    return ObxValue((param) => Container(
                      decoration: decor,
                      padding: padSym1613,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$title турист', style: headTitle),
                              Container(
                                decoration: const BoxDecoration(
                                    color: kBlue01,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: IconButton(
                                    onPressed: () => param.toggle(),
                                    icon: Icon(
                                      param.value
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: kBlue,
                                      size: 24,//32
                                    )),
                              )
                            ],
                          ),
                          param.value
                              ? Column(
                                  children: [
                                    const SizedBox(height: 4),
                                    ...strTitle.map((e) => Container(
                                        margin: padTop8,
                                        child: TextInput(e.title, e.type)))
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ), false.obs);
  }
}

AppBar myAppBar(BuildContext context, String name) {
  return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.keyboard_arrow_left,
          color: kBlack,
          size: 32,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(name, style: titleName),
      centerTitle: true,
      backgroundColor: kWhite,
      bottomOpacity: 0.0,
      elevation: 0.0);
}

class CardFour extends StatelessWidget {
  const CardFour({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Заказ оплачен'),
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: Get.height * 0.50,
              padding: const EdgeInsets.symmetric(horizontal: 16), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: const BoxDecoration(
                        color: kLightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(1000))),
                    child: Image.asset('assets/images/party_popper.png', width: 44, height: 44),
                  ),
                  const SizedBox(height: 32),
                  const Text('Ваш заказ принят в работу', style: headTitle),
                  const SizedBox(height: 17),
                  Text('Подтверждение заказа №${Random().nextInt(10000) + 1} может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
                    style: titleGrey,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: padSym1612,
              decoration: const BoxDecoration(
                color: kWhite,
                border: Border(top: BorderSide(color: kLine)),
              ),
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    onPressed: () => Get.offAll(() => CardOne()),
                    child: const Text('Супер!', style: litleTitleH)),
              ),
            )
          ],
        ),
      ),
    );
  }
}




class TextInput extends StatelessWidget {
  const TextInput(this.name, this.type, {super.key});
  final String name;
  final TextInputType type;

  MaskTextInputFormatter getMask(){
    if (name == 'Номер телефона') return   MaskTextInputFormatter(mask: '+7 (###) ###-##-##',filter: { "#": RegExp(r'[0-9]') }, type: MaskAutoCompletionType.lazy);
    if (name == strTitle[2].title || name == strTitle[5].title)  return  MaskTextInputFormatter(mask: '##.##.####', filter: { "#": RegExp(r'[0-9]') }, type: MaskAutoCompletionType.lazy);
    return MaskTextInputFormatter();
  }

  String? getValidEmail(String? str) {
    final regExpEmail = RegExp(r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)');
    final regExpPhon = RegExp(r'(^[+][7]..\d{3}..\d{3}.\d{2}.\d{2}$)');
    final regExpDate = RegExp(r'(^\d{2}.\d{2}.\d{4}$)');
    if (str!.isEmpty) return 'Пустое значение';
    if (name == 'Почта' && !regExpEmail.hasMatch(str)) return 'Некорректная почта';
    if (name == 'Номер телефона' && !regExpPhon.hasMatch(str)) return 'Некорректный номер телефона';
    if (name == strTitle[2].title || name == strTitle[5].title && !regExpDate.hasMatch(str)) return 'Некорректная дата';
    return null;
  } 

  @override
  Widget build(BuildContext context) {
    return ObxValue((control) => Container(
      decoration: const BoxDecoration(
          color: kInputBack,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        controller: control.value,
        inputFormatters: [getMask()],
        validator: (value) => getValidEmail(value),
        style: const TextStyle(color: kInputText),
        keyboardType: type,
        decoration: InputDecoration(
          errorText: null,
          isDense: true,
          contentPadding: padSym1610,
          border: InputBorder.none,
          labelText: name,
          labelStyle: const TextStyle(color: kInputLable),
        ),
      ),
    ), TextEditingController().obs);
  }
}
