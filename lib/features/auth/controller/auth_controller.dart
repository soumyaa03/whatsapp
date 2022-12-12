import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatsapp/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider(((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  //Provider.of<AuthRepository>(context);
  return AuthController(authRepository: authRepository);
}));

//have provider variables Global => general rule in RiverPod

class AuthController {
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }
}
