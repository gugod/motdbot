use v5.36;
use Object::Pad;

class Motdbot::MessageBuilder::HelloWorld {
    field $today;
    method build () {
        return "Hello World";
    }
}
