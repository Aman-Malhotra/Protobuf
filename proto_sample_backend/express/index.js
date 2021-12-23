const express = require('express');
const app = express();
const schema = require('./generated/sign_in_pb.js');
const { v4: uuidv4 } = require('uuid');

// this is must for binary content type
app.use(express.raw());

app.get("/", (req, res) => {
    res.send("<h1>From Express: Hey, I am alive</h1>");
});

app.post("/sign_in", (req, res) => {
    try {
        buf = req.body
        reqArray = buf.toString()
        reqArray = reqArray.substring(1, reqArray.length - 1)
        let bin = reqArray.split(", ")
        const request = new schema.SignIn.deserializeBinary(bin);
        username = request.getUsername()
        password = request.getPassword()
        if (username == 'aman' && password == 'password') {
            const response = new schema.SignInResponse()
            response.setToken(uuidv4())
            response.setUsername('aman')
            response.setEmail('aman@express.com')
            response.setFirstName('aman')
            response.setAge(22)
            resBuffer = Buffer.from(response.serializeBinary(), 'binary')
            res.send(resBuffer)
        } else {
            res.send('From Express: Invalid username or password ')
        }
    } catch (err) {
        res.send('From Express: Error ' + err)
    }
});

app.post("/proto_test", (req, res) => {
    buf = req.body
    reqArray = buf.toString()
    reqArray = reqArray.substring(1, reqArray.length - 1)
    let bin = reqArray.split(", ")
    res.send(Buffer.from(bin))
});

const port = 4000;
app.listen(port, () => {
    console.log('Hello world listening on port', port);
});



// this is for json content type
// app.use(express.json());
// app.use(express.urlencoded({ extended: true }));
