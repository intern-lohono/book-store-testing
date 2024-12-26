//
//  Generated code. Do not modify.
//  source: books.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'books.pb.dart' as $0;

export 'books.pb.dart';

@$pb.GrpcServiceName('books.BookService')
class BookServiceClient extends $grpc.Client {
  static final _$getBooks = $grpc.ClientMethod<$0.Empty, $0.Book>(
      '/books.BookService/getBooks',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Book.fromBuffer(value));
  static final _$addBook = $grpc.ClientMethod<$0.Book, $0.AddBookResponse>(
      '/books.BookService/addBook',
      ($0.Book value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddBookResponse.fromBuffer(value));

  BookServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.Book> getBooks($0.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getBooks, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.AddBookResponse> addBook($0.Book request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addBook, request, options: options);
  }
}

@$pb.GrpcServiceName('books.BookService')
abstract class BookServiceBase extends $grpc.Service {
  $core.String get $name => 'books.BookService';

  BookServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Book>(
        'getBooks',
        getBooks_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Book value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Book, $0.AddBookResponse>(
        'addBook',
        addBook_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Book.fromBuffer(value),
        ($0.AddBookResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Book> getBooks_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* getBooks(call, await request);
  }

  $async.Future<$0.AddBookResponse> addBook_Pre($grpc.ServiceCall call, $async.Future<$0.Book> request) async {
    return addBook(call, await request);
  }

  $async.Stream<$0.Book> getBooks($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.AddBookResponse> addBook($grpc.ServiceCall call, $0.Book request);
}
