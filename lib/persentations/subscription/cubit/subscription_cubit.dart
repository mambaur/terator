import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:terator/core/constants.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(const SubscriptionState());

  /// Initialize RevenueCat SDK and check subscription status.
  /// Call this once during app startup.
  Future<void> init() async {
    try {
      await Purchases.setLogLevel(LogLevel.debug);

      late PurchasesConfiguration configuration;
      if (Platform.isAndroid) {
        configuration = PurchasesConfiguration(revenueCatGoogleApiKey);
      }
      // Hanya Android sesuai kebutuhan
      if (Platform.isAndroid) {
        await Purchases.configure(configuration);
      }

      // Listen to CustomerInfo updates (purchase, restore, etc.)
      Purchases.addCustomerInfoUpdateListener((customerInfo) {
        _updateStatusFromCustomerInfo(customerInfo);
      });

      // Initial status check
      await checkStatus();
    } catch (e) {
      if (kDebugMode) print('RevenueCat init error: $e');
      // Jika gagal init (misal di emulator tanpa Play Store),
      // set ke inactive agar app tetap bisa berjalan
      emit(const SubscriptionState(status: SubscriptionStatus.inactive));
    }
  }

  /// Check current subscription status from RevenueCat.
  Future<void> checkStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      _updateStatusFromCustomerInfo(customerInfo);
    } catch (e) {
      if (kDebugMode) print('RevenueCat checkStatus error: $e');
      emit(const SubscriptionState(status: SubscriptionStatus.inactive));
    }
  }

  /// Update state based on CustomerInfo entitlements.
  void _updateStatusFromCustomerInfo(CustomerInfo customerInfo) {
    final isActive =
        customerInfo.entitlements.all[entitlementId]?.isActive ?? false;

    emit(SubscriptionState(
      status: isActive
          ? SubscriptionStatus.active
          : SubscriptionStatus.inactive,
    ));
  }

  /// Restore purchases and re-check status.
  Future<bool> restorePurchases() async {
    try {
      emit(state.copyWith(status: SubscriptionStatus.loading));
      final customerInfo = await Purchases.restorePurchases();
      _updateStatusFromCustomerInfo(customerInfo);
      return state.isPremium;
    } catch (e) {
      if (kDebugMode) print('RevenueCat restore error: $e');
      emit(state.copyWith(status: SubscriptionStatus.inactive));
      return false;
    }
  }

  /// Show RevenueCat's native paywall UI.
  /// Returns true if purchase was made successfully.
  Future<bool> showPaywall() async {
    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(entitlementId);
      if (kDebugMode) print('Paywall result: $result');

      // Re-check status after paywall interaction
      await checkStatus();
      return state.isPremium;
    } catch (e) {
      if (kDebugMode) print('RevenueCat paywall error: $e');
      return false;
    }
  }
}
