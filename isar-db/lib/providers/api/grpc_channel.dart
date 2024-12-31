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


// For debugging: to trace the flow of the grpc call, use the below provider.
 
// It is because, the above RiverPod.provider uses Cache Mechanism, i.e. If the getGrpcChannel provider has already been created (i.e., its value exists in the cache), its factory function will not be executed again. Instead, the cached ClientChannel is returned. As a result, the debugger skips stepping into getGrpcChannel.

// Provider<ClientChannel> getGrpcChannel() {
//   return Provider<ClientChannel>(
//     (ref) {
//       return GrpcTransportChannel("10.0.2.2", 50051);
//     },
//   );
// }
