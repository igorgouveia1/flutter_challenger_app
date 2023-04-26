import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/build_tab.dart';
import '../components/custom_tile_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomTabIndex = 0;

// desloga o usuário
  void logout() async {
    FirebaseAuth.instance.signOut();
  }

//enviar e-mail de verificação
  void verificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (!user.emailVerified) {
        await user
            .sendEmailVerification()
            .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('E-mail de confirmação enviado'),
                ),
              ),
            )
            .then((value) => logout());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail já enviado'),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

// indica qual aba do bottom será selecionada.
  void _onTabTapped(int index) {
    setState(() {
      _bottomTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const DrawerHeader(child: Text('ChallengerApp')),
            CustomTileMenu(
              menuTitle: 'Meu Perfil',
              onClick: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            CustomTileMenu(
              menuTitle: 'Validar E-mail',
              onClick: verificationEmail,
            ),
            CustomTileMenu(
              menuTitle: 'Sair',
              onClick: logout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('ChallengerApp'),
      ),
      body: TabContent.buildTabContent(_bottomTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: _onTabTapped,
        currentIndex: _bottomTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
              ),
              label: 'Área Restrita'),
        ],
      ),
    );
  }
}
