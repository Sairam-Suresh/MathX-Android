List<String> calculateUnion(List<List<String>> setList) {
  final resultSet = <String>{};
  for (final set in setList) {
    resultSet.addAll(set);
  }
  return resultSet.toList();
}

List<String> calculateIntersection(List<List<String>> setList) {
  if (setList.isEmpty) {
    return [];
  }
  final resultSet = setList.first.toSet();
  for (final set in setList.skip(1)) {
    resultSet.retainAll(set);
  }
  return resultSet.toList();
}
