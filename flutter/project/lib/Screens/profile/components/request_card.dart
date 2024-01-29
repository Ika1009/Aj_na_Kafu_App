import 'package:flutter/material.dart';
import 'package:project/models/request_tile.dart';

import '../../../constants.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key? key,
    required this.request,
  }) : super(key: key);

  final FriendRequest request;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                      backgroundImage: NetworkImage(request.image),
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
                          request.username,
                          style:
                              const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Opacity(
                          opacity: 0.64,
                          child: Text(
                            request.fullName,
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
                GestureDetector(
                  onTap: () {

                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: const Icon(
                    Icons.check,
                    color: secondaryColor,
                    size: 24,
                  ),
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
