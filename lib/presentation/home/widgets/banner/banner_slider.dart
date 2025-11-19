// widgets/banner_slider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trendychef/core/services/models/banner.dart';

class BannerSlider extends StatefulWidget {
  final List<BannerModel> images;
  final Duration autoScrollInterval;
  final Duration autoScrollDuration;

  const BannerSlider({
    super.key,
    required this.images,
    this.autoScrollInterval = const Duration(
      seconds: 4,
    ), // Slower interval for better UX
    this.autoScrollDuration = const Duration(
      milliseconds: 700,
    ), // Smoother scroll duration
  });

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late PageController _controller;
  Timer? _timer;
  int _current = 50000;
  final double _viewportFraction = 0.86;

  @override
  void initState() {
    super.initState();
    // Initialize PageController with a large initial page for infinite effect
    _controller = PageController(
      initialPage: _current,
      viewportFraction: _viewportFraction,
    );
    _startAuto();
  }

  void _startAuto() {
    _timer?.cancel();
    if (widget.images.length > 1) {
      // Only auto-scroll if there's more than one image
      _timer = Timer.periodic(widget.autoScrollInterval, (_) {
        if (!mounted || !_controller.hasClients) return;
        _current++;
        _controller.animateToPage(
          _current,
          curve: Curves.easeOut,
          duration: widget.autoScrollDuration,
        );
      });
    }
  }

  // --- Interaction Handlers ---

  void _onInteractionStart() {
    _timer?.cancel();
  }

  void _onInteractionEnd() {
    // Ensure that _current is updated to the page the user stopped on
    if (_controller.hasClients) {
      _current = _controller.page?.round() ?? _current;
    }
    _startAuto(); // Restart timer
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    // Use NotificationListener for reliable detection of scroll start/end
    return SizedBox(
      height: 200,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _onInteractionStart();
          } else if (notification is ScrollEndNotification) {
            _onInteractionEnd();
          }
          return false; // Return false to allow other listeners to receive the notification
        },
        // Wrapping in GestureDetector for taps/non-drag gestures (though less critical here)
        child: PageView.builder(
          controller: _controller,
          // Set to null for infinite scroll
          itemCount: null,
          // Update the current page variable when a page change is completed
          onPageChanged: (v) => _current = v,
          itemBuilder: (_, index) {
            final actualIndex = index % widget.images.length;
            final banner = widget.images[actualIndex];

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double value = 0.0;

                if (_controller.position.haveDimensions) {
                  // KEY FIX: Calculate the offset of the current item (index) relative to the current scroll position (_controller.page)
                  value = (_controller.page ?? _current.toDouble()) - index;
                }

                // Clamp to prevent calculations for non-adjacent pages
                value = value.clamp(-1.0, 1.0);

                // Smooth scaling: 1.0 (active) -> 0.95 (adjacent)
                final scale = 1.0 - (value.abs() * 0.05);

                // Smooth opacity: 1.0 (active) -> 0.7 (adjacent)
                final opacity = (1.0 - value.abs() * 0.3).clamp(0.7, 1.0);

                // Determine if this is the active (centered) banner for custom styling

                return Center(
                  // Use Padding to create space for shadow effect outside the scaled area
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    child: Opacity(
                      opacity: opacity,
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          height: 200.0 - 16.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Banner Image
                                Image.network(
                                  banner.imageUrl,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
