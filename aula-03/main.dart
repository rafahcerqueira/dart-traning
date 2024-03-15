import 'dart:io';

const MAX = 4;

class Aluno {
  String ra;
  String nome;
  int idade;
  List<double> notas;

  Aluno(this.ra, this.nome, this.idade, this.notas);

  Map<String, dynamic> toJson() {
    return {
      'ra': ra,
      'nome': nome,
      'idade': idade,
      'notas': notas,
    };
  }
}

class Curso {
  List<Aluno> alunos;

  Curso() : alunos = [];

  void inserirAluno(Aluno aluno) {
    alunos.add(aluno);
  }

  Aluno? buscarAluno(String ra) {
    return alunos.firstWhere(
      (aluno) => aluno.ra == ra,
      orElse: () => null,
    );
  }

  void exibirAlunos() {
    alunos.forEach((aluno) {
      print('RA: ${aluno.ra}');
      print('Nome: ${aluno.nome}');
      print('Idade: ${aluno.idade}');
      for (int i = 0; i < MAX; i++) {
        print('Nota ${i + 1}: ${aluno.notas[i]}');
      }
      print('');
    });
  }

  void excluirAluno(int ra) {
    alunos.removeWhere((aluno) => aluno.ra == ra);
  }

  void exportarLista() {
    List<Map<String, dynamic>> listaExportada = [];
    alunos.forEach((aluno) {
      listaExportada.add(aluno.toJson());
    });
    print(listaExportada);
  }
}

int menu() {
  print('\n\n\t*** MENU ***\n');
  print('1 - Inserir aluno;');
  print('2 - Buscar aluno por RA;');
  print('3 - Exibir lista de alunos;');
  print('4 - Excluir aluno da lista (RA);');
  print('5 - Exportar lista de alunos;');
  print('0 - Sair.\n');
  stdout.write('---> Informe sua escolha: ');
  return int.parse(stdin.readLineSync()!);
}

bool validaRa(String input) {
  // Verifica se não há caracteres especiais no input, permitindo números inteiros
  var specialCharRegExp = RegExp(r'^[bB][tT]\d+$');
  return specialCharRegExp.hasMatch(input);
}

bool validaNome(String input) {
  // Verifica se o nome contém apenas letras
  final nomeRegExp = RegExp(r'^[a-zA-Z]+$');
  return nomeRegExp.hasMatch(input);
}

bool validaIdade(String input) {
  // Verifica se a idade é um número inteiro positivo
  final idadeRegExp = RegExp(r'^\d+$');
  return idadeRegExp.hasMatch(input);
}

bool validaNota(String input) {
  // Verifica se a nota é um número inteiro positivo
  final notaRegExp = RegExp(r'^\d+$');
  return notaRegExp.hasMatch(input);
}

void main() {
  var option;
  var raAux;
  var curso = Curso();

  do {
    option = menu();

    switch (option) {
      case 1:
        print('\n--- Dados do Aluno ---\n');
        stdout.write('- Informe o RA: ');
        var ra = stdin.readLineSync()!;
        if (!validaRa(ra)) {
          print('RA inválido! Insira somente letras e números.\n');
          break;
        }

        stdout.write('- Informe o nome: ');
        var nome = stdin.readLineSync()!;
        if (!validaNome(nome)) {
          print('Nome inválido! Insira somente letras.\n');
          break;
        }

        stdout.write('- Informe a idade: ');
        var idade = stdin.readLineSync()!;
        if (!validaIdade(idade)) {
          print('Idade inválida! Insira somente números inteiros.\n');
          break;
        }

        var notas = <double>[];
        for (var i = 0; i < MAX; i++) {
          stdout.write('- Informe a nota ${i + 1}: ');
          var nota = stdin.readLineSync()!;
          if (!validaNota(nota)) {
            print('Nota inválida! Insira somente números inteiros.\n');
            break;
          }
          notas.add(double.parse(nota));
        }

        var aluno = Aluno(ra, nome, int.parse(idade), notas);
        curso.inserirAluno(aluno);
        break;
      case 2:
        stdout.write('\nInforme o valor do RA para buscar: ');
        raAux = stdin.readLineSync()!;
        if (!validaRa(raAux)) {
          print('RA inválido! Insira somente letras e números.\n');
          break;
        }
        var alunoEncontrado = curso.buscarAluno(raAux);
        if (alunoEncontrado != null) {
          print('\nAluno encontrado:');
          print('RA: ${alunoEncontrado.ra}');
          print('Nome: ${alunoEncontrado.nome}');
          print('Idade: ${alunoEncontrado.idade}');
          for (var i = 0; i < MAX; i++) {
            print('Nota ${i + 1}: ${alunoEncontrado.notas[i]}');
          }
        } else {
          print('\nERRO! Aluno não encontrado :(');
        }
        break;
      case 3:
        print('\nExibindo lista de alunos: \n');
        curso.exibirAlunos();
        break;
      case 4:
        stdout.write('\nInforme o valor do RA para excluir: ');
        raAux = stdin.readLineSync()!;
        if (!validaRa(raAux)) {
          print('RA inválido! Insira somente letras e números.\n');
          break;
        }
        curso.excluirAluno(int.parse(raAux));
        print('\nAluno excluído!');
        break;
      case 5:
        print('\nExportando lista de alunos: \n');
        curso.exportarLista();
        break;
      case 0:
        print('\nFinalizando, até mais :)\n');
        break;
      default:
        print('\nOpção inválida :(\n');
        break;
    }
  } while (option != 0);
}
