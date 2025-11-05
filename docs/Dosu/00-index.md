## Documentation Index for Plugn Developer Onboarding

1. **Plugn Quickstart (Day 1)**
   - Introduction to the Plugn ecosystem.
   - Setting up your development environment for documentation and code.
   - Previewing and deploying documentation changes using Mintlify CLI.
   - Editing docs with MDX and React components.
   - [Reference: Quickstart guide](https://github.com/BAWES-Universe/plugn/blob/bc485b0a1da61d516955c5dc4fc29e95afccea92/docs/quickstart.mdx#L6-L97)

2. **plugn-dashboard-ionic – Setup & API Config**
   - Native plugin configuration: camera, file system, geolocation, Google auth.
   - App ID: `io.plugn.dashboard`.
   - OneSignal plugin setup for notifications ([Ionic native docs](https://ionicframework.com/docs/native/onesignal)).
   - iOS build: remove `ios` from capacitor in `plugn-device/package.json`.
   - Android keystore management: `keytool` commands for signing.
   - Docker setup: `docker compose up`, build and run images, port mappings.
   - Accessing the app: `http://localhost:3000/login` (browser), port 8100 for `ionic serve`.
   - CircleCI integration with Slack notifications using `SLACK_ACCESS_TOKEN`.
   - Payment API references: [Tap Payments](https://developers.tap.company/reference/testing-cards), [Pricing API](http://localhost:8888/bawes/plugn/agent/web/v1/plans/price?currency=USD).
   - [Reference: plugn-dashboard-ionic README](https://github.com/BAWES-Universe/plugn-dashboard-ionic/blob/df58999aa0bc4780cf96becde4c3dc05da643a1a/README.md#L3-L117)

3. **plugn-ionic – Setup & API Config**
   - Environment configuration: API endpoints, restaurant UUIDs.
   - Docker deployment and environment variable setup.
   - [Reference: plugn-ionic environment config](https://github.com/BAWES-Universe/plugn-ionic/blob/6766364857d8146d8b89356a015798e053357bbd/src/environments/environment.ts)

4. **plugn-store & plugn-store-community – Setup**
   - Documentation preview and publishing using Mintlify starter kit.
   - General setup instructions for store variants.
   - [Reference: plugn-store docs](https://github.com/BAWES-Universe/plugn-store/blob/b6b0cadf2c73bc3912211e798ff56958db808389/docs/README.md)

5. **Plugn Integrations (Slack, S3, Payments)**
   - Slack integration for deployment notifications via CircleCI (`SLACK_ACCESS_TOKEN`).
   - S3 bucket configuration for file storage:
     - Temporary bucket: `plugn-public-anyone-can-upload-24hr-expiry.s3.amazonaws.com`
     - Permanent bucket: `plugn-uploads-dev-server.s3.amazonaws.com`
   - Payment integration with Tap Payments API.
   - [Reference: plugn-dashboard-ionic environment config](https://github.com/BAWES-Universe/plugn-dashboard-ionic/blob/df58999aa0bc4780cf96becde4c3dc05da643a1a/src/environments/environment.ts#L9-L21)

6. **Plugn Repositories – Priority & Status**
   - Overview of Plugn repositories: dashboard, store, device, microservices, etc.
   - Repository structure and code organization.
   - Active maintenance and priority inferred from root-level docs and contribution files.
   - No formal priority/status file; check main README or issue tracker for current status.

---

This index is ordered for new developer onboarding, starting with a high-level quickstart, followed by setup and API configuration for each main project, integration guides, and ending with repository context. For further details, consult the referenced documentation files and configuration sources.
