motdbot -- Message-of-the-day bot.

# Examples

Print a new Fortune message to STDOUT:

```
motdbot --message-maker Fortune
```

Print a new MoonPhase message to STDOUT, as if today was 2022-12-31. Message makers honor this CLI argument and compute the correct message if message-building process depending on the current date.

```
motdbot --message-maker MoonPhase \
    --today=2022-12-31
```

Print a new FridayThe13Countdown message to STDOUT, as well as to multiple remote channels. (Without the `--yes` option, it shall be a dry-run -- no posts are made to any remote channels.)

```
motdbot --message-maker FridayThe13Countdown \
    --yes
    --twitter-config /app/config/tweet-1.yml \
    --twitter-config /app/config/tweet-2.yml \
    --twitter-config /app/config/tweet-3.yml \
    --mastodon-config /app/config/mastodon-1.yml
    --mastodon-config /app/config/mastodon-2.yml
    --mastodon-config /app/config/mastodon-3.yml
```
