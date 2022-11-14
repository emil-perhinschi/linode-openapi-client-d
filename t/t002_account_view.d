#!/usr/bin/env dub
/+ dub.json: { "dependencies": { "zug-tap": "*", "linode-openapi-client-d": { "path": "../" }  } } +/

import std.stdio: writeln, stderr;
import dyaml;

void main(string[] args) {
    import oapi;
    import oapi.model;
    import oapi.actions;
    import std.process;
    alias env = std.process.environment;

    import zug.tap;

    auto tap = Tap("Testing action AccountView");

    string linode_key = env.get("LINODE_API_KEY");
    if (linode_key.length == 0) {
        tap.skip("The LINODE_API_KEY environment variable is not set or is empty, skipping all tests.");
    }

    AccountEndpoint account_action = AccountEndpoint(linode_key);
    Account account = account_action.get();

    // How do make tests work for everybody ? ... 
    // https://www.linode.com/community/questions/23484/is-there-a-stagingtesting-server-for-the-linode-api 
    tap.ok(account.first_name != "");
    tap.ok(account.last_name != "");
    tap.ok(account.euuid != "");
    tap.done_testing();
}


