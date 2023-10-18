import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/ui/component/component_input.dart';
import 'package:flutter_chrome_app/ui/screen/add_candidate/add_candidate_controller.dart';
import 'package:flutter_chrome_app/utils/profile_parser.dart';
import 'package:get/get.dart';

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
              ComponentInput(
                label: 'Address',
                controller: controller.addressController,
              ),
              const SizedBox(
                height: 16,
              ),
              ComponentInput(
                label: 'Linkedin link*',
                controller: controller.linkedinUrl,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 2,
                    child: ComponentInput(
                      label: 'Work experience',
                      controller: controller.workExperience,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 1,
                    child: ComponentInput(
                      label: 'Year',
                      controller: controller.yearExperience,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF5D25FD),
                    child: IconButton(
                      onPressed: () {
                        //if have a same role, remove it
                        if (controller.isEdit) {
                          controller.roles.removeWhere((element) => element.name == controller.workExperience.text);
                          controller.isEdit = false;
                        }
                        var role = Role(controller.workExperience.text,
                            DurationModel(year: int.parse(controller.yearExperience.text), month: 0));
                        controller.roles.add(role);
                        controller.roles.refresh();
                        controller.workExperience.clear();
                        controller.yearExperience.clear();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
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
                                  controller.workExperience.text = e.name;
                                  controller.yearExperience.text = e.duration.year.toString();
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xFF5D25FD),
                                ),
                              ),
                              Chip(
                                label: Text(e.getTextDisplay()),
                                onDeleted: () {
                                  controller.roles.remove(e);
                                },
                              ),
                            ],
                          ),
                        )
                        .toList());
              }),
              const SizedBox(
                height: 16,
              ),
              ComponentInput(
                  label: 'Skills',
                  controller: controller.skill,
                  customSuffixWidget: IconButton(
                    onPressed: () {
                      controller.skills.add(controller.skill.text);
                      controller.skills.refresh();
                      controller.skill.clear();
                    },
                    icon: const Icon(Icons.add),
                  )),
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
                            label: Text(e),
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
