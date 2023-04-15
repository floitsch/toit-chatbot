# HTTP Chat Bot

A simple HTTP chat bot using OpenAI's API that runs on an ESP32 (or
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


## Running locally
Set the following environment variables:
- `OPENAI_API_KEY`: your OpenAI API key

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

## Support
If you have questions, please ask on the [Toit Discord](https://discord.gg/Q7Y9VQ5nh2).
