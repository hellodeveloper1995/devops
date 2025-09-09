const express = require('express');
const mongoose = require('mongoose');

const app = express();

// Middleware to parse JSON request bodies
app.use(express.json());

// Middleware to parse URL-encoded request bodies
app.use(express.urlencoded({ extended: true }));

app.get('/health', (req, res) => {
    res.status(200).send('Up');
});

// console.log('Connceting to db...');
// mongoose
//     .connect('mongodb://mongodb/store', {
//         auth: {
//             username: 'kamrul',
//             password: 'root',
//         },
//         connectTimeoutMS: 500,
//     })
//     .then(() => {
//         console.log('Connected to DB');
//         app.listen(3000, () => {
//             console.log('Server listening on port 3000');
//         });
//     })
//     .catch((err) => {
//         console.log('Something went wrong');
//         console.log(err);
//     });

app.listen(3000, () => {
    console.log('Server listening on port 3000');
});
