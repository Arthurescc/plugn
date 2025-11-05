## Requirements

- **PHP**: Version 8.2 or higher is required [`composer.json`](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/composer.json#L1-L78).
- **Composer**: Required for dependency management.
- **Database**: MySQL. For local development, the default credentials are:
  - Host: `localhost`
  - Port: `3306`
  - Username: `root`
  - Password: `12345`
  - PhpMyAdmin is available at [http://localhost:8080](http://localhost:8080) [`README.md`](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/README.md#L13-L341).

## Install Dependencies

Run the following command in the project root to install PHP dependencies:

```bash
composer install
```

If using Docker, you may need to run this inside the backend container:

```bash
docker-compose exec backend bash
php composer.phar install
```

## Environment & Configuration

Configuration is managed via files in the `environments/` directory, such as `environments/dev/common/config/params-local.php` and `common/config/main.php`. You may need to create or edit these files for your environment.

### Example: `params-local.php`

```php
return [
  'apiEndpoint' => 'http://localhost/plugn/api/web',
  'frontendUrl' => 'http://localhost/plugn/frontend/web',
  'dashboardAppUrl' => 'https://dash.staging.plugn.io',
  'crmAppUrl'  => 'https://crm.staging.plugn.io',
  'dashboardCookieDomain' => 'dash.dev.plugn.io',
  'newDashboardAppUrl' => 'https://dash.dev.plugn.io',
  'oneSignalStoreAPPID' => '',
  'oneSignalStoreAPIKey' => '',
  'oneSignalAgentAPPID' => '',
  'oneSignalAgentAPIKey' => '',
  'currencylayer_api_key' => ''
];
```
[`params-local.php`](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/environments/dev/common/config/params-local.php#L3-L16)

### Example: `main.php` (Key Services)

- **AWS S3**:  
  - `region`: `eu-west-2`
  - `key`: AWS access key
  - `secret`: AWS secret key
  - `bucket`: `plugn-public-anyone-can-upload-24hr-expiry`
- **Slack**:  
  - `slack.url`: Webhook URL for notifications
  - `slackTapOperation.url`: Webhook URL for TapPayments ops
  - `slackError.url`: Webhook URL for error reporting
- **Payment Gateways**:  
  - TapPayments: `plugnLiveApiKey`, `plugnTestApiKey`, `destinationId`
  - MyFatoorah: `kuwaitLiveApiKey`, `kuwaitTestApiKey`, `saudiLiveApiKey`
- **Other Keys**:  
  - Cloudinary: `cloud_name`, `api_key`, `api_secret`
  - ApplePay, Ipstack, reCaptcha, Auth0, Zapier, JWT, Google Maps, Netlify, Github, OneSignal, currencylayer

See [`main.php`](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/common/config/main.php#L3-L172) for full details.

### Security

- Set a unique `cookieValidationKey` in your local config (`main-local.php`):
  ```php
  'request' => [
      'cookieValidationKey' => 'YOUR_UNIQUE_KEY',
  ],
  ```

## Running Migrations & Yii Console Commands

After dependencies are installed and configuration is set:

```bash
./init
./yii migrate
```

If using Docker, run these inside the backend container:

```bash
docker-compose exec backend bash
./init
./yii migrate
```

### Common Yii Console Commands (for cron jobs)

- `cron/site-status`
- `cron/create-payment-gateway-account`
- `cron/update-transactions`
- `cron/update-stock-qty`
- `cron/send-reminder-email`
- `cron/make-refund`
- `cron/update-refund-status-message`
- `cron/update-voucher-status`
- `cron/update-sitemap`
- `cron/retention-emails-who-passed-five-days-and-no-sales`
- `cron/retention-emails-who-passed-two-days-and-no-products`
- `cron/notify-agents-for-subscription-that-will-expire-soon`
- `cron/downgraded-store-subscription`
- `cron/create-build-js-file`
- `cron/weekly-report`
See [`README.md`](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/README.md#L13-L341) for scheduling details.

## Starting the App Locally

### Using Docker

```bash
docker-compose up
```

This will start the backend, MySQL, and Redis containers. Access the backend container for further commands:

```bash
docker-compose exec backend bash
```

### Using PHP Built-in Server

You may also use the PHP built-in server for development:

```bash
php -S localhost:8083 -t backend/web
```

### Using nginx

If nginx is configured, use the provided Dockerfile or local nginx configuration. The Docker setup will start nginx automatically.

## Endpoints Used by Ionic/Vue Frontends

Controllers and routes commonly used by frontends include:

- **API Controllers**:
  - `api/modules/v1/controllers/OrderController.php`
  - `api/modules/v2/controllers/OrderController.php`
  - `api/modules/v2/controllers/QueueController.php` (POST `/v2/queue/create`) [`QueueController`](https://github.com/BAWES-Universe/plugn/pull/39)
- **Agent Module Controllers**:
  - `agent/modules/v1/controllers/AddonController.php`
  - `agent/modules/v1/controllers/InvoiceController.php`
  - `agent/modules/v1/controllers/PlanController.php`
- **Frontend Controller**:
  - `frontend/controllers/SiteController.php` (includes `paymentWebhook` action)

These controllers expose endpoints for order management, payment webhooks, queue creation, and agent operations. The API uses RESTful routes defined via `yii\rest\UrlRule` in `api/config/main.php`.

## Troubleshooting

### Missing Environment Variables

- Ensure all required keys (AWS, Slack, payment, DB, etc.) are set in your config files.
- If migrations fail due to missing columns or schema issues, clear the cache:
  ```bash
  ./yii cache/flush-schema db
  ./yii cache/flush cache
  ```
  Or manually remove runtime cache folders as described in the [`README.md`](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/README.md#L13-L341).

### Database Connection Issues

- Verify MySQL is running and accessible with the correct credentials.
- If using Docker, wait for MySQL to be ready before running migrations. Deployment scripts may attempt to connect up to 60 times before failing [`PR #31`](https://github.com/BAWES-Universe/plugn/pull/31).
- For SSL connection issues, add `--ssl=0` to your MySQL command [`PR #34`](https://github.com/BAWES-Universe/plugn/pull/34).

### Permissions

- Ensure file and directory permissions allow the web server and PHP process to read/write runtime and cache directories.
- If you encounter permission errors, check ownership and permissions of the `runtime/` and `web/assets/` directories.

### Debugging

- In development, debug and gii modules are enabled. Access them for troubleshooting via the web interface if needed.

---

For further details, refer to the [plugn README](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/README.md#L13-L341) and configuration files in the repository.
