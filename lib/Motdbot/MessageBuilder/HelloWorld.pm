use v5.38;
use feature 'class';
use Motdbot::MessageBuilder;

class Motdbot::MessageBuilder::HelloWorld :isa(Motdbot::MessageBuilder) {
    method build () {
        return "Hello World";
    }
}
