
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../Controller/Dashboard_Controller.dart';
import '../Controller/Get_Job_Controller.dart';
import '../Controller/Get_stats_Controller.dart';
import '../model/job_model/job_Filter.dart';
import 'widget/filter_sheet.dart';
import 'widget/job_card.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _scaffoldKey   = GlobalKey<ScaffoldState>();
  final _scrollCtrl    = ScrollController();        // ✅ for infinite scroll

  bool _hasSearched = false;
  DateTime? _lastPressedAt;
  String _lastSearchText = '';
  String _lastLocationText = '';

  Future<void> _handleBackPress() async {
    final hasSearch = controller.searchCtrl.text.isNotEmpty;
    final hasLocation = controller.locationCtrl.text.isNotEmpty;
    final hasFilter = controller.filter.value.activeCount > 0;

    if (hasSearch || hasLocation || hasFilter || _hasSearched) {
      FocusScope.of(context).unfocus();
      controller.searchCtrl.clear();
      controller.locationCtrl.clear();
      controller.filter.value = JobFilter();
      getjobcontroller.alljobs.clear();
      getjobcontroller.totalResults.value = 0;
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.jumpTo(0);
      }
      setState(() {
        _hasSearched = false;
      });
      return;
    }

    final now = DateTime.now();
    if (_lastPressedAt == null || now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'If you press back button again you will be exiting the app',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.darkRed,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    await SystemNavigator.pop();
  }

  final GetAllJobsController getjobcontroller = Get.put(GetAllJobsController());
  final GetStatsController getstatscontroller = Get.put(GetStatsController());
  late final DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<DashboardController>();
    controller.loadUser();
    getstatscontroller.fetchStats();
    _lastSearchText = controller.searchCtrl.text;
    _lastLocationText = controller.locationCtrl.text;

    // Reset to home when search bar is cleared
    controller.searchCtrl.addListener(() {
      final newText = controller.searchCtrl.text;
      if (newText != _lastSearchText) {
        _lastSearchText = newText;
        if (controller.filter.value.activeCount > 0) {
          controller.filter.value = JobFilter();
        }
      }

      if (controller.searchCtrl.text.isEmpty &&
          controller.locationCtrl.text.isEmpty &&
          _hasSearched) {
        setState(() => _hasSearched = false);
      }
    });
    controller.locationCtrl.addListener(() {
      final newText = controller.locationCtrl.text;
      if (newText != _lastLocationText) {
        _lastLocationText = newText;
        if (controller.filter.value.activeCount > 0) {
          controller.filter.value = JobFilter();
        }
      }

      if (controller.searchCtrl.text.isEmpty &&
          controller.locationCtrl.text.isEmpty &&
          _hasSearched) {
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
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _search() {
    FocusScope.of(context).unfocus();

    if (controller.searchCtrl.text.trim().isEmpty &&
        controller.locationCtrl.text.trim().isEmpty) {
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

  String _getUserInitial() {
    final name = controller.userName.value.trim();
    if (name.isEmpty || name.toLowerCase() == 'there' || name.toLowerCase() == 'guest') {
      return 'U';
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPress();
      },
      child: Obx(() => Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBg1,
      endDrawer: controller.isLoggedIn.value
          ? _SideDrawer(controller: controller)
          : null,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ────────────────────────────────────────────────
            Container(
              height: 70,
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.05, vertical: 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      controller.searchCtrl.clear();
                      controller.locationCtrl.clear();
                      controller.filter.value = JobFilter();
                      getjobcontroller.alljobs.clear();
                      getjobcontroller.totalResults.value = 0;
                      if (_scrollCtrl.hasClients) {
                        _scrollCtrl.jumpTo(0);
                      }
                      setState(() {
                        _hasSearched = false;
                      });
                    },
                    child: Image.asset(
                      'assets/logo.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                  Obx(() {
                    if (controller.isLoggedIn.value) {
                      return GestureDetector(
                        onTap: () =>
                            _scaffoldKey.currentState?.openEndDrawer(),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: CircleAvatar(
                            backgroundColor: AppColors.darkRed,
                            child: Text(
                              _getUserInitial(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
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
                              minimumSize: const Size(80, 30),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
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
                              minimumSize: const Size(80, 30),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 12,
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
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: AppColors.darkRed,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Obx(() {
                                      final total = getstatscontroller.statsData2.value?.totalJobsScraped;
                                      final String totalJobsStr = total != null
                                          ? total.toString()
                                          : '...'; // shows '...' while loading, real number after

                                      return Text(
                                        'Over $totalJobsStr+ jobs added this week',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      );
                                    }),
                                    // Obx(() {
                                    //   final stats = getstatscontroller.statsData.value;
                                    //   final String totalJobsStr = stats?.totalJobsCount?.toString() ?? '14,000';
                                    //   return Text(
                                    //     'Over $totalJobsStr+ jobs added this week',
                                    //     style: const TextStyle(
                                    //       fontSize: 13,
                                    //       fontWeight: FontWeight.w500,
                                    //       color: AppColors.black,
                                    //     ),
                                    //   );
                                    // }),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Find Jobs Faster with ',
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'AI',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.darkRed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: sh * 0.02),
                            const Center(
                              child: Text(
                               'Stop jumping between career pages. Discover top company jobs in one place instantly matched to your skills.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            SizedBox(height: sh * 0.05),
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
                                    prefixIcon: Icon(Icons.search,
                                        color: AppColors.textHint,
                                        size: 30),
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
                                if (_hasSearched) ...[
                                  const SizedBox(height: 4),
                                  TextField(
                                    controller: controller.locationCtrl,
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
                                      prefixIcon: Icon(
                                          Icons.location_on_outlined,
                                          color: AppColors.textHint,
                                          size: 30),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 40, minHeight: 40),
                                      border: InputBorder.none,
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 12),
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

                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: sw * 0.05, vertical: sh * 0.02),
                          padding: EdgeInsets.symmetric(vertical: sh * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '$totalJobs+',
                                  style: const TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.darkRed,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Jobs',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
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

                        if (getjobcontroller.alljobs.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(top: sh * 0.08),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'No jobs found in this location/type',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Try adjusting your search query, location, or filters.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
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
      )),
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

            // _DrawerItem(
            //   icon: Icons.speed_outlined,
            //   label: 'Dashboard',
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Get.toNamed(AppRoutes.sideDashboard);
            //   },
            // ),
            _DrawerItem(
              svgAsset: 'assets/speedometer2.svg',
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
              icon: Icons.bookmark,
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
            _DrawerItem(
              icon: Icons.info_outline, // Swapped to an 'info' icon which fits 'About Us' perfectly
              label: 'About Us',
              onTap: () {
                Navigator.of(context).pop(); // Close drawer first
                _showAboutUsDialog(context); // Launch the About Us dialog
              },
            ),

<<<<<<< HEAD

            // const Divider(height: 1, color: AppColors.border),
=======
            _DrawerItem(
              icon: Icons.info_outline, // Swapped to an 'info' icon which fits 'About Us' perfectly
              label: 'About Us',
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.aboutus);
              },
            ),

>>>>>>> eb0ad95112169f3e86e4b68975156b22fc771994

            // In your Drawer - update the DrawerItem

            _DrawerItem(
              icon: Icons.delete_outline_rounded, // more appropriate icon
              label: 'Delete Account',
              onTap: () {
                Navigator.of(context).pop(); // close drawer first
                showDeleteAccountConfirmation(context,DashboardController()); // then show dialog
              },
            ),

            const Divider(height: 1, color: AppColors.border),

<<<<<<< HEAD
=======

>>>>>>> eb0ad95112169f3e86e4b68975156b22fc771994

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

// Confirmation dialog - add this helper in your controller or a utils file

  void showDeleteAccountConfirmation(BuildContext context,DashboardController dashboardcontroller) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Delete Account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cancel - just close dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close dialog first
                dashboardcontroller.deleteAccount();                   // Then call API
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


// Helper widget to generate clickable hyperlinks
Widget _buildHyperlink({required String label, required String linkText, required String url}) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 14),
      children: [
        TextSpan(text: label),
        TextSpan(
          text: linkText,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final Uri uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            },
        ),
      ],
    ),
  );
}

// ── Drawer item ───────────────────────────────────────────────────────────────

class _DrawerItem extends StatelessWidget {
  final IconData? icon;
  final String? svgAsset;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;
  final Color labelColor;

  const _DrawerItem({
    super.key,
    this.icon,
    this.svgAsset,
    required this.label,
    required this.onTap,
    this.iconColor = AppColors.black,
    this.labelColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          children: [
            svgAsset != null
                ? SvgPicture.asset(
              svgAsset!,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
            )
                : Icon(
              icon,
              size: 22,
              color: iconColor,
            ),
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