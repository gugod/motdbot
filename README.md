motdbot -- Message-of-the-day bot.

# Examples

Print a new Fortune message to STDOUT:

```
motdbot --message-builder Fortune
```

Print a new MoonPhase message to STDOUT, as if today is 2022-12-31. All Message Builders honor this CLI argument and compute the correct message if message-building process depends on the current date.

```
motdbot --message-builder MoonPhase \
    --today=2022-12-31
```

Print a new FridayThe13Countdown message to STDOUT, as well as to a mastodon instance. Without the `--yes` option, it is a dry-run -- no posts are made to any remote channels.

```
motdbot --message-builder FridayThe13Countdown \
    --yes
    --mastodon-config /app/config/mastodon.yml
```
