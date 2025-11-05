## External Integrations in `plugn/common/config/main.php`

This document lists all major external integrations configured in the backend, including their purpose, configuration location, and whether they are required for local development.

### AWS S3

**Purpose:**  
Used for managing file uploads and resources in Amazon S3 buckets, including saving, copying, deleting files, and retrieving file metadata. The `temporaryBucketResourceManager` component is specifically used for temporary public uploads with a 24-hour expiry.

**Configuration:**  
Configured as the `temporaryBucketResourceManager` component in `plugn/common/config/main.php`:

```php
'temporaryBucketResourceManager' => [
    'class' => 'common\components\S3ResourceManager',
    'region' => 'eu-west-2',
    'key' => '...',
    'secret' => '...',
    'bucket' => 'plugn-public-anyone-can-upload-24hr-expiry'
],
```
[Source](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/common/config/main.php#L3-L172)

**Local Development:**  
OPTIONAL. The backend will throw an error if required parameters are missing, but for local development, you can stub or omit this integration if file upload features are not needed.

---

### Slack Webhooks

**Purpose:**  
Used for sending notifications and error reports to Slack channels. There are separate components for general notifications, TapPayments operations, and error reporting.

**Configuration:**  
Configured as `slack`, `slackTapOperation`, and `slackError` components in `plugn/common/config/main.php`:

```php
'slack' => [
    'class' => 'understeam\slack\Client',
    'url' => 'https://hooks.slack.com/services/...',
    'username' => 'Plugn',
],
'slackTapOperation' => [
    'class' => 'understeam\slack\Client',
    'url' => 'https://hooks.slack.com/services/...',
    'username' => 'Plugn',
],
'slackError' => [
    'class' => 'understeam\slack\Client',
    'url' => 'https://hooks.slack.com/services/...',
    'username' => 'Plugn',
],
```
[Source](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/common/config/main.php#L3-L172)

**Local Development:**  
OPTIONAL. These can be stubbed or omitted for local development.

---

### TapPayments

**Purpose:**  
Handles payment processing, including charges, refunds, and business/merchant creation. Supports multiple payment gateways (KNET, VISA/MASTER, MADA, BENEFIT).

**Configuration:**  
Configured as the `tapPayments` component in `plugn/common/config/main.php`:

```php
'tapPayments' => [
    'class' => 'common\components\TapPayments',
    'gatewayToUse' => \common\components\TapPayments::USE_LIVE_GATEWAY,
    'plugnLiveApiKey' => '...',
    'plugnTestApiKey' => '...',
    'destinationId' => '...',
],
```
[Source](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/common/config/main.php#L3-L172)

**Local Development:**  
OPTIONAL. Required for payment features, but can be stubbed or omitted for local development if payments are not being tested.

---

### MyFatoorah

**Purpose:**  
Provides payment processing through the MyFatoorah gateway, including supplier management, charges, refunds, and dashboard retrieval.

**Configuration:**  
Configured as the `myFatoorahPayment` component in `plugn/common/config/main.php`:

```php
'myFatoorahPayment' => [
    'class' => 'common\components\MyFatoorahPayment',
    'gatewayToUse' => \common\components\MyFatoorahPayment::USE_LIVE_GATEWAY,
    'kuwaitLiveApiKey' => '...',
    'kuwaitTestApiKey' => '...',
    'saudiLiveApiKey' => '...',
],
```
[Source](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/common/config/main.php#L3-L172)

**Local Development:**  
OPTIONAL. Required for payment features, but can be stubbed or omitted for local development if payments are not being tested.

---

### Cloudinary

**Purpose:**  
Manages media assets, including image upload, deletion, and retrieval.

**Configuration:**  
Configured as the `cloudinaryManager` component in `plugn/common/config/main.php`:

```php
'cloudinaryManager' => [
    'class' => 'common\components\CloudinaryManager',
    'cloud_name' => 'plugn',
    'api_key' => '...',
    'api_secret' => '...',
],
```
[Source](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/common/config/main.php#L3-L172)

**Local Development:**  
OPTIONAL. Required for media management features, but can be stubbed or omitted for local development if not needed.

---

### OneSignal

**Purpose:**  
Not present in the backend configuration. OneSignal is typically used for push notifications and appears to be managed on the frontend or another service tier.

**Configuration:**  
Not configured in `plugn/common/config/main.php`.

**Local Development:**  
Not applicable for backend local development.

---

## Local-only Minimal Config

To run the backend locally, only core dependencies are required (such as MySQL, Redis, PHP, etc.). All external integrations listed above (AWS S3, Slack webhooks, TapPayments, MyFatoorah, Cloudinary) can be stubbed or omitted for local development. You do not need to provide real API keys or connect to external services unless you are specifically developing or testing those features.

**Example minimal config for local development:**

```php
// In plugn/common/config/main.php, you can stub integrations like this:
'cloudinaryManager' => [
    'class' => 'common\components\CloudinaryManager',
    'cloud_name' => '',
    'api_key' => '',
    'api_secret' => '',
],
'temporaryBucketResourceManager' => [
    'class' => 'common\components\S3ResourceManager',
    'region' => '',
    'key' => '',
    'secret' => '',
    'bucket' => '',
],
'tapPayments' => [
    'class' => 'common\components\TapPayments',
    'gatewayToUse' => \common\components\TapPayments::USE_TEST_GATEWAY,
    'plugnLiveApiKey' => '',
    'plugnTestApiKey' => '',
    'destinationId' => '',
],
'myFatoorahPayment' => [
    'class' => 'common\components\MyFatoorahPayment',
    'gatewayToUse' => \common\components\MyFatoorahPayment::USE_TEST_GATEWAY,
    'kuwaitLiveApiKey' => '',
    'kuwaitTestApiKey' => '',
    'saudiLiveApiKey' => '',
],
'slack' => [
    'class' => 'understeam\slack\Client',
    'url' => '',
    'username' => 'Plugn',
],
// ...other stubs as needed
```

No external integration is strictly required to boot and run the backend locally, unless you are actively developing or testing features that depend on them.
