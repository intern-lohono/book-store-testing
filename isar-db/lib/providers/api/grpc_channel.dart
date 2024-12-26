import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:letstalkbooksfinished/internal/grpc_transport_channel.dart';
import 'package:letstalkbooksfinished/utils/riverpod.dart';

Provider<ClientChannel> getGrpcChannel() {
  return RiverPod.provider(
    'grpc-channel',
    (ref) {
      return GrpcTransportChannel(
        "10.0.2.2",
        50051,
      );
    },
  );
}
