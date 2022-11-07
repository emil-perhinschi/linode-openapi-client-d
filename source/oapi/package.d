module oapi;
import dyaml;

bool file_is_valid(string file_name) {
    import std.stdio: writeln, stderr;
    import std.file: exists;
    if (!file_name.exists) {
        return false;
    }
    // TODO 
    //   - how do I test easily it is a yaml file ?

    return true;
}

void looks_like_oapi_file(Node root) {
    string[] expected_keys_in_root = [
        "openapi",
        "info",
        "servers",
        "paths",
        "components",
        "tags"
    ];
    if(!(root.type == NodeType.mapping) ) {
        fatal_error("The root node is not a 'mapping' so it does not look like the root of an OpenAPI file. Giving up ...");
    }

    foreach (string key; expected_keys_in_root) {
        if (!root.containsKey(key)) {
            fatal_error("Key '", key, "' not found in file ", oapi_file, "; Please check it is a proper OpenAPI file!");
        }
    }
}

void fatal_error(const(char)[] message) {
    import std.conv: to;
    fatal_error(message.to!string);
}

void fatal_error(string[] message...) {
    import std.array: join;
    fatal_error(message.join(""));
}

void fatal_error(string message) {
    import std.stdio: writeln, stderr;
    import core.stdc.stdlib: exit;
    stderr.writeln("ERROR: ", message);
    exit(1);
}