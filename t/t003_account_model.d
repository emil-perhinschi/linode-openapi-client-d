#!/usr/bin/env dub
/+ dub.json: { "dependencies": { "zug-tap": "*", "linode-openapi-client-d": { "path": "../" }  } } +/

import std.stdio: writeln, stderr;
import dyaml;

void main(string[] args) {
    import oapi.model;
    import zug.tap;

    auto tap = Tap("Testing model Account");

    string content = get_test_json();
    Account acc = Account(content);

    tap.done_testing();
}

string get_test_json() {
    return `
{
    "active_promotions": [
        {
            "credit_monthly_cap": "10.00",
            "credit_remaining": "50.00",
            "description": "Receive up to $10 off your services every month for 6 months! Unused credits will expire once this promotion period ends.",
            "expire_dt": "2018-01-31T23:59:59",
            "image_url": "https://linode.com/10_a_month_promotion.svg",
            "service_type": "all",
            "summary": "$10 off your Linode a month!",
            "this_month_credit_remaining": "10.00"
        }
    ],
    "company": "",
    "email": "emilper@gmail.com",
    "first_name": "Emil Nicolaie",
    "last_name": "Perhinschi",
    "address_1": "28 Noiembrie",
    "address_2": "5/B/10",
    "city": "Siret",
    "state": "Suceava",
    "zip": "725500",
    "country": "RO",
    "phone": "",
    "balance": 0.0,
    "tax_id": "",
    "billing_source": "linode",
    "credit_card": {
        "last_four": "6819",
        "expiry": "05/2024"
    },
    "balance_uninvoiced": 1.57,
    "active_since": "2009-02-11T15:15:43",
    "capabilities": [
        "Linodes",
        "NodeBalancers",
        "Block Storage",
        "Object Storage",
        "Kubernetes",
        "Cloud Firewall",
        "Vlans",
        "LKE HA Control Planes",
        "Machine Images"
    ],
    "euuid": "A8421185-20FE-11EA-B88C0CC47AEB2714"
    }
`;
}