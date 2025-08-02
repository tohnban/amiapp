import 'package:ami_projecto/pages/minhaconta.dart';
import 'package:ami_projecto/pages/principalpage.dart';
import 'package:ami_projecto/pages/promotorpage.dart';
import 'package:ami_projecto/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String titleIsDark = "";

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    titleIsDark = isDarkMode ? 'Claro' : 'Nocturno';

    return Drawer(
      width:
          MediaQuery.of(context).size.width * 0.7, // Ajusta a largura do Drawer
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com imagem de fundo
            Container(
              height: 200.0,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://img.freepik.com/fotos-premium/fundo-azul-com-um-padrao-poligonal_692652-216.jpg',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(2.0),
              child: GridView.count(
                crossAxisCount: 2, // Número de itens por linha
                shrinkWrap:
                    true, // Necessário para usar dentro de SingleChildScrollView
                physics:
                    const NeverScrollableScrollPhysics(), // Desativa o scroll do GridView
                //crossAxisSpacing: 0,
                //mainAxisSpacing: 0,
                children: [
                  // Alternância de Tema
                  GestureDetector(
                    onTap: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.brightness_6,
                            color: Colors.blueGrey[900],
                          ),
                          Text(titleIsDark,
                              style: TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                    ),
                  ),
                  // Minha Conta
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Minhaconta(),
                      ));
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.manage_accounts_outlined,
                            color: Colors.blueGrey,
                          ),
                          SizedBox(height: 5),
                          Text('Minha Conta',
                              style: TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                    ),
                  ),
                  // Histórico
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrincipalPage(),
                      ));
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.history, color: Colors.blueGrey),
                          SizedBox(height: 5),
                          Text('Principal',
                              style: TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                    ),
                  ),
                  // Postos
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PromotorPage(),
                      ));
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.local_gas_station, color: Colors.blueGrey),
                          SizedBox(height: 5),
                          Text('Promotor',
                              style: TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                    ),
                  ),
                  // Configurações
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Minhaconta(),
                      ));
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.settings, color: Colors.blueGrey),
                          SizedBox(height: 5),
                          Text('Configurações',
                              style: TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                    ),
                  ),
                  // Você pode adicionar mais itens aqui seguindo o mesmo padrão
                ],
              ),
            ),
            // Caso queira adicionar mais seções abaixo da grade, faça aqui
            // Por exemplo, uma seção de logout
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.blueGrey[600]),
              title: const Text('Logout'),
              onTap: () {
                // Adicione a ação para Logout aqui
                // Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Minhaconta()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
