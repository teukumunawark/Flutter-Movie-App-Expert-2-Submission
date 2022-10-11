import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  if (dir.endsWith('module_movies')) {
    return File('$dir/test/$name').readAsStringSync();
  }
  return File('$dir/module_movies/test/$name').readAsStringSync();
}
