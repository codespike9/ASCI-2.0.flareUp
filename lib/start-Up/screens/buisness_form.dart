import 'package:flutter/material.dart';
import 'package:flutter_flareup/start-Up/widgets/common_formfield.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BuisnessFormScreen extends StatefulWidget {
  static const String routeName = '/buisness-form-screen';
  const BuisnessFormScreen({super.key, required this.authToken});
  final String authToken;

  @override
  State<BuisnessFormScreen> createState() => _BuisnessFormScreenState();
}

class _BuisnessFormScreenState extends State<BuisnessFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _businessStageController =
      TextEditingController();
  final TextEditingController _industryCategoryController =
      TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
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
  //final TextEditingController _raisingAmountController =  TextEditingController();
  final TextEditingController _equityController = TextEditingController();
  //final TexteditingController _valuationController = TextEditingController();
  //final TextEditingController _quantityAvailableController =TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

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

  Future<void> _submitForm() async {
    final authToken = widget.authToken;
    if (_formKey.currentState!.validate()) {
      final uri =
          Uri.parse('http://dharmarajjena.pythonanywhere.com/api/company/');

      print(authToken);

      final request = http.MultipartRequest('POST', uri);
      request.headers['Token'] = authToken;
      // request.headers['Access-Control-Allow-Credentials'] = 'true';
      request.headers['Content-Type'] = 'application/json';

      request.fields['business_stage'] = _businessStageController.text;
      request.fields['industry_category'] = _industryCategoryController.text;
      request.fields['companyName'] = _companyNameController.text;
      request.fields['description'] = _descriptionController.text;
      request.fields['link'] = _linkController.text;
      request.fields['last_month_revenue'] = _lastMonthRevenueController.text;
      request.fields['second_last_month_revenue'] =
          _secondLastMonthRevenueController.text;
      request.fields['third_last_month_revenue'] =
          _thirdLastMonthRevenueController.text;
      request.fields['last_year_revenue'] = _lastYearRevenueController.text;
      request.fields['equity'] = _equityController.text;
      request.fields['category'] = _categoryController.text;

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

      if (response.statusCode == 201) {
        print("Form submission successful");

        if (!context.mounted) {
          return;
        }

        Navigator.of(context).pop();
        // Handle successful submission
      } else {
        print("Form submission unsuccessful : ${response.statusCode}");
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
                CommonTextField(
                  labelText: 'Business Stage',
                  hintText: 'Enter the business stage',
                  controller: _businessStageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Industry Category',
                  hintText: 'Enter the industry category',
                  controller: _industryCategoryController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Company Name',
                  hintText: 'Enter the company name',
                  controller: _companyNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
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
                CommonTextField(
                  labelText: 'Equity',
                  hintText: 'Enter the equity',
                  controller: _equityController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  labelText: 'Category',
                  hintText: 'Enter the category',
                  controller: _categoryController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
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
                    'Register',
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
