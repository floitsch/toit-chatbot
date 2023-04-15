# Telegram Chat Bot

A simple Telegram bot using OpenAI's API that runs on an ESP32 (or
  desktop if you prefer).

## Setup
### Toit
Make sure you have [Toit](toitlang.org) installed. The easiest is to use
  [Jaguar](https://github.com/toitlang/jaguar).

Install the dependencies (in this directory; or add `--project_root=<DIR>`).
- with Jaguar: `jag pkg install`
- with pure Toit: `toit.pkg install`

If you are using Jaguar (preferred), flash it to your device:
- `jag flash`

### OpenAI
Create an account at https://platform.openai.com/, and create an API key
in the [api-keys page](https://platform.openai.com/account/api-keys).

### Telegram
Create a new Telegram bot by running `/newbot`. '@BotFather' will as you
for a name and username, then provide the authentication token.

If you want your bot to be able to chat in groups, you need to disable
"Groups Privacy": go into the settings, by running `/mybots` and select
the bot you just created. Go to the "Group Privacy" section and disable
it.

## Authentication
This example bot requires a password before it sends any request to OpenAI.

To provide the password write the following in a direct message to the bot:
```
/authenticate <password>
```

If you want to authorize a group, take the group's chat-id. (The chat-bot
will tell you the chat-id in its error message). Then write the following
in a direct message to the bot:
```
/authenticate <password> <chat-id>
```

## Running locally
Set the following environment variables:
- `OPENAI_API_KEY`: your OpenAI API key
- `TELEGRAM_TOKEN`: the token provided by '@BotFather'
- `CHAT_PASSWORD`: the password for the chat. (See the 'Authentication'
  section above)

Run the bot:
- with Jaguar: `jag run -d host main.toit`
- with pure Toit: `toit.run main.toit`

## Running on an ESP32
Take the provided `esp32-example.toit` and copy/rename it to
`esp32.toit` (or `esp32_<suffix>.toit` if you want to
run multiple bots).

Change the credentials in that file, then do the usual Jaguar installation
steps:
* optionally start the serial monitor: `jag monitor`
* run the bot: `jag run esp32.toit`

If you want to install the bot so it runs on boot:
* install the bot: `jag container install bot esp32.toit`

If you have questions, please ask on the [Toit Discord](https://discord.gg/Q7Y9VQ5nh2).

## Support
If you have questions, please ask on the [Toit Discord](https://discord.gg/Q7Y9VQ5nh2).
