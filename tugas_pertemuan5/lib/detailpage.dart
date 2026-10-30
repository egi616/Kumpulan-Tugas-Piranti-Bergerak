import 'package:flutter/material.dart';

import 'app_color.dart';

final Color _softOrange = AppColor.primaryOrange;

class DetailPage extends StatefulWidget {
  final String nama, harga, img, deskripsi;
  final String rating;

  final List<Map<String, dynamic>> bahan;

  const DetailPage({
    super.key,
    required this.nama,
    required this.harga,
    required this.img,
    required this.deskripsi,
    required this.bahan,
    this.rating = '5.0',
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _qty = 1;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryYellow,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildSheet()),
          ],
        ),
      ),
    );
  }

  // ---------- Header ----------
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 24, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.only(top: 2, right: 4),
              child: Icon(Icons.chevron_left,
                  color: AppColor.primaryOrange, size: 26),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.nama,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColor.font,
                  ),
                ),
                const SizedBox(height: 4),
                _RatingChip(rating: widget.rating),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => setState(() => _isFavorite = !_isFavorite),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColor.primaryOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: AppColor.font2,
                size: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- White rounded sheet ----------
  Widget _buildSheet() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.font2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 28, 32, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(),
                  const SizedBox(height: 20),
                  _buildPriceRow(),
                  Divider(color: _softOrange, height: 32),
                  Text(
                    widget.deskripsi,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.25,
                      color: AppColor.font,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColor.font,
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (final item in widget.bahan) _buildIngredientRow(item),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 8, 32, 12),
              child: _buildAddToCart(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: Image.network(
        widget.img,
        width: double.infinity,
        height: 320,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const SizedBox(
            height: 320,
            child: Center(
              child: CircularProgressIndicator(color: AppColor.primaryOrange),
            ),
          );
        },
        errorBuilder: (context, error, stack) => Container(
          height: 320,
          color: AppColor.yellow1,
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image_outlined,
              color: AppColor.primaryOrange, size: 40),
        ),
      ),
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.harga.startsWith('\$') ? widget.harga : '\$${widget.harga}',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColor.primaryOrange,
          ),
        ),
        Row(
          children: [
            _RoundIconButton(
              icon: Icons.remove,
              enabled: _qty > 1,
              onTap: () => setState(() => _qty--),
            ),
            SizedBox(
              width: 44,
              child: Text(
                '$_qty',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColor.font,
                ),
              ),
            ),
            _RoundIconButton(
              icon: Icons.add,
              onTap: () => setState(() => _qty++),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIngredientRow(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '${item['nama']}',
            style: const TextStyle(fontSize: 14, color: AppColor.font),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: _DottedLine(),
            ),
          ),
          Text(
            '${item['takaran'] ?? ''}',
            style: const TextStyle(fontSize: 14, color: AppColor.font3),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCart() {
    return Center(
      child: SizedBox(
        width: 175,
        height: 46,
        child: ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${widget.nama} x$_qty ditambahkan')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryOrange,
            foregroundColor: AppColor.font2,
            elevation: 0,
            shape: const StadiumBorder(),
          ),
          icon: const Icon(Icons.shopping_bag_outlined, size: 22),
          label: const Text(
            'Add to Cart',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// ---------- Small reusable widgets ----------

class _RatingChip extends StatelessWidget {
  final String rating;
  const _RatingChip({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColor.primaryOrange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColor.font2,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(Icons.star_rounded, size: 12, color: AppColor.primaryYellow),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: enabled ? AppColor.primaryOrange : _softOrange,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: AppColor.font2),
      ),
    );
  }
}

class _DottedLine extends StatelessWidget {
  const _DottedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = (constraints.maxWidth / 4).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => Container(
              width: 1.5,
              height: 1.5,
              decoration: BoxDecoration(
                color: _softOrange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}