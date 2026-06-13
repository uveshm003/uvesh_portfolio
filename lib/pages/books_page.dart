import 'package:flutter/material.dart';

import '../sections/books_section.dart';
import '../widgets/page_scaffold.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      title: 'Books',
      lead: 'Books that shaped how I think about software and craft.',
      child: BooksContent(),
    );
  }
}
