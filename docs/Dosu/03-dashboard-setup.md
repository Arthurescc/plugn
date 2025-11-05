## plugn-dashboard-ionic – Developer Setup Guide

### Stack

This project uses [Ionic Angular with Angular 14.x and Ionic Angular 6.1.9](https://github.com/BAWES-Universe/plugn-dashboard-ionic/blob/df58999aa0bc4780cf96becde4c3dc05da643a1a/package.json#L6-L55).

### Install & Run Commands

Install dependencies:

```sh
npm install
```

Run the app in development mode:

```sh
npm run start
```

Alternative: run with a specific configuration:

```sh
npm run serve-kk
```

### API/Base URL Configuration

The API base URLs are configured in `src/environments/environment.ts`. The relevant keys are `apiEndpoint` and `storeApiEndpoint`:

```ts
export const environment = {
  // ...
  //apiEndpoint: 'http://localhost/plugn/agent/web/v1/',
  apiEndpoint: 'https://agent.dev.plugn.io/v1/',
  storeApiEndpoint: 'https://api.dev.plugn.io/v2/',
  // ...
};
```
To use a local backend, uncomment and set:
```ts
apiEndpoint: 'http://localhost/plugn/agent/web/v1/',
```
For local development, ensure your backend is running at `http://localhost/plugn/api/web` and update the endpoint accordingly
([source](https://github.com/BAWES-Universe/plugn-dashboard-ionic/blob/df58999aa0bc4780cf96becde4c3dc05da643a1a/src/environments/environment.ts#L5-L22)).

### Backend Services and Endpoints

#### StoreService

Located at `src/app/services/logged-in/store.service.ts`, this service calls endpoints such as:

- `store`, `store/upgrade`, `store/update-bank-account`, `store/create`, `store/update`, `store/update-email-settings`, `store/update-store-settings`, `store/settings/{code}`, `store/deactivate`, `store/remove-store`, `store/connect-domain`
- Payment method endpoints: `store/disable-payment-method/{store_uuid}/{payment_method_id}`, `store/enable-payment-method/{store_uuid}/{payment_method_id}`, `store/view-shipping-methods`, `store/view-payment-methods/{store_uuid}`
- Integration endpoints: `store/update-delivery-integration/{store_uuid}`, `store/update-analytics-integration/{store_uuid}`, `store/create-tap-queue/{store_uuid}`, `store/create-tap-account/{store_uuid}`, `store/update-business-details/{store_uuid}`, `store/update-kyc/{store_uuid}`, `store/upload-docs/{store_uuid}`
- Payment enable/disable: `store/disable-online-payment/{store_uuid}`, `store/enable-online-payment/{store_uuid}`, `store/disable-free-checkout/{store_uuid}`, `store/enable-free-checkout/{store_uuid}`, `store/disable-moyasar/{store_uuid}`, `store/enable-moyasar/{store_uuid}`, `store/disable-stripe/{store_uuid}`, `store/enable-stripe/{store_uuid}`, `store/disable-upayment/{store_uuid}`, `store/enable-upayment/{store_uuid}`, `store/disable-cod/{store_uuid}`, `store/enable-cod/{store_uuid}`
- Other: `store/process-gateway-queue/{store_uuid}`, `store/remove-gateway-queue/{store_uuid}`, `store/test-tap`, `store/status`
([source](https://github.com/BAWES-Universe/plugn-dashboard-ionic/blob/df58999aa0bc4780cf96becde4c3dc05da643a1a/src/app/services/logged-in/store.service.ts#L15-L544)).

#### StripePage (StripeFormComponent)

Located at `src/app/components/stripe-form/stripe-form.component.ts`, this component uses `StripeService.getInitParams()` to initialize payments. It expects parameters like `invoice_uuid` and `plan_id` and receives payment intent details (amount, currency, client secret, success/cancel URLs) from the backend ([source](https://github.com/BAWES-Universe/plugn-dashboard-ionic/blob/df58999aa0bc4780cf96becde4c3dc05da643a1a/src/app/components/stripe-form/stripe-form.component.ts#L36-L123)).

#### PaymentMethodService

Not enough information was found to document this service's endpoints.

---

**Note:** For local development, point your API endpoints to `http://localhost/plugn/api/web` and ensure the backend is running.

---

## plugn-ionic – Setup & API Config

### Stack

This project uses [Ionic Angular with Angular 14.x and Ionic Angular 6.1.9](https://github.com/BAWES-Universe/plugn-ionic/blob/6766364857d8146d8b89356a015798e053357bbd/package.json#L6-L50).

### Install & Run Commands

Install dependencies:

```sh
npm install
```

Run the app in development mode:

```sh
npm start
```

### API/Base URL Configuration

The API base URL is configured in `src/environments/environment.ts`:

```ts
export const environment = {
  // ...
  //apiEndpoint : 'https://api.plugn.io/v2', 
  apiEndpoint : 'http://localhost:8888/bawes/plugn/api/web/v2', 
  // ...
}
```
To change the API URL for local development, edit the `apiEndpoint` value in this file ([source](https://github.com/BAWES-Universe/plugn-ionic/blob/6766364857d8146d8b89356a015798e053357bbd/src/environments/environment.ts#L1-L12)).

### Backend Services and Endpoints

#### StoreService

Located at `src/app/services/store.service.ts`, this service calls endpoints such as:

- `/store/locations/{restaurantUuid}`, `/item/category/{category_slug}`, `/item/items`, `/item/{category_id}`, `/item/view/{slug}`, `/item/detail`, and others, typically appending the `restaurantUuid` from the environment config ([source](https://github.com/BAWES-Universe/plugn-ionic/blob/6766364857d8146d8b89356a015798e053357bbd/src/app/services/store.service.ts#L3-L160)).

#### StripePage (StripeFormComponent)

Located at `src/app/components/stripe-form/stripe-form.component.ts`, this component uses `StripeService.getInitParams(order_uuid)` to initialize payments and expects the backend to return payment intent details ([source](https://github.com/BAWES-Universe/plugn-ionic/blob/6766364857d8146d8b89356a015798e053357bbd/src/app/components/stripe-form/stripe-form.component.ts#L42-L107)).

---

**Note:** For local development, set `apiEndpoint` to your local backend (e.g., `http://localhost/plugn/api/web`) and ensure the backend is running.

---

## plugn-store & plugn-store-community – Setup

### Stack

Both projects use Ionic with Vue 3 and Capacitor ([plugn-store package.json](https://github.com/BAWES-Universe/plugn-store/blob/b6b0cadf2c73bc3912211e798ff56958db808389/package.json#L5-L50), [plugn-store-community package.json](https://github.com/BAWES-Universe/plugn-store-community/blob/87e95883560d3f72ac07f192a9cc516681d4416a/package.json#L1-L80)).

### Install & Run Commands

Install dependencies:

```sh
npm install
```

Run in development mode:

```sh
npm run serve
```

For local development mode (if available):

```sh
npm run serve:local
```

Build for production:

```sh
npm run build
```

### API/Base URL Location

The API/base URL is typically configured in an environment or configuration file, but the exact file location was not found in the available sources. Check for `.env`, `src/environments/`, or similar files in the project root.

### Yii2 Backend Dependencies

Modules that interact with the backend (such as those handling authentication, store data, payments, etc.) depend on the Yii2 backend API. The frontend expects the backend to be running and accessible at the configured API/base URL.

---

**Warning:** The Yii2 backend must be running and accessible before starting the frontend apps. For local development, ensure the backend is available at `http://localhost/plugn/api/web` (or the configured local endpoint).

---
