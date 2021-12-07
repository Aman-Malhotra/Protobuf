### Install protoc
> brew install protobuf

### Python
> protoc --python_out=flask/generated protos/sign_in.proto

### Javascript
> protoc --js_out=import_style=commonjs,binary:./express/generated protos/sign_in.proto

### Dart
> protoc --dart_out=grpc:lib/generated -Iprotos protos/sign_in.proto   

### Java/Kotlin
> protoc --java_out=java --kotlin_out=kotlin  protos/sign_in.proto

### Swift 
> brew install swift-protobuf
> protoc --swift_out=swift protos/sign_in.proto 
