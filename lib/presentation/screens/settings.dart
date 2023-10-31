import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/settings_data_service.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/theme_bloc.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/alert.dart';
import 'package:cleanarchdemo/presentation/components/app_bar.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/presentation/components/file_picker.dart';
import 'package:cleanarchdemo/presentation/components/side_bar.dart';
import 'package:cleanarchdemo/presentation/components/text_field.dart';
import 'package:cleanarchdemo/utils/constants/enums.dart';
import 'package:cleanarchdemo/utils/resources/data.dart';
import 'package:cleanarchdemo/utils/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class SettingsPage extends HookWidget {
  SettingsPage({
    super.key,
    required this.userBloc,
    required this.images,
    required this.user  
  });

  final List<dynamic> images;
  final LocalUser user;
  final UserBloc userBloc;

  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController fullNameTextField = TextEditingController();
  final TextEditingController phoneNumberTextField = TextEditingController();

  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery(image, type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      type = "local";
    }
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera(image, type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      image = File(pickedFile.path);
      type = "local";
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = useState("Light");
    var lang = useState("English");
    var image = useState(File(""));
    var imageType = useState("network");
    var themeIcon = useState(
      locator<AppTheme>() == AppTheme.light ? Icons.dark_mode : Icons.light_mode
    );

    fullNameTextField.text = "${user.fname} ${user.lname}";
    emailTextField.text = user.email ?? "";
    phoneNumberTextField.text = user.phonenumber ?? "";

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: MyAppBar(
          title: "Settings",
          actions: [
            IconButton(
              onPressed: () {
                if(locator<AppTheme>() == AppTheme.light) {
                  themeIcon.value = Icons.dark_mode;
                  locator<ThemeBloc>().add(const ThemeChanged(AppTheme.dark));
                  locator<ThemeManager>().toggleTheme(true);
                }else {
                  themeIcon.value = Icons.light_mode;
                  locator<ThemeBloc>().add(const ThemeChanged(AppTheme.light));
                  locator<ThemeManager>().toggleTheme(false);
                }
              }, 
              icon: Icon(themeIcon.value)
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: MySideBar(
          userBloc: userBloc,
          images: images,
          user: user,
        ),
      ),
      body: BlocProvider(
        create: (context) => UserBloc(locator<UserApiRepository>()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {},
          builder: (BuildContext context, UserState state) {
            return _buildInitial(context, theme, lang, image, imageType);
          },
        ),
      )
    );
  }

  Widget _buildInitial(BuildContext context, theme, lang, image, imageType) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40),
        color: Theme.of(context).colorScheme.primary,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return const MyAlert(
                              title: "Pick Image", 
                              type: AlertType.message, 
                              body: MyFilePicker(type: FileType.Image)
                            );
                          }
                        );
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(75)),
                        child: imageType.value == "local" ?
                        Image.file(
                          image.value,
                          width: 150,
                          height: 150
                        ) :
                        Image.network(
                          images[0],
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    MyTextField(
                      label: "Full name",
                      placeholder: "John Doe",
                      type: "first name",
                      fontSize: 14,
                      height: 40,
                      width: 300,
                      enabledBorderWidth: 1,
                      focusedBorderWidth: 1.5,
                      textEditingController: fullNameTextField,
                      regexChecker: isValidFullName,
                    ),
                    MyTextField(
                      label: "Email",
                      placeholder: "JohnDoe@gmail.com",
                      type: "email",
                      fontSize: 14,
                      height: 40,
                      width: 300,
                      enabledBorderWidth: 1,
                      focusedBorderWidth: 1.5,
                      textEditingController: emailTextField,
                      regexChecker: isValidEmail,
                    ),
                    MyTextField(
                      label: "Phone Number",
                      placeholder: "2519xxxxxx",
                      type: "phone number",
                      fontSize: 14,
                      height: 40,
                      width: 300,
                      enabledBorderWidth: 1,
                      focusedBorderWidth: 1.5,
                      textEditingController: phoneNumberTextField,
                      regexChecker: isValidPhoneNumber,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        MyButton(
                          text: "Edit",
                          width: 140,
                          height: 35,
                          bgcolor: "#83A598",
                          fgcolor: "#ffffff",
                          onPressed: () {}),
                        const SizedBox(
                          width: 20,
                        ),
                        MyButton(
                          text: "Delete",
                          width: 140,
                          height: 35,
                          bgcolor: "#FB4934",
                          fgcolor: "#ffffff",
                          onPressed: () {})
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
