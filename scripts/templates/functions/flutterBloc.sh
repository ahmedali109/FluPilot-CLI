#!/bin/bash

source ./scripts/pickers/pick_directory.sh

function flutterBloc(){
  DEST_DIR="${FLUTTER_PROJECT_DIR}"
  NAME_CUBIT=$(gum input --placeholder "Enter cubit name ")
  # make first lettter of NAME_CUBIT uppercase
  NAME_CUBIT_CLASS=$(echo "$NAME_CUBIT" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

  if [ -z "$NAME_CUBIT" ]; then
    echo "❌ Cubit name cannot be empty. Please provide a valid name."
    exit 1
  fi

  if [ -z "$DEST_DIR" ]; then
    echo "❌ FLUTTER_PROJECT_DIR is not set. Please set it to your Flutter project directory."
    exit 1
  fi

  echo "🔍 Choose a directory to add cubit files in your project."
  PICKED_DIR=$(pick_dir "$DEST_DIR/lib")

  if [ -z "$PICKED_DIR" ]; then
    echo "❌ No directory selected. Please select a valid Flutter project directory."
    exit 1
  fi

  echo "🛠️ Adding Flutter Bloc files in $PICKED_DIR"

  mkdir -p "$PICKED_DIR/cubit/$NAME_CUBIT"

  if [ ! -d "$PICKED_DIR/cubit/$NAME_CUBIT" ]; then
    echo "❌ Failed to create directory $PICKED_DIR/cubit/$NAME_CUBIT"
    exit 1
  fi

  echo "📂 Created directory $PICKED_DIR/cubit/$NAME_CUBIT"
  cat <<EOF > "$PICKED_DIR/cubit/$NAME_CUBIT/${NAME_CUBIT}_state.dart"
part of '${NAME_CUBIT}_cubit.dart';

@immutable
sealed class ${NAME_CUBIT_CLASS}State {}

final class ${NAME_CUBIT_CLASS}Initial extends ${NAME_CUBIT_CLASS}State {}

final class ${NAME_CUBIT_CLASS}Loading extends ${NAME_CUBIT_CLASS}State {}

final class ${NAME_CUBIT_CLASS}Success extends ${NAME_CUBIT_CLASS}State {}

final class ${NAME_CUBIT_CLASS}Error extends ${NAME_CUBIT_CLASS}State {
  final String message;
  ${NAME_CUBIT_CLASS}Error(this.message);
}
EOF

  cat <<EOF > "$PICKED_DIR/cubit/$NAME_CUBIT/${NAME_CUBIT}_cubit.dart"
import 'package:flutter_bloc/flutter_bloc.dart';

part '${NAME_CUBIT}_state.dart';

class ${NAME_CUBIT_CLASS} extends Cubit<${NAME_CUBIT_CLASS}State> {
  ${NAME_CUBIT_CLASS}() : super(${NAME_CUBIT_CLASS}Initial());
}
EOF

  echo "✅ Flutter Bloc files added successfully in $PICKED_DIR/$NAME_CUBIT"
  echo "You can now implement your business logic in ${NAME_CUBIT}_cubit.dart and manage the state in ${NAME_CUBIT}_state.dart."
  echo "Remember to import the necessary packages in your Dart files."
  echo "For more information, visit the official Flutter Bloc documentation: https://bloclibrary.dev/getting-started/"
  echo
  echo "You can now use the $NAME_CUBIT in your Flutter project."

   # ...existing code...

  # Ask user what to do next

  NEXT_ACTION=$(gum choose "Create another cubit" "Continue Script Setup")
  if [[ "$NEXT_ACTION" == "Create another cubit" ]]; then
    flutterBloc
  fi

  # Navigate back to the original directory
  echo "🔙 Returning to the original directory..."
  echo
  cd - >/dev/null || exit 1
  cd - >/dev/null || exit 1
}
