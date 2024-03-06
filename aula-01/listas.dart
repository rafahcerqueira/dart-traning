import 'dart:math';

main() {
  List<int> lst1 = List.generate(50, (index) => Random().nextInt(1000));
  List<int> lst2 = List.generate(50, (index) => Random().nextInt(1000));

  print(lst1);
  print("\n");
  print(lst2);

  var lstIntersec = lst1.where((x) => lst2.contains(x));

  print("\n");
  print(lstIntersec);
}
