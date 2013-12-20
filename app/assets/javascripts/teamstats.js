var ctx = document.getElementById("DonutChart").getContext("2d");


var donutData = [
  {
    value: gon.one,
    color:"#F7464A"
  },
  {
    value : gon.two,
    color : "#E2EAE9"
  },
  {
    value : gon.three,
    color : "#D4CCC5"
  },
  {
    value : gon.four,
    color : "#949FB1"
  },
    {
    value : gon.five,
    color : "#949FB1"
  },
  {
    value : gon.six,
    color : "#4D5980"
  }

];

var myNewChart = new Chart(ctx).Doughnut(donutData);
