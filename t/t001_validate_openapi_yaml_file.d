#!/usr/bin/env dub
/+ dub.json: { "dependencies": { "zug-tap": "*", "linode-openapi-client-d": { "path": "../" }  } } +/

import std.stdio: writeln, stderr;
import dyaml;

void main(string[] args) {
    import oapi;
    import oapi.model;
    import std.conv: to;

    if (args.length <= 1 ) {
        fatal_error("OpenAPI file name is required, giving up ... ");
    }

    string oapi_file = args[1];
    if (!file_is_valid(oapi_file)) {
        fatal_error("There is a problem with the file ", oapi_file);
    }

    Node root;

    try {
        root = Loader.fromFile(oapi_file).load();
    } catch(YAMLException e) {
        fatal_error(e.message);
    }

    // this writes an error message and exits in case it does not look like the Linode openapi.yaml
    looks_like_oapi_file(root);

    OpenAPI api = get_openapi_info(root);

    api = add_tags(api, root);
    api = add_servers(api, root);
}



void guessing_how_to_use_dyaml() {
    string oapi_file = "openapi.yaml";

    Node root = Loader.fromFile(oapi_file).load();
    writeln(typeof(root).stringof);
    writeln("root length: ", root.length);

    writeln("root type is: ", root.type);

    foreach (component; root["components"]["schemas"].mapping) {
        writeln("class ", component.value["type"].get!string, " ", component.key.get!string);
        auto schema = component.value;
        if (!schema.containsKey("properties")) {
            writeln("!!! not found properties");
            continue;
        }

        foreach (property; component.value["properties"].mapping) {
            if (!property.value.containsKey("type")) {
                writeln(">>> property without type");
                continue;
            }

            if (property.value["type"].get!string == "string") {
                writeln("  ", property.value["type"].get!string, " ", property.key.get!string);
                if (property.value.containsKey("enum")) {
                    writeln("    enum");
                    foreach(Node v; property.value["enum"]) {
                        writeln("      - ", v.get!string);
                    }
                }
            } else if (property.value["type"].get!string == "array") {
                auto x = property.value["items"];
                if (x.containsKey("type") && x["type"].get!string == "object") {

                } else {
                    if (x.type == NodeType.mapping) {
                        foreach (item; x.mapping) {
                            writeln(";;;;;;;;;;;;;;; ", typeof(item).stringof);
                            writeln("key type is ", item.key.get!string, " >>> key value type is ", item.value.type, " >> value is ", item.value.get!string);
                        }
                    }
                }
            } else if (property.value["type"].get!string == "object") {
                writeln("  is object ", property.key.get!string);
            } else if (property.value["type"].get!string == "number") {
                writeln("  number ", property.key.get!string);
            } else {
                writeln("  is something new: ", property.value["type"].get!string);
            }
        }
    }

    // foreach (item; root.mapping) {
    //     writeln(typeof(item).stringof, " ", typeof(item.key).stringof, " ", typeof(item.value).stringof, " ", item.key, " ", item.value.type, " ", typeof(item.value.type).stringof);
    //     // if (item.value.type == NodeType.string) {
    //     //     writeln(item.value);
    //     // } else if (item.value.type == NodeType.mapping) {
    //     //     unfold_mapping(item.value);
    //     // }
    // }
}

void unfold_node(Node item) {

    foreach (Node key, Node value; item) {
        writeln(key, " ", value.type);
    }
}




// foreach (item; root["components"]["schemas"]["Account"]["properties"].mapping) {
//     writeln(item.key, " ", item.value["type"]);
// }