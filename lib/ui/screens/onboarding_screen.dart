import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../../routes/app_pages.dart';
import '../../services/onboarding_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: "Turn Spending into\nWhat-Ifs 🤔",
      subtitle:
          "Ever wonder what that coffee money could become if you invested it instead? Let's find out!",
      lottieAsset: "assets/lotties/money.json",
      backgroundColor: [TurfitColors.primaryLight, TurfitColors.gradientEnd],
    ),
    OnboardingData(
      title: "See Your Money\nGrow 📈",
      subtitle:
          "Pick any everyday item, choose a stock, and discover what your purchase could have become in a year!",
      lottieAsset: "assets/lotties/piggy.json",
      backgroundColor: [TurfitColors.tertiaryLight, TurfitColors.successLight],
    ),
    OnboardingData(
      title: "Start Building\nYour Future 🚀",
      subtitle:
          "Ready to flip from 'what can I buy?' to 'what could I build?' Let's explore together!",
      lottieAsset: "assets/lotties/pf.json",
      backgroundColor: [TurfitColors.secondaryLight, TurfitColors.accentLight],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _onboardingData[_currentPage].backgroundColor,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _goToHome,
                      child: Text(
                        'Skip',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: TurfitColors.white(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(_onboardingData[index]);
                  },
                ),
              ),

              // Bottom section with dots and button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: Column(
                  children: [
                    // Page dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingData.length,
                        (index) => _buildDot(index),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Next/Get Started button
                    SizedBox(
                      width: double.infinity,
                      // height: 6.h,
                      child: ElevatedButton(
                        onPressed: _currentPage == _onboardingData.length - 1
                            ? _goToHome
                            : _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TurfitColors.white(context),
                          foregroundColor:
                              _onboardingData[_currentPage].backgroundColor[0],
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          _currentPage == _onboardingData.length - 1
                              ? 'Get Started 🎉'
                              : 'Next',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie animation
          Container(
                // height: 35.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: TurfitColors.white(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Lottie.asset(
                    data.lottieAsset,
                    height: 25.h,
                    width: 60.w,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback widget if Lottie fails to load
                      return Container(
                        height: 25.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: TurfitColors.white(context).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.animation,
                          size: 10.h,
                          color: TurfitColors.white(context),
                        ),
                      );
                    },
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.8, 0.8))
              .then()
              .shimmer(duration: 1000.ms),

          SizedBox(height: 6.h),

          // Title
          Text(
                data.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: TurfitColors.white(context),
                  height: 1.2,
                ),
              )
              .animate()
              .fadeIn(delay: 300.ms, duration: 600.ms)
              .slideY(begin: 0.3),

          SizedBox(height: 3.h),

          // Subtitle
          Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: TurfitColors.white(context).withOpacity(0.9),
                  // height: 1.4,
                ),
              )
              .animate()
              .fadeIn(delay: 500.ms, duration: 600.ms)
              .slideY(begin: 0.3),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      height: 1.h,
      width: _currentPage == index ? 6.w : 2.w,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? TurfitColors.white(context)
            : TurfitColors.white(context).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToHome() async {
    await OnboardingService.setOnboardingCompleted();
    Get.offAllNamed(Routes.tabs);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final String lottieAsset;
  final List<Color> backgroundColor;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.lottieAsset,
    required this.backgroundColor,
  });
}
