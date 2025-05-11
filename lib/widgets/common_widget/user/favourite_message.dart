import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../common/color_extention.dart';
import '../../common/color_extentionn.dart';

class FavouriteMessageCard extends StatelessWidget {
  final RxMap<dynamic, dynamic> userData;

  const FavouriteMessageCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final favouriteMessages = userData['email'];

    print("Dữ liệu favouriteMessages trong FavouriteMessageCard: $favouriteMessages");

    if (favouriteMessages == null || favouriteMessages.isEmpty) {
      return const Center(
        child: Text(
          'Không có tin nhắn yêu thích.2',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return Card(
      color: ChatColor.gray1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tin nhắn yêu thích',
              style: TextStyle(
                color: ChatColor.almond,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favouriteMessages.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white24,
                thickness: 0.5,
              ),
              itemBuilder: (context, index) {
                final message = favouriteMessages[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message.toString(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}