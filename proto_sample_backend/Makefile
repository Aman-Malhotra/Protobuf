PROTO_PATH = protos/*.proto

gen-python:
	protoc --python_out=flask/generated $(PROTO_PATH)

gen-javascript:
	protoc --js_out=import_style=commonjs,binary:./express/generated $(PROTO_PATH)

gen-java:
	protoc --java_out=java  $(PROTO_PATH)

gen-kotlin:
	protoc --kotlin_out=kotlin  $(PROTO_PATH)

gen-swift:
	protoc --swift_out=swift $(PROTO_PATH)

gen-models: gen-python gen-javascript gen-java gen-kotlin gen-swift

