import 'dart:typed_data';

import 'package:art/dio/dio_client.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/constants.dart';
import 'package:universal_io/io.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../personal_center_screen.dart';

class UploadPage extends StatefulWidget {
  UploadPage({ Key? key,this.email }) : super(key: key);
  String? email;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with SingleTickerProviderStateMixin {
  String _image = 'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';
  late AnimationController loadingController;

  File? _myFile;
  Uint8List? _file;
  PlatformFile? _platformFile;
  Uint8List? logoBase64;

  DioClient dioClient = DioClient();

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'bmp']
    );



    if (file != null) {
      setState(()  {
        // uploadfile = file.files.single.bytes;
        // _file = File(file.files.single.path!);
        _file = file.files.single.bytes;
        logoBase64 = file.files.first.bytes;
        _platformFile = file.files.first;

        // await FirebaseStorage.instance.ref('uploads/${_platformFile!.name}').putData(logoBase64!);

        // _myFile = createFileFromBytes(_file!);
        // print("---------------");
        // print(_myFile);
        // print(_myFile?.path);
      });
    }

    loadingController.forward();
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() { setState(() {}); });

    super.initState();
  }

  File createFileFromBytes(Uint8List bytes) => File.fromRawPath(bytes);


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 100.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: colorBlack),
              ),
              Text(
                'Upload',
                style: GoogleFonts.manrope(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: colorBlack,
                ),
              ),
              SizedBox(
                width: 35,
                height: 30,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100,),
            Image.network(_image, width: 300,),
            SizedBox(height: 50,),
            Text('Upload your file', style: TextStyle(fontSize: 25, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('File should be jpg, png', style: TextStyle(fontSize: 15, color: Colors.grey.shade500),),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: selectFile,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    dashPattern: [10, 4],
                    strokeCap: StrokeCap.round,
                    color: Colors.blue.shade400,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.folder_open, color: Colors.blue, size: 40,),
                          SizedBox(height: 15,),
                          Text('Select your file', style: TextStyle(fontSize: 15, color: Colors.grey.shade400),),
                        ],
                      ),
                    ),
                  )
              ),
            ),
            _platformFile != null
                ? Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selected File',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 15, ),),
                    SizedBox(height: 10,),
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                spreadRadius: 2,
                              )
                            ]
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),

                              // child: Image.file(_file.!, width: 70,)
                              child: Image.memory(logoBase64!,width: 200,height: 200,),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_platformFile!.name,
                                    style: TextStyle(fontSize: 13, color: Colors.black),),
                                  SizedBox(height: 5,),
                                  Text('${(_platformFile!.size / 1024).ceil()} KB',
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                      height: 5,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue.shade50,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: loadingController.value,
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    // MaterialButton(
                    //   minWidth: double.infinity,
                    //   height: 45,
                    //   onPressed: () {},
                    //   color: Colors.black,
                    //   child: Text('Upload', style: TextStyle(color: Colors.white),),
                    // )
                  ],
                ))
                : Container(),
            SizedBox(height: 150,),
            IconButton(
                onPressed: () async {
                  if(_file != null){
                    var snapshot = await FirebaseStorage.instance.ref('uploads/${_platformFile!.name}').putData(logoBase64!);
                    var downloadUrl = await snapshot.ref.getDownloadURL();
                    // print(downloadUrl);
                    bool result = await dioClient.uploadImage(downloadUrl, widget.email) as bool;
                    if(result){
                      EasyLoading.showSuccess("Uploaded successfully!");
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const PersonalCenterScreen();
                        },
                      ));
                    }else{
                      EasyLoading.showError("upload failed!");
                    }
                  }else{
                    EasyLoading.showError("Please select file!");
                  }
                },
          icon: const Icon(Icons.upload),color: Colors.cyanAccent,),
            Text('Upload', style: TextStyle(fontSize: 25, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}