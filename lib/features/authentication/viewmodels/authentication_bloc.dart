import 'package:bloc/bloc.dart';
import 'package:wedy/features/authentication/models/login_api_model.dart';
import 'package:wedy/features/authentication/models/register_api_model.dart';
import 'package:wedy/features/authentication/models/verify_api_model.dart';
import 'package:wedy/features/authentication/services/authentication_service.dart';
import 'package:wedy/features/authentication/viewmodels/authentication_event.dart';
import 'package:wedy/features/authentication/viewmodels/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(this._authenticationService) : super(const AuthenticationState()) {
    on<AuthenticationRegisterRequested>(_onRegisterRequested);
    on<AuthenticationVerifyRequested>(_onVerifyRequested);
    on<AuthenticationLoginRequested>(_onLoginRequested);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    on<AuthenticationCheckStatus>(_onCheckStatus);
    on<AuthenticationClearError>(_onClearError);
  }

  Future<void> _onRegisterRequested(AuthenticationRegisterRequested event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true, status: AuthenticationStatus.loading, errorMessage: null));

    try {
      final response = await _authenticationService.register(event.request);

      if (response.exists != null && response.exists!) {
        emit(
          state.copyWith(
            user: null,
            isLoading: false,
            isVerified: false,
            isAuthenticated: false,
            status: AuthenticationStatus.unauthenticated,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            isVerified: false,
            isAuthenticated: true,
            user: response.user,
            status: AuthenticationStatus.unauthenticated,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          status: AuthenticationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onVerifyRequested(AuthenticationVerifyRequested event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true, isVerified: false, status: AuthenticationStatus.loading, errorMessage: null));

    try {
      await _authenticationService.verify(event.request);

      emit(
        state.copyWith(
          isLoading: false,
          isVerified: true,
          isAuthenticated: false,
          status: AuthenticationStatus.unauthenticated,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isVerified: false,
          isAuthenticated: false,
          status: AuthenticationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoginRequested(AuthenticationLoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true, status: AuthenticationStatus.loading, errorMessage: null));

    try {
      final response = await _authenticationService.login(event.request);
      await _authenticationService.storeToken(response.accessToken);

      final user = await _authenticationService.getCurrentUser();

      emit(
        state.copyWith(isLoading: false, isAuthenticated: true, user: user, status: AuthenticationStatus.authenticated),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          status: AuthenticationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _authenticationService.logout();
      emit(
        state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          user: null,
          status: AuthenticationStatus.unauthenticated,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString(), status: AuthenticationStatus.error));
    }
  }

  Future<void> _onCheckStatus(AuthenticationCheckStatus event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final token = _authenticationService.getStoredToken();

      if (token != null) {
        final user = await _authenticationService.getCurrentUser();
        emit(
          state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            user: user,
            status: AuthenticationStatus.authenticated,
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false, isAuthenticated: false, status: AuthenticationStatus.unauthenticated));
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          status: AuthenticationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onClearError(AuthenticationClearError event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(errorMessage: null));
  }

  // Convenience methods for the View
  void register(String fullname, String login, String password) {
    add(
      AuthenticationEvent.registerRequested(
        RegisterRequestModel(
          firstname: fullname.split(' ')[0],
          lastname: fullname.split(' ')[1],
          login: login,
          password: password,
        ),
      ),
    );
  }

  void verify(String login, String code) {
    add(AuthenticationEvent.verifyRequested(VerifyRequestModel(login: login, code: code)));
  }

  void login(String login, String password) {
    add(AuthenticationEvent.loginRequested(LoginRequestModel(login: login, password: password)));
  }

  void logout() {
    add(const AuthenticationEvent.logoutRequested());
  }

  void checkStatus() {
    add(const AuthenticationEvent.checkStatus());
  }

  void clearError() {
    add(const AuthenticationEvent.clearError());
  }
}
