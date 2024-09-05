part of '../screen.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 50, left: 10, right: 10, bottom: 40),
                decoration: BoxDecoration(
                  color: CIPSColor.primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat pagi,',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Altamis ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Colors.white, fontSize: 32.0),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child:
                              Text('AA', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Cari proyek',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Daftar proyek',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: CIPSColor.textPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: CIPSColor.textPrimaryColor),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: const Text('Lihat semua',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: List.generate(5, (index) {
                    return const ProjectCardWidget(
                      title: 'SD Negeri 1 Ngawi',
                      projectId: '#AM1656648201213N',
                      objectCount: 35,
                      photoCount: 10,
                      videoCount: 10,
                    );
                  }),
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(Icons.search, color: Colors.purple),
                    fillColor: CIPSColor.filledBackgroundInputColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CIPSColor.borderColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    labelText: 'Masukkan nama proyek!',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: CIPSColor.textSecondaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
