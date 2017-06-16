var isDate = function(value) {
  var dateFormat;
  if (toString.call(value) === '[object Date]') {
    return true;
  }
  if (typeof value.replace === 'function') {
    value.replace(/^\s+|\s+$/gm, '');
  }
  dateFormat = /(^\d{1,4}[\.|\\/|-]\d{1,2}[\.|\\/|-]\d{1,4})(\s*(?:0?[1-9]:[0-5]|1(?=[012])\d:[0-5])\d\s*[ap]m)?$/;
  return dateFormat.test(value);
}

var convertFromTimeStampToDate = function(labels) { 
  for (var i = 0; i < labels.length; i++) {
    if (!isDate(labels[i])) {
      var date = new Date(labels[i])
      var hours = date.getHours();
      var mins = date.getMinutes();
      mins = mins < 10 ? "0" + mins : mins
      var ampm = hours >= 12 ? 'pm' : 'am';
      hours = hours % 12;
      hours = hours ? hours : 12; 
      labels[i] = date.getMonth() + "/" + date.getDate() + "/" + date.getFullYear().toString().substr(-2) + " " + hours + ":" + mins + ampm;
    }
  }
  return labels;
}
$(document).on('turbolinks:load', function() {
  $(function () {
    var linechart;

    $('.nav-link').on('click', function() {
        $('.nav-link').removeClass('active');
        $(this).addClass('active');
        if($(this).attr('id') == "daily") {
          $('[data-chart]').each(function () {
            var labels = $(this).data().dailylabels;
            window.lineChart.data.labels = convertFromTimeStampToDate(labels);
            window.lineChart.data.datasets[0].data = $(this).data().dataset[0]
            window.lineChart.update();
          });
        }
        if($(this).attr('id') == "weekly") {
          $('[data-chart]').each(function () {
            var labels = $(this).data().weeklylabels;
            window.lineChart.data.labels = convertFromTimeStampToDate(labels);
            window.lineChart.data.datasets[0].data = $(this).data().weeklydataset[0]
            window.lineChart.update();
          });
        }
        if($(this).attr('id') == "monthly") {
          $('[data-chart]').each(function () {
            var labels = $(this).data().monthlylabels;
            window.lineChart.data.labels = convertFromTimeStampToDate(labels);
            window.lineChart.data.datasets[0].data = $(this).data().monthlydataset[0]
            window.lineChart.update();
          });
        }
        if($(this).attr('id') == "yearly") {
          $('[data-chart]').each(function () {
            var labels = $(this).data().yearlylabels;
            window.lineChart.data.labels = convertFromTimeStampToDate(labels);
            window.lineChart.data.datasets[0].data = $(this).data().yearlydataset[0]
            window.lineChart.update();
          });
        }
    });

    $(document)
      .on('redraw.bs.charts', function () {
        $('[data-chart]').each(function () {
          if ($(this).is(':visible') && !$(this).hasClass('js-chart-drawn')) {
            var element = $(this);
            var attrData = $.extend({}, element.data())
            var data           = attrData.dataset ? eval(attrData.dataset) : []
            var datasetOptions = attrData.datasetOptions ? eval(attrData.datasetOptions) : []
            var labels         = attrData.dailylabels ? eval(attrData.dailylabels) : {}
            var options     = attrData.options        ? eval('(' + attrData.options + ')') : {}
            var isDark         = !!attrData.dark

            labels = convertFromTimeStampToDate(labels);
            
            var data = {
              labels   : labels,
              datasets : data.map(function (set, i) {
                return $.extend({
                  data: set,
                  fill: true,
                  backgroundColor: 'rgba(255,255,255,.3)',
                  borderColor: '#fff',
                  pointBorderColor: '#fff',
                  lineTension : 0.25,
                  pointRadius: 0,
                  pointHoverRadius: 0,
                  pointHitRadius: 20
                }, datasetOptions[i])
              })
            }

            var options = $.extend({
              animation: {
                duration: 0
              },
              legend: {
                display: false
              },
              scales: {
                yAxes: [{
                  gridLines: {
                    color: isDark ? 'rgba(255,255,255,.05)' : 'rgba(0,0,0,.05)',
                    zeroLineColor: isDark ? 'rgba(255,255,255,.05)' : 'rgba(0,0,0,.05)',
                    drawBorder: false
                  },
                  ticks: {
                    beginAtZero: false,
                    fontColor: isDark ? '#a2a2a2' : 'rgba(0,0,0,.4)',
                    fontSize: 14, 
                    stacked: false,
                    steps: 20,
                  }, 
                }],
                xAxes: [{
                  display: true
                }]
              },
              tooltips: {
                enabled: true,
                intersect: true,
                bodyFontSize: 14,
                callbacks: {
                  title: function () { return "Total" },
                  label: function(tooltipItem, data) {
                    return tooltipItem.xLabel + ": $" + tooltipItem.yLabel.toFixed(2);
                  }
                }
              }
            }, options)
            var ctx = this.getContext("2d");

            window.lineChart = new Chart(ctx, {
                type: 'line',
                data: data,
                options: options
            })

            $(this).addClass('js-chart-drawn')
          }
        })
      })
      .trigger('redraw.bs.charts')
  });

  
});
