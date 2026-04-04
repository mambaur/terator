part of 'subscription_cubit.dart';

enum SubscriptionStatus { loading, active, inactive, error }

@immutable
class SubscriptionState {
  final SubscriptionStatus status;
  final String? errorMessage;

  const SubscriptionState({
    this.status = SubscriptionStatus.loading,
    this.errorMessage,
  });

  bool get isPremium => status == SubscriptionStatus.active;

  SubscriptionState copyWith({
    SubscriptionStatus? status,
    String? errorMessage,
  }) {
    return SubscriptionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
