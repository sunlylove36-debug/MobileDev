import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/config/app_config.dart';
import '../../../../shared/widgets/custom_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: 'Quick Loan Application',
      description: 'Apply for a loan in just 10 minutes with minimal paperwork and fast approval process.',
      icon: Icons.speed,
      color: AppColors.primary,
    ),
    OnboardingData(
      title: 'Secure Document Upload',
      description: 'Upload your National ID, Job verification, and take a selfie securely through our app.',
      icon: Icons.cloud_upload,
      color: AppColors.secondary,
    ),
    OnboardingData(
      title: 'Flexible Repayment',
      description: 'Choose your repayment period from 90-365 days with competitive interest rates.',
      icon: Icons.schedule,
      color: AppColors.info,
    ),
    OnboardingData(
      title: 'Build Your Credit',
      description: 'Start with small amounts and build your credit score to access larger loans up to \$1000.',
      icon: Icons.trending_up,
      color: AppColors.success,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            
            // PageView
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_onboardingData[index]);
                },
              ),
            ),
            
            // Page Indicators
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                  
                  SizedBox(height: 32.h),
                  
                  // Navigation Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        if (_currentPage > 0)
                          Expanded(
                            child: CustomButton(
                              text: 'Previous',
                              variant: ButtonVariant.outlined,
                              onPressed: _previousPage,
                            ),
                          ),
                        
                        if (_currentPage > 0) SizedBox(width: 16.w),
                        
                        Expanded(
                          child: CustomButton(
                            text: _currentPage == _onboardingData.length - 1
                                ? 'Get Started'
                                : 'Next',
                            onPressed: _currentPage == _onboardingData.length - 1
                                ? _completeOnboarding
                                : _nextPage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(60.r),
            ),
            child: Icon(
              data.icon,
              size: 60.sp,
              color: data.color,
            ),
          ),
          
          SizedBox(height: 48.h),
          
          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _currentPage == index ? 32.w : 8.w,
      height: 8.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.primary : AppColors.outline,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() async {
    await AppConfig.setOnboardingCompleted(true);
    if (mounted) {
      context.goNamed('login');
    }
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}