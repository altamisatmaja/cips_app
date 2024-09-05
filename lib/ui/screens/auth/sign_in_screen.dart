part of '../screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Masuk',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            Text(
              'Yuk, mulai masuk menggunakan akun Anda!',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: CIPSColor.textSecondaryColor),
            ),
            const SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: CIPSColor.filledBackgroundInputColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CIPSColor.borderColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    labelText: 'Masukkan email Anda...',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: CIPSColor.textSecondaryColor),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: CIPSColor.filledBackgroundInputColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CIPSColor.borderColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    labelText: 'Masukkan password Anda...',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: CIPSColor.textSecondaryColor),
                  ),
                ),
                const SizedBox(height: 20.0),
                CipsButtonWidget(
                  textTitle: 'Masuk',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: CIPSColor.textSecondaryColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Text(
                        'Daftar',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: CIPSColor.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
