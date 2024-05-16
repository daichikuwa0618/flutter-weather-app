import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              // NOTE: [_ForecastContent] を上下中央に表示するために
              //       [flex: 1] を設定してある [Spacer] および [Expanded] で挟んでいる。
              //       [Column] に要素を追加すると上下中央のレイアウトが崩れるため注意。
              Spacer(),
              _ForecastContent(),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: _ButtonsRow(),
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

class _ForecastContent extends StatelessWidget {
  const _ForecastContent();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const AspectRatio(aspectRatio: 1, child: Placeholder(),),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '** ℃',
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge?.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '** ℃',
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ButtonsRow extends StatelessWidget {
  const _ButtonsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Close',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Reload',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
