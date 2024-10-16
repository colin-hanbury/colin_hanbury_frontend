import 'package:colin_hanbury_frontend/bloc/candidates/candidates_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/candidates/candidates_event.dart';
import 'package:colin_hanbury_frontend/bloc/candidates/candidates_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadidatesPage extends StatefulWidget {
  const CadidatesPage({super.key});

  @override
  State<StatefulWidget> createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CadidatesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text('Candidates'),
        ),
        actions: const [SearchBar()],
      ),
      body: _candidates(),
    );
  }

  Widget _candidates() {
    return BlocBuilder<CandidatesBLoC, CandidatsState>(
      builder: (context, state) {
        switch (state.status) {
          case CandidatesStatus.successful:
            return Expanded(
              child: ListView.builder(
                itemCount: state.visitors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.visitors[index].name ?? ''),
                    subtitle: Text(
                      state.visitors[index].date.toString(),
                    ),
                  );
                },
              ),
            );
          default:
            context.read<CandidatesBLoC>().add(
                  LoadCandidates(),
                );
            return const Text('No visitors');
        }
      },
    );
  }
}
