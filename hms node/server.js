const express = require('express');
const hostelRoutes = require('./src/hostels/routes');

const app = express();
const port = 3000;

app.use(express.json());

app.get("/", (req, res) => {
    res.send("Hello World");
});

app.use('/api', hostelRoutes);

app.listen(port, '0.0.0.0', () => console.log('app listening on port ${port}'));