import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/target_controller.dart';
import '../theme/theme_controller.dart';
import 'package:intl/intl.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  final TargetController controller =
      Get.find();

  final ThemeController
      themeController = Get.find();

  DateTime focusedDay =
      DateTime.now();

  DateTime selectedDay =
      DateTime.now();

  CalendarFormat format =
      CalendarFormat.month;

  bool modeMinggu = false;

  String getLabel(DateTime date) {

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final d = DateTime(
      date.year,
      date.month,
      date.day,
    );

    final diff =
        d.difference(today).inDays;

    if (diff == 0) return "Hari ini";
    if (diff == 1) return "Besok";
    if (diff == 2) return "Lusa";

    if (diff > 0 && diff < 7) {
      return "$diff hari lagi";
    }

    if (diff >= 7 && diff < 30) {
      final m = (diff / 7).floor();
      return "$m minggu lagi";
    }

    if (diff < 0) {
      return DateFormat(
        "EEEE",
        "id",
      ).format(date);
    }

    return DateFormat(
      "d MMMM yyyy",
      "id",
    ).format(date);
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Target Belajar"),
        actions: [
          IconButton(
            icon: Icon(
                Icons
                    .brightness_6),
            onPressed:
                themeController
                    .toggleTheme,
          )
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(
              top: 6,
              bottom: 6,
            ),

            child: ToggleButtons(
              borderRadius:
                  BorderRadius.circular(
                      18),
              constraints:
                  const BoxConstraints(
                minHeight: 32,
                minWidth: 70,
              ),

              isSelected: [
                !modeMinggu,
                modeMinggu,
              ],

              onPressed: (index) {
                setState(() {
                  if (index == 0) {
                    format =
                        CalendarFormat
                            .month;
                    modeMinggu =
                        false;
                  } else {
                    format =
                        CalendarFormat
                            .week;
                    modeMinggu =
                        true;
                  }
                });
              },

              children: const [
                Padding(
                  padding:
                      EdgeInsets.symmetric(
                          horizontal:
                              10),
                  child:
                      Text("Bulan"),
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(
                          horizontal:
                              10),
                  child:
                      Text("Minggu"),
                ),
              ],
            ),
          ),

          TableCalendar(
            firstDay:
                DateTime(2000),
            lastDay:
                DateTime(2100),
            focusedDay:
                focusedDay,
            calendarFormat:
                format,
            headerStyle:
                HeaderStyle(
              formatButtonVisible:
                  false,
            ),

            selectedDayPredicate:
                (day) =>
                    isSameDay(
              selectedDay,
              day,
            ),

            onDaySelected:
                (selected,
                    focused) {
              setState(() {
                selectedDay =
                    selected;
                focusedDay =
                    focused;
              });
            },

            onPageChanged:
                (focused) {
              setState(() {
                focusedDay =
                    focused;
              });
            },
          ),

          const SizedBox(
              height: 8),

          Expanded(
            child: Obx(() {
              if (controller
                  .isLoading
                  .value) {
                return Center(
                  child:
                      CircularProgressIndicator(),
                );
              }

              final data =
                  controller.targets
                      .where((t) {

                if (modeMinggu) {
                  return t.deadline
                              .weekOfYear ==
                          focusedDay
                              .weekOfYear &&
                      t.deadline
                              .year ==
                          focusedDay
                              .year;
                }

                return t.deadline
                            .month ==
                        focusedDay
                            .month &&
                    t.deadline
                            .year ==
                        focusedDay
                            .year;
              }).toList()

                    ..sort(
                      (a, b) =>
                          a.deadline
                              .compareTo(
                                  b.deadline),
                    );

              final belum =
                  data
                      .where(
                          (e) =>
                              !e
                                  .selesai)
                      .toList();

              final selesai =
                  data
                      .where(
                          (e) =>
                              e.selesai)
                      .toList();

              Map<DateTime,
                      List>
                  grouped = {};

              for (var t
                  in belum) {

                final d =
                    DateTime(
                  t.deadline.year,
                  t.deadline.month,
                  t.deadline.day,
                );

                grouped
                    .putIfAbsent(
                        d,
                        () => []);

                grouped[d]!
                    .add(t);
              }

              final keys =
                  grouped.keys
                      .toList()
                    ..sort();

              return ListView(

                children: [
                  ...keys.map(
                    (date) {
                      final list =
                          grouped[
                              date]!;

                      return Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Padding(
                            padding:
                                EdgeInsets
                                    .all(
                                        8),

                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [
                                Text(
                                  getLabel(
                                      date),
                                  style:
                                      TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),

                                Text(
                                  DateFormat(
                                          "d MMM yyyy",
                                          "id")
                                      .format(
                                          date),
                                ),
                              ],
                            ),
                          ),

                          ...list.map(
                            (item) {
                              return Card(
                                child:
                                    ListTile(
                                  leading:
                                      GestureDetector(
                                    onTap: () =>
                                        controller
                                            .toggleSelesai(
                                                item),
                                    child:
                                        Icon(
                                      item.selesai
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                    ),
                                  ),
                                  title: Text(
                                      item
                                          .mataKuliah),
                                  subtitle:
                                      Text(
                                    item
                                        .target,
                                  ),
                                  trailing:
                                      IconButton(
                                    icon:
                                        Icon(
                                            Icons.edit),

                                    onPressed:
                                        () {
                                      Get.to(
                                        () =>
                                            FormPage(
                                          target:
                                              item,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),

                  if (selesai
                      .isNotEmpty)
                    Padding(
                      padding:
                          EdgeInsets
                              .all(
                                  8),
                      child: Text(
                        "Selesai",
                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),

                  ...selesai.map(
                    (item) {

                      return Card(
                        color: Colors
                            .grey
                            .withOpacity(
                                0.2),

                        child:
                            ListTile(
                          leading:
                              GestureDetector(
                            onTap: () =>
                                controller
                                    .toggleSelesai(
                                        item),

                            child:
                                Icon(
                              Icons
                                  .check_circle,
                              color: Colors
                                  .grey,
                            ),
                          ),

                          title: Text(
                            item
                                .mataKuliah,
                            style:
                                TextStyle(
                              color:
                                  Colors.grey,
                              decoration:
                                  TextDecoration
                                      .lineThrough,
                            ),
                          ),

                          subtitle:
                              Text(
                            item.target,
                            style:
                                TextStyle(
                              color:
                                  Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}

extension WeekNumber on DateTime {

  int get weekOfYear {

    final firstDay =
        DateTime(year, 1, 1);

    final diff =
        difference(firstDay)
            .inDays;

    return ((diff +
                firstDay
                    .weekday) /
            7)
        .ceil();
  }
}