const express = require('express');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT;

// Middleware to parse JSON request bodies
app.use(express.json());

// Middleware to parse URL-encoded request bodies
app.use(express.urlencoded({ extended: true }));

app.get('/health', (req, res) => {
    res.status(200).send('Up');
});

console.log('Connceting to db...');
mongoose
    .connect(`mongodb://mongodb/${process.env.KEY_VALUE_DB}`, {
        auth: {
            username: process.env.KEY_VALUE_USER,
            password: process.env.KEY_VALUE_PASSWORD,
        },
        connectTimeoutMS: 500,
    })
    .then(() => {
        console.log('Connected to DB');
        app.listen(port, () => {
            console.log(`Server listening on port ${port}`);
        });
    })
    .catch((err) => {
        console.log('Something went wrong');
        console.log(err);
    });
