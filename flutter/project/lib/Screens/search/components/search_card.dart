import 'package:flutter/material.dart';
import 'package:project/models/search_tile.dart';

import '../../../constants.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
    required this.search,
    required this.press,
  }) : super(key: key);

  final Search search;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.5),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(search.image),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          search.username,
                          style:
                              const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Opacity(
                          opacity: 0.64,
                          child: Text(
                            search.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                              const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: accentColor,
                  size: 24,
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
            thickness: 0.2,
            indent: 24,
            endIndent: 24,
            color: Color(0xFF757575),
          ),
        ],
      ),
    );
  }
}
