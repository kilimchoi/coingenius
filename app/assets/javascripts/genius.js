$(document).ready(function() {
  var linechart;
  $('.dropdown-toggle').dropdown()

  $('.nav-link').on('click', function() {
    $('.nav-link').removeClass('active');
    $(this).addClass('active');
    if($(this).attr('id') == "daily") {
      $('[data-chart]').each(function () {
        var labels = $(this).data().dailylabels;
        window.lineChart.data.labels = labels;
        window.lineChart.data.datasets[0].data = $(this).data().dataset[0]
        window.lineChart.update();
      });
    }
    if($(this).attr('id') == "weekly") {
      $('[data-chart]').each(function () {
        var labels = $(this).data().weeklylabels;
        window.lineChart.data.labels = labels;
        window.lineChart.data.datasets[0].data = $(this).data().weeklydataset[0]
        window.lineChart.update();
      });
    }
    if($(this).attr('id') == "monthly") {
      $('[data-chart]').each(function () {
        var labels = $(this).data().monthlylabels;
        window.lineChart.data.labels = labels;
        window.lineChart.data.datasets[0].data = $(this).data().monthlydataset[0]
        window.lineChart.update();
      });
    }
    if($(this).attr('id') == "yearly") {
      $('[data-chart]').each(function () {
        var labels = $(this).data().yearlylabels;
        window.lineChart.data.labels = labels;
        window.lineChart.data.datasets[0].data = $(this).data().yearlydataset[0]
        window.lineChart.update();
      });
    }
  });

  $(document)
    .on('redraw.bs.charts', function () {
      $('[data-chart]').each(function () {
        var originalLineController = Chart.controllers.line;
        Chart.controllers.line = Chart.controllers.line.extend({
          
          draw: function(ease) {
            originalLineController.prototype.draw.call(this, ease);

            var originalShowTooltip = this.showTooltip;
            
            if (this.chart.tooltip._active && this.chart.tooltip._active.length) {
              var activePoint = this.chart.tooltip._active[0],
                   ctx = this.chart.ctx,
                   x = activePoint.tooltipPosition().x,
                   topY = this.chart.scales['y-axis-0'].top,
                   bottomY = this.chart.scales['y-axis-0'].bottom;

              // draw line
              ctx.save();
              ctx.beginPath();
              ctx.moveTo(x, topY);
              ctx.lineTo(x, bottomY);
              ctx.lineWidth = 2;
              ctx.strokeStyle = '#07C';
              ctx.stroke();
              ctx.restore();
            }
          }
        });
        if ($(this).is(':visible') && !$(this).hasClass('js-chart-drawn')) {
          var element = $(this);
          var attrData = $.extend({}, element.data())
          var data           = attrData.dataset ? eval(attrData.weeklydataset) : []
          var datasetOptions = attrData.datasetOptions ? eval(attrData.datasetOptions) : []
          var labels         = attrData.weeklylabels ? eval(attrData.weeklylabels) : {}
          var options     = attrData.options        ? eval('(' + attrData.options + ')') : {}
          var isDark         = !!attrData.dark
          
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
              }]
            },
            tooltips: {
              enabled: true,
              intersect: false,
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
          });
          $(this).addClass('js-chart-drawn')
        }
      })
    })
    .trigger('redraw.bs.charts')
});
