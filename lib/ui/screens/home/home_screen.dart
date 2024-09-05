part of '../screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is HomeScreenDataLoaded) {
          return Scaffold(
            body: [
              const HomeFragment(),
              const ConfigureFragment(),
              const ProfileFragment(),
            ][state.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.selectedIndex,
              onTap: (index) {
                context
                    .read<HomeScreenBloc>()
                    .add(SetHomeScreenSelectedIndex(index: index));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.space_dashboard_outlined,
                    size: 30.0,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings_accessibility_outlined,
                    size: 30.0,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined,
                      size: 30.0, color: Color(0xFF4A4B57)),
                  label: '',
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
