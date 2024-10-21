import 'package:colin_hanbury_frontend/bloc/associates/associates_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/associates/associates_event.dart';
import 'package:colin_hanbury_frontend/bloc/associates/associates_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssociatesPage extends StatefulWidget {
  const AssociatesPage({super.key});

  @override
  State<StatefulWidget> createState() => _AssociatesPageState();
}

class _AssociatesPageState extends State<AssociatesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text('Associates'),
        ),
        actions: const [SearchBar()],
      ),
      body: _associates(),
    );
  }

  Widget _associates() {
    return BlocBuilder<AssociatesBLoC, AssociatesState>(
      builder: (context, state) {
        switch (state.status) {
          case AssociatesStatus.successful:
            return Expanded(
              child: ListView.builder(
                itemCount: state.associates.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.associates[index].name ?? ''),
                    subtitle: Text(
                      state.associates[index].date.toString(),
                    ),
                  );
                },
              ),
            );
          default:
            context.read<AssociatesBLoC>().add(
                  LoadAssociates(),
                );
            return const Text('No associates');
        }
      },
    );
  }
}
