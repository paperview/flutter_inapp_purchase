import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:platform/platform.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

void main() {
  group('FlutterInappPurchase', () {
    group('platformVersion', () {
      final List<MethodCall> log = <MethodCall>[];
      setUp(() {
        FlutterInappPurchase(FlutterInappPurchase.private(FakePlatform()));

        FlutterInappPurchase.channel
            .setMockMethodCallHandler((MethodCall methodCall) async {
          log.add(methodCall);
          return "Android 5.1.1";
        });
      });

      tearDown(() {
        FlutterInappPurchase.channel.setMethodCallHandler(null);
      });

      test('invoke correct method', () async {
        await FlutterInappPurchase.platformVersion;
        expect(log, <Matcher>[
          isMethodCall(
            'getPlatformVersion',
            arguments: null,
          ),
        ]);
      });

      test('returns correct result', () async {
        expect(await FlutterInappPurchase.platformVersion, "Android 5.1.1");
      });
    });

    group('consumeAllItems', () {
      group('For Android', () {
        final List<MethodCall> log = <MethodCall>[];
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return "All items have been consumed";
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.consumeAllItems;
          expect(log, <Matcher>[
            isMethodCall('consumeAllItems', arguments: null),
          ]);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.consumeAllItems,
              "All items have been consumed");
        });
      });

      group('For iOS', () {
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.consumeAllItems, "no-ops in ios");
        });
      });
    });

    group('initConnection', () {
      group('For Android', () {
        final List<MethodCall> log = <MethodCall>[];
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return "Billing client ready";
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.initConnection;
          expect(log, <Matcher>[
            isMethodCall('prepare', arguments: null),
          ]);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.initConnection,
              "Billing client ready");
        });
      });

      group('For iOS', () {
        final List<MethodCall> log = <MethodCall>[];
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return "true";
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.initConnection;
          expect(log, <Matcher>[
            isMethodCall('canMakePayments', arguments: null),
          ]);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.initConnection, "true");
        });
      });
    });

    group('getProducts', () {
      group('For Android', () {
        final List<MethodCall> log = <MethodCall>[];
        List<String> skus = List()..add("testsku");

        List<IAPItem> result = List();

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getProducts(skus);
          expect(log, <Matcher>[
            isMethodCall(
              'getItemsByType',
              arguments: <String, dynamic>{
                'type': 'inapp',
                'skus': skus,
              },
            ),
          ]);
        });
      });

      group('For iOS', () {
        final List<MethodCall> log = <MethodCall>[];
        List<String> skus = List()..add("testsku");

        List<IAPItem> result = List();

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getProducts(skus);
          expect(log, <Matcher>[
            isMethodCall(
              'getItems',
              arguments: <String, dynamic>{
                'skus': skus,
              },
            ),
          ]);
        });
      });
    });

    group('getSubscriptions', () {
      group('For Android', () {
        final List<MethodCall> log = <MethodCall>[];
        List<String> skus = List()..add("testsku");

        List<IAPItem> result = List();

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getSubscriptions(skus);
          expect(log, <Matcher>[
            isMethodCall(
              'getItemsByType',
              arguments: <String, dynamic>{
                'type': 'subs',
                'skus': skus,
              },
            ),
          ]);
        });
      });

      group('For iOS', () {
        final List<MethodCall> log = <MethodCall>[];
        List<String> skus = List()..add("testsku");

        List<IAPItem> result = List();

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getSubscriptions(skus);
          expect(log, <Matcher>[
            isMethodCall(
              'getItems',
              arguments: <String, dynamic>{
                'skus': skus,
              },
            ),
          ]);
        });
      });
    });

    group('getPurchaseHistory', () {
      group('For Android', () {
        final List<MethodCall> log = <MethodCall>[];

        List<PurchasedItem> result = List();

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getPurchaseHistory();
          expect(log, <Matcher>[
            isMethodCall(
              'getPurchaseHistoryByType',
              arguments: <String, dynamic>{
                'type': 'inapp',
              },
            ),
            isMethodCall(
              'getPurchaseHistoryByType',
              arguments: <String, dynamic>{
                'type': 'subs',
              },
            ),
          ]);
        });
      });

      group('For iOS', () {
        final List<MethodCall> log = <MethodCall>[];

        List<PurchasedItem> result = List();

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getPurchaseHistory();
          expect(log, <Matcher>[
            isMethodCall(
              'getAvailableItems',
              arguments: null,
            ),
          ]);
        });
      });
    });

    group('getAvailablePurchases', () {
      group('For Android', () {
        final List<MethodCall> log = <MethodCall>[];

        List<PurchasedItem> result = List();

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getAvailablePurchases();
          expect(log, <Matcher>[
            isMethodCall(
              'getAvailableItemsByType',
              arguments: <String, dynamic>{
                'type': 'inapp',
              },
            ),
            isMethodCall(
              'getAvailableItemsByType',
              arguments: <String, dynamic>{
                'type': 'subs',
              },
            ),
          ]);
        });
      });

      group('For iOS', () {
        final List<MethodCall> log = <MethodCall>[];

        List<PurchasedItem> result = List();

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getAvailablePurchases();
          expect(log, <Matcher>[
            isMethodCall(
              'getAvailableItems',
              arguments: null,
            ),
          ]);
        });
      });
    });

    group('buyProduct', () {
      group('for Android', () {
        final List<MethodCall> log = <MethodCall>[];

        final String sku = "testsku";
        final String result = """{
            "transactionDate":"1552824902000",
            "transactionId":"testTransactionId",
            "productId":"com.cooni.point1000",
            "transactionReceipt":"testTransactionReciept",
            "purchaseToken":"testPurchaseToken",
            "autoRenewingAndroid":true,
            "dataAndroid":"testDataAndroid",
            "signatureAndroid":"testSignatureAndroid",
            "originalTransactionDateIOS":"1552831136000",
            "originalTransactionIdentifierIOS":"testOriginalTransactionIdentifierIOS"
          }""";

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.buyProduct(sku);
          expect(log, <Matcher>[
            isMethodCall(
              'buyItemByType',
              arguments: <String, dynamic>{
                'type': 'inapp',
                'sku': sku,
                'oldSku': null,
              },
            ),
          ]);
        });

        test('returns correct result', () async {
          PurchasedItem actual = await FlutterInappPurchase.buyProduct(sku);
          PurchasedItem expected = PurchasedItem.fromJSON(json.decode(result));
          expect(actual.transactionDate, expected.transactionDate);
          expect(actual.transactionId, expected.transactionId);
          expect(actual.productId, expected.productId);
          expect(actual.transactionReceipt, expected.transactionReceipt);
          expect(actual.purchaseToken, expected.purchaseToken);
          expect(actual.autoRenewingAndroid, expected.autoRenewingAndroid);
          expect(actual.dataAndroid, expected.dataAndroid);
          expect(actual.signatureAndroid, expected.signatureAndroid);
          expect(actual.originalTransactionDateIOS,
              expected.originalTransactionDateIOS);
          expect(actual.originalTransactionIdentifierIOS,
              expected.originalTransactionIdentifierIOS);
        });
      });

      group('for iOS', () {
        final List<MethodCall> log = <MethodCall>[];
        final String sku = "testsku";
        final dynamic result = {
          "transactionDate": "1552824902000",
          "transactionId": "testTransactionId",
          "productId": "com.cooni.point1000",
          "transactionReceipt": "testTransactionReciept",
          "purchaseToken": "testPurchaseToken",
          "autoRenewingAndroid": true,
          "dataAndroid": "testDataAndroid",
          "signatureAndroid": "testSignatureAndroid",
          "originalTransactionDateIOS": "1552831136000",
          "originalTransactionIdentifierIOS":
              "testOriginalTransactionIdentifierIOS"
        };

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.buyProduct(sku);
          expect(log, <Matcher>[
            isMethodCall(
              'buyProductWithFinishTransaction',
              arguments: <String, dynamic>{
                'sku': sku,
              },
            ),
          ]);
        });

        test('returns correct result', () async {
          PurchasedItem actual = await FlutterInappPurchase.buyProduct(sku);
          PurchasedItem expected = PurchasedItem.fromJSON(result);
          expect(actual.transactionDate, expected.transactionDate);
          expect(actual.transactionId, expected.transactionId);
          expect(actual.productId, expected.productId);
          expect(actual.transactionReceipt, expected.transactionReceipt);
          expect(actual.purchaseToken, expected.purchaseToken);
          expect(actual.autoRenewingAndroid, expected.autoRenewingAndroid);
          expect(actual.dataAndroid, expected.dataAndroid);
          expect(actual.signatureAndroid, expected.signatureAndroid);
          expect(actual.originalTransactionDateIOS,
              expected.originalTransactionDateIOS);
          expect(actual.originalTransactionIdentifierIOS,
              expected.originalTransactionIdentifierIOS);
        });
      });
    });

    group('buySubscription', () {
      group('for Android', () {
        final List<MethodCall> log = <MethodCall>[];

        final String sku = "testsku";
        final String oldSku = "testOldSku";
        final String result = """{
            "transactionDate":"1552824902000",
            "transactionId":"testTransactionId",
            "productId":"com.cooni.point1000",
            "transactionReceipt":"testTransactionReciept",
            "purchaseToken":"testPurchaseToken",
            "autoRenewingAndroid":true,
            "dataAndroid":"testDataAndroid",
            "signatureAndroid":"testSignatureAndroid",
            "originalTransactionDateIOS":"1552831136000",
            "originalTransactionIdentifierIOS":"testOriginalTransactionIdentifierIOS"
          }""";

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.buySubscription(sku, oldSku: oldSku);
          expect(log, <Matcher>[
            isMethodCall(
              'buyItemByType',
              arguments: <String, dynamic>{
                'type': 'subs',
                'sku': sku,
                'oldSku': oldSku,
              },
            ),
          ]);
        });

        test('returns correct result', () async {
          PurchasedItem actual = await FlutterInappPurchase.buyProduct(sku);
          PurchasedItem expected = PurchasedItem.fromJSON(json.decode(result));
          expect(actual.transactionDate, expected.transactionDate);
          expect(actual.transactionId, expected.transactionId);
          expect(actual.productId, expected.productId);
          expect(actual.transactionReceipt, expected.transactionReceipt);
          expect(actual.purchaseToken, expected.purchaseToken);
          expect(actual.autoRenewingAndroid, expected.autoRenewingAndroid);
          expect(actual.dataAndroid, expected.dataAndroid);
          expect(actual.signatureAndroid, expected.signatureAndroid);
          expect(actual.originalTransactionDateIOS,
              expected.originalTransactionDateIOS);
          expect(actual.originalTransactionIdentifierIOS,
              expected.originalTransactionIdentifierIOS);
        });
      });

      group('for iOS', () {
        final List<MethodCall> log = <MethodCall>[];
        final String sku = "testsku";
        final dynamic result = {
          "transactionDate": "1552824902000",
          "transactionId": "testTransactionId",
          "productId": "com.cooni.point1000",
          "transactionReceipt": "testTransactionReciept",
          "purchaseToken": "testPurchaseToken",
          "autoRenewingAndroid": true,
          "dataAndroid": "testDataAndroid",
          "signatureAndroid": "testSignatureAndroid",
          "originalTransactionDateIOS": "1552831136000",
          "originalTransactionIdentifierIOS":
              "testOriginalTransactionIdentifierIOS"
        };

        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.buyProduct(sku);
          expect(log, <Matcher>[
            isMethodCall(
              'buyProductWithFinishTransaction',
              arguments: <String, dynamic>{
                'sku': sku,
              },
            ),
          ]);
        });

        test('returns correct result', () async {
          PurchasedItem actual = await FlutterInappPurchase.buyProduct(sku);
          PurchasedItem expected = PurchasedItem.fromJSON(result);
          expect(actual.transactionDate, expected.transactionDate);
          expect(actual.transactionId, expected.transactionId);
          expect(actual.productId, expected.productId);
          expect(actual.transactionReceipt, expected.transactionReceipt);
          expect(actual.purchaseToken, expected.purchaseToken);
          expect(actual.autoRenewingAndroid, expected.autoRenewingAndroid);
          expect(actual.dataAndroid, expected.dataAndroid);
          expect(actual.signatureAndroid, expected.signatureAndroid);
          expect(actual.originalTransactionDateIOS,
              expected.originalTransactionDateIOS);
          expect(actual.originalTransactionIdentifierIOS,
              expected.originalTransactionIdentifierIOS);
        });
      });
    });

    group('consumePurchase', () {
      group('for Android', () {
        final List<MethodCall> log = <MethodCall>[];
        final String token = "testToken";
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return "Consumed: 0";
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.consumePurchase(token);
          expect(log, <Matcher>[
            isMethodCall('consumeProduct', arguments: <String, dynamic>{
              'token': token,
            }),
          ]);
        });

        test('returns correct result', () async {
          expect(
              await FlutterInappPurchase.consumePurchase(token), "Consumed: 0");
        });
      });

      group('for iOS', () {
        final String token = "testToken";
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.consumePurchase(token),
              "no-ops in ios");
        });
      });
    });

    group('endConnection', () {
      group('for Android', () {
        final List<MethodCall> log = <MethodCall>[];
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return "Billing client has ended.";
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.endConnection;
          expect(log, <Matcher>[
            isMethodCall('endConnection', arguments: null),
          ]);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.endConnection,
              "Billing client has ended.");
        });
      });

      group('for iOS', () {
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.endConnection, "no-ops in ios");
        });
      });
    });

    group('finishTransaction', () {
      group('for Android', () {
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.finishTransaction(),
              "no-ops in android.");
        });
      });

      group('for iOS', () {
        final List<MethodCall> log = <MethodCall>[];
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return "Finished current transaction";
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.finishTransaction();
          expect(log, <Matcher>[
            isMethodCall('finishTransaction', arguments: null),
          ]);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.finishTransaction(),
              "Finished current transaction");
        });
      });
    });
    group('getAppStoreInitiatedProducts', () {
      group('for Android', () {
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "android")));
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('returns correct result', () async {
          expect(await FlutterInappPurchase.getAppStoreInitiatedProducts(),
              List<IAPItem>());
        });
      });

      group('for iOS', () {
        final List<MethodCall> log = <MethodCall>[];

        final dynamic result = [
          {
            "productId": "com.cooni.point1000",
            "price": "120",
            "currency": "JPY",
            "localizedPrice": "¥120",
            "title": "1,000",
            "description": "1000 points 1000P",
            "introductoryPrice": "1001",
            "introductoryPricePaymentModeIOS": "1002",
            "introductoryPriceNumberOfPeriodsIOS": "1003",
            "introductoryPriceSubscriptionPeriodIOS": "1004",
            "subscriptionPeriodUnitIOS": "1",
            "subscriptionPeriodAndroid": "2",
            "subscriptionPeriodNumberIOS": "3",
            "introductoryPriceCyclesAndroid": "4",
            "introductoryPricePeriodAndroid": "5",
            "freeTrialPeriodAndroid": "6"
          }
        ];
        setUp(() {
          FlutterInappPurchase(FlutterInappPurchase.private(
              FakePlatform(operatingSystem: "ios")));

          FlutterInappPurchase.channel
              .setMockMethodCallHandler((MethodCall methodCall) async {
            log.add(methodCall);
            return result;
          });
        });

        tearDown(() {
          FlutterInappPurchase.channel.setMethodCallHandler(null);
        });

        test('invokes correct method', () async {
          await FlutterInappPurchase.getAppStoreInitiatedProducts();
          expect(log, <Matcher>[
            isMethodCall('getAppStoreInitiatedProducts', arguments: null),
          ]);
        });

        test('returns correct result', () async {
          List<IAPItem> products =
              await FlutterInappPurchase.getAppStoreInitiatedProducts();
          List<IAPItem> expected = result
              .map<IAPItem>(
                (product) => IAPItem.fromJSON(product as Map<String, dynamic>),
              )
              .toList();
          for (var i = 0; i < products.length; ++i) {
            var product = products[i];
            var expectedProduct = expected[i];
            expect(product.productId, expectedProduct.productId);
            expect(product.price, expectedProduct.price);
            expect(product.currency, expectedProduct.currency);
            expect(product.localizedPrice, expectedProduct.localizedPrice);
            expect(product.title, expectedProduct.title);
            expect(product.description, expectedProduct.description);
            expect(
                product.introductoryPrice, expectedProduct.introductoryPrice);
            expect(product.subscriptionPeriodNumberIOS,
                expectedProduct.subscriptionPeriodNumberIOS);
            expect(product.introductoryPricePaymentModeIOS,
                expectedProduct.introductoryPricePaymentModeIOS);
            expect(product.introductoryPriceNumberOfPeriodsIOS,
                expectedProduct.introductoryPriceNumberOfPeriodsIOS);
            expect(product.introductoryPriceSubscriptionPeriodIOS,
                expectedProduct.introductoryPriceSubscriptionPeriodIOS);
            expect(product.subscriptionPeriodAndroid,
                expectedProduct.subscriptionPeriodAndroid);
            expect(product.introductoryPriceCyclesAndroid,
                expectedProduct.introductoryPriceCyclesAndroid);
            expect(product.introductoryPricePeriodAndroid,
                expectedProduct.introductoryPricePeriodAndroid);
            expect(product.freeTrialPeriodAndroid,
                expectedProduct.freeTrialPeriodAndroid);
          }
        });
      });
    });
    group('checkSubscribed', () {
      // FIXME
      // This method can't be tested, because this method calls static methods internally.
      // To test, it needs to change static method to non-static method.
    });

    group('validateReceiptAndroid', () {
      setUp(() {
        http.Client mockClient = MockClient((request) async {
          return Response(null, 200);
        });

        FlutterInappPurchase(FlutterInappPurchase.private(
            FakePlatform(operatingSystem: "ios"),
            client: mockClient));
      });

      tearDown(() {
        FlutterInappPurchase.channel.setMethodCallHandler(null);
      });

      test('returns correct http request url, isSubscription is true',
          () async {
        final String packageName = "testpackege";
        final String productId = "testProductId";
        final String productToken = "testProductToken";
        final String accessToken = "testAccessToken";
        final String type = "subscriptions";
        final response = await FlutterInappPurchase.validateReceiptAndroid(
            packageName: packageName,
            productId: productId,
            productToken: productToken,
            accessToken: accessToken,
            isSubscription: true);
        expect(response.request.url.toString(),
            "https://www.googleapis.com/androidpublisher/v2/applications/$packageName/purchases/$type/$productId/tokens/$productToken?access_token=$accessToken");
      });
      test('returns correct http request url, isSubscription is false',
          () async {
        final String packageName = "testpackege";
        final String productId = "testProductId";
        final String productToken = "testProductToken";
        final String accessToken = "testAccessToken";
        final String type = "products";
        final response = await FlutterInappPurchase.validateReceiptAndroid(
            packageName: packageName,
            productId: productId,
            productToken: productToken,
            accessToken: accessToken,
            isSubscription: false);
        expect(response.request.url.toString(),
            "https://www.googleapis.com/androidpublisher/v2/applications/$packageName/purchases/$type/$productId/tokens/$productToken?access_token=$accessToken");
      });
    });
  });
}
