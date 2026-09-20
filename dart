import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Form',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xfff5f6fa),
      ),
      home: const StudentFormPage(),
    );
  }
}

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final registrationController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();

  String? bloodGroup;
  String? gender;

  Map<String, String>? studentData;

  void submitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select gender'),
        ),
      );
      return;
    }

    setState(() {
      studentData = {
        'Name': nameController.text,
        'Roll': rollController.text,
        'Registration': registrationController.text,
        'Blood Group': bloodGroup!,
        'Gender': gender!,
        'Phone': phoneController.text,
        'About Me': aboutController.text,
      };

      nameController.clear();
      rollController.clear();
      registrationController.clear();
      phoneController.clear();
      aboutController.clear();

      bloodGroup = null;
      gender = null;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    registrationController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  InputDecoration fieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.indigo),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.indigo,
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Form'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Student Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Please fill up the form below',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: nameController,
                decoration: fieldDecoration(
                  'Name',
                  Icons.person,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: rollController,
                      decoration: fieldDecoration(
                        'Roll',
                        Icons.numbers,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter roll';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: registrationController,
                      decoration: fieldDecoration(
                        'Registration',
                        Icons.badge,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter registration';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: bloodGroup,
                decoration: fieldDecoration(
                  'Blood Group',
                  Icons.bloodtype,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'A+',
                    child: Text('A+'),
                  ),
                  DropdownMenuItem(
                    value: 'A-',
                    child: Text('A-'),
                  ),
                  DropdownMenuItem(
                    value: 'B+',
                    child: Text('B+'),
                  ),
                  DropdownMenuItem(
                    value: 'B-',
                    child: Text('B-'),
                  ),
                  DropdownMenuItem(
                    value: 'AB+',
                    child: Text('AB+'),
                  ),
                  DropdownMenuItem(
                    value: 'AB-',
                    child: Text('AB-'),
                  ),
                  DropdownMenuItem(
                    value: 'O+',
                    child: Text('O+'),
                  ),
                  DropdownMenuItem(
                    value: 'O-',
                    child: Text('O-'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    bloodGroup = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Select blood group';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 18),

              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: fieldDecoration(
                  'Phone Number',
                  Icons.phone,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter phone number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: aboutController,
                maxLines: 4,
                decoration: fieldDecoration(
                  'About Me',
                  Icons.info_outline,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Write something about yourself';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              if (studentData != null) ...[
                const SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo.shade100,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Submitted Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...studentData!.entries.map(
                            (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${item.key}: ${item.value}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
