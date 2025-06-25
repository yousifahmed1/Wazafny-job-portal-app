import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazafny/Screens/Company/JobPosts/widgets/Process_bar.dart';
import 'package:wazafny/Screens/Company/nav_bar_company.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/custom_app_bar.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/create_job_post_model.dart';
import 'package:wazafny/Screens/Company/JobPosts/models/company_job_post_model.dart';
import 'package:wazafny/Screens/Company/JobPosts/services/create_job_post_service.dart';
import '../../../Dashboard/cubit/dashboard_cubit.dart';
import '../../cubits/company_Job_posts_cubit/company_job_posts_cubit.dart';
import 'pages/basic_info_page.dart';
import 'pages/skills_page.dart';
import 'pages/extra_sections_page.dart';
import 'pages/questions_page.dart';
import 'pages/preview_page.dart';

const kTileHeight = 50.0;
final _processes = [
  'Basic Info',
  'Skills',
  'Extra\nSections',
  'Questions',
  'Preview',
];

class CreateJobPost extends StatefulWidget {
  final CompanyJobPostModel? jobPostToEdit;
  final bool editMode;
  const CreateJobPost({Key? key, this.jobPostToEdit, this.editMode = false})
      : super(key: key);

  @override
  State<CreateJobPost> createState() => _CreateJobPostState();
}

class _CreateJobPostState extends State<CreateJobPost> {
  int _processIndex = 1;
  final TextEditingController _controller = TextEditingController();
  final CreateJobPostModel _jobPostData = CreateJobPostModel();
  final GlobalKey<FormState> _basicInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _skillsFormKey = GlobalKey<FormState>();
  final CreateJobPostService _jobPostService = CreateJobPostService();
  bool _isSubmitting = false;

  bool _isBasicInfoValid() {
    if (_basicInfoFormKey.currentState == null) return false;
    return _basicInfoFormKey.currentState!.validate() &&
        _jobPostData.jobTitle != null &&
        _jobPostData.jobTitle!.isNotEmpty &&
        _jobPostData.about != null &&
        _jobPostData.about!.isNotEmpty &&
        _jobPostData.country != null &&
        _jobPostData.country!.isNotEmpty &&
        _jobPostData.city != null &&
        _jobPostData.city!.isNotEmpty &&
        _jobPostData.jobType != null &&
        _jobPostData.jobType!.isNotEmpty &&
        _jobPostData.employmentType != null &&
        _jobPostData.employmentType!.isNotEmpty;
  }

  bool _isSkillsValid() {
    if (_skillsFormKey.currentState == null) return false;
    return _skillsFormKey.currentState!.validate() &&
        _jobPostData.skills.isNotEmpty;
  }

  Widget _getPage() {
    switch (_processIndex) {
      case 1:
        return BasicInfoPage(
          formKey: _basicInfoFormKey,
          jobPostData: _jobPostData,
          onDataChanged: (data) {
            setState(() {
              _jobPostData.jobTitle = data['jobTitle'];
              _jobPostData.about = data['about'];
              _jobPostData.country = data['country'];
              _jobPostData.city = data['city'];
              _jobPostData.jobType = data['jobType'];
              _jobPostData.employmentType = data['employmentType'];
            });
          },
        );
      case 2:
        return SkillsPage(
          formKey: _skillsFormKey,
          jobPostData: _jobPostData,
          onSkillsChanged: (skills) {
            setState(() {
              _jobPostData.skills = skills;
            });
          },
        );
      case 3:
        return ExtraSectionsPage(
          jobPostData: _jobPostData,
          onSectionsChanged: (sections) {
            setState(() {
              _jobPostData.extraSections = sections;
            });
          },
        );
      case 4:
        return QuestionsPage(
          jobPostData: _jobPostData,
          onQuestionsChanged: (questions) {
            setState(() {
              _jobPostData.questions = questions;
            });
          },
        );
      case 5:
        return PreviewPage(jobPostData: _jobPostData);
      default:
        return BasicInfoPage(
          formKey: _basicInfoFormKey,
          jobPostData: _jobPostData,
          onDataChanged: (data) {
            setState(() {
              _jobPostData.jobTitle = data['jobTitle'];
              _jobPostData.about = data['about'];
              _jobPostData.country = data['country'];
              _jobPostData.city = data['city'];
              _jobPostData.jobType = data['jobType'];
              _jobPostData.employmentType = data['employmentType'];
            });
          },
        );
    }
  }

  void updateIndex() {
    final value = int.tryParse(_controller.text);
    if (value != null && value >= 0 && value < _processes.length) {
      setState(() {
        _processIndex = value;
      });
    }
  }

  Future<void> _submitJobPost() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      String message;
      if (widget.editMode && widget.jobPostToEdit != null) {
        // Call update API (PUT)
        message = await _jobPostService.updateJobPost(
            widget.jobPostToEdit!.jobpost.jobId, _jobPostData);

      } else {
        message = await _jobPostService.createJobPost(_jobPostData);
      }
      if (mounted) {
        if (message == 'Complete your profile first') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Profile Incomplete'),
                content: const Text(
                    'Please complete your company profile before creating a job post.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NavBarCompany(
                            index: 2,
                          ),
                        ),
                      );
                    },
                    child: const Text('Go to Profile'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
              margin: const EdgeInsets.only(
                bottom: 100,
                left: 10,
                right: 10,
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<CompanyJobPostsCubit>().fetchCompanyJobPosts();
          context.read<CompanyDashboardCubit>().fetchStats();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBarCompany(),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create job post: ${e.toString()}'),
            backgroundColor: Colors.red,
            margin: const EdgeInsets.only(
              bottom: 100,
              left: 10,
              right: 10,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.editMode && widget.jobPostToEdit != null) {
      // Pre-fill form fields from jobPostToEdit
      final job = widget.jobPostToEdit!;
      _jobPostData.jobTitle = job.jobpost.jobTitle;
      _jobPostData.about = job.jobpost.jobAbout;
      _jobPostData.country = job.jobpost.jobCountry;
      _jobPostData.city = job.jobpost.jobCity;
      _jobPostData.jobType = job.jobpost.jobType;
      _jobPostData.employmentType = job.jobpost.jobTime;
      _jobPostData.companyID = job.jobpost.companyId;
      _jobPostData.skills = job.skills.map((s) => s.skill).toList();
      _jobPostData.questions = job.questions
          .map((q) =>
              JobQuestion(questionId: q.questionId, question: q.question))
          .toList();
      _jobPostData.extraSections = job.sections
          .map((s) => {
                'name': s.sectionName,
                'description': s.sectionDescription,
              })
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        onBackPressed: () => Navigator.pop(context),
        title: widget.editMode ? 'Edit Job Post' : 'Create Job Post',
      ),
      body: _isSubmitting
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 100,
                  child: ProcessTimelineBar(
                    processIndex: _processIndex,
                    processes: _processes,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _getPage(),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 10,
                        blurRadius: 50,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_processIndex > 1) {
                              setState(() {
                                _processIndex--;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: _processIndex != 1
                                    ? darkerPrimary
                                    : whiteColor,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 35,
                                  vertical: 8,
                                ),
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                    color: _processIndex != 1
                                        ? darkerPrimary
                                        : whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: darkerPrimary,
                          ),
                          child: TextButton(
                            onPressed: _isSubmitting
                                ? null
                                : () async {
                                    if (_processIndex == 1) {
                                      if (_isBasicInfoValid()) {
                                        setState(() {
                                          _processIndex++;
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please fill in all required fields in Basic Info'),
                                            backgroundColor: Colors.red,
                                            margin: EdgeInsets.only(
                                              bottom: 100,
                                              left: 10,
                                              right: 10,
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      }
                                    } else if (_processIndex == 2) {
                                      if (_isSkillsValid()) {
                                        setState(() {
                                          _processIndex++;
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please add at least one skill'),
                                            backgroundColor: Colors.red,
                                            margin: EdgeInsets.only(
                                              bottom: 100,
                                              left: 10,
                                              right: 10,
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      }
                                    } else if (_processIndex ==
                                        _processes.length) {
                                      await _submitJobPost();
                                    } else {
                                      setState(() {
                                        _processIndex++;
                                      });
                                    }
                                  },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 3,
                              ),
                              child: _isSubmitting
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      _processIndex == _processes.length - 1
                                          ? "Preview"
                                          : _processIndex == _processes.length
                                              ? (widget.editMode
                                                  ? "Update"
                                                  : "Submit")
                                              : "Next",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
