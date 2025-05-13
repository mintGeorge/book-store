const mongoose = require('mongoose');

const bookSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  author: {
    type: String,
    required: true,
  },
  coverImagePath: {   
    type: String,
    required: true,
  },
  genre: {
    type: String,
  },
  description: {
    type: String,
  },
  pages: {
    type: String,
  },
  isFavorite: {
    type: Boolean,
    default: false,
  },
  isPopular: {
    type: Boolean,
    default: false,
  },
});

const Book = mongoose.model('Book', bookSchema);

module.exports = Book;
