import 'dart:io';

String fictive(String name) => File('test/fictive/$name').readAsStringSync();
