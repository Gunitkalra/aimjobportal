class JobFilter {
  List<String> jobTypes;
  List<String> workLocations;
  List<String> experiences;
  List<String> postedDates;
  List<String> education;
  List<String> industry;
  List<String> department;
  double salary;      // in Lakhs
  double distance;    // in km

  JobFilter({
    List<String>? jobTypes,
    List<String>? workLocations,
    List<String>? experiences,
    List<String>? postedDates,
    List<String>? education,
    List<String>? industry,
    List<String>? department,
    this.salary = 0,
    this.distance = 0,
  })  : jobTypes = jobTypes ?? [],
        workLocations = workLocations ?? [],
        experiences = experiences ?? [],
        postedDates = postedDates ?? [],
        education = education ?? [],
        industry = industry ?? [],
        department = department ?? [];

  bool get isEmpty =>
      jobTypes.isEmpty &&
          workLocations.isEmpty &&
          experiences.isEmpty &&
          postedDates.isEmpty &&
          education.isEmpty &&
          industry.isEmpty &&
          department.isEmpty &&
          salary == 0 &&
          distance == 0;

  JobFilter copyWith({
    List<String>? jobTypes,
    List<String>? workLocations,
    List<String>? experiences,
    List<String>? postedDates,
    List<String>? education,
    List<String>? industry,
    List<String>? department,
    double? salary,
    double? distance,
  }) =>
      JobFilter(
        jobTypes: jobTypes ?? List.from(this.jobTypes),
        workLocations: workLocations ?? List.from(this.workLocations),
        experiences: experiences ?? List.from(this.experiences),
        postedDates: postedDates ?? List.from(this.postedDates),
        education: education ?? List.from(this.education),
        industry: industry ?? List.from(this.industry),
        department: department ?? List.from(this.department),
        salary: salary ?? this.salary,
        distance: distance ?? this.distance,
      );

  void clear() {
    jobTypes.clear();
    workLocations.clear();
    experiences.clear();
    postedDates.clear();
    education.clear();
    industry.clear();
    department.clear();
    salary = 0;
    distance = 0;
  }

  int get activeCount =>
      jobTypes.length +
          workLocations.length +
          experiences.length +
          postedDates.length +
          education.length +
          industry.length +
          department.length +
          (salary > 0 ? 1 : 0) +
          (distance > 0 ? 1 : 0);
}