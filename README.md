#Purity Stopwatch Example

The simplest possible example application I could think of to demo Purity.
Run [`test/integration/index_without_purity.html`](http://0xor1.net/purity_stopwatch_example/index_without_purity.html) to see the whole app running
on the client side with the view directly consuming the model, or run
[`test/integration/index_with_purity.html`](http://0xor1.net/purity_stopwatch_example/index_with_purity.html) to see the whole app running on the 
client side with remote proxy objects relaying meesages through the core Purity
app server also running in the browser.

Run `pub build` and then run `build/bin/server.dart` to run the app as a full Purity
client-server app and browse to `http://127.0.0.1:4346/` to see the view consuming
the remote proxy object with all messages being realyed to the remote server via websockets.

Enjoy!