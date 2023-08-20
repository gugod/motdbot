use v5.38;
use utf8;
use feature 'class';
use Motdbot::MessageBuilder;

class Motdbot::MessageBuilder::TaiwanElectionDayCountdown :isa(Motdbot::MessageBuilder) {
    use Motdbot::Fun qw(DateTime_from_ymd);
    use List::MoreUtils qw(part);

    method build () {
        # Sorted by date.
        my @votes = (
            # Date, Title, URL
            ["2024/01/13", "第16任總統副總統及第11屆立法委員選舉", "https://www.cec.gov.tw/central/cms/112news/39148"],
            ["2021/02/06", "高雄市議員黃捷罷免案", "https://www.cec.gov.tw/central/cms/110news/34965"],
            ["2021/10/23", "第10屆立法委員臺中市第2選舉區陳柏惟罷免案", "https://www.cec.gov.tw/central/cms/110news/35453"],
            ["2021/12/18", "全國性公民投票", "https://www.cec.gov.tw/central/cms/110news/35412"],
            ["2022/01/09", "立法委員臺中市第2選舉區缺額補選", "https://www.cec.gov.tw/central/cms/110news/35853"],
            ["2022/01/09", "第10屆立法委員林昶佐罷免案", "https://web.cec.gov.tw/central/cms/110news/36048"],
            ["2022/11/26", "地方公職人員選舉", "https://www.cec.gov.tw/central/cms/111news/36291"],
            ["2022/11/26", "111年憲法修正案之複決案", "https://www.cec.gov.tw/central/cms/111news/36606"],
            ["2022/12/18", "嘉義市第11屆市長重行選舉", "https://web.cec.gov.tw/central/cms/111news/38110"],
        );

        return build_countdown_message( DateTime_from_ymd($self->today), \@votes );
    }

    sub titles ($votes) {
        my @titles = map { "#". $_->{"title"} } @$votes;
        if (@titles == 1) {
            return $titles[0];
        } else {
            return "- " . join("\n- ", @titles);
        }
    }

    sub build_countdown_message ($today, $votes) {
        my @votes = map {
            my $date = DateTime_from_ymd( $_->[0] );
            my $diff_days = int ($date->epoch - $today->epoch())/86400;

            +{
                "date" => $date->ymd("/"),
                "title" => $_->[1],
                "url" => $_->[2],
                "diff_days" => $diff_days,
            }
        } @$votes;

        my ($past_votes, $yesterday_votes, $today_votes, $tomorrow_votes, $upcoming_votes) = part {
            my $diff = ($_->{"diff_days"} + 2);
            $diff <= 0 ? 0 : $diff >= 4 ? 4 : $diff;
        } @votes;

        my $msg = "";
        my $hashtags = "#台灣投票\n#TaiwanVotes";

        if ($today_votes) {
            $msg = "投票日... 不就是今天嗎。\n\n" . titles($today_votes) . "\n\n#你投票了嗎\n" . $hashtags;
        } elsif ($tomorrow_votes) {
            $msg = "投票日... 就是明天呢。\n\n" . titles($tomorrow_votes) . "\n\n#記得去投票\n" . $hashtags;
        } elsif ($upcoming_votes) {
            $msg = join(
                "\n\n",  map {
                    "離 #" . $_->{"title"} . " 投票日 " . $_->{"date"} . " 還有 " . $_->{"diff_days"} . " 天。"
                } @$upcoming_votes
            ) . "\n\n" . $hashtags;
        } elsif ($yesterday_votes) {
            $msg = '投票日倒數完畢 ! 總算可以放假了。';
        }

        return $msg;
    }
}
