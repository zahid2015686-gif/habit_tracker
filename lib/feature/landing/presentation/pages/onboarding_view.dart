import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';

// ---------------------------------------------------------------------------
// Assets
// ---------------------------------------------------------------------------
final String onboardingImage_1 = 'assets/images/onboarding_image_1.png';
final String onboardingImage_2 = 'assets/images/onboarding_image_2.png';
final String onboardingImage_3 = 'assets/images/onboarding_image_3.png';

// ---------------------------------------------------------------------------
// Page data model
// ---------------------------------------------------------------------------
class _OnboardingPageData {
  final String image;
  final IconData icon;
  final String titleKey;
  final String descKey;

  const _OnboardingPageData({
    required this.image,
    required this.icon,
    required this.titleKey,
    required this.descKey,
  });
}

final List<_OnboardingPageData> _pages = [
  const _OnboardingPageData(
    image: 'assets/images/onboarding_image_1.png',
    icon: Icons.favorite_border_rounded,
    titleKey: 'build_better_habits',
    descKey: 'build_better_habits_desc',
  ),
  const _OnboardingPageData(
    image: 'assets/images/onboarding_image_2.png',
    icon: Icons.calendar_month_outlined,
    titleKey: 'find_your_rhythm',
    descKey: 'find_your_rhythm_desc',
  ),
  const _OnboardingPageData(
    image: 'assets/images/onboarding_image_3.png',
    icon: Icons.person_outline_rounded,
    titleKey: 'stay_accountable',
    descKey: 'stay_accountable_desc',
  ),
];

// ---------------------------------------------------------------------------
// Onboarding View
// ---------------------------------------------------------------------------
class OnboardingView extends StatefulWidget {
  static const String route = '/onboarding_view';
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _goToNext() {
    if (_currentIndex == _pages.length - 1) {
      _finishOnboarding();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _goToBack() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _skip() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    // TODO: navigate to your next route (e.g. login/home) here.
    // Navigator.of(context).pushReplacementNamed(SomeRoute.route);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) {
          return _OnboardingPage(
            data: _pages[index],
            pageIndex: index,
            totalPages: _pages.length,
            onSkip: _skip,
            onNext: _goToNext,
            onBack: _goToBack,
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Single page
// ---------------------------------------------------------------------------
class _OnboardingPage extends StatelessWidget {
  final _OnboardingPageData data;
  final int pageIndex;
  final int totalPages;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _OnboardingPage({
    required this.data,
    required this.pageIndex,
    required this.totalPages,
    required this.onSkip,
    required this.onNext,
    required this.onBack,
  });

  Widget _nextButton() {
    return ElevatedButton(
      onPressed: onNext,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2E4A2E),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
      ),
      child: Text(
        'next'.L(),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _buildButtonRow({required bool isFirst}) {
    if (isFirst) {
      // Full-width Next button, standalone (not inside a Row, so
      // double.infinity is safe here — the parent gives a bounded width).
      return SizedBox(
        width: double.infinity,
        child: _nextButton(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onBack,
          child: Text(
            'back'.L(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        _nextButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isFirst = pageIndex == 0;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEFE8D8), // cream
            Color(0xFFD6CE9E), // soft khaki
            Color(0xFFAEBD7E), // olive green
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ---------- Skip button ----------
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextButton(
                  onPressed: onSkip,
                  child: Text(
                    'skip'.L(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),

            // ---------- Circular image ----------
            Expanded(
              flex: 5,
              child: Center(
                child: Container(
                  width: size.width * 0.62,
                  height: size.width * 0.62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 3),
                    image: DecorationImage(
                      image: AssetImage(data.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // ---------- Text + button card ----------
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // icon badge
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(data.icon, color: Colors.white, size: 22),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          data.titleKey.L(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data.descKey.L(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ---------- Buttons ----------
                    _buildButtonRow(isFirst: isFirst),
                  ],
                ),
              ),
            ),

            // ---------- Page indicator dots ----------
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (i) {
                  final active = i == pageIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: active ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}