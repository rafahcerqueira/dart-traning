import 'dart:io';

//Rafael Cerqueira Gomes BT3032591

class Aluno {
  String ra;
  String nome;
  int anoEntrada;
  double ira;
  Curso curso;

  Aluno(this.ra, this.nome, this.anoEntrada, this.ira, this.curso);

  Map<String, dynamic> toJson() {
    return {
      'ra': ra,
      'nome': nome,
      'anoEntrada': anoEntrada,
      'ira': ira,
      'curso': curso.toJson(),
    };
  }
}

class Curso {
  String nome;
  String campus;

  Curso({
    required this.nome,
    required this.campus,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'campus': campus,
    };
  }
}
  
  List<Aluno> alunos = []; 

  void inserirAluno(Aluno aluno) {
    alunos.add(aluno);
  }

  bool alunoExiste(String ra) {
    return alunos.any((aluno) => aluno.ra == ra);
  }

  Aluno? buscarAluno(String ra) {
    return alunos.firstWhere(
      (aluno) => aluno.ra == ra,
    );
  }

  Aluno? buscarAlunoNome(String nome) {
    return alunos.firstWhere(
      (aluno) => aluno.nome == nome,
    );
  }

  void exibirAlunos() {
    alunos.forEach((aluno) {
      print('RA: ${aluno.ra}');
      print('Nome: ${aluno.nome}');
      print('Ano de Entrada: ${aluno.anoEntrada}');
      print('IRA: ${aluno.ira}');
      print('Curso: ${aluno.curso.nome}');
      print('Campus: ${aluno.curso.campus}');
      print('');
    });
  }

  void exibirAlunosIRA() {
    alunos.forEach((aluno) {
      if (aluno.ira >= 6) {
        print('RA: ${aluno.ra}');
        print('Nome: ${aluno.nome}');
        print('Ano de Entrada: ${aluno.anoEntrada}');
        print('IRA: ${aluno.ira}');
        print('Curso: ${aluno.curso.nome}');
        print('Campus: ${aluno.curso.campus}');
        print('');
      }
    });
  }

  void excluirAluno(String ra) {
    alunos.removeWhere((aluno) => aluno.ra == ra);
  }

  List<Map<String, dynamic>> exportarLista() {
    return alunos.map((aluno) => aluno.toJson()).toList();
  }

bool validaRa(String ra) {
  if (ra.length < 5 || ra.isEmpty || ra.contains(' ')) {
    return false;
  }
  return true;
}

bool validaNome(String nome) {
  if (nome.isEmpty || nome.length < 3 || nome.contains(RegExp(r'[0-9]')) || nome.contains(' ')) {
    return false;
  }
  return true;
}

bool validaAnoEntrada(String anoEntrada) {
  if (anoEntrada.isEmpty || int.tryParse(anoEntrada) == null || int.parse(anoEntrada) < 0 || anoEntrada.length != 4) {
    return false;
  }
  return true;
}

bool validaIRA(double ira) {
  if (ira.isNaN || ira < 0 || ira > 10) {
    return false;
  }
  return true;
}

void main() {
  var option;
  var raAux;

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

        if (alunoExiste(ra)) {
          print('RA já cadastrado!\n');
          break;
        }

        stdout.write('- Informe o nome: ');
        var nome = stdin.readLineSync()!;
        if (!validaNome(nome)) {
          print('Nome inválido! Insira somente letras.\n');
          break;
        }

        stdout.write('- Informe o ano de entrada: ');
        var anoEntrada = stdin.readLineSync()!;
        if (!validaAnoEntrada(anoEntrada)) {
          print('Ano de Entrada inválido!\n');
          break;
        }
        
        stdout.write('- Informe o seu IRA: ');
        var ira = double.parse(stdin.readLineSync()!);
        if (!validaIRA(ira)) {
          print('IRA inválido! Insira somente números.\n');
          break;
        }
        
        stdout.write('- Informe o nome do curso: ');
        var nomeCurso = stdin.readLineSync()!;

        stdout.write('- Informe o nome do campus: ');
        var nomeCampus = stdin.readLineSync()!;

        var curso = Curso(nome: nomeCurso, campus: nomeCampus);
        var aluno = Aluno(ra, nome, int.parse(anoEntrada), ira, curso);
        inserirAluno(aluno);
        break;

      case 2:
        stdout.write('\nInforme o nome para buscar: ');
        var nome = stdin.readLineSync()!;
        if (!validaNome(nome)) {
          print('Nome não encontrado!\n');
          break;
        }

        var alunoEncontrado = buscarAlunoNome(nome);
        if (alunoEncontrado != null) {
          print('\nAluno encontrado:');
          print('RA: ${alunoEncontrado.ra}');
          print('Nome: ${alunoEncontrado.nome}');
          print('Ano de Entrada: ${alunoEncontrado.anoEntrada}');
          print('IRA: ${alunoEncontrado.ira}');
          print('Curso: ${alunoEncontrado.curso.nome}');
          print('Campus: ${alunoEncontrado.curso.campus}');
          
        } else {
          print('\nERRO! Aluno não encontrado.');
        }
        break;

      case 3:
        stdout.write('\nInforme o valor do RA para buscar: ');
        raAux = stdin.readLineSync()!;
        if (!validaRa(raAux)) {
          print('RA inválido! Insira somente letras e números.\n');
          break;
        }

        var alunoEncontrado = buscarAluno(raAux);
        if (alunoEncontrado != null) {
          print('\nAluno encontrado:');
          print('RA: ${alunoEncontrado.ra}');
          print('Nome: ${alunoEncontrado.nome}');
          print('Ano de Entrada: ${alunoEncontrado.anoEntrada}');
          print('IRA: ${alunoEncontrado.ira}');
          
        } else {
          print('\nERRO! Aluno não encontrado.');
        }
        break;

      case 4:
        stdout.write('\nInforme o valor do RA para excluir: ');
        raAux = stdin.readLineSync()!;
        if (!validaRa(raAux)) {
          print('RA inválido ou não encontrado! Tente usar letras e números.\n');
          break;
        }

        excluirAluno(raAux);
        print('\nAluno excluído!');
        break;

      case 5:
        print('\nExibindo lista de alunos: \n');
        exibirAlunos();
        break;

      case 6:
        print('\nExibindo lista de alunos com IRA >= 6: \n');
        exibirAlunosIRA();
        break;

      case 7:
        print('\nApagar todos: \n');
        alunos.clear();
        break;

      case 8:
        print('\nExportando lista de alunos: \n');
        print(exportarLista());
        break;

      case 0:
        print('\nPrograma Finalizado \n');
        break;

      default:
        print('\nOpção inválida :(\n');
        break;
    }
  } while (option != 0);
}

int menu() {
  print('\n\n\t*** MENU ***\n');
  print('1 - Inserir aluno');
  print('2 - Buscar aluno por Nome');
  print('3 - Buscar aluno por RA');
  print('4 - Excluir aluno por RA');
  print('5 - Exibir lista de alunos');
  print('6 - Exibir lista de alunos com IRA >= 6');
  print('7 - Excluir todos os alunos');
  print('8 - Exportar lista de alunos');
  print('0 - Sair.\n');
  stdout.write('Informe sua escolha: ');
  
  return int.parse(stdin.readLineSync()!);
}
