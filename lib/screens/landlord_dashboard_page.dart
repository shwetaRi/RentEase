
import 'package:flutter/material.dart';
import 'package:project_rent_ease/screens/select_category.dart';
import 'package:project_rent_ease/screens/favorite_page.dart';

class LandlordDashboardPage extends StatefulWidget {
  const LandlordDashboardPage({super.key});

  @override
  State<LandlordDashboardPage> createState() =>
      _LandlordDashboardPageState();
}

class _LandlordDashboardPageState
    extends State<LandlordDashboardPage> {
  final Color orange = const Color(0xFFF9834D);
  final Color navColor = const Color(0xFFF0E3E7);


  Widget _emptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 65,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF383838),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _yourPropertyTab() {
    return _emptyState(
      icon: Icons.home_work_outlined,
      title: 'No Properties Yet',
      message:
      'Tap the + button below to select a category and add your property.',
    );
  }


  Widget _applicantsTab() {
    return _emptyState(
      icon: Icons.people_outline,
      title: 'No Applicants Yet',
      message:
      'People who apply for your properties will appear here.',
    );
  }


  Widget _bottomNavigationBar() {
    return Container(
      height: 76,
      color: navColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Image.asset(
              'assets/icons/home.png',
              height: 24,
              width: 24,
            ),
          ),


          Icon(
            Icons.dashboard,
            size: 26,
            color: orange,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectCategory(),
                ),
              );
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: orange.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
            child: Image.asset(
              'assets/icons/love.png',
              height: 24,
              width: 24,
            ),
          ),

          // Profile
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Landlord profile coming soon.',
                  ),
                ),
              );
            },
            child: Image.asset(
              'assets/icons/profile.png',
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,


        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Landlord Dashboard',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Color(0xFF383838),
            ),
          ),


          bottom: TabBar(
            labelColor: orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: orange,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Your Property'),
              Tab(text: 'Applicants'),
            ],
          ),
        ),

        // Tab Content
        body: TabBarView(
          children: [
            _yourPropertyTab(),
            _applicantsTab(),
          ],
        ),

        // Bottom Navigation
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }
}
