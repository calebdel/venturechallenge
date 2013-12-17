// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// If you need to customize any bootstrap js, we've placed the un-minified versions in
// assets/javascripts/bootstrap including the test suite that ships with bootstrap.
// Love,
// Shopify
//
//= require Chart
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .
$(function(){ $(document).foundation(); });

var ctx = document.getElementById("LineChart").getContext("2d");

// push each store's data (as an array) into the data array for all stores.
var lineData = [];
for (var i=0;i<gon.numberofTeams;i++){
  lineData.push(
      {
        fillColor : gon.data[i].color,
        strokeColor : gon.data[i].color,
        pointColor : gon.data[i].color,
        pointStrokeColor : gon.data[i].color,
        data : gon.data[i].points
      }
  );
  $('.'+gon.data[i].ident)
  .css('background-color', gon.data[i].color);
}

var pointsChart = {
  labels : gon.labels,
  datasets : lineData
};

var myNewChart = new Chart(ctx).Line(pointsChart);

var ctx = document.getElementById("BarChart").getContext("2d");

// push each store's data (as an array) into the data array for all stores.

var labels = [];
var colors = [];
var pts = [];

for (var i=0;i<gon.numberofTeams;i++){
  labels.push(gon.data[i].name);
  colors.push(gon.data[i].color);
  pts.push(gon.data[i].totalpts);
}

  num1 = Math.floor(Math.random() * (254))
  num2 = Math.floor(Math.random() * (254))
  num3 = Math.floor(Math.random() * (254))
  var colorRandom = "rgba("+num1+","+num2+","+num3+",0.5)" 

var barChart = {
  labels : labels,
  datasets : [
    {
      fillColor : colorRandom,
      strokeColor : colorRandom,
      data : pts
    }
  ]
}

var myNewChart = new Chart(ctx).Bar(barChart);
