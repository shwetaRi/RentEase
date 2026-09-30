
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_rent_ease/screens/property_details_page.dart';
import 'package:project_rent_ease/models/favorite_store.dart';

class RentCard extends StatefulWidget {
  final String title;
  final String location;
  final int amount;
  final String imagePath;

  const RentCard({
    super.key,
    required this.title,
    required this.location,
    required this.amount,
    required this.imagePath,
  });

  @override
  State<RentCard> createState() => _RentCardState();
}

class _RentCardState extends State<RentCard> {
  final FavoriteStore _store = FavoriteStore.instance;

  @override
  void initState() {
    super.initState();
    _store.addListener(_updateFavorite);
  }

  @override
  void dispose() {
    _store.removeListener(_updateFavorite);
    super.dispose();
  }

  void _updateFavorite() {
    if (mounted) setState(() {});
  }

  void _toggleFavorite() {
    _store.toggleFavorite(
      FavoriteProperty(
        title: widget.title,
        location: widget.location,
        amount: widget.amount,
        imagePath: widget.imagePath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = _store.isFavorite(widget.title);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PropertyDetailsPage(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: 156,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: _toggleFavorite,
                    tooltip: isFavorite
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite
                          ? const Color(0xFFF9834D)
                          : Colors.black87,
                      size: 22,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 38,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 2, right: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF494949),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Image(
                      image: AssetImage('assets/icons/location.png'),
                      height: 14,
                      width: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.location,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF848D84),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      '৳',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF9834D),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      NumberFormat('#,##,##0', 'en_IN')
                          .format(widget.amount),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF383838),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}