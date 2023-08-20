use v5.38;
use utf8;
use Object::Pad;

class Motdbot::MessageBuilder::TaiwanAirQuality :isa(Motdbot::MessageBuilder) {
    use Mojo::UserAgent;
    use Geo::Hash;

    method build () {
        my $groups = air_quality_summarized_by_geohash4();
        my @bricks = map {
            brick(percentile95( map { $_->{"Data"}{"Dust2_5"} } @{ $groups->{$_} } ))
        } sorted(keys %$groups);
        return join("", @bricks) . "\n(PM2.5 熱度圖)";
    }


    sub percentile95 (@nums) {
        my @sorted = sort { $a <=> $b } @nums;
        return $sorted[ @sorted / 100 * 95 ];
    }

    sub brick ($num) {
        # More-or-less the same as the legend from  https://v5.airmap.g0v.tw/
        ($num >= 70) ? "🟪" :     # LARGE PURPLE SQUARE
        ($num >= 53) ? "🟥" : # LARGE RED SQUARE
        ($num >= 41) ? "🟨" : # LARGE ORANGE SQUARE
        ($num >= 35) ? "🟨" : # LARGE YELLOW SQUARE
        "🟩"                  # LARGE GREEN SQUARE
    }

    sub sorted (@geohashes) {
        my $hasher = Geo::Hash->new;
        return map { $_->[0] } sort {
            $a->[1][0] <=> $b->[1][0] || # Lat: South first
                $b->[1][1] <=> $a->[1][1] # Lng: East first
            } map { [$_, [ $hasher->decode($_) ] ] } @geohashes;
    }

    sub air_quality_summarized_by_geohash4() {
        my $sites = Mojo::UserAgent->new()->get('https://api.airmap.g0v.tw/json/airmap.json')->result->json;
        my %groups;
        my $hasher = Geo::Hash->new;
        for my $site (@{ $sites }) {
            my $geohash = $hasher->encode(
                $site->{"LatLng"}{"lat"},
                $site->{"LatLng"}{"lng"},
                4,
            );
            push @{ $groups{$geohash} //= [] }, $site;
        }
        return \%groups;
    }
}
