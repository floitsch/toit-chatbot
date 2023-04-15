// Copyright (C) 2023 Florian Loitsch.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the EXAMPLES_LICENSE file.

/**
Index page.

Generated (and then sligthly adjusted) by OpenAI with the following prompt:
```
Write a small html page that implements a chat bot application.
The page should look good.
Whenever the user enters a message (submitting with Enter), the message should be sent to the server (endpoint `/new_message` as json with key "message"). The response is another JSON (key "response") containing pure text. This text should then be shown.
Don't forget to escape the returned text and replace `\n` with visible new lines.
```

If you don't like the style, just run the same query.
*/

INDEX_PAGE ::= """
<!DOCTYPE html>
<html>
<head>
	<title>Chat Bot Application</title>
	<style>
		/* Chat box style */
		.chatbox {
			width: 400px;
			height: 500px;
			background-color: #f5f5f5;
			margin: 50px auto;
			padding: 20px;
			border-radius: 10px;
			box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
			overflow-y: scroll;
		}
		.chatbox p {
			margin: 10px 0;
		}
		/* Input box style */
		.inputbox {
			width: 100%;
			height: 50px;
			padding: 10px;
			border: none;
			border-radius: 5px;
			box-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
			font-size: 16px;
			outline: none;
			margin-top: 20px;
			box-sizing: border-box;
		}
		/* Colors */
		.user-message {
			color: #007bff;
		}
		.bot-message {
			color: #28a745;
		}
	</style>
</head>
<body>
	<div class="chatbox">
		<h2>Chat Bot Application</h2>
		<div id="chatlog"></div>
		<input type="text" id="userinput" class="inputbox" placeholder="Type your message and hit Enter to send">
	</div>

	<script>
		// Function to send user input to server and receive response
		function sendMessage(userinput) {
      let xhr = new XMLHttpRequest();
      xhr.open('POST', '/new_message', true);
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.onload = function() {
        if (xhr.status === 200) {
          let response = JSON.parse(xhr.responseText).response;
          let chatlog = document.getElementById('chatlog');
          chatlog.innerHTML += '<p class="bot-message"><strong>Bot:</strong> ' + response.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\\n/g, "<br>") + '</p>';
          chatlog.scrollTop = chatlog.scrollHeight;
        } else {
          console.error(xhr.statusText);
        }
      };
      xhr.onerror = function() {
        console.error(xhr.statusText);
      };
      xhr.send(JSON.stringify({message: userinput}));
		}

		// Call sendMessage function when user hits Enter
		document.getElementById('userinput').addEventListener('keyup', function(event) {
			if (event.keyCode === 13) {
				event.preventDefault();
        let chatlog = document.getElementById('chatlog');
        let userinput = document.getElementById('userinput').value.trim();
        if (userinput) {
          chatlog.innerHTML += '<p class="user-message"><strong>You:</strong> ' + userinput.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\\n/g, "<br>") + '</p>';
          document.getElementById('userinput').value = '';
          sendMessage(userinput);
        }
			}
		});
	</script>
</body>
</html>
"""
