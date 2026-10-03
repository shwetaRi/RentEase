
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_rent_ease/screens/property_details_page.dart';
import 'package:project_rent_ease/models/favorite_store.dart';

class RentCard extends StatefulWidget {
  final String title;
  final String location;
  final int amount;
  final String imagePath;
  final Map<String, dynamic>? propertyData;

  const RentCard({
    super.key,
    required this.title,
    required this.location,
    required this.amount,
    required this.imagePath,
    this.propertyData,
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
    if (mounted) {
      setState(() {});
    }
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

  Widget _buildCardThumbnail() {
    final images = widget.propertyData?['images'];

    String path = widget.imagePath;

    if (images is List && images.isNotEmpty) {
      path = images.first.toString();
    }

    if (path.startsWith('http://') ||
        path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _imagePlaceholder();
        },
      );
    }

    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _imagePlaceholder();
        },
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imagePlaceholder();
      },
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(
        Icons.home_outlined,
        size: 45,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = _store.isFavorite(widget.title);

    return GestureDetector(
      onTap: () {
        final Map<String, dynamic> data =
            widget.propertyData ?? {
              'category': widget.title,
              'fullAddress': widget.location,
              'rentPrice': widget.amount.toString(),
              'images': widget.imagePath.isNotEmpty
                  ? [widget.imagePath]
                  : <String>[],
            };

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsPage(
              propertyData: data,
            ),
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
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: _buildCardThumbnail(),
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
