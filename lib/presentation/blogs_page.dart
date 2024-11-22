import 'package:colin_hanbury_frontend/bloc/blogs/blogs_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/blogs/blogs_event.dart';
import 'package:colin_hanbury_frontend/bloc/blogs/blogs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<StatefulWidget> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          'Blogs',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250.0),
              child: SearchBar(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.secondaryContainer),
                hintText: 'Search blogs',
                hintStyle: WidgetStateProperty.all(
                  TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                trailing: [
                  Icon(
                    Icons.search_outlined,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: _blogs(),
    );
  }

  Widget _blogs() {
    return BlocBuilder<BlogsBLoC, BlogsState>(
      builder: (context, state) {
        switch (state.status) {
          case BlogsStatus.successful:
            return Expanded(
              child: ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.blogs[index].title ?? ''),
                    subtitle: Text(
                      state.blogs[index].date.toString(),
                    ),
                  );
                },
              ),
            );
          default:
            context.read<BlogsBLoC>().add(
                  LoadBlogs(),
                );
            return const Center(
              child: Text('No blogs to show'),
            );
        }
      },
    );
  }
}
