import 'dart:math';

main() {
  List<int> lst1 = [for (int i = 0; i < 50; i++) Random().nextInt(1000)];
  List<int> lst2 = [for (int i = 0; i < 50; i++) Random().nextInt(1000)];

  print(lst1);
  print("\n");
  print(lst2);

  List<int> lstIntersec = [
    for (var i in lst1)
      if (lst2.contains(i)) i
  ];

  print("\n");
  print(lstIntersec);
}
//...lst1, ...lst2