// app/javascript/channels/consumer.js
import { createConsumer } from "@rails/actioncable"

// The consumer is automatically created based on the cable.yml and the
// Action Cable meta tags in your layout.
export default createConsumer()