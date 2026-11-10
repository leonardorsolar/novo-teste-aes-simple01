const express = require('express');

const app = express();

app.get('/', (req, res) => {
  res.type('text/plain').send('Hello World');
});

module.exports = app;
