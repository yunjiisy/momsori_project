import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:momsori/screens/diary_edit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({Key? key}) : super(key: key);

  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  @override
  final ImagePicker _picker = ImagePicker();
  late PickedFile _image;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("일기 작성"),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Container(
                  child: OutlinedButton(
                    onPressed: () {
                      _getImage();
                    },
                    child: Container(
                      height: 20,
                      width: 60,
                      alignment: Alignment.center,
                      child: Text("사진추가"),
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    //textAlignVertical: ,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _getImage() async {
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }
}
