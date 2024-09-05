part of '../screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CIPSColor.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Image.asset(
              'assets/icons/splash-cips-icon.png',
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 450,
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/welcome-background.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yuk, Izinkan lokasi',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Sebelum mulai, pastikan akses izin lokasinya sudah diperbolehkan',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CipsButtonWidget(
                    textTitle: 'Beri Izin Lokasi',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    isLight: true,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
