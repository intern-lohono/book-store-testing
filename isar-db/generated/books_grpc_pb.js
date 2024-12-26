// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('grpc');
var books_pb = require('./books_pb.js');

function serialize_BookList(arg) {
  if (!(arg instanceof books_pb.BookList)) {
    throw new Error('Expected argument of type BookList');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_BookList(buffer_arg) {
  return books_pb.BookList.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_Empty(arg) {
  if (!(arg instanceof books_pb.Empty)) {
    throw new Error('Expected argument of type Empty');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_Empty(buffer_arg) {
  return books_pb.Empty.deserializeBinary(new Uint8Array(buffer_arg));
}


var BookServiceService = exports.BookServiceService = {
  getBooks: {
    path: '/BookService/GetBooks',
    requestStream: false,
    responseStream: false,
    requestType: books_pb.Empty,
    responseType: books_pb.BookList,
    requestSerialize: serialize_Empty,
    requestDeserialize: deserialize_Empty,
    responseSerialize: serialize_BookList,
    responseDeserialize: deserialize_BookList,
  },
};

exports.BookServiceClient = grpc.makeGenericClientConstructor(BookServiceService);
