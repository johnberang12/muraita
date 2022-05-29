import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';


class CountryCodePage extends StatelessWidget {
  const CountryCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country'),
        centerTitle: true,

      ),
      body: Center(
        child: CountryCodePicker(
          initialSelection: 'Ph',
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          favorite: const ['+63', 'PH'],
          enabled: true,
          hideMainText: false,
          showFlag: false,
          hideSearch: false,
          showFlagDialog: false,

        ),
      ),
    );
  }
}
