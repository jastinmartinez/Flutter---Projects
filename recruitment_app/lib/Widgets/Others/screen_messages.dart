import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ScreenMessages {
  final BuildContext context;
  final String message;
  ScreenMessages(
    this.context,
    this.message,
  );
  ProgressDialog get progressLoadingProcess {
    return _progressDialog();
  }

  ProgressDialog _progressDialog() {
    ProgressDialog _progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );

    _progressDialog.style(
      message: message,
      borderRadius: 50.0,
      elevation: 5.0,
      progressWidget: SvgPicture.asset('assets/icons/owl.svg'),
    );
    return _progressDialog;
  }
}
