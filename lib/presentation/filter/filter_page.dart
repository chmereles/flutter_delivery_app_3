import 'package:app_delivery_3/l10n/l10n.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:app_delivery_3/presentation/widgets/custom_button.dart';
import 'package:app_delivery_3/presentation/widgets/rating_widget.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  static String id = 'filter-page';

  @override
  Widget build(BuildContext context) {
    return _BuildBody();
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({Key? key}) : super(key: key);

  Widget _buildCategory(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.filterCategory),
        Row(
          children: [
            CustomButton(
              onPressed: () {},
              child: Text(l10n.filterFood),
            ),
            CustomButton(
              onPressed: () {},
              child: Text(l10n.filterDrinks),
            ),
            CustomButton(
              onPressed: () {},
              child: Text(l10n.filterDessert),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGoups(BuildContext context) {
    return Container();
  }

  Widget _buildRating(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.filterRating),
        Row(
          children: [
            for (var i = 1; i < 6; i++)
              CustomButton(
                onPressed: i == 4 ? () {} : null,
                child: Row(
                  children: [
                    // Text('$i'),
                    RatingStarWidget(
                      rating: i.toDouble(),
                    )
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRange(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.filterPriceRange),
        Row(
          children: [
            for (var i = 1; i < 6; i++)
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                  width: 60,
                  height: 60,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    // primary: lightPrimaryColor,
                  ),
                  child: const Text('122.99'),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: Text('adfadfa'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
        child: Column(
          children: [
            _buildCategory(context),
            _buildGoups(context),
            _buildRating(context),
            _buildPriceRange(context),
          ],
        ),
      ),
    );
  }
}
