$(document).on('turbolinks:load', function() {
  // $("#transaction_coin_id").select2({
  //   theme: "bootstrap"
  // });
  var ctx = $("#portfolioChart");
  
  var attrData = ctx.data()

  var data        = attrData.dataset        ? eval(attrData.dataset) : {}
  var dataOptions = attrData.datasetOptions ? eval('(' + attrData.datasetOptions + ')') : {}
  var labels      = attrData.labels         ? eval(attrData.labels) : {}
  var options     = attrData.options        ? eval('(' + attrData.options + ')') : {}

  var datasets = $.extend({
    data: data,
    borderWidth: 2,
    hoverBorderColor: 'transparent'
  }, dataOptions)

  var portfolioChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
      datasets: [ datasets ],
      labels: labels
    },
    options: options
  });
});