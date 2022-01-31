import consumer from "./consumer"

$(document).on('turbolinks:load', function () {
  consumer.subscriptions.create("DashboardChannel", {
    connected() {
      console.log('Connected to dashboard_channel...')
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log("Received data")
      updateChart(data)
    }
  });
})