import 'dart:html';

import 'package:art/dio/dio_client.dart';
import 'package:art/model/art_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import '../../packages/flutter_firebase_chat_core/src/firebase_chat_core.dart';
import 'chat.dart';
import 'util.dart';
import 'package:art/data/theme.dart' as theme;

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);

  DioClient dioClient = DioClient();

  void _handlePressed(types.User otherUser, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
        decoration: const BoxDecoration(
        gradient: theme.Theme.mainGradient,
        ),
      margin: const EdgeInsets.only(right: 16),
      child:
          FutureBuilder(
            future: dioClient.getArtUserByUsername(user.lastName),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                ArtUser artUser = snapshot.data as ArtUser;
                return CircleAvatar(
                  backgroundColor: hasImage ? Colors.transparent : color,
                  backgroundImage: hasImage ? NetworkImage(artUser.photoUrl!) : null,
                  radius: 20,
                  child: !hasImage
                      ? Text(
                    name.isEmpty ? '' : name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )
                      : null,
                );
              }else{
                return  CircleAvatar(
                  backgroundColor: hasImage ? Colors.transparent : color,
                  backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
                  radius: 20,
                  child: !hasImage
                      ? Text(
                    name.isEmpty ? '' : name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )
                      : null,
                );
                // return Container();
              }
            },

          ),


      // ClipOval(
      //   child: Image.network(
      //     user.imageUrl!,
      //     width: 100,
      //     height: 100,
      //     fit: BoxFit.cover,
      //   ),
      // ),

      // ExtendedImage.network(
      //   user.imageUrl!,
      //   width: 100,
      //   height: 100,
      //   fit: BoxFit.fill,
      //   cache: true,
      //   border: Border.all(color: Colors.red, width: 1.0),
      //   shape: BoxShape.circle,
      //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
      //   //cancelToken: cancellationToken,
      // )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xD6F8F8FF),
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle.light,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('All Users'),
      ),
      body: StreamBuilder<List<types.User>>(
        stream: FirebaseChatCore.instance.users(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No users'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  _handlePressed(user, context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _buildAvatar(user),
                      Text(getUserName(user)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}