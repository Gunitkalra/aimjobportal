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
    'Entry Level', 'Mid Level', 'Senior', 'Lead', 'Director', 'Executive'
  ];
  final List<String> _postedDates = [
    'Today', 'This week', 'Last 2 weeks', 'This month', 'Any time'
  ];

  @override
  void initState() {
    super.initState();
    _filter = widget.currentFilter.copyWith();
  }

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
    final sw = MediaQuery.of(context).size.width;

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // ── Handle ───────────────────────────────────────────────
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.line,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // ── Header ───────────────────────────────────────────────
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
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.line),

          // ── Scrollable content ────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Job Type
                  _SectionTitle(title: 'Job Type'),
                  const SizedBox(height: 14),
                  _ChipGrid(
                    items: _jobTypes,
                    selected: _filter.jobTypes,
                    onTap: (v) => _toggleItem(_filter.jobTypes, v),
                  ),

                  const SizedBox(height: 28),

                  // Work Location
                  _SectionTitle(title: 'Work Location'),
                  const SizedBox(height: 14),
                  _ChipGrid(
                    items: _workLocations,
                    selected: _filter.workLocations,
                    onTap: (v) => _toggleItem(_filter.workLocations, v),
                  ),

                  const SizedBox(height: 28),

                  // Experience
                  _SectionTitle(title: 'Experience'),
                  const SizedBox(height: 14),
                  _ChipGrid(
                    items: _experiences,
                    selected: _filter.experiences,
                    onTap: (v) => _toggleItem(_filter.experiences, v),
                  ),

                  const SizedBox(height: 28),

                  // Salary slider
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
                      activeTrackColor: AppColors.darkRed,
                      inactiveTrackColor: AppColors.appBg5,
                      thumbColor:AppColors.darkRed ,
                      overlayColor: AppColors.lightRed.withOpacity(0.2),
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: _filter.salary,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (v) => setState(() => _filter.salary = v),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Distance slider
                  _SectionTitle(title: 'Distance'),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '${_filter.distance.toInt()} km',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkRed,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.darkRed,
                      inactiveTrackColor: AppColors.appBg5,
                      thumbColor: AppColors.darkRed,
                      overlayColor:AppColors.lightRed.withOpacity(0.2) ,
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: _filter.distance,
                      min: 0,
                      max: 200,
                      divisions: 200,
                      onChanged: (v) => setState(() => _filter.distance = v),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Posted date
                  _SectionTitle(title: 'Posted date'),
                  const SizedBox(height: 14),
                  _ChipGrid(
                    items: _postedDates,
                    selected: _filter.postedDates,
                    onTap: (v) => _toggleItem(_filter.postedDates, v),
                    singleSelect: true,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // ── Bottom buttons ────────────────────────────────────────
          const Divider(height: 1, color: AppColors.line),
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
            child: Row(
              children: [
                // Clear
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => _filter.clear());
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFB33A3A),
                      side: const BorderSide(
                          color: AppColors.darkRed, width: 1.5),
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
                // Show Jobs
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(_filter);
                      Get.back();
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

// ── Section title ─────────────────────────────────────────────────────────────

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

// ── Chip grid ─────────────────────────────────────────────────────────────────

class _ChipGrid extends StatefulWidget {
  final List<String> items;
  final List<String> selected;
  final Function(String) onTap;
  final bool singleSelect;

  const _ChipGrid({
    required this.items,
    required this.selected,
    required this.onTap,
    this.singleSelect = false,
  });

  @override
  State<_ChipGrid> createState() => _ChipGridState();
}

class _ChipGridState extends State<_ChipGrid> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: widget.items.map((item) {
        final isSelected = widget.selected.contains(item);
        return GestureDetector(
          onTap: () {
            if (widget.singleSelect) {
              widget.selected.clear();
              if (!isSelected) widget.selected.add(item);
            } else {
              widget.onTap(item);
            }
            setState(() {});
          },
          child: Container(
            constraints: BoxConstraints(
              minWidth: (MediaQuery.of(context).size.width - 52) / 2,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFE8F0FE)
                  : Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF1A73E8)
                    : const Color(0xFFDDDDDD),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF1A73E8)
                      : const Color(0xFF333333),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}