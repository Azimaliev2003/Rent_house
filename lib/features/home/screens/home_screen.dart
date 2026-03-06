import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rent_house/features/cards/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedRoomIndex = 1;

  final List<String> containerFilters = [
    "All",
    "Apartment sale",
    "Plots",
    "Rent"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      // Убрал внешний Padding, так как он мешает Sliver-эффектам
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          /// ---------- Верхний блок ----------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset(
                          "assets/images/logo.svg",
                          fit: BoxFit.contain,
                        ), // Заглушка логотипа
                      ),
                      SvgPicture.asset(
                        "assets/images/notification.svg",
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Hello, ef",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "What do you want to learn?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          /// ---------- Поисковое поле (Pinned) ----------
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarDelegate(
              child: Container(
                color: const Color(0xFFF5F5F5),
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF3A9C9D),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    strutStyle: const StrutStyle(
                      fontSize: 16,
                      height: 1.0,
                      forceStrutHeight: true,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: "Search...",
                      border: InputBorder.none,
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 48, minHeight: 48),
                      suffixIconConstraints:
                          const BoxConstraints(minWidth: 48, minHeight: 48),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/images/search.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.grey, BlendMode.srcIn),
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/images/filter.svg",
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF2BAE9E), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// ---------- Фильтры ----------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: List.generate(
                    containerFilters.length,
                    (index) => buildFilter(
                      text: containerFilters[index],
                      isSelected: selectedRoomIndex == index,
                      onTap: () {
                        setState(() {
                          selectedRoomIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],

        /// ---------- ИСПРАВЛЕННАЯ СЕТКА ----------
        body: MasonryGridView.builder(
          // ВАЖНО: Убрал shrinkWrap и NeverScrollableScrollPhysics
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: 10,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemBuilder: (context, index) {
            return buildHouseCard(context);
          },
        ),
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _SearchBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child); // Растягиваем на всю высоту делегата
  }

  @override
  double get maxExtent => 91; // Высота контейнера (55) + padding (8+8)

  @override
  double get minExtent => 91;

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) => true;
}

// Заглушки для функций, чтобы код запустился
Widget buildFilter(
    {required String text,
    required bool isSelected,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3A9C9D) : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
    ),
  );
}

Widget buildHouseCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const CardDetailScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A9C9D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "houseImage",
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                "assets/images/card1.png",
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "House GUM",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "15000c",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    "Located near GUM, Bishkek.\n2 rooms • 65 m² • Fully furnished.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
