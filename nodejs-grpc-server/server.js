const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/books', {
}).then(() => {
  console.log('MongoDB connected');
}).catch((err) => {
  console.log('MongoDB connection failed:', err);
});

const Book = mongoose.model('Book', {
  bookName: String,
  duration: String,
  priorityValue: Number,
});

const packageDefinition = protoLoader.loadSync('../protos/books.proto', {
  keepCase: true,
  longs: String,
  enums: String,
  defaults: true,
  oneofs: true,
});

const booksProto = grpc.loadPackageDefinition(packageDefinition).books;

const getBooks = async (call) => {
  try {
    console.log('getBooks called');

    const books = await Book.find({});

    for (const book of books) {
      call.write({
        bookName: book.bookName,
        duration: book.duration,
        priorityValue: book.priorityValue,
      });
    }

    call.end();
  } catch (err) {
    console.error('Error fetching books:', err);

    call.destroy(err);
  }
};

const addBook = async (call, callback) => {
  console.log('addBook called with:', call.request);

  try {
    const newBook = new Book({
      bookName: call.request.bookName,
      duration: call.request.duration,
      priorityValue: call.request.priorityValue,
    });

    await newBook.save();

    callback(null, { success: true, message: 'Book added successfully!' });
  } catch (err) {
    callback(null, { success: false, message: 'Failed to add book.' });
  }
};

const server = new grpc.Server();

server.addService(booksProto.BookService.service, {
  getBooks: getBooks,
  addBook: addBook,
});

server.bindAsync('0.0.0.0:50051', grpc.ServerCredentials.createInsecure(), () => {
  console.log('gRPC Server running on port 50051');
});
