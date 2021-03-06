import 'package:dartclassgenerator/editor_settings/editor_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

// todo: add code zoom setting
class EditorSettingsDialog extends StatefulWidget {
  EditorSettingsDialog({Key key}) : super(key: key);

  @override
  _EditorSettingsDialogState createState() => _EditorSettingsDialogState();
}

class _EditorSettingsDialogState extends State<EditorSettingsDialog> {
  TextEditingController _fontSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _settingsBloc = Provider.of<EditorSettingsBloc>(context);
    return StreamBuilder(
      stream: CombineLatestStream.combine3(
        _settingsBloc.lineNumbersStream,
        _settingsBloc.codeFontSizeStream,
        _settingsBloc.codeEditingStream,
        (bool lineNumsOn, double fontSize, bool codeEditingOn) => [
          lineNumsOn,
          fontSize,
          codeEditingOn,
        ],
      ),
      initialData: [
        _settingsBloc.lineNumbersStream.value,
        _settingsBloc.codeFontSizeStream.value,
        _settingsBloc.codeEditingStream.value,
      ],
      builder: (context, snapshot) {
        bool _lineNumsOn = snapshot.data[0];
        double _fontSize = snapshot.data[1];
        bool _codeEditingOn = snapshot.data[2];
        return SimpleDialog(
          title: Text('Editor Settings'),
          titlePadding: EdgeInsets.fromLTRB(16, 24, 16, 0),
          children: [
            SwitchListTile(
              value: _lineNumsOn,
              title: Text('Show line numbers'),
              onChanged: (linesOn) {
                _settingsBloc.lineNumbersOn.add(linesOn);
              },
              activeColor: Theme.of(context).accentColor,
            ),
            SwitchListTile(
              value: _codeEditingOn,
              title: Text('Allow direct code editing'),
              onChanged: (codeEditingOn) {
                _settingsBloc.codeEditingOn.add(codeEditingOn);
              },
              activeColor: Theme.of(context).accentColor,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: TextFormField(
                controller: _fontSizeController,
                //keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Default: $_fontSize (numbers only!)',
                ),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  child: Text('Done'),
                  onPressed: () {
                    if (_fontSizeController.text.isNotEmpty) {
                      double _fs = double.parse(_fontSizeController.text);
                      if (_fs >= 10 && _fs <= 40) {
                        _settingsBloc.fontSize.add(_fs);
                      }
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
