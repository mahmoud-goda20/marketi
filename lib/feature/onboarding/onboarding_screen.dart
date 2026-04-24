import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/widgets/custom_button.dart';
import 'package:marketi/feature/auth/presentation/ui/pages/login_screen.dart';
import '../../core/utils/app_style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<_OnboardingPageModel> _pages = const [
    _OnboardingPageModel(
      image: 'assets/images/Illustration_Onboarding_1.svg',
      title: "Welcome to Marketi",
      subtitle:
          'Discover a world of endless possibilities and shop from the comfort of your fingertips Browse through a wide range of products, from fashion and electronics to home.',
    ),
    _OnboardingPageModel(
      image: 'assets/images/Illustration_Onboarding_2.svg',
      title: 'Easy to Buy',
      subtitle:
          'Find the perfect item that suits your style and needs With secure payment options and fast delivery, shopping has never been easier.',
    ),
    _OnboardingPageModel(
      image: 'assets/images/Illustration_Onboarding_3.svg',
      title: 'Wonderful User Experience',
      subtitle:
          'Start exploring now and experience the convenience of online shopping at its best.',
    ),
  ];

  void _goToNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 280,
                        child: SvgPicture.asset(
                          page.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        page.title,
                        textAlign: TextAlign.center,
                        style: AppStyle.title2,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        page.subtitle,
                        textAlign: TextAlign.center,
                        style: AppStyle.body,
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: _currentPage == index ? 27 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppStyle.darkBlue900
                        : AppStyle.lightBlue700,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              onPressed: _goToNext,
              buttonTitle: _currentPage == _pages.length - 1
                  ? 'Get Started'
                  : 'Next',
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageModel {
  final String image;
  final String title;
  final String subtitle;

  const _OnboardingPageModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
