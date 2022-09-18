// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'calculo.dart';
import 'localStorage.dart';
import 'utils.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MyApp> {
  // Variáveis de controle de entrada de dados (formulário flutter).
  TextEditingController infController   = TextEditingController();
  TextEditingController supController   = TextEditingController();
  TextEditingController nController     = TextEditingController();
  TextEditingController expressionInput = TextEditingController();

  // Variáveis de controle de recuperação de dados e manipulação para calculos.
  String limInferior = " ";
  String limSuperior = " ";
  double nNumber     = 0.0;
  String expression  = " ";
  String input       = " ";
  double deltax      = 0.0;
  num xi             = 0.0;
  String riemann     = " ";
  bool  localStorage = false;

  // Remove qualquer dado que possa estar armazenado localmente no navegador.
  @override
  void initState() {
    super.initState();
    SaveUserExpression().removeSavedData();
  }

  // Atualiza o state do widget a direita. Quando apertar o botão e terminar os calculos, atualizará com os resultados.
  void createExpressionWidget() {
    setState(() {
      localStorage = true;
    });
  }

  // Função para impressão dos resultados na tela.
  // @param - limInferior, limSuperior, nNumber - Valores de limite inferior, superior e n da soma de Riemman.
  // @param - deltax - valor para calculos na soma de riemman.
  // @param - xi - valor para calculos na soma de riemman.
  // @param - resultado - string que irá conter o resultado final dos calculos.
  Widget createResultContainer(String limInferior, String limSuperior, String input, double nNumber, double deltax, num xi, String resultado) {
    // Manipulando os dados para notação latex.
    String supLatex = createLatexExpression(limSuperior.toString());
    String infLatex = createLatexExpression(limInferior.toString());

    // DeltaN - Intervalo de DeltaX dividido por "n" <apenas para mostrar o calculo realizado>.
    String deltaN   = r'\''dfrac{$supLatex-$infLatex}{n}';

    // xI - valor de xi para n <apenas para mostrar o calculo realizado>.
    String xiN      = '$infLatex + $deltaN * i';

    // string para manipulação latex.
    String result   = " ";
    String tmp = result;

    // Manipulação de notações latex para impressão na tela.
    if(input.contains('^2')) {
      result = input.replaceAll(r'x^2', '(x)^2');
      result = result.replaceAll(r'x', '$xiN');      
    }
    if(input.contains('teta')) {
      result = input.replaceAll(r'teta', '$xiN');
    }
    if(input.contains('^x')) {
      result = input.replaceAll(r'x', '{$xiN}');
    }
    // Faltando o f(x) para x normal.

    // Coluna titulo - Resultados.
    return Column(
      children: [
        const SizedBox(height: 8,),
        const Align(
          alignment: Alignment.center,
          child: Text("Resultados:", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,),
              textAlign: TextAlign.center,
            ),
        ),

        const SizedBox(height: 8,),
        
        // Container que mostra a integral interpretada pela entrada do usuario pela função Math.tex().
        Container(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                const Text("Integral interpretada de sua entrada: ",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Math.tex(r'\int_' '{$infLatex}^{$supLatex} $input ' r'\ \ dx',
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Container que mostra a formula de soma de Riemman pela função Math.tex().
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
            const Text("Soma de Riemman: ", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            Math.tex(r'\underset{n \to \infty}{lim} \sum_{i=1}^{n} \Delta x * f(x_i)', 
              textStyle: const TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),

        // Container que mostra o calculo de DeltaX da função inserida pelo usuário.
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Math.tex(r'\Delta x = ' r'\dfrac{b-a}{n}, \ portanto:' r'\Delta x =''$deltaN', 
              textStyle: const TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),

        // Container que mostra o calculo de xi da função inserida pelo usuário.
        Container(
        padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Math.tex('x_i = a + ' r'\Delta x * i, \ portanto: ''x_i=$xiN', 
              textStyle: const TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),

        // Container que mostra f(xi) da função inserida pelo usuário.
        Container(
        padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Math.tex('f(x_i) = ''$result', 
              textStyle: const TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),

        // Container que mostra como a integral inserida pelo usuário fica na notação de Riemman.
        Container(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                const Text("Somatório: ", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Math.tex(r'\underset{n \to \infty}{lim} \sum''_{i=1}^{$nNumber}''$deltaN * f($xiN)',
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Container que mostrará o resultado obtido pelos calculos da soma de Riemman.
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
            Text("Resultado calculado: $resultado", style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 8,),
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Entrada de dados:",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Limite Inferior: ",
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        hintText: "... -1, 0, 1 ...",
                      ),
                      textInputAction: TextInputAction.next,
                      controller: infController,
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Limite Superior: ",
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        hintText: "... -1, 0, 1 ...",
                      ),
                      textInputAction: TextInputAction.next,
                      controller: supController,
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "N: ",
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        hintText: "... tender ao infinito ...",
                      ),
                      textInputAction: TextInputAction.next,
                      controller: nController,
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Expressão (fx): ",
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        hintText: "... x² + 1...",
                      ),
                      textInputAction: TextInputAction.next,
                      controller: expressionInput,
                    ),
                    const SizedBox(height: 30,),
                    ElevatedButton(
                      // Botão que ao ser pressionado fará diversas ações:
                      // 1ª Salvar no Local Storage do navegador todos os dados inseridos pelo usuário.
                      // 2ª Limpar o formulário de inserção de dados.
                      // 3ª Pegar do Local Storage os valores do limite inferior, limite superior e lançalos na função .interpret().
                      // 3.1ª A função .interpret() fará uma expressão em string devolver um valor inteiro. 
                      //      - Exemplo: 
                      //                String str = '2+2' 
                      //                int strToInt = str.interpret() // 4
                      // 3.2ª Pegar do Local Storage os valores de N e expressão (fx).
                      // 4ª Calcula o deltaX - apenas para uso em outras funções (seu calculo já está embutido no calculoRiemman).
                      // 4.1ª Calcula o xi     - apenas para uso em outras funções (seu calculo já está embutido no calculoRiemman).
                      // 5ª Calcula e guarda o resultado em uma string (riemman) a soma de riemman dos daods inseridos pelo usuário.
                      // 6ª Atualiza o state do widget para exibir os resultados.
                      // 7ª Cria uma expressão no padrão latex da entrada do usuário.
                      // Exemplo: entrada do usuário = sqrt(pi*x^2) / ln2.
                      //          saída em formato Latex = \dfrac{\sqrt{\pi*x^2}}{ln2}.
                      onPressed: () async {
                        SaveUserExpression().saveInputData(infController, supController, nController, expressionInput);
                        infController.clear(); supController.clear(); nController.clear(); expressionInput.clear();
                        limInferior  = await SaveUserExpression().getLimInferior();
                        num inf      = limInferior.interpret();
                        limSuperior  = await SaveUserExpression().getLimSuperior();
                        num sup      = limSuperior.interpret();
                        nNumber      = await SaveUserExpression().getN();
                        expression   = await SaveUserExpression().getExpression();
                        deltax       = deltaX(inf, sup, nNumber);
                        xi           = xI(inf, deltax, 1);
                        riemann = calculoRiemman(expression, inf, sup, nNumber);
                        createExpressionWidget();
                        input = createLatexExpression(expression);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[100],
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Text(
                        "Calcular",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        // Se o localStorage for true significa que todos os calculos já foram feitos.
                        if (localStorage == true)
                        // Chamada da função para imprimir os resultados na tela, os parametros são justamente o significado de cada variável, sendo riemman o valor do resultado.
                          createResultContainer(limInferior, limSuperior, input,
                              nNumber, deltax, xi, riemann)
                      ],
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}