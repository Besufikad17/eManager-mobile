import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/settings_data_service.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/domain/models/user.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/theme_bloc.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/alert.dart';
import 'package:cleanarchdemo/presentation/components/app_bar.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/presentation/components/file_picker.dart';
import 'package:cleanarchdemo/presentation/components/side_bar.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
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
  });

  final List<dynamic> images;
  final UserBloc userBloc;



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

  Future<LocalResponseData> getUser() async {
    return (await locator<LocalStorageRepositoryImpl>().getLocalResponseData())!;
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
          images: images,
        ),
      ),
      body: FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, snapshot) {
          if(snapshot.data != null) {
            return BlocProvider(
              create: (context) => UserBloc(locator<UserApiRepository>())..add(
                GetUserById(
                  snapshot.data!.user.id.toString(), 
                  snapshot.data!.token
                )
              ),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {},
                builder: (BuildContext context, UserState state) {
                  if(state is UserLoaded) {
                    final localUser = LocalUser(
                      state.user.id, 
                      state.user.fname, 
                      state.user.lname, 
                      state.user.email, 
                      state.user.phoneNumber, null, null
                    );
                    locator<LocalStorageRepositoryImpl>().addLocalResponseData(
                      LocalResponseData(
                        localUser,
                        snapshot.data!.token
                      )
                    );
                    return _buildInitial(context, theme, lang, image, imageType, localUser, snapshot.data!.token);
                  } else if(state is UserError) {
                    _buildError(context, state.message!);
                  } else if(state is UserLoading) {
                    return CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,);
                  } 
                  return Container();       
                },
              ),
            );
          } else {
            return CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,);
          }
        } 
      )
    );
  }

  void _buildError(BuildContext context, String message) async {
    await Future.delayed(const Duration(microseconds: 1));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 30, // Adjust the height as needed
          child: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          backgroundColor: Colors.black,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.read<UserBloc>().add(const UserLoginLoading());
          },
        ),
      ),
    );
  }

  Widget _buildInitial(BuildContext context, theme, lang, image, imageType, LocalUser user, token) {
    TextEditingController emailTextField = TextEditingController();
    TextEditingController fullNameTextField = TextEditingController();
    TextEditingController phoneNumberTextField = TextEditingController();
    
    fullNameTextField.text = "${user.fname} ${user.lname}";
    emailTextField.text = user.email!;
    phoneNumberTextField.text = user.phonenumber!;

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
                            return MyAlert(
                              title: "Pick Image", 
                              type: AlertType.message, 
                              body: MyFilePicker(
                                type: FileType.Image, 
                                image: image,
                                pickFromGallery: (p0, p1) => getImageFromCamera(p0, p1),     
                                pickFromCamera:  (p0, p1) => getImageFromCamera(p0, p1),                         
                              )
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
                          images.isNotEmpty ? images[0] : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
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
                          borderColor: "#83A598",
                          borderRadius: 5,
                          onPressed: () {
                            if(
                              isValidFullName(fullNameTextField.text) && 
                              isValidEmail(emailTextField.text) && 
                              isValidPhoneNumber(phoneNumberTextField.text)) {
                                userBloc.add(
                                  EditProfileEvent(
                                    user.id.toString(), 
                                    User(
                                      fname: fullNameTextField.text.split(" ")[0],
                                      lname: fullNameTextField.text.split(" ")[1],
                                      email: emailTextField.text,
                                      phoneNumber: phoneNumberTextField.text
                                    ),
                                    token
                                  )
                                );
                                context.router.push(const HomeRoute());
                            } else {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return const MyAlert(
                                    title: "Invalid inputs", 
                                    type: AlertType.error, 
                                    body: Text("Please enter valid inputs!!")
                                  );
                                }
                              );
                            }
                          }),
                        const SizedBox(
                          width: 20,
                        ),
                        MyButton(
                          text: "Delete",
                          width: 140,
                          height: 35,
                          bgcolor: "#FB4934",
                          fgcolor: "#ffffff",
                          borderColor: "#FB4934",
                          borderRadius: 5,
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return MyAlert(
                                  title: "Alert", 
                                  type: AlertType.message, 
                                  body: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      MyText(
                                        text: "Are you sure you want to delete your account?", 
                                        size: 13
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          const SizedBox(width: 15,),
                                          MyButton(
                                            text: "Yes", 
                                            width: 100, 
                                            height: 35, 
                                            bgcolor: "#FB4934",
                                            fgcolor: "#ffffff",
                                            borderColor: "#FB4934",
                                            borderRadius: 5,
                                            onPressed: () {
                                              userBloc.add(RemoveUser(user.id.toString(), token));
                                              userBloc.add(const UserLogoutEvent());
                                              context.router.push(const WelcomeRoute());
                                            }
                                          ),
                                          const SizedBox(width: 20,),
                                          MyButton(
                                            text: "No", 
                                            width: 100, 
                                            height: 35, 
                                            bgcolor: "#83A598",
                                            fgcolor: "#ffffff",
                                            borderColor: "#83A598",
                                            borderRadius: 5,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                );
                              }
                            );
                          })
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
