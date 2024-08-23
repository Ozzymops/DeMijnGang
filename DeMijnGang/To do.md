# De MijnGang Theme 1.1
- [ ] Nieuws/Posts: grid view
- [ ] NextGen Gallery: CSS
- [ ] NinjaForms: CSS
- [ ] Events Manager post list: grid view, CSS
- [ ] Chomsky readability (letter spacing?)
# FacebookExtractor 1.2
- [ ] Logger/ProgressBar fusion, follow format:
	- [ ] [12:00:00] Downloading file 1 of 60 from 2024-08-01 [#||||||----- 25%, 1mbps (asterisk spin)]
- [ ] Extract planned/future posts
- [ ] Error handling: retry up to five times over ten seconds before skipping, retry failed files at the very end one more time, notify how many/which files failed
- [ ] Show download progress in new print format
	- [ ] [12:00:00] Downloading file 1 of 60 from 2024-08-01 [0%, 1mbps]
# De MijnGang App 1.0
- [ ] Fetch events from site via exported XML
	- [ ] Asynchronous/check every hour in background (?)
	- [ ] Show as 'grouped object,' tap to expand for more information
	- [ ] Store in local database, compare with fetched XML to reduce excessive processing
- [ ] Display fetched events on a single scrollable page
	- [ ] Featured events
	- [ ] Subscribe to event for push notifications
	- [ ] Participate in event, automatically subscribing
	- [ ] Comment on event
- [ ] Push notifications for newly added (major) events
- [ ] Push notifications for upcoming (subscribed/major) events
- [ ] Upload the app
	- [ ] Google Play Store: 25,- one-time fee
	- [ ] iOS: 100,- annual fee, not including iOS machine for building the app (https://appcircle.io/pricing)
	- [ ] Local on WordPress, linked via QR-code