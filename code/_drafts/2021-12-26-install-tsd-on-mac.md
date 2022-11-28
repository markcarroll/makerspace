---
layout: post
title:  "Install The Spaghetti Detective on a Mac"
author: mark
categories: [ 3dprinting ]
tags: [TSD, Voron, Ender6]
image: assets/images/5.jpg
description: "My steps to installing The Spaghetti Detective on a Mac"
print: false
---

For folks that haven't found it, The Spaghetti Detective is a fantastic AI-driven tool for monitoring your 3D prints and alerting you to potential failure, i.e. spaghetti. There is a hosted service that you can sign up for, but the amazing folks at TSD have also released the service as an open source download that you can run on your own machine.  This is my process for getting this working locally.

These are my steps to installing TheSpaghettiDetective on a Mac and configuring DNS/Reverse Proxy to give it a unique DNS name.

## Set up DNS to point to the machine

In your router's DNS settings create a `CNAME` if you can that maps to the machine that you are installing TSD on.  So in my case I have a Mac Mini called `minimus` so I am going to create `tsd.minimus.home` to map to `minimus.home`.  If you can't create `CNAME`s you will have to create an `A` entry and map the new machine name to the IP of your Mac.

## Setup local reverse proxy with nginx

Before running this commands make sure you have Homebrew installed.

1. Install nginx

    ```sh
    brew install nginx
    ```

2. Setup launchd to start nginx on login and now

    ```sh
    brew services start nginx
    ```

3. By default `brew` installs `nginx` into `/opt/homebrew/etc/nginx`. It creates a `servers` directory from which it loads all config files present in there.  So we add a new file called `tsd.conf` with these contents:

    ```conf
      server {
        listen 80;
        server_name tsd.**YOUR MACHINE NAME HERE**;

        location / {
          proxy_pass http://localhost:3334/;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host $http_host;
          proxy_set_header X-Forwarded-Proto https;
          proxy_redirect off;
          client_max_body_size 10m;
        }
        location /ws/ {
          proxy_pass http://localhost:3334/ws/;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "Upgrade";
        }
      }
    ```

4. Restart `nginx`:

    ```sh
    brew services restart nginx
    ```

Done. Now you can go to http://localhost and it will be proxied to the TSD instance installed there. You also may want to change proxy port in nginx config.