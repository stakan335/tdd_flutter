import 'dart:io';

String _fixture(String name) => File('test/fixtures/$name').readAsStringSync();

String fixtureJson(String name) => _fixture('$name.json');
