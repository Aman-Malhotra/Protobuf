from flask import Flask, request
from generated.sign_in_pb2 import SignIn, SignInResponse
from uuid import uuid4

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def base():
    return '<h1>From Flask: Hey, I am alive</h1>'


@app.route('/sign_in', methods=['GET', 'POST'])
def sign_in():
    data = str(request.get_data())
    data = data[3:-2]
    data = data.split(", ")
    data = [int(byte) for byte in data]
    data = bytearray(data)

    signInReq = SignIn()
    signInReq.ParseFromString(data)
    if signInReq.username == 'aman' and signInReq.password == 'password':
        res = SignInResponse()
        res.username = 'aman'
        res.email = 'aman@flask.com'
        res.first_name = 'aman'
        res.token = str(uuid4())
        res.age = 22
        response = res.SerializeToString()
        return response
    else:
        return 'From Flask: Invalid username or password'


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000)
