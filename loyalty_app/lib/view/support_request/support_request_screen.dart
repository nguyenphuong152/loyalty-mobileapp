import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loyalty_app/bloc/support_request_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/request_support_model.dart';

class SupportRequestScreen extends StatefulWidget {
  @override
  _SupportRequestScreenState createState() => _SupportRequestScreenState();
}

class _SupportRequestScreenState extends State<SupportRequestScreen> {
  List<String> problems = [
    "Tài khoản",
    "Sản phẩm",
    "Ưu đãi",
    "Thanh toán",
    "Lỗi ứng dụng"
  ];
  String problem = "";

  SupportRequestBloc _supportRequestBloc = new SupportRequestBloc();
  RequestSupportModel requestModel = new RequestSupportModel();

  TextEditingController descriptionController = new TextEditingController();

  PickedFile imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: mPrimaryColor,
              size: 16,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Trung tâm hỗ trợ',
          style: TextStyle(
            fontSize: mFontSize,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: problem.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chọn vấn đề hỗ trợ",
                              style: TextStyle(
                                  fontSize: mFontSize,
                                  color: mPrimaryColor,
                                  fontWeight: FontWeight.w600)),
                          IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: mPrimaryColor,
                              ),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          height: 300,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Loại vấn đề",
                                                    style: TextStyle(
                                                        fontSize: mFontSize,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                  child: ListView.separated(
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        const Divider(),
                                                itemCount: problems.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        problem =
                                                            problems[index];
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      title: Text(
                                                          '${problems[index]}'),
                                                    ),
                                                  );
                                                },
                                              ))
                                            ],
                                          ));
                                    });
                              })
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            problem,
                            style: TextStyle(
                                fontSize: mFontSize,
                                color: mPrimaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: mPrimaryColor,
                              ),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          height: 300,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Loại vấn đề",
                                                    style: TextStyle(
                                                        fontSize: mFontSize,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                  child: ListView.separated(
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        const Divider(),
                                                itemCount: problems.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        problem =
                                                            problems[index];
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      title: Text(
                                                          '${problems[index]}'),
                                                    ),
                                                  );
                                                },
                                              ))
                                            ],
                                          ));
                                    });
                              })
                        ],
                      )),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: TextFormField(
                minLines: 2,
                maxLines: 6,
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  hintText: 'Mô tả',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 5, right: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Chọn hình ảnh"),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mPrimaryColor,
                      ),
                      child:
                          FaIcon(FontAwesomeIcons.camera, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [test()],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: size.width,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide(color: mPrimaryColor)),
                  color: mPrimaryColor,
                  textColor: Colors.white,
                  child: Text("Gửi", style: TextStyle(fontSize: 18)),
                  onPressed: () async {
                    setState(() {
                      requestModel.photo = imageFile.path;
                      requestModel.senderName = "Doe John";
                      requestModel.description = descriptionController.text;
                      requestModel.problemType = problem;
                      requestModel.isActive = false;
                    });

                    showLoaderDialog(context);

                    _supportRequestBloc
                        .sendSupport(requestModel)
                        .then((value) => {
                              if (value != null)
                                {Navigator.pop(context), _showMaterialDialog()}
                              else
                                {_showErrorDialog()}
                            });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: new Image(
                width: 130,
                height: 130,
                image: AssetImage("assets/images/success.gif"),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Yêu cầu đã được gửi đi. Chúng tôi sẽ liên hệ với bạn sớm nhất!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                            child: Text('Quay lại',
                                style: TextStyle(
                                    color: mPrimaryColor, fontSize: 15)),
                            onPressed: () {
                              setState(() {
                                problem = '';
                                descriptionController.text = "";
                                imageFile = null;
                              });
                              Navigator.of(context, rootNavigator: true).pop();
                            }),
                      ])
                ],
              ),
            ));
  }

  _showErrorDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: Container(
                child: Column(
                  children: [
                    Image(
                      width: 250,
                      height: 250,
                      image: AssetImage("assets/images/error.gif"),
                    ),
                    Text(
                      "Thất bại",
                      style: TextStyle(fontSize: mFontSize, color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Bạn vui lòng kiểm tra lại thông tin đăng kí nhé!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.black, fontSize: mFontSize),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: mPrimaryColor)),
                        color: mPrimaryColor,
                        child: Text('Quay lại',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        })
                  ],
                ),
              ),
            ));
  }

  void _openGallary(ImageSource source) async {
    final media = await picker.getImage(source: source);

    this.setState(() {
      imageFile = media;
    });

    Navigator.of(context).pop();
  }

  Widget test() {
    if (imageFile == null) {
      return Text("");
    } else {
      return Image.file(
        File(imageFile.path),
        width: 300,
        height: 300,
      );
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Chọn ảnh hoặc video"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                  onPressed: () => _openGallary(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text("Camera")),
              FlatButton.icon(
                  onPressed: () => _openGallary(ImageSource.gallery),
                  icon: Icon(Icons.collections),
                  label: Text("Thư viện"))
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descriptionController.dispose();
  }
}
