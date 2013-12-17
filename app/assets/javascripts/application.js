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

var ctx = document.getElementById("myChart").getContext("2d");

// default
// var data = {
//   labels : ["Sale 1","Sale 2","Sale 3","Sale 4","Sale 5","Sale 6","Sale 7","Sale 8","Sale 9","Sale 10"],
//   datasets : [
//       {
//         fillColor : gon.color[i],
//         strokeColor : "rgba(220,220,220,1)",
//         pointColor : "rgba(220,220,220,1)",
//         pointStrokeColor : "#fff",
//         data : gon.orders[i]
//       },
//   ]
// }

// push each store's data (as an array) into the data array for all stores.
var dataArray = [];
for (var i=0;i<gon.numberofTeams;i++){
  dataArray.push(
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
  datasets : dataArray
};

var myNewChart = new Chart(ctx).Line(pointsChart);

