const mongoose = require('mongoose');
const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');

const app = express();
app.use(cors());
app.use(express.json());
dotenv.config({path: './config/.env'});
const PORT = process.env.PORT || 8080;

const Book = require('./models/bookmodel.js');

mongoose.connect(process.env.MONGODB_URI, {dbName: 'books_db'})
    .then(() => {
        console.log('Connected to MongoDB');
    })
    .catch(err => {
        console.error('MongoDB connection error:', err);
    });

app.get('/popular', (req, res) => {
    
    const token = req.headers.authorization;

    if (token !== `Bearer ${process.env.ACCESS_TOKEN}`) {
        return res.status(401).json({ message: 'Unauthorized' });
    }

    Book.find({ isPopular: true })
        .then(books => {
            res.json(books);
        })
        .catch(err => {
            console.error('Error fetching popular books:', err);
            res.status(500).send('Internal Server Error');
        });

});

app.post('/addFavorite', (req, res) => {

});

app.listen(PORT,'0.0.0.0', () => {
    console.log(`Server is running on port ${PORT}`);
});