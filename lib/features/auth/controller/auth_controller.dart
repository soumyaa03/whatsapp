import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

import 'package:whatsapp/features/auth/repository/auth_repository.dart';
import 'package:whatsapp/models/user_model.dart';

final authControllerProvider = Provider(((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  //Provider.of<AuthRepository>(context);
  return AuthController(authRepository: authRepository, ref: ref);
}));

final userDataAuthProvider = FutureProvider(((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
}));
//have provider variables Global => general rule in RiverPod

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFireBase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }
}
