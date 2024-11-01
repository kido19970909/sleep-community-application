import 'package:intl/intl.dart';

class Post {
  final String title;
  final String? content;
  final String? location;
  final DateTime timestamp;
  final int likesCount;
  final int commentsCount;
  final int views;

  Post({
    required this.title,
    this.content,
    this.location,
    required this.timestamp,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.views = 0,
  });

  Post copyWith({
    String? title,
    String? content,
    String? authorId,
    String? location,
    DateTime? timestamp,
  }) {
    return Post(
      title: title ?? this.title,
      content: content,
      location: location ?? this.location,
      timestamp: timestamp ?? this.timestamp,
      commentsCount: commentsCount ?? this.commentsCount,
      views: views ?? this.views,
    );
  }
}

class PostViewModel {
  String formatPostTime(DateTime postTime) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(postTime);

    if (difference.inSeconds < 60) {
      return '방금';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간전';
    } else {
      final format = currentTime.year == postTime.year ? 'M.d' : 'yyyy.M.d';
      return DateFormat(format).format(postTime);
    }
  }

  String formatPostViews(int? count) {
    if (count == null) return '0';

    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }

  String formatDoubleToOneDecimal(double value) {
    return value.toStringAsFixed(1);
  }

  String getEventStatus(DateTime eventStartDate) {
    final currentDate = DateTime.now();
    final currentDateWithoutTime = DateTime(currentDate.year, currentDate.month, currentDate.day);
    final eventDateWithoutTime = DateTime(eventStartDate.year, eventStartDate.month, eventStartDate.day);

    final difference = eventDateWithoutTime.difference(currentDateWithoutTime).inDays;

    if (difference > 999) {
      return 'D-999+';
    } else if (difference > 0) {
      return 'D-$difference';
    } else if (difference == 0) {
      return 'D-day';
    } else {
      return '마감';
    }
  }
}
