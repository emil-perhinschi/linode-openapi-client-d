module oapi;
import dyaml;

import oapi.model;

Contact get_contact(Node root) {
    Contact contact;

    return contact;
}

Info get_info(Node root) {
    Contact contact = get_contact(root);
    Info info;

    return info;
}

OpenAPI get_openapi_info(Node root) {
    OpenAPI api;
    api.openapi_version = root["openapi"].get!string;
    api.info.api_version = root["info"]["version"].get!string;
    api.info.title = root["info"]["title"].get!string;
    api.info.description = root["info"]["description"].get!string;

    return api;
}

OpenAPI add_servers(OpenAPI api, Node root) {
    if (root.containsKey("servers")) {
        foreach (Node server_node; root["servers"]) {
            if (!server_node.containsKey("url") || server_node["url"].type != NodeType.string) {
                fatal_error("'url' not found in 'servers' or the value is not a string, something is very wrong with the openapi spec file!");
            }
            Server server;
            server.url = server_node["url"].get!string;
            api.servers ~= server;
        }
    }
    return api;
}

OpenAPI add_tags(OpenAPI api, Node root) {
    if (root.containsKey("tags")) {
        foreach (Node tag_node; root["tags"]) {
            Tag tag;
            if (tag_node.containsKey("name")) {
                tag.name = tag_node["name"].get!string;
            }

            if (tag_node.containsKey("description")) {
                tag.description = tag_node["description"].get!string;
            }

            if (tag_node.containsKey("externalDocs")) {
                tag.externalDocs = tag_node["externalDocs"].get!string;
            }
            if (tag.name in api.tags) {
                warning("Tag ", tag.name, " already seen: duplicate.");
            }
            api.tags[tag.name] = tag;
        }
    }
    return api;
}
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
            fatal_error("Key '", key, "' not found in file; Please check it is a proper OpenAPI file!");
        }
    }
}

void warning(T)(T[] message_parts...) {
    import std.conv: to;
    import std.stdio: writeln, stderr;
    import std.array: join;
    stderr.writeln("WARNING: ", message_parts.to!(string[]).join(" "));
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