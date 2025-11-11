import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';

class DocumentUploadPage extends StatefulWidget {
  final String? loanId;

  const DocumentUploadPage({super.key, this.loanId});

  @override
  State<DocumentUploadPage> createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  final List<DocumentType> _documents = [
    DocumentType(
      id: 'national_id',
      title: 'National ID',
      description: 'Upload both sides of your National ID card',
      icon: Icons.credit_card,
      isRequired: true,
    ),
    DocumentType(
      id: 'job_verification',
      title: 'Job Verification',
      description: 'Upload your job verification letter or contract',
      icon: Icons.work,
      isRequired: true,
    ),
    DocumentType(
      id: 'selfie',
      title: 'Selfie Photo',
      description: 'Take a clear selfie for identity verification',
      icon: Icons.face,
      isRequired: true,
    ),
    DocumentType(
      id: 'proof_of_income',
      title: 'Proof of Income',
      description: 'Upload salary slip or bank statement (Optional)',
      icon: Icons.receipt_long,
      isRequired: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Documents'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Document Verification',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Please upload the required documents for identity verification',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '0/3 completed',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      LinearProgressIndicator(
                        value: 0.0,
                        backgroundColor: AppColors.outline,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Document List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(24.w),
                itemCount: _documents.length,
                itemBuilder: (context, index) {
                  return _DocumentCard(
                    document: _documents[index],
                    onUpload: () => _handleDocumentUpload(_documents[index]),
                  );
                },
              ),
            ),
            
            // Bottom Actions
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  CustomButton(
                    text: 'Submit Documents',
                    onPressed: () {
                      // TODO: Implement document submission
                      _showSubmissionDialog();
                    },
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'All required documents must be uploaded before submission',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDocumentUpload(DocumentType document) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => _UploadOptionsSheet(document: document),
    );
  }

  void _showSubmissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text('Submit Documents'),
        content: const Text(
          'Are you sure you want to submit your documents for verification? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CustomButton(
            text: 'Submit',
            height: 40.h,
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Handle submission
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Documents submitted successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DocumentCard extends StatefulWidget {
  final DocumentType document;
  final VoidCallback onUpload;

  const _DocumentCard({
    required this.document,
    required this.onUpload,
  });

  @override
  State<_DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<_DocumentCard> {
  bool _isUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: _isUploaded ? AppColors.success : AppColors.outline,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: (_isUploaded ? AppColors.success : AppColors.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _isUploaded ? Icons.check_circle : widget.document.icon,
                  color: _isUploaded ? AppColors.success : AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.document.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (widget.document.isRequired) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'Required',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.document.description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: _isUploaded ? 'Re-upload' : 'Upload',
              variant: _isUploaded ? ButtonVariant.outlined : ButtonVariant.filled,
              height: 40.h,
              onPressed: widget.onUpload,
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadOptionsSheet extends StatelessWidget {
  final DocumentType document;

  const _UploadOptionsSheet({required this.document});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload ${document.title}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          
          _OptionTile(
            icon: Icons.camera_alt,
            title: 'Take Photo',
            subtitle: 'Use camera to capture document',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement camera capture
            },
          ),
          
          _OptionTile(
            icon: Icons.photo_library,
            title: 'Choose from Gallery',
            subtitle: 'Select from your photo gallery',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement gallery selection
            },
          ),
          
          if (document.id != 'selfie')
            _OptionTile(
              icon: Icons.description,
              title: 'Choose File',
              subtitle: 'Select PDF or image file',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement file selection
              },
            ),
          
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}

class DocumentType {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final bool isRequired;

  DocumentType({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.isRequired,
  });
}