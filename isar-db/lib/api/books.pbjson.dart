//
//  Generated code. Do not modify.
//  source: books.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use bookDescriptor instead')
const Book$json = {
  '1': 'Book',
  '2': [
    {'1': 'bookName', '3': 1, '4': 1, '5': 9, '10': 'bookName'},
    {'1': 'priorityValue', '3': 2, '4': 1, '5': 5, '10': 'priorityValue'},
    {'1': 'duration', '3': 3, '4': 1, '5': 9, '10': 'duration'},
  ],
};

/// Descriptor for `Book`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bookDescriptor = $convert.base64Decode(
    'CgRCb29rEhoKCGJvb2tOYW1lGAEgASgJUghib29rTmFtZRIkCg1wcmlvcml0eVZhbHVlGAIgAS'
    'gFUg1wcmlvcml0eVZhbHVlEhoKCGR1cmF0aW9uGAMgASgJUghkdXJhdGlvbg==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use addBookResponseDescriptor instead')
const AddBookResponse$json = {
  '1': 'AddBookResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AddBookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addBookResponseDescriptor = $convert.base64Decode(
    'Cg9BZGRCb29rUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGA'
    'IgASgJUgdtZXNzYWdl');

