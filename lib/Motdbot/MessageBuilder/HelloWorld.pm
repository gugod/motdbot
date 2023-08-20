use v5.38;
use Object::Pad;

class Motdbot::MessageBuilder::HelloWorld :isa(Motdbot::MessageBuilder) {
    method build () {
        return "Hello World";
    }
}
