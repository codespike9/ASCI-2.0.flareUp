import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});
  static const String routeName = '/investor-blog-page';

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 156, 209, 234), Colors.white]),
              
        ),
        child: const Center(child: Text('Blog-Page'),),
      ),
    );
  }
}
