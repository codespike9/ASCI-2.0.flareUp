import 'package:flutter/material.dart';
import 'package:flutter_flareup/start-Up/widgets/common_formfield.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateBuisness extends StatefulWidget {
  const UpdateBuisness({super.key, required this.id});
  final int id;

  @override
  State<UpdateBuisness> createState() => _UpdateBuisness();
}

class _UpdateBuisness extends State<UpdateBuisness> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _lastMonthRevenueController =
      TextEditingController();
  final TextEditingController _secondLastMonthRevenueController =
      TextEditingController();
  final TextEditingController _thirdLastMonthRevenueController =
      TextEditingController();
  final TextEditingController _lastYearRevenueController =
      TextEditingController();

  String _abstractFilePath = '';

  Future<void> _pickAbstractFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _abstractFilePath = file.path ?? '';
      });
    }
  }

  Future<void> _UpdateForm() async {
    final buisnessid = widget.id;
    
    if (_formKey.currentState!.validate()) {
      final uri = Uri.parse(
          'http://dharmarajjena.pythonanywhere.com/api/updateCompany/$buisnessid');

      final request = http.MultipartRequest('PATCH', uri);

      request.fields['description'] = _descriptionController.text;
      request.fields['link'] = _linkController.text;
      request.fields['last_month_revenue'] = _lastMonthRevenueController.text;
      request.fields['second_last_month_revenue'] =
          _secondLastMonthRevenueController.text;
      request.fields['third_last_month_revenue'] =
          _thirdLastMonthRevenueController.text;
      request.fields['last_year_revenue'] = _lastYearRevenueController.text;

      if (_selectedImage != null) {
        // Add the image file to the request
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            _selectedImage!.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      if (_abstractFilePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'abstract',
          _abstractFilePath,
          contentType: MediaType('application', 'pdf'),
        ));
      }

      final response = await request.send();
      
      print(buisnessid);
      if (response.statusCode == 200) {
        print("Form Updation successful");

        const snackBar = SnackBar(
          content: Text('Update Succesful!!'),
          backgroundColor: Color.fromARGB(223, 19, 192, 108),
          duration: Duration(seconds: 5),
        );
        if (!context.mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.of(context).pop();
        // Handle successful submission
      } else {
        print("Form Updation unsuccessful : ${response.statusCode}");
        // Handle unsuccessful submission
      }
    }
  }

  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 300,
    );

    if (pickedImageFile != null) {
      setState(() {
        _selectedImage = File(pickedImageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey), // Add a border for visual clarity
                  ),
                  child: _selectedImage == null
                      ? const Center(
                          child: Text(
                            'Select Logo Of Your Company',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      : Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(
                    Icons.image,
                    color: Color.fromARGB(255, 101, 0, 118),
                  ),
                  label: const Text(
                    'Add Image',
                    style: TextStyle(
                      color: Color.fromARGB(255, 101, 0, 118),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Description',
                  hintText: 'Enter the description',
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Link',
                  hintText: 'Enter the link',
                  controller: _linkController,
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Abstract (PDF)',
                  hintText: 'Choose an abstract PDF',
                  controller: TextEditingController(text: _abstractFilePath),
                  prefixIcon: Icons.attach_file,
                  readOnly: true,
                ),
                ElevatedButton(
                  onPressed: _pickAbstractFile,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Pick Abstract PDF'),
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Last Month Revenue',
                  hintText: 'Enter the revenue',
                  controller: _lastMonthRevenueController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Second Last Month Revenue',
                  hintText: 'Enter the revenue',
                  controller: _secondLastMonthRevenueController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Third Last Month Revenue',
                  hintText: 'Enter the revenue',
                  controller: _thirdLastMonthRevenueController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Last Year Revenue',
                  hintText: 'Enter the revenue',
                  controller: _lastYearRevenueController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _UpdateForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(208, 176, 85, 241),
                    // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
