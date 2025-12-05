import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/notification/data/repositories/notification_repository.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;
  final String _userId;
  StreamSubscription? _notificationsSubscription;

  NotificationCubit(this._repository, this._userId)
    : super(const NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(const NotificationLoading());
    final result = await _repository.fetchNotifications(_userId);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  void streamNotifications() {
    emit(const NotificationLoading());
    _notificationsSubscription?.cancel();
    _notificationsSubscription = _repository
        .streamNotifications(_userId)
        .listen((result) {
          result.fold(
            (failure) => emit(NotificationError(failure.message)),
            (notifications) => emit(NotificationLoaded(notifications)),
          );
        });
  }

  Future<void> markAsRead(String notificationId) async {
    // We don't emit loading here to avoid full screen refresh,
    // the stream will update the UI automatically
    final result = await _repository.markAsRead(_userId, notificationId);
    result.fold((failure) => emit(NotificationActionError(failure.message)), (
      _,
    ) {
      // Success handled by stream update
    });
  }

  Future<void> markAllAsRead() async {
    final result = await _repository.markAllAsRead(_userId);
    result.fold((failure) => emit(NotificationActionError(failure.message)), (
      _,
    ) {
      // Success handled by stream update
    });
  }

  Future<void> deleteNotification(String notificationId) async {
    final result = await _repository.deleteNotification(
      _userId,
      notificationId,
    );
    result.fold((failure) => emit(NotificationActionError(failure.message)), (
      _,
    ) {
      // Success handled by stream update
    });
  }

  @override
  Future<void> close() {
    _notificationsSubscription?.cancel();
    return super.close();
  }
}
