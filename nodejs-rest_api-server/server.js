const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

app.use(bodyParser.json());

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

app.post('/submit-data', async (req, res) => {
  try {
    const { bookName, duration, priorityValue } = req.body;

    const newBook = new Book({ bookName, duration, priorityValue });
    await newBook.save();

    res.status(201).json({ message: 'Data submitted successfully!', data: newBook });
  } catch (err) {
    console.error("Error submitting data:", err);
    res.status(500).json({ message: 'Failed to submit data', error: err.message });
  }
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on port ${PORT}`);
});
