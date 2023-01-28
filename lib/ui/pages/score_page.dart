import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/bloc/score/score_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;
    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      if (state is ScoreLoadedState) {
        return _scoresLoaded(context, state, localizer);
      }
      return _scoresLoading(context);
    });
  }
}

Widget _scoresLoading(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _scoresLoaded(
    BuildContext context, ScoreLoadedState state, AppLocalizations localizer) {
  return Column(
    children: [
      const SizedBox(height: 24),
      DataTable(
        columns: [
          DataColumn(
              label: Text(localizer.ranking,
                  style: const TextStyle(fontStyle: FontStyle.italic))),
          DataColumn(
              label: Text(localizer.username,
                  style: const TextStyle(fontStyle: FontStyle.italic))),
          DataColumn(
              label: Text(localizer.score,
                  style: const TextStyle(fontStyle: FontStyle.italic))),
        ],
        rows: state.scores.map(
          ((element) {
            var index = state.scores.indexOf(element) + 1;
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(index.toString())),
                DataCell(Text(element.username)),
                DataCell(Text(element.score.toString())),
              ],
            );
          }),
        ).toList(),
      ),
    ],
  );
}
