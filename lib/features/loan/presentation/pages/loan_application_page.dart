import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class LoanApplicationPage extends StatefulWidget {
  const LoanApplicationPage({super.key});

  @override
  State<LoanApplicationPage> createState() => _LoanApplicationPageState();
}

class _LoanApplicationPageState extends State<LoanApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _purposeController = TextEditingController();
  double _selectedAmount = 100.0;
  int _selectedTenure = 90;
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Loan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Loan Amount Section
                Text(
                  'Loan Amount',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '\$${_selectedAmount.toInt()}',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Slider(
                        value: _selectedAmount,
                        min: 50.0,
                        max: 1000.0,
                        divisions: 19,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            _selectedAmount = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$50',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '\$1,000',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Repayment Period
                Text(
                  'Repayment Period',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                
                Row(
                  children: [
                    _TenureCard(
                      days: 90,
                      isSelected: _selectedTenure == 90,
                      onTap: () => setState(() => _selectedTenure = 90),
                    ),
                    SizedBox(width: 12.w),
                    _TenureCard(
                      days: 180,
                      isSelected: _selectedTenure == 180,
                      onTap: () => setState(() => _selectedTenure = 180),
                    ),
                    SizedBox(width: 12.w),
                    _TenureCard(
                      days: 365,
                      isSelected: _selectedTenure == 365,
                      onTap: () => setState(() => _selectedTenure = 365),
                    ),
                  ],
                ),
                
                SizedBox(height: 32.h),
                
                // Loan Purpose
                Text(
                  'Loan Purpose',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  controller: _purposeController,
                  hintText: 'What will you use this loan for?',
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the loan purpose';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32.h),
                
                // Loan Summary
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.outline),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loan Summary',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _SummaryRow('Loan Amount', '\$${_selectedAmount.toInt()}'),
                      _SummaryRow('Repayment Period', '$_selectedTenure days'),
                      _SummaryRow('Interest Rate', '15% p.a.'),
                      _SummaryRow('Total Interest', '\$${(_selectedAmount * 0.15 * _selectedTenure / 365).toStringAsFixed(2)}'),
                      Divider(height: 24.h, color: AppColors.outline),
                      _SummaryRow(
                        'Total Repayment',
                        '\$${(_selectedAmount + (_selectedAmount * 0.15 * _selectedTenure / 365)).toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Apply Button
                CustomButton(
                  text: 'Apply for Loan',
                  isLoading: _isLoading,
                  onPressed: _handleLoanApplication,
                ),
                
                SizedBox(height: 16.h),
                
                // Terms Text
                Text(
                  'By applying, you agree to our Terms of Service and confirm that the information provided is accurate.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _SummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: FontWeight.w600,
              color: isTotal ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _handleLoanApplication() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      // TODO: Implement actual loan application logic
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Loan application submitted successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Application failed: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class _TenureCard extends StatelessWidget {
  final int days;
  final bool isSelected;
  final VoidCallback onTap;

  const _TenureCard({
    required this.days,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.outline,
            ),
          ),
          child: Column(
            children: [
              Text(
                '$days',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'days',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isSelected ? Colors.white.withOpacity(0.9) : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}