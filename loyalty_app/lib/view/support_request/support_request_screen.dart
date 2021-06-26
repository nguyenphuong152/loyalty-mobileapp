import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
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
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: problem.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chọn vấn đề hỗ trợ",
                              style: TextStyle(fontSize: mFontSize)),
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
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
                            style: TextStyle(fontSize: mFontSize),
                          ),
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
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
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Text("picture")),
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
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return WarrantyScreen(
                    //         widget.product,
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
