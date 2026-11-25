import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ChefDaCarneRomaApp());
}

class ChefDaCarneRomaApp extends StatelessWidget {
  const ChefDaCarneRomaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chef da Carne Roma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF4F5F7),
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.black87,
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// TELA DE LOGIN / IDENTIFICAÇÃO
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  void _entrar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeChurrascoScreen(
            clienteNome: _nomeController.text.trim(),
            clienteTelefone: _telefoneController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(color: Colors.black12, width: 1),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.local_fire_department, size: 38, color: Colors.white),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'CHEF DA CARNE ROMA',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2.5),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Boutique de Carnes & Cortes Especiais',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600], letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 36),
                      TextFormField(
                        controller: _nomeController,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        decoration: InputDecoration(
                          labelText: 'Seu Nome Completo',
                          prefixIcon: const Icon(Icons.person_outline, color: Colors.black, size: 20),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Informe seu nome.' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _telefoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        decoration: InputDecoration(
                          labelText: 'Seu WhatsApp / Telefone',
                          prefixIcon: const Icon(Icons.phone_outlined, color: Colors.black, size: 20),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Informe seu telefone.' : null,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _entrar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: const Text(
                          'ACESSAR EXPERIÊNCIA',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TELA PRINCIPAL DA CALCULADORA
// ==========================================
class HomeChurrascoScreen extends StatefulWidget {
  final String clienteNome;
  final String clienteTelefone;

  const HomeChurrascoScreen({
    super.key,
    required this.clienteNome,
    required this.clienteTelefone,
  });

  @override
  State<HomeChurrascoScreen> createState() => _HomeChurrascoScreenState();
}

class _HomeChurrascoScreenState extends State<HomeChurrascoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int homens = 2;
  int mulheres = 2;
  int criancas = 0;
  bool isChurrascoLongo = false;

  final Map<String, Map<String, dynamic>> itensCatalogo = {
    // Bovinos
    'picanha': {'nome': 'Picanha', 'isCarne': true, 'comOsso': false, 'selecionado': true, 'quantidade': 0.5, 'dica': 'Ideal para grelha ou espeto. Assar em bifes grossos com gordura para cima.'},
    'contrafile': {'nome': 'Contrafilé', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Corte macio e saboroso com excelente capa de gordura lateral.'},
    'alcatra': {'nome': 'Alcatra', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Corte magro e macio, com fibras uniformes.'},
    'fraldinha': {'nome': 'Fraldinha', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Suculenta e com sabor acentuado. Assar inteira na brasa forte.'},
    'maminha': {'nome': 'Maminha', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Suave e suculenta, ideal para assar inteira no espeto ou grelha.'},
    'costela': {'nome': 'Costela Bovina', 'isCarne': true, 'comOsso': true, 'selecionado': false, 'quantidade': 1.0, 'dica': 'Exige fogo baixo e paciência (4 a 6 horas) para desmanchar.'},
    
    // Suínos
    'lombo': {'nome': 'Lombo Suíno', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Corte magro e sofisticado. Excelente em medalhões.'},
    'costelinhasuina': {'nome': 'Costelinha Suína (Barbecue)', 'isCarne': true, 'comOsso': true, 'selecionado': false, 'quantidade': 1.0, 'dica': 'Perfeita para assar lentamente e finalizar com molho barbecue.'},
    'pernil': {'nome': 'Pernil Fatiado', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Saboroso e versátil, excelente grelhado em bifes ou tiras.'},
    'linguica': {'nome': 'Linguiça Toscana', 'isCarne': true, 'comOsso': false, 'selecionado': true, 'quantidade': 1.0, 'dica': 'Asse em fogo médio, sem furar, para manter a suculência.'},

    // Aves
    'coracao': {'nome': 'Coração de Frango', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'À brasa forte por poucos minutos para não ressecar.'},
    'asinha': {'nome': 'Coxinha da Asa', 'isCarne': true, 'comOsso': true, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Marinada com ervas e assada até a pele ficar crocante.'},

    // Peixes
    'salmao': {'nome': 'Posta de Salmão', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Grelhe rapidamente com azeite, limão siciliano e ervas.'},
    'tilapia': {'nome': 'Filé de Tilápia (Alumínio)', 'isCarne': true, 'comOsso': false, 'selecionado': false, 'quantidade': 0.5, 'dica': 'Preparar na grelha embrulhado em alumínio com manteiga e alho.'},

    // Acompanhamentos & Bebidas
    'paoalho': {'nome': 'Pão de Alho', 'isCarne': false, 'comOsso': false, 'selecionado': true, 'quantidade': 1.0},
    'queijo': {'nome': 'Queijo Coalho', 'isCarne': false, 'comOsso': false, 'selecionado': false, 'quantidade': 1.0},
    'carvao': {'nome': 'Carvão (kg)', 'isCarne': false, 'comOsso': false, 'selecionado': true, 'quantidade': 5.0},
    'refrigerante': {'nome': 'Refrigerante (2L)', 'isCarne': false, 'comOsso': false, 'selecionado': true, 'quantidade': 2.0},
    'agua': {'nome': 'Água Mineral', 'isCarne': false, 'comOsso': false, 'selecionado': true, 'quantidade': 2.0},
  };

  String tipoLogistica = 'Retirar na Loja';
  final TextEditingController _dataHorarioController = TextEditingController();
  String? pedidoSalvoResumo;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _dataHorarioController.dispose();
    super.dispose();
  }

  int get totalPessoas => homens + mulheres + criancas;

  double get totalCarneIdealKg {
    double base = ((homens * 500) + (mulheres * 400) + (criancas * 200)) / 1000;
    if (isChurrascoLongo) base *= 1.25;
    return base;
  }

  double get totalCarneEscolhidaKg {
    double soma = 0;
    itensCatalogo.forEach((key, item) {
      if (item['isCarne'] == true && item['selecionado'] == true) {
        soma += (item['quantidade'] as double);
      }
    });
    return soma;
  }

  void _deslogar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Encerrar Sessão', style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text('Deseja realmente sair e retornar à tela de identificação?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 0),
            child: const Text('Sim, Sair'),
          ),
        ],
      ),
    );
  }

  List<String> _obterListaItensFormatada() {
    final List<String> itens = [];
    
    itensCatalogo.forEach((key, item) {
      if (item['selecionado']) {
        String qtdStr = '';
        double qtd = item['quantidade'];
        if (item['isCarne']) {
          qtdStr = '${qtd.toStringAsFixed(1)} kg';
        } else if (key == 'paoalho') {
          qtdStr = '${qtd.toInt()} pacote(s)';
        } else if (key == 'queijo') {
          qtdStr = '${qtd.toInt()} espeto(s)';
        } else if (key == 'carvao') {
          qtdStr = '${qtd.toInt()} kg';
        } else if (key == 'refrigerante') {
          qtdStr = '${qtd.toInt()} garrafa(s)';
        } else if (key == 'agua') {
          qtdStr = '${qtd.toInt()} garrafa(s)';
        }
        itens.add('• ${item['nome']}: *$qtdStr*');
      }
    });

    return itens;
  }

  void _mostrarDicaPreparo(BuildContext context, String nomeCarne, String dica) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.restaurant_menu, size: 22, color: Colors.black),
            const SizedBox(width: 10),
            Expanded(child: Text(nomeCarne, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900))),
          ],
        ),
        content: Text(dica, style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 0),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _salvarPedidoLocalmente() {
    if (totalPessoas == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicione pelo menos 1 pessoa para salvar o pedido.'), backgroundColor: Colors.black),
      );
      return;
    }

    setState(() {
      pedidoSalvoResumo = '''
Cliente: ${widget.clienteNome}
Convidados: $totalPessoas pessoa(s) | Selecionado: ~${totalCarneEscolhidaKg.toStringAsFixed(1)} kg de carne
Logística: $tipoLogistica
Data/Horário: ${_dataHorarioController.text.isEmpty ? 'Não informado' : _dataHorarioController.text}
''';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('💾 Rascunho salvo com sucesso na memória.'),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _mostrarComandaPreview(BuildContext context) {
    if (totalPessoas == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicione pelo menos 1 pessoa na aba Convidados.'), backgroundColor: Colors.black),
      );
      _tabController.animateTo(0);
      return;
    }

    final itens = _obterListaItensFormatada();
    if (itens.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione pelo menos 1 item.'), backgroundColor: Colors.black),
      );
      _tabController.animateTo(1);
      return;
    }

    double diferencaFalta = totalCarneIdealKg - totalCarneEscolhidaKg;
    if (diferencaFalta > 0.2) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              SizedBox(width: 10),
              Text('Atenção ao Peso!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
            ],
          ),
          content: Text(
            'Você selecionou ${totalCarneEscolhidaKg.toStringAsFixed(1)} kg de carne, mas o recomendado para seus $totalPessoas convidados é de aproximadamente ${totalCarneIdealKg.toStringAsFixed(1)} kg (faltam cerca de ${(diferencaFalta * 1000).toStringAsFixed(0)}g).\n\nDeseja continuar mesmo assim ou ajustar na seleção?',
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ajustar Seleção', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _abrirDialogoFinal();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 0),
              child: const Text('Continuar Assim'),
            ),
          ],
        ),
      );
      return;
    }

    _abrirDialogoFinal();
  }

  void _abrirDialogoFinal() {
    final itens = _obterListaItensFormatada();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Text('CHEF DA CARNE ROMA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            Text('— RESERVA DE CORTES —', style: TextStyle(fontSize: 11, color: Colors.grey, letterSpacing: 1.5)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cliente: ${widget.clienteNome}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('WhatsApp: ${widget.clienteTelefone}'),
              Text('Modalidade: $tipoLogistica'),
              if (_dataHorarioController.text.isNotEmpty)
                Text('Data/Horário: ${_dataHorarioController.text}'),
              const Divider(height: 24),
              Text('Convidados: $totalPessoas pessoas'),
              Text('Estilo: ${isChurrascoLongo ? "Longo / Open Bar" : "Rápido"}'),
              Text('Total de Carne: ${totalCarneEscolhidaKg.toStringAsFixed(1)} kg', style: const TextStyle(fontWeight: FontWeight.bold)),
              if (totalCarneEscolhidaKg > totalCarneIdealKg + 0.5)
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text('🔥 Nota: Sua seleção está generosa e acima da média padrão!', style: TextStyle(fontSize: 11, color: Colors.green, fontStyle: FontStyle.italic)),
                ),
              const Divider(height: 24),
              const Text('SELEÇÃO PARA O CHURRASCO:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...itens.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(e),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _salvarPedidoLocalmente();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200, foregroundColor: Colors.black, elevation: 0),
            child: const Text('Salvar Rascunho'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _copiarPedidoParaClipboard();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 0),
            child: const Text('Enviar WhatsApp'),
          ),
        ],
      ),
    );
  }

  void _copiarPedidoParaClipboard() {
    final itensTexto = _obterListaItensFormatada().join('\n');
    final mensagem = '''
🔥 *RESERVA DE CORTES - CHEF DA CARNE ROMA* 🔥

👤 *CLIENTE:*
• Nome: *${widget.clienteNome}*
• WhatsApp: ${widget.clienteTelefone}

🚚 *LOGÍSTICA:*
• Modalidade: *$tipoLogistica*
${_dataHorarioController.text.isNotEmpty ? '• Data e Horário: *${_dataHorarioController.text}*\n' : ''}
🥩 *RESUMO DO EVENTO:*
• Estilo: *${isChurrascoLongo ? "Longo / Open Bar" : "Rápido"}* | Convidados: *$totalPessoas* pessoas
• Peso Total de Carne: *${totalCarneEscolhidaKg.toStringAsFixed(1)} kg*

🛒 *SELEÇÃO PARA O CHURRASCO:*
$itensTexto

---
*Olá! Gostaria de confirmar a disponibilidade e os valores desta seleção. Aguardo retorno!*''';

    Clipboard.setData(ClipboardData(text: mensagem));
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.black, size: 28),
            SizedBox(width: 10),
            Text('Copiado com Sucesso!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
          ],
        ),
        content: const Text(
          'Sua reserva de cortes foi copiada! Agora basta abrir o WhatsApp e colar a mensagem na conversa com a Casa de Carnes.',
          style: TextStyle(fontSize: 13, height: 1.4),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 0),
            child: const Text('OK, Entendido'),
          ),
        ],
      ),
    );
  }

  Widget _buildContadorCard({
    required String titulo,
    required String subtitulo,
    required IconData icone,
    required int valor,
    required VoidCallback onDec,
    required VoidCallback onInc,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(14)),
              child: Icon(icone, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black)),
                  const SizedBox(height: 2),
                  Text(subtitulo, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Row(
              children: [
                _buildBotaoControle(icone: Icons.remove, ativo: valor > 0, onTap: valor > 0 ? onDec : null),
                Container(
                  constraints: const BoxConstraints(minWidth: 38),
                  alignment: Alignment.center,
                  child: Text('$valor', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black)),
                ),
                _buildBotaoControle(icone: Icons.add, ativo: true, onTap: onInc),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotaoControle({required IconData icone, required bool ativo, required VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ativo ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icone, size: 16, color: ativo ? Colors.white : Colors.grey.shade400),
      ),
    );
  }

  Widget _buildProdutoTile(String key, Map<String, dynamic> item) {
    bool selecionado = item['selecionado'];
    double quantidade = item['quantidade'];
    bool isCarne = item['isCarne'];

    String qtdTexto = '';
    if (selecionado) {
      if (isCarne) {
        qtdTexto = '${quantidade.toStringAsFixed(1)} kg';
      } else if (key == 'paoalho') {
        qtdTexto = '${quantidade.toInt()} pct';
      } else if (key == 'queijo') {
        qtdTexto = '${quantidade.toInt()} esp';
      } else if (key == 'carvao') {
        qtdTexto = '${quantidade.toInt()} kg';
      } else {
        qtdTexto = '${quantidade.toInt()} un';
      }
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Row(
          children: [
            Expanded(
              child: Text(
                item['nome'],
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),
              ),
            ),
            if (item['dica'] != null)
              InkWell(
                onTap: () => _mostrarDicaPreparo(context, item['nome'], item['dica']),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 15, color: Colors.grey.shade700),
                      const SizedBox(width: 4),
                      const Text('Dica', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
          ],
        ),
        subtitle: selecionado
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Text(qtdTexto, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () {
                        setState(() {
                          double passo = isCarne ? 0.5 : 1.0;
                          if (quantidade > passo) {
                            item['quantidade'] -= passo;
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.remove, size: 14, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        setState(() {
                          double passo = isCarne ? 0.5 : 1.0;
                          item['quantidade'] += passo;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.add, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            : null,
        value: selecionado,
        activeColor: Colors.black,
        checkColor: Colors.white,
        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onChanged: (val) {
          setState(() {
            item['selecionado'] = val ?? false;
          });
        },
      ),
    );
  }

  Widget _buildSecaoProdutos(String titulo, List<String> chaves) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(19)),
            ),
            child: Text(titulo.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          ),
          ...chaves.map((k) => _buildProdutoTile(k, itensCatalogo[k]!)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool excessoCarne = totalCarneEscolhidaKg > (totalCarneIdealKg * 1.5);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white, size: 20),
          tooltip: 'Deslogar',
          onPressed: _deslogar,
        ),
        title: Column(
          children: [
            const Text('CHEF DA CARNE ROMA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 2.0, fontSize: 16)),
            const SizedBox(height: 2),
            Text('Cliente: ${widget.clienteNome}', style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600, fontSize: 11)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white24, size: 18),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(color: Colors.black, border: Border(top: BorderSide(color: Colors.white12))),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1.0),
              tabs: const [Tab(text: '1. CONVIDADOS & PERFIL'), Tab(text: '2. SELEÇÃO & LOGÍSTICA')],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ABA 1: CONVIDADOS & ESTILO
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (pedidoSalvoResumo != null) ...[
                  Container(
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black26, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('📌 RASCUNHO SALVO', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5)),
                            Icon(Icons.bookmark, size: 18, color: Colors.black),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(pedidoSalvoResumo!, style: const TextStyle(fontSize: 13, height: 1.4)),
                        const SizedBox(height: 4),
                        const Text('Altere os dados abaixo e clique em salvar para atualizar.', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
                const Text('Estilo do Churrasco', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Rápido (3h)'),
                        selected: !isChurrascoLongo,
                        selectedColor: Colors.black,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(color: !isChurrascoLongo ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onSelected: (bool selected) => setState(() => isChurrascoLongo = false),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Longo / Open Bar (6h+)'),
                        selected: isChurrascoLongo,
                        selectedColor: Colors.black,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(color: isChurrascoLongo ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onSelected: (bool selected) => setState(() => isChurrascoLongo = true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Text('Quantidade de Convidados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black)),
                const SizedBox(height: 14),
                _buildContadorCard(titulo: 'Homens', subtitulo: 'Média: 500g', icone: Icons.man, valor: homens, onDec: () => setState(() => homens--), onInc: () => setState(() => homens++)),
                _buildContadorCard(titulo: 'Mulheres', subtitulo: 'Média: 400g', icone: Icons.woman, valor: mulheres, onDec: () => setState(() => mulheres--), onInc: () => setState(() => mulheres++)),
                _buildContadorCard(titulo: 'Crianças', subtitulo: 'Média: 200g', icone: Icons.child_care, valor: criancas, onDec: () => setState(() => criancas--), onInc: () => setState(() => criancas++)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('CARNE ESCOLHIDA / IDEAL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white70, letterSpacing: 1.0)),
                          Text(
                            '${totalCarneEscolhidaKg.toStringAsFixed(1)} kg / ${totalCarneIdealKg.toStringAsFixed(1)} kg',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                        ],
                      ),
                      if (excessoCarne) ...[
                        const SizedBox(height: 10),
                        const Text(
                          '⚠️ Aviso: Você selecionou bem mais carne do que o limite estimado para o número de convidados!',
                          style: TextStyle(fontSize: 11, color: Colors.amberAccent, fontWeight: FontWeight.bold, height: 1.3),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ABA 2: OPÇÕES & LOGÍSTICA
          ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text('Logística do Pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Retirar na Loja'),
                      selected: tipoLogistica == 'Retirar na Loja',
                      selectedColor: Colors.black,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(color: tipoLogistica == 'Retirar na Loja' ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onSelected: (val) => setState(() => tipoLogistica = 'Retirar na Loja'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Entrega (Delivery)'),
                      selected: tipoLogistica == 'Entrega (Delivery)',
                      selectedColor: Colors.black,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(color: tipoLogistica == 'Entrega (Delivery)' ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onSelected: (val) => setState(() => tipoLogistica = 'Entrega (Delivery)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _dataHorarioController,
                decoration: InputDecoration(
                  labelText: 'Data e Horário do Evento (Ex: Sábado às 13h)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.black, width: 2)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
              const SizedBox(height: 28),
              const Text('Seleção de Cortes & Produtos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black)),
              const SizedBox(height: 6),
              const Text('Marque os itens e ajuste a quantidade manualmente nos botões + e -.', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),
              
              _buildSecaoProdutos('Cortes Bovinos Nobres', ['picanha', 'contrafile', 'alcatra', 'fraldinha', 'maminha', 'costela']),
              _buildSecaoProdutos('Cortes Suínos & Linguiças', ['lombo', 'costelinhasuina', 'pernil', 'linguica']),
              _buildSecaoProdutos('Aves', ['coracao', 'asinha']),
              _buildSecaoProdutos('Peixes', ['salmao', 'tilapia']),
              _buildSecaoProdutos('Acompanhamentos', ['paoalho', 'queijo', 'carvao']),
              _buildSecaoProdutos('Bebidas', ['refrigerante', 'agua']),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12, width: 1)),
        ),
        child: ElevatedButton.icon(
          onPressed: () => _mostrarComandaPreview(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          icon: const Icon(Icons.receipt_long, size: 20),
          label: const Text(
            'VISUALIZAR RESERVA E ENVIAR',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.1),
          ),
        ),
      ),
    );
  }
}