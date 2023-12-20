import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/model/duration_model.dart';
import 'package:flutter_chrome_app/model/education_model.dart';
import 'package:flutter_chrome_app/model/location_model.dart';
import 'package:flutter_chrome_app/model/role.dart';
import 'package:flutter_chrome_app/ui/component/component_input.dart';
import 'package:flutter_chrome_app/ui/screen/add_candidate/add_candidate_controller.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import '../../../utils/style/style.dart';

class AddCandidateScreen extends GetWidget<AddCandidateController> {
  const AddCandidateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Candidate'),
        actions: [
          IconButton(
            onPressed: () {
              controller.saveToSharePref();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: Get.height * 0.05),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              ComponentInput(
                label: 'First name *',
                controller: controller.firstNameController,
              ),
              const SizedBox(
                height: 16,
              ),
              ComponentInput(
                label: 'Last name *',
                controller: controller.lastNameController,
              ),
              const SizedBox(
                height: 16,
              ),
              ComponentInput(
                label: 'Email',
                controller: controller.emailController,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ComponentInput(
                      label: 'Phone code',
                      controller: controller.phoneCodeController,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 3,
                    child: ComponentInput(
                      label: 'Phone Number',
                      controller: controller.phoneController,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(() {
                return ComponentDropdown(
                  label: 'Location',
                  items: controller.locationItems,
                  selectedValue: controller.matchLocation.value,
                  onChanged: (value) {
                    controller.matchLocation.value = value;
                  },
                );
              }),
              const SizedBox(
                height: 16,
              ),
              ComponentInput(
                label: 'Linkedin link*',
                controller: controller.linkedinUrl,
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Education',
                    style: TextStyle(
                      color: theme.n800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF5D25FD),
                    child: IconButton(
                      onPressed: () {
                        //if have a same role, remove it
                        if (controller.isEditEdu) {
                          controller.educations.removeWhere((element) => element.schoolName == controller.institution.text);
                          controller.isEditEdu = false;
                        }
                        var education = EducationModel(
                          schoolName: controller.institution.text,
                          degree: controller.degree.text,
                          dateRange: DurationModel(
                            toMonth: int.tryParse(controller.toMonthEdu.text),
                            toYear: int.tryParse(controller.toYearEdu.text),
                            isNew: controller.toYearEdu.text.isEmpty,
                          ),
                        );

                        controller.educations.add(education);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ComponentInput(
                label: 'Institution',
                controller: controller.institution,
              ),
              const SizedBox(height: 8),
              ComponentInput(
                label: 'Degree',
                controller: controller.degree,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    child: ComponentInput(
                      label: 'To',
                      controller: controller.toMonthEdu,
                      hintText: 'Month',
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 1,
                    child: ComponentInput(
                      controller: controller.toYearEdu,
                      hintText: 'Year',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                return Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: controller.educations
                        .map(
                          (e) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.isEditEdu = true;
                              controller.institution.text = e.schoolName ?? '';
                              controller.degree.text = e.degree ?? '';
                              controller.toYearEdu.text = e.dateRange?.toYear?.toString() ?? '';
                              controller.toMonthEdu.text = e.dateRange?.toMonth?.toString() ?? '';
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Color(0xFF5D25FD),
                            ),
                          ),
                          Flexible(
                            child: Chip(
                              label: Text(
                                e.getTextDisplay(),
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                                softWrap: true,
                              ),
                              onDeleted: () {
                                controller.educations.remove(e);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                        .toList());
              }),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Work experience',
                    style: TextStyle(
                      color: theme.n800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF5D25FD),
                    child: IconButton(
                      onPressed: () {
                        //if have a same role, remove it
                        if (controller.isEdit) {
                          controller.roles.removeWhere((element) => element.title == controller.jobTitle.text);
                          controller.isEdit = false;
                        }
                        var role = Role(
                          controller.jobTitle.text,
                          DurationModel(
                            fromMonth: int.tryParse(controller.fromMonth.text),
                            fromYear: int.tryParse(controller.fromYear.text),
                            toMonth: int.tryParse(controller.toMonth.text),
                            toYear: int.tryParse(controller.toYear.text),
                            isNew: controller.toYear.text.isEmpty,
                          ),
                          companyName: controller.companyName.text,
                        );
                        controller.roles.add(role);
                        controller.roles.refresh();
                        controller.jobTitle.clear();
                        controller.fromYear.clear();
                        controller.fromMonth.clear();
                        controller.toYear.clear();
                        controller.toMonth.clear();
                        controller.companyName.clear();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ComponentSearchField(
                label: 'Job title',
                controller: controller.jobTitle,
                suggestions: controller.searchFieldListRoles,
              ),
              const SizedBox(
                height: 8,
              ),
              ComponentInput(
                label: 'Company',
                controller: controller.companyName,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    child: ComponentInput(
                      label: 'From',
                      controller: controller.fromMonth,
                      hintText: 'Month',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 1,
                    child: ComponentInput(
                      controller: controller.fromYear,
                      hintText: 'Year',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 1,
                    child: ComponentInput(
                      label: 'To',
                      controller: controller.toMonth,
                      hintText: 'Month',
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 1,
                    child: ComponentInput(
                      controller: controller.toYear,
                      hintText: 'Year',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                return Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: controller.roles
                        .map(
                          (e) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.isEdit = true;
                                  controller.jobTitle.text = e.title;
                                  controller.fromYear.text = e.duration.fromYear?.toString() ?? '';
                                  controller.fromMonth.text = e.duration.fromMonth?.toString() ?? '';
                                  controller.toYear.text = e.duration.toYear?.toString() ?? '';
                                  controller.toMonth.text = e.duration.toMonth?.toString() ?? '';
                                  controller.companyName.text = e.companyName ?? '';
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xFF5D25FD),
                                ),
                              ),
                              Flexible(
                                child: Chip(
                                  label: Text(
                                    e.getTextDisplay(),
                                    overflow: TextOverflow.visible,
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                  onDeleted: () {
                                    controller.roles.remove(e);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList());
              }),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              ComponentSearchField(
                label: 'Skills',
                controller: controller.skill,
                suggestions: controller.searchFieldListSkills,
                customSuffixWidget: InkWell(
                  onTap: () {
                    controller.skills.add(controller.skill.text);
                    controller.skills.refresh();
                    controller.skill.clear();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.add),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                return Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: controller.skills
                        .map(
                          (e) => Chip(
                            label: Text(
                              e,
                              overflow: TextOverflow.visible,
                              maxLines: 2,
                              softWrap: true,
                            ),
                            onDeleted: () {
                              controller.skills.remove(e);
                            },
                          ),
                        )
                        .toList());
              }),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  controller.addCandidate();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF5D25FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Add candidate',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF5F5F8),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComponentSearchField extends StatelessWidget {
  const ComponentSearchField({
    super.key,
    required this.controller,
    required this.suggestions,
    required this.label,
    this.customSuffixWidget,
  });

  final String label;
  final TextEditingController controller;
  final List<SearchFieldListItem> suggestions;
  final Widget? customSuffixWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.n800,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SearchField(
          controller: controller,
          suggestions: suggestions,
          searchInputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 14, bottom: 14, left: 16),
            errorMaxLines: 5,
            hintStyle: TextStyle(
              fontSize: 14,
              color: theme.n600,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            errorStyle: TextStyle(
              fontSize: 12,
              color: theme.error400,
              fontWeight: FontWeight.w300,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: theme.n300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: theme.n300),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(
                  width: 1,
                  color: theme.error400,
                )),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                width: 1,
                color: theme.error400,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
            suffix: customSuffixWidget,
            fillColor: theme.n000,
          ),
        ),
      ],
    );
  }
}

class ComponentDropdown extends StatelessWidget {
  const ComponentDropdown({
    super.key,
    required this.label,
    required this.items,
    this.selectedValue,
    this.onChanged,
  });

  final String label;
  final List<DropdownMenuItem<LocationModel>> items;
  final LocationModel? selectedValue;
  final Function(LocationModel?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.n800,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.n300),
            color: theme.n000,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<LocationModel>(
              isExpanded: true,
              items: items,
              value: selectedValue,
              onChanged: onChanged,
              buttonStyleData: ButtonStyleData(
                height: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
