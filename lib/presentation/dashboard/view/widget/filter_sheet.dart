import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/colors.dart';
import '../../model/job_model/job_Filter.dart';


class FilterBottomSheet extends StatefulWidget {
  final JobFilter currentFilter;
  final Function(JobFilter) onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentFilter,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late JobFilter _filter;

  final List<String> _jobTypes = [
    'Full-Time', 'Part-Time', 'Contractor', 'Freelance', 'Intern', 'Permanent'
  ];
  final List<String> _workLocations = ['Hybrid', 'Remote', 'On-site'];
  final List<String> _experiences = [
    'Entry Level', 'Mid Level', 'Senior-level', 'Executive', 'Internship'
  ];
  final List<String> _postedDates = [
    'Today', 'This week', 'Last 2 weeks', 'This month', 'Any time'
  ];
  final List<String> _education = [
    'High School', 'Diploma', 'Bachelor\'s Degree', 'Master\'s Degree', 'MBA', 'PhD', 'Not Specified'
  ];
  final List<String> _industry = [
    'Information Technology', 'Banking & Finance', 'Automotive', 'Manufacturing', 
    'Healthcare', 'Pharmaceuticals & Biotech', 'Retail & E-Commerce', 'Consulting', 
    'Telecommunications', 'Energy & Utilities', 'Education', 'Media & Entertainment', 
    'Government & Public Sector', 'Logistics & Supply Chain', 'Real Estate', 
    'Hospitality & Travel', 'Non-Profit', 'Legal', 'Agriculture', 'Other'
  ];
  final List<String> _department = [
    'Engineering', 'Software Development', 'Information Technology', 'Data and Analytics',
    'DevOps and Infrastructure', 'Security', 'Research and Development', 'Quality Assurance',
    'IT Support', 'Design', 'Creative and Art Services', 'User Experience',
    'Project and Program Management', 'Product Management', 'Operations', 'Supply Chain and Logistics','Administration','Sales','Marketing','Communications and Public Affairs','Business Development','Customer Support','Healthcare and Medicine','Nursing',
    'Pharmacy','Medical Research','Health Administration','Finance and Accounting','Audit and Compliance','Tax',
    'Investment and Trading','Human Resources','Talent Acquisition','Learning and Development','Legal and Compliance',
    'General Management','Strategy and consulting'
  ];

  @override
  void initState() {
    super.initState();
    _filter = widget.currentFilter.copyWith();
  }

  void _close() => Navigator.of(context).pop();

  void _toggleItem(List<String> list, String value) {
    setState(() {
      if (list.contains(value)) {
        list.remove(value);
      } else {
        list.add(value);
      }
    });
  }

  void _toggleSingleItem(List<String> list, String value) {
    setState(() {
      if (list.contains(value)) {
        list.clear();
      } else {
        list.clear();
        list.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.line,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Spacer(),
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _close,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.appBg1,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.line),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _FilterSection(
                    title: 'Job Type',
                    items: _jobTypes,
                    selectedItems: _filter.jobTypes,
                    onToggle: (v) => _toggleItem(_filter.jobTypes, v),
                  ),
                  const SizedBox(height: 24),
                  
                  _FilterSection(
                    title: 'Work Location',
                    items: _workLocations,
                    selectedItems: _filter.workLocations,
                    onToggle: (v) => _toggleItem(_filter.workLocations, v),
                  ),
                  const SizedBox(height: 24),
                  
                  _FilterSection(
                    title: 'Experience',
                    items: _experiences,
                    selectedItems: _filter.experiences,
                    onToggle: (v) => _toggleItem(_filter.experiences, v),
                  ),
                  const SizedBox(height: 24),
                  
                  _FilterSection(
                    title: 'Posted date',
                    items: _postedDates,
                    selectedItems: _filter.postedDates,
                    onToggle: (v) => _toggleSingleItem(_filter.postedDates, v),
                  ),
                  const SizedBox(height: 24),
                  
                  _FilterSection(
                    title: 'Education',
                    items: _education,
                    selectedItems: _filter.education,
                    onToggle: (v) => _toggleItem(_filter.education, v),
                  ),
                  const SizedBox(height: 24),
                  
                  _FilterSection(
                    title: 'Industry',
                    items: _industry,
                    selectedItems: _filter.industry,
                    onToggle: (v) => _toggleItem(_filter.industry, v),
                  ),
                  const SizedBox(height: 24),
                  
                  _FilterSection(
                    title: 'Department',
                    items: _department,
                    selectedItems: _filter.department,
                    onToggle: (v) => _toggleItem(_filter.department, v),
                  ),
                  // const SizedBox(height: 24),
                  //
                  // _SectionTitle(title: 'Salary'),
                  // const SizedBox(height: 8),
                  // Center(
                  //   child: Text(
                  //     _filter.salary == 0
                  //         ? '0 Lakhs'
                  //         : '${_filter.salary.toInt()} Lakhs',
                  //     style: const TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //       color: AppColors.darkRed,
                  //     ),
                  //   ),
                  // ),
                  // SliderTheme(
                  //   data: SliderTheme.of(context).copyWith(
                  //     activeTrackColor: AppColors.textRed,
                  //     inactiveTrackColor: AppColors.appBg5,
                  //     thumbColor: AppColors.darkRed,
                  //     overlayColor: AppColors.white,
                  //     trackHeight: 4,
                  //     thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                  //   ),
                  //   child: Slider(
                  //     value: _filter.salary,
                  //     min: 0,
                  //     max: 100,
                  //     divisions: 100,
                  //     onChanged: (v) => setState(() => _filter.salary = v),
                  //   ),
                  // ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          const Divider(height: 1, color: AppColors.line),
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => _filter.clear());
                      widget.onApply(_filter);
                      _close();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.darkRed,
                      side: const BorderSide(color: AppColors.darkRed, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: AppColors.darkRed,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(_filter);
                      _close();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkRed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Show Jobs',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;
  final Function(String) onToggle;

  const _FilterSection({
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return GestureDetector(
              onTap: () => onToggle(item),
              child: Container(
                width: (MediaQuery.of(context).size.width - 40 - 12) / 2,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.appBg7 : Colors.white,
                  border: Border.all(
                    color: isSelected ? AppColors.darkRed : AppColors.line,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                    color: isSelected ? AppColors.darkRed : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}