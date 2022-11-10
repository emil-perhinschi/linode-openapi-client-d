module oapi.actions;

import oapi;

struct APIInfo {
    string api_key;
    string base_url = "https://api.linode.com/v4";

    this(string api_key) {
        this.api_key = api_key;
        if (this.api_key.length == 0) {
            fatal_error("The LINODE_API_KEY environment variable is not set or is empty, giving up ...");
        }
    }
}

// Account View, /account, get
struct AccountEndpoint {
    import oapi.model;
    APIInfo api;
    string path = "/account";

    this(string api_key) {
        this.api = APIInfo(api_key);
    }
  
    Account get() {
        import std.conv: to;
        import std.net.curl;
        import std.stdio: writeln;
        auto client = HTTP();
        client.addRequestHeader("Authorization", "Bearer " ~ this.api.api_key);
        string content = std.net.curl.get("https://api.linode.com/v4/account", client).to!string;
        
        return Account(content);
    }
}
// Account Update, /account, put

