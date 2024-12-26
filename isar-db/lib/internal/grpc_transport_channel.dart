import 'package:grpc/grpc.dart';

class GrpcTransportChannel extends ClientChannel {
  final String host;
  final int port;

  GrpcTransportChannel(this.host, this.port)
      : super(
          host,
          port: port,
          options:
              const ChannelOptions(credentials: ChannelCredentials.insecure()),
        );

  @override
  Future<void> shutdown() async {
    await super.shutdown();
  }

  @override
  Future<void> terminate() async {
    await super.terminate();
  }

  @override
  Stream<ConnectionState> get onConnectionStateChanged async* {
    yield ConnectionState.ready;
  }
}
