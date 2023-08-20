use v5.38;
use utf8;
use feature 'class';
use Motdbot::MessageBuilder;

class Motdbot::MessageBuilder::MoonPhase :isa(Motdbot::MessageBuilder) {
    use DateTime ();
    use Astro::MoonPhase qw(phaselist);

    method build () {
        my @name = qw(新月 上弦月 滿月 下弦月);
        my $phase = moonphase_of_ymd( $self->today );

        return "" unless defined($phase);

        return "今晚是" . $name[$phase] . "呢。";
    }

    sub moonphase_of_ymd ($ymd) {
        my @ymd = split /\D/, $ymd;

        my $date = DateTime->new(
            year => $ymd[0],
            month => $ymd[1],
            day => $ymd[2],
            time_zone => 'Asia/Taipei',
        )->truncate(to => 'day');

        my ($phase) = phaselist( $date->epoch, $date->epoch + 86400 );
        return $phase;
    }
}
