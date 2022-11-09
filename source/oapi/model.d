module oapi.model;

enum BillingSource : string {
    akamai = "akamai",
    linode = "linode"
}

struct CreditCard {
    string card_number; // min: 14 char, max 24 char
    int expiry_month;
    int expiry_year;
    int cvv; 
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
    Promotion[] promotions;
    string active_since;
    string address_1;
    string address_2;
    float balance;
    string balance_string;
    float balance_uninvoiced;
    string balance_uninvoiced_as_string;
    BillingSource billing_source;
    string city;
    CreditCard credit_card;
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