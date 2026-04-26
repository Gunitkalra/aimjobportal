
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../Controller/Dashboard_Controller.dart';
import '../Controller/Get_Job_Controller.dart';
import '../Controller/Get_stats_Controller.dart';
import 'widget/filter_sheet.dart';
import 'widget/job_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _scaffoldKey   = GlobalKey<ScaffoldState>();
  final _locationCtrl  = TextEditingController();
  final _scrollCtrl    = ScrollController();        // ✅ for infinite scroll

  bool _hasSearched = false;

  final GetAllJobsController getjobcontroller = Get.put(GetAllJobsController());
  final GetStatsController getstatscontroller = Get.put(GetStatsController());
  late final DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<DashboardController>();
    controller.loadUser();
    getstatscontroller.fetchStats();
    // Reset to home when search bar is cleared
    controller.searchCtrl.addListener(() {
      if (controller.searchCtrl.text.isEmpty && _hasSearched) {
        setState(() => _hasSearched = false);
      }
    });

    // ✅ Infinite scroll — trigger next page near bottom
    _scrollCtrl.addListener(() {
      final pos        = _scrollCtrl.position;
      final nearBottom = pos.pixels >= pos.maxScrollExtent - 200;
      if (nearBottom && getjobcontroller.hasMore) {
        getjobcontroller.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _locationCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _search() {
    FocusScope.of(context).unfocus();

    if (controller.searchCtrl.text.trim().isEmpty &&
        _locationCtrl.text.trim().isEmpty) {
      setState(() => _hasSearched = false);
      return;
    }

    setState(() => _hasSearched = true);

    // ✅ Always start from page 1 on a new search
    controller.triggerSearch(controller.searchCtrl.text.trim());

    // Scroll back to top on new search
    if (_scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBg1,
      drawer: controller.isLoggedIn.value
          ? _SideDrawer(controller: controller)
          : null,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ────────────────────────────────────────────────
            Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.05, vertical: 8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 100,
                  ),
                  const Spacer(),
                  Obx(() {
                    if (controller.isLoggedIn.value) {
                      return GestureDetector(
                        onTap: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(Icons.menu,
                                color: AppColors.darkRed, size: 22),
                          ),
                        ),
                      );
                    } else {
                      return Row(
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                Get.toNamed(AppRoutes.signup),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkRed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: const Size(80, 36),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () =>
                                Get.toNamed(AppRoutes.login),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                    color: AppColors.darkRed, width: 1),
                              ),
                              minimumSize: const Size(80, 36),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: AppColors.darkRed,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),

            // ── Scrollable body ────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollCtrl,          // ✅ attach scroll controller
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Search section ───────────────────────────────────
                    Container(
                      width: double.infinity,
                      color: AppColors.appBg1,
                      padding: EdgeInsets.fromLTRB(
                        sw * 0.05,
                        _hasSearched ? sh * 0.02 : sh * 0.03,
                        sw * 0.05,
                        _hasSearched ? sh * 0.02 : sh * 0.035,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_hasSearched) ...[
                            Center(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Find Jobs Faster with ',
                                      style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'AI',
                                      style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.darkRed,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Center(
                              child: Text(
                                'Jobs From Multiple Company Career Pages-All In One Place',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            SizedBox(height: sh * 0.025),
                          ],

                          // ── Search card ────────────────────────────────
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.07),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                TextField(
                                  controller: controller.searchCtrl,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textPrimary),
                                  decoration: const InputDecoration(
                                    hintText:
                                    'Job title,Skills,Company name',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textHint),
                                    // prefixIcon: Icon(Icons.search,
                                    //     color: AppColors.darkRed,
                                    //     size: 30),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 40, minHeight: 40),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkRed),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkRed),
                                    ),
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                TextField(
                                  controller: _locationCtrl,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (_) => _search(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textPrimary),
                                  decoration: const InputDecoration(
                                    hintText: 'Location',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textHint),
                                    // prefixIcon: Icon(
                                    //     Icons.location_on_outlined,
                                    //     color: AppColors.darkRed,
                                    //     size: 30),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 40, minHeight: 40),
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      // gradient: AppColors.blueGradient,
                                      color: AppColors.darkRed,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _search,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Search Job',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Stats OR Results ──────────────────────────────────
                    if (!_hasSearched)
                      Obx(() {
                        if (getstatscontroller.isLoading.value) {
                          return Padding(
                            padding: EdgeInsets.only(top: sh * 0.1),
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.buttonPrimary),
                            ),
                          );
                        }

                        // Get data from the controller (fallback to '0' if null)
                        final stats = getstatscontroller.statsData.value;
                        final String totalJobs = stats?.totalJobsCount?.toString() ?? '0';
                        final String totalCompanies = stats?.totalTrackingCompaniesCount?.toString() ?? '0';

                        return Center(
                          child: Container(
                            width: double.infinity,
                            color: AppColors.appBg1,
                            padding: EdgeInsets.symmetric(vertical: sh * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _StatItem(
                                  // real data for companies
                                  value: '$totalCompanies+',
                                  label: 'Companies',
                                  valueColor: AppColors.darkRed,
                                ),
                                SizedBox(width: sh * 0.07),
                                _StatItem(
                                  // real data for jobs
                                  value: '$totalJobs+',
                                  label: 'Jobs',
                                  valueColor: AppColors.darkRed,
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                    else
                      Obx(() {
                        // ── First-page loading spinner ─────────────────
                        if (getjobcontroller.isLoading.value) {
                          return Padding(
                            padding: EdgeInsets.only(top: sh * 0.1),
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.buttonPrimary),
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Results header ─────────────────────────
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  sw * 0.05, 18, sw * 0.05, 4),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'We found ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        TextSpan(
                                          // ✅ Real total from API
                                          text:
                                          '${getjobcontroller.totalResults.value}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.darkRed,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: ' Matches\nfor you.',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (_) => FilterBottomSheet(
                                          currentFilter:
                                          controller.filter.value,
                                          onApply: controller.applyFilter,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.border),
                                      ),
                                      child: Obx(() {
                                        final count =
                                            controller.activeFilterCount;
                                        return Row(
                                          children: [
                                            Icon(
                                              Icons.filter_list_rounded,
                                              size: 16,
                                              color: count > 0
                                                  ? AppColors.buttonPrimary
                                                  : AppColors.textPrimary,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              count > 0
                                                  ? 'Filters ($count)'
                                                  : 'Filters',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: count > 0
                                                    ? AppColors.buttonPrimary
                                                    : AppColors.textPrimary,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ✅ Page indicator  e.g. "Showing 20 of 602"
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  sw * 0.05, 2, sw * 0.05, 8),
                              child: Obx(() => Text(
                                'Showing ${getjobcontroller.alljobs.length} '
                                    'of ${getjobcontroller.totalResults.value}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              )),
                            ),

                            // ── Job cards ──────────────────────────────
                            Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: sw * 0.04),
                              itemCount:
                              getjobcontroller.alljobs.length,
                              itemBuilder: (_, i) {
                                final job =
                                getjobcontroller.alljobs[i];
                                return JobCard(
                                  job: job,
                                  onTap: () => controller
                                      .navigateToJobDetail(job),
                                );
                              },
                            )),

                            // ✅ Bottom: paginating spinner OR end message
                            Obx(() {
                              if (getjobcontroller.isPaginating.value) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.buttonPrimary),
                                  ),
                                );
                              }

                              if (!getjobcontroller.hasMore &&
                                  getjobcontroller.alljobs.isNotEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20),
                                  child: Center(
                                    child: Text(
                                      '✓ All jobs loaded',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return const SizedBox(height: 24);
                            }),
                          ],
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// ── Stat item ─────────────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _StatItem({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ── Side Drawer ───────────────────────────────────────────────────────────────

class _SideDrawer extends StatelessWidget {
  final DashboardController controller;
  const _SideDrawer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Obx(() {
                    final initial = controller.userName.value.isNotEmpty
                        ? controller.userName.value[0].toUpperCase()
                        : 'U';
                    return Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: AppColors.darkRed,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          initial,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userName.value,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          controller.userEmail.value,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close,
                        color: AppColors.textSecondary, size: 22),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: AppColors.border),

            _DrawerItem(
              icon: Icons.speed_outlined,
              label: 'Dashboard',
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.sideDashboard);
              },
            ),
            _DrawerItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.myprofile);
              },
            ),
            _DrawerItem(
              icon: Icons.bookmark_outline_rounded,
              label: 'Saved Jobs',
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.savedJobs);
              },
            ),
            _DrawerItem(
              icon: Icons.description_outlined,
              label: 'My Resume',
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.myresume);
              },
            ),
            _DrawerItem(
              icon: Icons.search_rounded,
              label: 'Search',
              onTap: () => Navigator.of(context).pop(),
            ),

            const Divider(height: 1, color: AppColors.border),

            _DrawerItem(
              icon: Icons.logout_rounded,
              label: 'Logout',
              labelColor: AppColors.textRed,
              iconColor: AppColors.textRed,
              onTap: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Drawer item ───────────────────────────────────────────────────────────────

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;
  final Color labelColor;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = AppColors.textPrimary,
    this.labelColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
