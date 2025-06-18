#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
NAME_FIELD_FILE="$DEST_DIR/name_field.dart"
PUBSPEC_FILE="$FLUTTER_PROJECT_DIR/pubspec.yaml"

function nameFieldLocalization(){
  cat <<EOL > "$NAME_FIELD_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../logic/auth/auth_cubit.dart';
import 'my_textfield.dart';

class NameField extends StatelessWidget {
  const NameField({super.key});
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: context.read<AuthCubit>().nameController,
      hintText: "name".tr(),
      obscureText: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please_enter_your_name".tr();
        }
        return null;
      },
    );
  }
}
EOL
}

function nameFieldWithoutLocalization(){
  cat <<EOL > "$NAME_FIELD_FILE"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_cubit.dart';
import 'my_textfield.dart';

class NameField extends StatelessWidget {
  const NameField({super.key});
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: context.read<AuthCubit>().nameController,
      hintText: "Name",
      obscureText: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your name";
        }
        return null;
      },
    );
  }
}
EOL
}

if grep -q "easy_localization:" "$PUBSPEC_FILE"; then
  echo "✅ easy_localization is present in pubspec.yaml"
  echo "Generating name field with localization support."
  nameFieldLocalization
else
  echo "❌ easy_localization is NOT present in pubspec.yaml"
  echo "Generating name field without localization support."
  nameFieldWithoutLocalization
fi

echo "📄 Created name_field.dart file successfully at $NAME_FIELD_FILE"
echo "✅ Name Field template generated successfully."
