// Copyright (C) 2023 Florian Loitsch.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the EXAMPLES_LICENSE file.

import http
import encoding.json
import monitor
import net
import host.os // For os.env.get.
import chatbot show *

import .index

main:
  openai_key := os.env.get "OPENAI_KEY"
  if not openai_key or openai_key == "":
    print "Please set the OPENAI_KEY environment variable."
    return

  main --openai_key=openai_key

main --openai_key/string:
  bot := HttpBot "http-bot" --openai_key=openai_key
  bot.run

class HttpBot extends ChatBot:
  my_name_/string
  network_/net.Interface? := null
  port_/int
  response_channel_/monitor.Channel := monitor.Channel 1

  constructor .my_name_
      --port/int=8080
      --openai_key/string:
    network_ = net.open
    port_ = port
    super --openai_key=openai_key

  close:
    super
    if network_:
      network_.close
      network_ = null

  run -> none:
    server := http.Server
    server.listen network_ port_:: | request/http.Request writer/http.ResponseWriter |
      clear_old_messages_
      if request.path == "/" or request.path == "/index.html":
        writer.write INDEX_PAGE
      else if request.path == "/new_message":
        decoded := json.decode_stream request.body
        message := decoded["message"]
        store_message_ message --chat_id=0
        send_response_ 0
        response := response_channel_.receive
        writer.headers.set "Content-Type" "application/json"
        encoded := json.encode {
          "response": response
        }
        writer.write encoded
      writer.close

  send_message_ text/string --chat_id/any:
    response_channel_.send text
