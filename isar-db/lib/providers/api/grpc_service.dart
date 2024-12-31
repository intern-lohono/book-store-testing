import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/service_api.dart';
import 'package:letstalkbooksfinished/api/books.pbgrpc.dart';
import 'grpc_channel.dart';
import 'package:letstalkbooksfinished/utils/riverpod.dart';

Provider<BookServiceClient> getBookService() {
  return getService((channel) => BookServiceClient(channel));
}

Provider<T> getService<T>(T Function(ClientChannel channel) builder) {
  return RiverPod.provider(
    T.toString(),
    (ref) {
      final channel = ref.watch(getGrpcChannel());

      final service = builder(channel);

      return service;
    },
  );
}
