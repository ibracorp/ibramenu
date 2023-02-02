Before install, since we are going to validate the domains via DNS provider we will have to get an API token to allow the validation to take place.

This will be slightly different for each provider. We will use Cloudflare.

1 Log in Cloudflare, you will be in the Overview tab.

2 Now go to the botton right side of the screen and choose the top tab "Get your API Tokens". Click "Create Token", "Create Custom Token" and then change the zones resources to include all zones (you can specify just a single domain here if you like).

3 Now choose the top tab "API Tokens". Click "Create new API Token" and then change the zones resources to include all zones (you can specify just a single domain here if you like).
Click "Continue to summary" and then "Create Token". Copy this token and keep it somewhere safe for now.

Fot the realIP mode:

Edit the nginx.conf using `nano /mnt/user/appdata/swag/nginx/nginx.conf` and add `real_ip_recursive on;`
it should look like this:

```real_ip_header X-Forwarded-For;
real_ip_recursive on;
include /config/nginx/cf_real-ip.conf;```