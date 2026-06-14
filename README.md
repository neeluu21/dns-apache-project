# 🌐 DNS + Apache Setup (Ubuntu EC2) – Complete Guide

## 📌 Project Overview

This project demonstrates:

* DNS Server setup using BIND9
* Domain configuration (neel.test)
* Apache Web Server integration
* Access website using domain name

---

# 🔹 Step 1: Install DNS (BIND9)

```bash
sudo apt update
sudo apt install bind9 bind9utils bind9-doc dnsutils -y
```

Start service:

```bash
sudo systemctl start bind9
sudo systemctl enable bind9
```

---

# 🔹 Step 2: Configure DNS Zone

## Edit zone config:

```bash
sudo nano /etc/bind/named.conf.local
```

Add:

```bash
zone "neel.test" {
    type master;
    file "/etc/bind/db.neel.test";
};
```

---

## Create zone file:

```bash
sudo cp /etc/bind/db.local /etc/bind/db.neel.test
```

Edit:

```bash
sudo nano /etc/bind/db.neel.test
```

Update:

```bash
$TTL    604800
@       IN      SOA     neel.test. root.neel.test. (
                              2
                         604800
                          86400
                        2419200
                         604800 )

@       IN      NS      neel.test.
@       IN      A       13.203.81.240
www     IN      A       13.203.81.240
```

---

# 🔹 Step 3: Configure DNS Options

```bash
sudo nano /etc/bind/named.conf.options
```

Add:

```bash
options {
    directory "/var/cache/bind";

    listen-on { any; };
    allow-query { any; };

    recursion yes;

    forwarders {
        8.8.8.8;
        8.8.4.4;
    };

    dnssec-validation auto;
};
```

---

# 🔹 Step 4: Restart DNS

```bash
sudo systemctl restart bind9
```

---

# 🔹 Step 5: Test DNS

```bash
dig @127.0.0.1 neel.test
```

Expected:

```
status: NOERROR
```

---

# 🔹 Step 6: Install Apache

```bash
sudo apt install apache2 -y
```

Start:

```bash
sudo systemctl start apache2
sudo systemctl enable apache2
```

---

# 🔹 Step 7: Allow Port 80

```bash
sudo ufw allow 80
```

---

# 🔹 Step 8: AWS Security Group

Allow:

* HTTP (Port 80)
* DNS (Port 53)

---

# 🔹 Step 9: Test Web Server

Open:

```
http://13.203.81.240
```

---

# 🔹 Step 10: Configure Local System (IMPORTANT)

## On Windows:

Edit:

```
C:\Windows\System32\drivers\etc\hosts
```

Add:

```
13.203.81.240 neel.test www.neel.test
```

Flush DNS:

```bash
ipconfig /flushdns
```

---

# 🔹 Step 11: Access Website

Open:

```
http://neel.test
http://www.neel.test
```

---

# 🧠 Key Concepts

* DNS resolves domain → IP
* Apache serves website
* `/etc/hosts` = local DNS override
* `dig @127.0.0.1` = test BIND directly
