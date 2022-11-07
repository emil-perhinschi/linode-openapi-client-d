enum BillingSource {
    akamai = "akamai",
    linode = "linode"
}

class CreditCard {
    string card_number; // min: 14 char, max 24 char
    int expiry_month;
    int expiry_year;
    int cvv; 
}

struct Promotion {}

class Account {
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
