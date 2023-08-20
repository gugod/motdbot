use v5.38;
package Motdbot::Fun;

use Exporter 'import';

our @EXPORT_OK = qw( DateTime_from_ymd );

use DateTime ();

sub DateTime_from_ymd ($s) {
    my @ymd = split /[\/\-]/, $s;

    if (@ymd != 3) {
        die "Unknown date format in '$s'. Try something like: 2020/01/11";
    }

    return DateTime->new(
        year      => $ymd[0],
        month     => $ymd[1],
        day       => $ymd[2],
        hour      => '0',
        minute    => '0',
        second    => '0',
        time_zone => 'Asia/Taipei',
    );
}
