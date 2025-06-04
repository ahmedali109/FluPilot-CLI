#!/bin/bash

DEST_DIR="$FLUTTER_PROJECT_DIR/lib/features/auth/ui/widgets"
NAME_FIELD_FILE="$DEST_DIR/name_field.dart"
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

echo "📄 Created name_field.dart file successfully at $NAME_FIELD_FILE"
echo "✅ Name Field template generated successfully."
