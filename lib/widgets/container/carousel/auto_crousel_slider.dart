import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trendychef/core/services/models/banner/banner.dart';

class AutoSlidingBanner extends StatefulWidget {
  final List<BannerModel> banners;
  final double aspectRatio;

  const AutoSlidingBanner({
    super.key,
    required this.banners,
    this.aspectRatio = 16 / 7,
  });

  @override
  State<AutoSlidingBanner> createState() => _AutoSlidingBannerState();
}

class _AutoSlidingBannerState extends State<AutoSlidingBanner> {
  late final PageController _controller;
  Timer? _autoScrollTimer;
  int _currentPage = 1; // Start at 1 because of loop padding

  List<BannerModel> get _loopedBanners {
    if (widget.banners.length >= 2) {
      return [widget.banners.last, ...widget.banners, widget.banners.first];
    }
    return widget.banners;
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.9,
      initialPage: _currentPage,
    );

    if (widget.banners.length >= 2) _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;

      int nextPage = _currentPage + 1;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  void _pauseAutoScroll() {
    _autoScrollTimer?.cancel();
    // resume after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) _startAutoScroll();
    });
  }

  void _handlePageChanged(int index) {
    setState(() => _currentPage = index);

    // Infinite loop logic
    if (index == 0) {
      Future.delayed(const Duration(milliseconds: 350), () {
        if (_controller.hasClients) {
          _controller.jumpToPage(_loopedBanners.length - 2);
        }
      });
    } else if (index == _loopedBanners.length - 1) {
      Future.delayed(const Duration(milliseconds: 350), () {
        if (_controller.hasClients) _controller.jumpToPage(1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: const Center(child: Text("No banners found")),
      );
    }

    if (_loopedBanners.isEmpty) {
      return BannerSkeleton(aspectRatio: widget.aspectRatio);
    }

    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: GestureDetector(
        onTapDown: (_) => _pauseAutoScroll(),
        onPanDown: (_) => _pauseAutoScroll(),
        child: PageView.builder(
          controller: _controller,
          itemCount: _loopedBanners.length,
          onPageChanged: _handlePageChanged,
          itemBuilder: (context, i) {
            final banner = _loopedBanners[i];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    if (banner.url.isEmpty) return;

                    try {
                      final uri = Uri.parse(banner.url);
                      if (uri.path.contains('/product') &&
                          uri.queryParameters['id'] != null) {
                        final productId = uri.queryParameters['id']!;
                        context.push("/product/$productId");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid product link')),
                        );
                      }
                    } catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not parse link')),
                      );
                    }
                  },
                  child: Image.network(
                    banner.imageUrl,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (_, _, _) => Container(
                      color: Colors.grey.shade300,
                      child: const Center(child: Icon(Icons.error)),
                    ),
                    frameBuilder: (context, child, frame, wasSync) {
                      if (wasSync) return child;
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 500),
                        child: child,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BannerSkeleton extends StatelessWidget {
  final double aspectRatio;

  const BannerSkeleton({super.key, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
