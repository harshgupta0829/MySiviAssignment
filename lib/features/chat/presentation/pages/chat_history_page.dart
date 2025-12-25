import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import '../providers/chat_history_provider.dart';
import '../pages/chat_screen.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({super.key});

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ChatHistoryProvider>(
      builder: (context, provider, child) {
        final sessions = provider.sessions;
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: sessions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final session = sessions[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(user: session.user),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          child: Text(
                            session.user.initials,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        if (session.unreadCount > 0)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                session.unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                session.user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                _formatTime(session.lastMessageTime),
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTapUp: (details) {},
                            child: Wrap(
                              spacing: 3,
                              children: session.lastMessage.split(' ').map((
                                word,
                              ) {
                                return GestureDetector(
                                  onTap: () => _showMeaning(context, word),
                                  child: Text(
                                    word,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    if (DateTime.now().difference(time).inDays < 1) {
      return DateFormat.jm().format(time);
    }
    return DateFormat.MMMd().format(time);
  }

  void _showMeaning(BuildContext context, String word) async {
    final cleanWord = word.replaceAll(RegExp(r'[^\w\s]'), '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(24),
        child: FutureBuilder(
          future: Dio().get(
            "https://api.dictionaryapi.dev/api/v2/entries/en/$cleanWord",
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Definition not found for '$cleanWord'"),
              );
            }

            final data = snapshot.data?.data as List?;
            if (data == null || data.isEmpty) {
              return Center(
                child: Text("Definition not found for '$cleanWord'"),
              );
            }

            final firstEntry = data[0];
            final meanings = firstEntry['meanings'] as List?;
            final definition =
                meanings?[0]['definitions']?[0]['definition'] ??
                "No definition found.";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cleanWord,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Divider(),
                const SizedBox(height: 12),
                Text(definition, style: Theme.of(context).textTheme.bodyLarge),
              ],
            );
          },
        ),
      ),
    );
  }
}
