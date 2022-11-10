module oapi.model;

enum BillingSource : string {
    akamai = "akamai",
    linode = "linode"
}

struct CreditCard {
    string card_number; // min: 14 char, max 24 char
    long expiry_month;
    long expiry_year;
    long cvv; 
}

/*
if ("credit_card" in json) {
    auto card_json = json["credit_card"];
    if ("card_number" in card_json) {
        this.credit_card.card_number = card_json["card_number"].str;
    }
    if ("expiry_month" in card_json) {
        this.credit_card.expiry_month = card_json["expiry_month"].integer;
    }
    if ("expiry_year" in card_json) {
        this.credit_card.expiry_year = card_json["expiry_year"].integer;
    }
    if ("cvv" in card_json) {
        this.credit_card.cvv = card_json["cvv"].integer; 
    }
}
*/

struct CreditCardPrivate {
    string last_four;
    string expiry;
}


enum ServiceType : string {
    all  = "all",
    backup  = "backup",
    blockstorage  = "blockstorage",
    db_mysql  = "db_mysql",
    ip_v4  = "ip_v4",
    linode  = "linode",
    linode_disk  = "linode_disk",
    linode_memory  = "linode_memory",
    longview  = "longview",
    managed  = "managed",
    nodebalancer  = "nodebalancer",
    objectstorage  = "objectstorage",
    transfer_tx  = "transfer_tx"
}

struct Promotion {
    string credit_monthly_cap;
    string credit_remaining;
    string description;
    string expire_dt;
    string image_url;
    string summary;
    string this_month_credit_remaining;
    ServiceType service_type;

}

struct Account {
    Promotion[] active_promotions;
    string active_since;
    string address_1;
    string address_2;
    float balance;
    float balance_uninvoiced;
    BillingSource billing_source;
    string city;
    CreditCardPrivate credit_card;
    string company;
    string country;
    string email;
    string first_name;
    string last_name;
    string phone;
    string state;
    string tax_id;
    string euuid;
    string zip;

    this(string json_data) {
        import std.json: parseJSON;
        import std.stdio: writeln;
        import std.conv: to;

        auto json = parseJSON(json_data);
        this.active_since = json["active_since"].str;
        this.address_1 = json["address_1"].str;
        this.address_2 = json["address_2"].str;
        this.balance = json["balance"].floating;
        this.balance_uninvoiced = json["balance_uninvoiced"].floating;
        this.city = json["city"].str;
        this.company = json["company"].str;
        this.country = json["country"].str;
        this.email = json["email"].str;
        this.first_name = json["first_name"].str;
        this.last_name = json["last_name"].str;
        this.phone = json["phone"].str;
        this.state = json["state"].str;
        this.tax_id = json["tax_id"].str;
        this.euuid = json["euuid"].str;
        this.zip = json["zip"].str;
        
        if ("active_promotions" in json) {
            foreach (promotion; json["active_promotions"].array) {
                Promotion p;
                p.credit_monthly_cap = promotion["credit_monthly_cap"].str;
                p.credit_remaining = promotion["credit_remaining"].str;
                p.description = promotion["description"].str;
                p.expire_dt = promotion["expire_dt"].str;
                p.image_url = promotion["image_url"].str;
                p.service_type = to!ServiceType(promotion["service_type"].str);
                p.summary = promotion["summary"].str;
                p.this_month_credit_remaining = promotion["this_month_credit_remaining"].str;
                this.active_promotions ~= p;
            }
        }

        if ("credit_card" in json) {
            this.credit_card.expiry = json["credit_card"]["expiry"].str;
            this.credit_card.last_four = json["credit_card"]["last_four"].str;
        }

        if ("billin_source" in json) {
            this.billing_source = to!BillingSource(json["billing_source"].str);
        }

    }
}

struct OpenAPI {
    string openapi_version;
    Info info;
    Tag[string] tags;
    Server[] servers;
}

struct Server {
    string url;
}

struct Info {
    string api_version;
    string title;
    string description;
    Contact contact;
}

struct Contact {
    string name;
    string url;
    string email;
}

struct Tag {
    string name;
    string description;
    string externalDocs;
}