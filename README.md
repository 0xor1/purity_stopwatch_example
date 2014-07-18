#Purity Stopwatch Example

An extremely simple example application to demo the Purity framework.
Run [`test/integration/index_without_purity.html`](http://0xor1.github.io/purity_stopwatch_example/without_purity/)
to see the whole app running on the client with the view directly
consuming the source, or run [`test/integration/index_with_purity.html`](http://0xor1.github.io/purity_stopwatch_example/)
to see the whole app running on the client with remote proxy objects
relaying messages through the **Host** also running on the client.

Run `pub build` and then run `build/bin/host.dart` to run the app as a full distributed
app, browse to `http://127.0.0.1:4346/` to see the view consuming the remote proxy object 
with all messages being realyed to/from the **Host** via websockets.
