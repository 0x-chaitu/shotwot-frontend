// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shotwot_frontend/src/blocs/auth/auth_bloc.dart' as _i9;
import 'package:shotwot_frontend/src/repository/i_auth_facade.dart' as _i7;
import 'package:shotwot_frontend/src/repository/impl/auth_facade.dart' as _i8;
import 'package:shotwot_frontend/src/services/app.module.dart' as _i10;
import 'package:shotwot_frontend/src/services/app_service.dart' as _i3;
import 'package:shotwot_frontend/src/services/firebase_service.dart' as _i5;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i3.AppService>(() => appModule.appService);
  gh.factory<_i4.FirebaseAuth>(() => appModule.auth);
  await gh.factoryAsync<_i5.FirebaseService>(
    () => appModule.firebaseService,
    preResolve: true,
  );
  gh.factory<_i6.GoogleSignIn>(() => appModule.gauth);
  gh.factory<_i7.IAuthFacade>(() => _i8.AuthFacade(
        gh<_i4.FirebaseAuth>(),
        gh<_i6.GoogleSignIn>(),
        gh<_i3.AppService>(),
      ));
  gh.factory<_i9.AuthBloc>(() => _i9.AuthBloc(gh<_i7.IAuthFacade>()));
  return getIt;
}

class _$AppModule extends _i10.AppModule {}
