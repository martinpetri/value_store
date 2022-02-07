// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import Chart from 'chart.js/auto'
import 'bootstrap'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', () => {
  
  var element_number = 0
  var topic_name = ''
  var topics = [[]]
  var line_chart_color = 'rgb(30, 144, 255)'
  
  var allElem = document.getElementsByTagName("*"); 
  for (var i = 0; i < allElem.length; i++) {

    if (allElem[i].className == 'lineChart'){
      window['ctx' + i] = document.getElementById(allElem[i].id).getContext('2d');

      topic_name = allElem[i].id.replace('_lineChart', '')
      topics.push([topic_name, i])

      window['lineChart' + i] = new Chart(window['ctx' + i], {
        type: 'line',
        data: {
          labels: JSON.parse(window['ctx' + i].canvas.dataset.labels),
          datasets: [{
            label: topic_name,
            borderColor: line_chart_color,
            data: JSON.parse(window['ctx' + i].canvas.dataset.data),
          }]
        },
      });
    }
  }
  function updateChart(json_data) {

    // for debugging ... makes json_data available in the browser console
    // window['json_data'] = json_data

    var topic_name = JSON.parse(json_data).topic
    var topic_labels = JSON.parse(json_data).labels
    var topic_values = JSON.parse(json_data).values

    var display = document.getElementById(topic_name + '_display');
    display.innerHTML = '<h1 class="display-2">' + topic_values[topic_values.length - 1] + '</h2>';
  
    
    for (i = 1; i < topics.length; i++){
      if (topics[i][0] == topic_name){
        element_number = topics[i][1]
        window['lineChart' + element_number].data.labels = topic_labels
        window['lineChart' + element_number].data.datasets[0].data = topic_values
        window['lineChart' + element_number].update('none')
      }
    }    
  }
  window.updateChart = updateChart;
})