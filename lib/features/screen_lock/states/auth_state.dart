import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthState extends StateNotifier<bool> {
  final Ref ref;

  AuthState(this.ref) : super(false);

  Future<void> setState(bool isPass) async {
    state = isPass;
  }
}

final authState =
    StateNotifierProvider<AuthState, bool>((ref) => AuthState(ref));
