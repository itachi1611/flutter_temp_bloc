import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/app/app_cubit.dart';
import 'package:flutter_temp/generated/l10n.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    Key? key,
    required this.appCubit,
  }) : super(key: key);

  final AppCubit appCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            Switch(
              inactiveThumbColor: Colors.green,
              inactiveTrackColor: Colors.pink[200],
              activeColor: Colors.blue,
              activeTrackColor: Colors.pink[200],
              value: state.themeMode == ThemeMode.light ? true : false,
              onChanged: (val) {
                appCubit.onChangeSwitch(val);
              },
            ),
            DropdownButton(
              items: state.lists!
                  .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                appCubit.setLocale(val);
              },
            ),
            Text(S.current.title),
          ],
        );
      },
    );
  }
}
