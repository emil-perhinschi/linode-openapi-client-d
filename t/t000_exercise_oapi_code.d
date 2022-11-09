#!/usr/bin/env dub
/+ dub.json: { "dependencies": { "zug-tap": "*", "linode-openapi-client-d": { "path": "../" }  } } +/

// The purpose of this file it to call stuff and see if they crash or smth
void main() {
    warning("this", "is", "a", "warning");
    warning(1, 2, 3, 4);
}