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
  final List<String> _workLocations = ['Hybrid', 'Remote',];
  final List<String> _experiences = [
    'Entry Level', 'Mid Level', 'Senior Level', 'Manager', 'Director', 'Executive'
  ];
  final List<String> _postedDates = [
    'Today', 'This week', 'Last 2 weeks', 'This month', 'Any time'
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
                    decoration: BoxDecoration(
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
                  _MultiSelectDropdown(
                    title: 'Job Type',
                    items: _jobTypes,
                    selectedItems: _filter.jobTypes,
                    onToggle: (v) => _toggleItem(_filter.jobTypes, v),
                  ),
                  const SizedBox(height: 20),
                  
                  _MultiSelectDropdown(
                    title: 'Work Location',
                    items: _workLocations,
                    selectedItems: _filter.workLocations,
                    onToggle: (v) => _toggleItem(_filter.workLocations, v),
                  ),
                  const SizedBox(height: 20),
                  
                  _MultiSelectDropdown(
                    title: 'Experience',
                    items: _experiences,
                    selectedItems: _filter.experiences,
                    onToggle: (v) => _toggleItem(_filter.experiences, v),
                  ),
                  const SizedBox(height: 24),
                  
                  _SectionTitle(title: 'Salary'),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      _filter.salary == 0
                          ? '0 Lakhs'
                          : '${_filter.salary.toInt()} Lakhs',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkRed,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.textRed,
                      inactiveTrackColor: AppColors.appBg5,
                      thumbColor: AppColors.darkRed,
                      overlayColor: AppColors.white,
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: _filter.salary,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (v) => setState(() => _filter.salary = v),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  _MultiSelectDropdown(
                    title: 'Any time',
                    items: _postedDates,
                    selectedItems: _filter.postedDates,
                    onToggle: (v) => _toggleItem(_filter.postedDates, v),
                    singleSelect: true,
                  ),
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
                      foregroundColor: const Color(0xFFB33A3A),
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

class _MultiSelectDropdown extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;
  final Function(String) onToggle;
  final bool singleSelect;

  const _MultiSelectDropdown({
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onToggle,
    this.singleSelect = false,
  });

  @override
  State<_MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<_MultiSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    String displayString = widget.title;
    if (widget.selectedItems.isNotEmpty) {
      if (widget.singleSelect) {
        displayString = "${widget.title}: ${widget.selectedItems.first}";
      } else {
        displayString = "${widget.title} (${widget.selectedItems.length})";
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedIconColor: AppColors.textPrimary,
          iconColor: AppColors.darkRed,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          title: Text(
            displayString,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: widget.selectedItems.isNotEmpty ? AppColors.darkRed : AppColors.textPrimary,
            ),
          ),
          children: widget.items.map((item) {
            final isSelected = widget.selectedItems.contains(item);
            return CheckboxListTile(
              dense: true,
              activeColor: AppColors.darkRed,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppColors.darkRed : AppColors.textPrimary,
                ),
              ),
              value: isSelected,
              onChanged: (val) {
                if (widget.singleSelect) {
                  widget.selectedItems.clear();
                  if (val == true) widget.selectedItems.add(item);
                } else {
                  widget.onToggle(item);
                }
                setState(() {});
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}