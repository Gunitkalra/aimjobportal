// import 'package:get/get.dart';
// import '../../../Utils/shared_prehelper.dart';
// import '../../../routes/app_routes.dart';
//
//
// class DashboardController extends GetxController {
//   final userName = 'there'.obs;
//   final _prefs = SharedPrefHelper();
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadUser();
//   }
//
//   Future<void> _loadUser() async {
//     final name = await _prefs.get('name') ?? 'there';
//     userName.value = name.toString().split(' ').first;
//   }
//
//   Future<void> logout() async {
//     await _prefs.clear();
//     Get.offAllNamed(AppRoutes.login);
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../../routes/app_routes.dart';
import '../model/job_model/Job_Model.dart';
import '../model/job_model/job_Filter.dart';


class DashboardController extends GetxController {
  final searchCtrl = TextEditingController();
  final userName = 'there'.obs;
  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  final _prefs = SharedPrefHelper();

  // All jobs (from API later)
  final allJobs = <JobModel>[].obs;
  // Filtered + searched result
  final displayedJobs = <JobModel>[].obs;

  final searchQuery = ''.obs;
  final filter = JobFilter().obs;

  // ── Mock data ──────────────────────────────────────────────────────────────
  static final List<JobModel> _mockJobs = [
    JobModel(
      id: '1',
      title: 'Python Developer',
      company: 'Tata Consultancy Services',
      location: 'Mumbai',
      experience: '3 - 10 Yrs',
      jobType: 'Full-Time',
      workLocation: 'On-site',
      level: 'Mid Level',
      industry: 'IT Services',
      salary: '12 - 20 Lakhs',
      postedDate: 'Today',
      description:
      'TCS is hiring for Python Developer. Experience Range – 3 to 10 years. Location – Mumbai. Education qualification – 15 years of full-time education. Required Skills include strong server-side engineering with Python, REST APIs, asynchronous and functional programming. Experience with Python libraries for AI/ML, NLP & API: Scikit-learn, Pandas, NumPy, NLTK, Pydantic, FastAPI. Proficiency in AI evaluation including regression, classification, information retrieval, power analysis, correlation, and statistical testing. Strong understanding of AI/ML fundamentals such as Deep Learning, LLMs, Gen-AI and implications. Proficiency with relational and/or NoSQL databases like PostgreSQL/Oracle, MongoDB. Experience with message systems such as Apache Kafka, Solace. Deep understanding of containerization (Docker) and orchestration (Kubernetes/OpenShift). Familiarity with CI/CD tools like Jenkins, Tekton, ArgoCD, Harness. Comfortable mentoring software engineers in an experiment-driven development workflow.',
      skills: [
        'Python','REST','Scikit-learn','Pandas','NumPy','NLTK',
        'Pydantic','FastAPI','PostgreSQL','Oracle','MongoDB',
        'Apache Kafka','Solace','Docker','Kubernetes','OpenShift',
        'Jenkins','Tekton','ArgoCD','Harness',
      ],
      tags: ['Mid-level', 'Technology', 'On-site', 'IT Services'],
      education: 'Bachelor of Engineering',
      logoText: 'T',
    ),
    JobModel(
      id: '2',
      title: 'Flutter Developer',
      company: 'Infosys',
      location: 'Bangalore',
      experience: '1 - 4 Yrs',
      jobType: 'Full-Time',
      workLocation: 'Hybrid',
      level: 'Entry Level',
      industry: 'IT Services',
      salary: '6 - 12 Lakhs',
      postedDate: 'This week',
      description:
      'Infosys is looking for a passionate Flutter Developer to join our mobile team. You will be responsible for building and maintaining high-quality cross-platform mobile applications. Strong knowledge of Dart, Flutter widgets, state management (GetX/Bloc/Provider), REST API integration, and Firebase is required.',
      skills: ['Flutter', 'Dart', 'GetX', 'Firebase', 'REST APIs', 'Git'],
      tags: ['Entry Level', 'Mobile', 'Hybrid', 'IT Services'],
      education: 'B.Tech / B.E. in Computer Science',
      logoText: 'I',
    ),
    JobModel(
      id: '3',
      title: 'UI/UX Designer',
      company: 'Wipro',
      location: 'Hyderabad',
      experience: '2 - 5 Yrs',
      jobType: 'Full-Time',
      workLocation: 'Remote',
      level: 'Mid Level',
      industry: 'Design',
      salary: '8 - 15 Lakhs',
      postedDate: 'Last 2 weeks',
      description:
      'Wipro is seeking a creative UI/UX Designer with strong skills in Figma, Adobe XD, and user research. You will work closely with product and engineering teams to create delightful and intuitive digital experiences.',
      skills: ['Figma', 'Adobe XD', 'Sketch', 'User Research', 'Prototyping', 'Wireframing'],
      tags: ['Mid Level', 'Design', 'Remote'],
      education: 'Bachelor of Design / B.Tech',
      logoText: 'W',
    ),
    JobModel(
      id: '4',
      title: 'Data Scientist',
      company: 'HCL Technologies',
      location: 'Noida',
      experience: '4 - 8 Yrs',
      jobType: 'Full-Time',
      workLocation: 'Hybrid',
      level: 'Senior',
      industry: 'Analytics',
      salary: '18 - 30 Lakhs',
      postedDate: 'This week',
      description:
      'HCL is hiring Data Scientists with expertise in machine learning, deep learning, and statistical modeling. You will work on cutting-edge AI projects to solve complex business problems.',
      skills: ['Python', 'TensorFlow', 'PyTorch', 'SQL', 'Tableau', 'ML', 'Deep Learning'],
      tags: ['Senior', 'Analytics', 'Hybrid'],
      education: 'M.Tech / M.Sc. in Data Science or related field',
      logoText: 'H',
    ),
    JobModel(
      id: '5',
      title: 'React Frontend Developer',
      company: 'Cognizant',
      location: 'Chennai',
      experience: '2 - 6 Yrs',
      jobType: 'Full-Time',
      workLocation: 'On-site',
      level: 'Mid Level',
      industry: 'IT Services',
      salary: '10 - 18 Lakhs',
      postedDate: 'Today',
      description:
      'Cognizant is looking for a skilled React Developer with experience in building scalable web applications. Strong knowledge of React.js, TypeScript, Redux, and RESTful APIs is required.',
      skills: ['React.js', 'TypeScript', 'Redux', 'HTML', 'CSS', 'REST APIs', 'Git'],
      tags: ['Mid Level', 'Frontend', 'On-site', 'IT Services'],
      education: 'B.Tech / B.E.',
      logoText: 'C',
    ),
    JobModel(
      id: '6',
      title: 'DevOps Engineer',
      company: 'Tech Mahindra',
      location: 'Pune',
      experience: '3 - 7 Yrs',
      jobType: 'Full-Time',
      workLocation: 'Remote',
      level: 'Mid Level',
      industry: 'Cloud',
      salary: '14 - 22 Lakhs',
      postedDate: 'This month',
      description:
      'Tech Mahindra is hiring DevOps Engineers with hands-on experience in CI/CD pipelines, containerization, and cloud infrastructure. AWS/Azure/GCP certification is a plus.',
      skills: ['Docker', 'Kubernetes', 'Jenkins', 'AWS', 'Terraform', 'Linux', 'Git'],
      tags: ['Mid Level', 'Cloud', 'Remote'],
      education: 'B.Tech / B.E. in Computer Science',
      logoText: 'TM',
    ),
    JobModel(
      id: '7',
      title: 'Product Manager',
      company: 'Flipkart',
      location: 'Bangalore',
      experience: '5 - 10 Yrs',
      jobType: 'Full-Time',
      workLocation: 'Hybrid',
      level: 'Senior',
      industry: 'E-commerce',
      salary: '30 - 50 Lakhs',
      postedDate: 'This week',
      description:
      'Flipkart is looking for an experienced Product Manager to lead our supply chain tech team. You will define product strategy, work with cross-functional teams, and drive execution.',
      skills: ['Product Strategy', 'Roadmapping', 'Agile', 'SQL', 'Analytics', 'Stakeholder Management'],
      tags: ['Senior', 'Product', 'Hybrid', 'E-commerce'],
      education: 'MBA / B.Tech',
      logoText: 'F',
    ),
    JobModel(
      id: '8',
      title: 'Android Developer',
      company: 'Paytm',
      location: 'Noida',
      experience: '2 - 5 Yrs',
      jobType: 'Full-Time',
      workLocation: 'On-site',
      level: 'Mid Level',
      industry: 'Fintech',
      salary: '10 - 18 Lakhs',
      postedDate: 'Today',
      description:
      'Paytm is seeking an Android Developer with strong Kotlin skills and experience building fintech applications. Knowledge of payment integrations and security best practices is preferred.',
      skills: ['Kotlin', 'Java', 'Android SDK', 'MVVM', 'Jetpack Compose', 'REST APIs'],
      tags: ['Mid Level', 'Mobile', 'On-site', 'Fintech'],
      education: 'B.Tech / B.E.',
      logoText: 'P',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadUser();
    _loadJobs();
    searchCtrl.addListener(() {
      searchQuery.value = searchCtrl.text;
      _applyFilters();
    });
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }

  Future<void> _loadUser() async {
    final token = await _prefs.get('token');
    if (token != null && token.toString().isNotEmpty) {
      isLoggedIn.value = true;
      final name = await _prefs.get('name') ?? 'there';
      userName.value = name.toString().split(' ').first;
    } else {
      isLoggedIn.value = false;
      userName.value = 'Guest';
    }
  }

  Future<void> _loadJobs() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    // TODO: Replace with real API call
    allJobs.assignAll(_mockJobs);
    displayedJobs.assignAll(_mockJobs);
    isLoading.value = false;
  }

  void _applyFilters() {
    final query = searchQuery.value.toLowerCase().trim();
    final f = filter.value;

    List<JobModel> result = allJobs.where((job) {
      // Search
      final matchesSearch = query.isEmpty ||
          job.title.toLowerCase().contains(query) ||
          job.company.toLowerCase().contains(query) ||
          job.location.toLowerCase().contains(query) ||
          job.skills.any((s) => s.toLowerCase().contains(query));

      // Job type
      final matchesJobType =
          f.jobTypes.isEmpty || f.jobTypes.contains(job.jobType);

      // Work location
      final matchesWorkLocation =
          f.workLocations.isEmpty || f.workLocations.contains(job.workLocation);

      // Experience level
      final matchesExp =
          f.experiences.isEmpty || f.experiences.contains(job.level);

      // Salary filter (show jobs >= selected salary)
      final matchesSalary = f.salary == 0 || _parseSalary(job.salary) >= f.salary;

      return matchesSearch &&
          matchesJobType &&
          matchesWorkLocation &&
          matchesExp &&
          matchesSalary;
    }).toList();

    displayedJobs.assignAll(result);
  }

  double _parseSalary(String salaryStr) {
    // "12 - 20 Lakhs" → returns 12.0
    final parts = salaryStr.split(' ');
    if (parts.isNotEmpty) {
      return double.tryParse(parts.first) ?? 0;
    }
    return 0;
  }

  void applyFilter(JobFilter newFilter) {
    filter.value = newFilter;
    _applyFilters();
  }

  void clearFilter() {
    filter.value = JobFilter();
    _applyFilters();
  }

  void navigateToJobDetail(JobModel job) {
    Get.toNamed(AppRoutes.jobDetail, arguments: job);
  }

  Future<void> logout() async {
    await _prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  int get activeFilterCount => filter.value.activeCount;
}