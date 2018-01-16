$(document).ready(function () {
  var select = document.querySelector("#currency");
  var lastSelected = localStorage.getItem('currency');
  var dataSetinLastSelectedCurrency = [];
  var setLength = 365;
  var symToCurrencyName = {
    "$": "USD",
    "€": "EUR",
    "£": "GBP",
    "C$": "CAD",
    "A$": "AUD",
    "฿": "BTC"
  }
  var currencyNameToSym = {
    "USD": "$",
    "EUR": "€",
    "GBP": "£",
    "CAD": "C$",
    "AUD": "A$",
    "BTC": "฿"
  }

  function updatePortfolioChange(range) {
    var changeValue = $(".portfolio-changes-data").data(range);

    return $(".portfolio-changes").text(changeValue);
  }

  function updateDefaultCurrency(currency) {
    //TODO: fix the url
    $.ajax({
      url: 'https://coingenius.co/portfolio/update_default_currency',
      type: 'post',
      data: {
        'currency': currency
      },
      dataType: 'json'
    });
  }

  if (lastSelected) {
    select.value = lastSelected;
    var dollarAmount = $("#total").data('total');
    var toCurrencyName = $("#currency").val();
    var currHoldingTotal = $("#holdingTotal").data('holdingtotal');
    var coinPrice = $("#coinPrice").data('coinprice');
    if (toCurrencyName == "BTC") {
      $.ajax({
        url: "https://min-api.cryptocompare.com/data/price?fsym=USD&tsyms=BTC",
        type: "get",
        dataType: "json",
      }).done(function (data) {
        var totalAmount = dollarAmount * data["BTC"];
        var matching = document.getElementsByClassName("coinPrice");
        for (var i = 0; i < matching.length; i++) {
          var converted = matching[i].dataset.coinprice * data["BTC"];
          matching[i].innerHTML = currencyNameToSym[toCurrencyName] + "" + converted.toFixed(8);
        }

        var matching2 = document.getElementsByClassName("holdingTotal");
        for (var i = 0; i < matching2.length; i++) {
          var converted2 = matching2[i].dataset.holdingtotal * data["BTC"];
          matching2[i].innerHTML = currencyNameToSym[toCurrencyName] + "" + converted2.toFixed(8);
        }

        $("#total").text(currencyNameToSym[toCurrencyName] + "" + totalAmount.toFixed(8));

        $('[data-chart]').each(function () {
          dataSetinLastSelectedCurrency = [];
          var yearlydataset = $(this).data().yearlydataset[0];
          for (var i = yearlydataset.length - 1; i >= 0; i--) {
            var d = yearlydataset[i];
            dataSetinLastSelectedCurrency.push(d * data["BTC"]);
          }
        });

        dataSetinLastSelectedCurrency.reverse();
        var idName = $('.nav-link.active').attr("id");
        if (idName == "weekly") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(setLength - 7, setLength)
        } else if (idName == "monthly") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(setLength - 30, setLength)
        } else {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency
        }
        window.lineChart.update();
      })
    } else if (toCurrencyName != "USD") {
      $.ajax({
        url: "https://api.fixer.io/latest?base=USD&symbols=" + toCurrencyName,
        type: 'get',
        dataType: 'json',
      }).done(function (data) {
        var matching = document.getElementsByClassName("coinPrice");
        for (var i = 0; i < matching.length; i++) {
          var converted = matching[i].dataset.coinprice * data["rates"][toCurrencyName];
          matching[i].innerHTML = currencyNameToSym[toCurrencyName] + "" + converted.toFixed(2);
        }

        var matching2 = document.getElementsByClassName("holdingTotal");
        for (var i = 0; i < matching2.length; i++) {
          var converted2 = matching2[i].dataset.holdingtotal * data["rates"][toCurrencyName];
          matching2[i].innerHTML = currencyNameToSym[toCurrencyName] + "" + converted2.toFixed(2);
        }

        var totalAmount = dollarAmount * data["rates"][toCurrencyName];

        $("#total").text(currencyNameToSym[toCurrencyName] + "" + totalAmount.toFixed(2));

        $('[data-chart]').each(function () {
          dataSetinLastSelectedCurrency = [];
          var yearlydataset = $(this).data().yearlydataset[0];
          for (var i = yearlydataset.length - 1; i >= 0; i--) {
            var d = yearlydataset[i];
            dataSetinLastSelectedCurrency.push(d * data["rates"][toCurrencyName]);
          }
        });

        dataSetinLastSelectedCurrency.reverse();
        var idName = $('.nav-link.active').attr("id");
        if (idName == "weekly") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(setLength - 7, setLength)
        } else if (idName == "monthly") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(setLength - 30, setLength)
        } else {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency
        }
        window.lineChart.update();
      })
    } else {
      var t = parseFloat($("#total").data('total')).toFixed(2);
      var holdingTotal = parseFloat($("#holdingTotal").data('holdingtotal')).toFixed(2);
      var coinPrice = parseFloat($("#coinPrice").data("coinprice")).toFixed(2);

      $("#total").text("$" + t);

      var matching = document.getElementsByClassName("coinPrice");
      for (var i = 0; i < matching.length; i++) {
        var converted = matching[i].dataset.coinprice;
        matching[i].innerHTML = "$" + converted;
      }

      var matching2 = document.getElementsByClassName("holdingTotal");
      for (var i = 0; i < matching2.length; i++) {
        var converted2 = matching2[i].dataset.holdingtotal;
        matching2[i].innerHTML = "$" + converted2;
      }
    }
  }

  $("#currency").on("change", function () {
    localStorage.setItem('currency', $("#currency").val());
    updateDefaultCurrency($("#currency").val());
    var dollarAmount = $("#total").data('total');
    var toCurrencyName = $("#currency").val();
    var currHoldingTotal = $("#holdingTotal").data('holdingtotal');
    var coinPrice = $("#coinPrice").data('coinprice');
    if (toCurrencyName == "BTC") {
      $.ajax({
        url: "https://min-api.cryptocompare.com/data/price?fsym=USD&tsyms=BTC",
        type: "get",
        dataType: "json",
      }).done(function (data) {
        var totalAmount = dollarAmount * data["BTC"];
        var matching = document.getElementsByClassName("coinPrice");
        var matchingCoinName = document.getElementsByClassName("coinname");
        for (var i = 0; i < matching.length; i++) {
          if (matchingCoinName[i].dataset.coinname == "Bitcoin") {
            matching[i].innerHTML = currencyNameToSym[toCurrencyName] + "1.00";
          } else {
            var converted = matching[i].dataset.coinprice * data["BTC"];
            matching[i].innerHTML = currencyNameToSym[toCurrencyName] + "" + converted.toFixed(8);
          }
        }

        var matching2 = document.getElementsByClassName("holdingTotal");
        for (var i = 0; i < matching2.length; i++) {
          var converted2 = matching2[i].dataset.holdingtotal * data["BTC"];
          matching2[i].innerHTML = currencyNameToSym[toCurrencyName] + "" + converted2.toFixed(8);
        }

        $("#total").text(currencyNameToSym[toCurrencyName] + "" + totalAmount.toFixed(8));

        $('[data-chart]').each(function () {
          dataSetinLastSelectedCurrency = [];
          var yearlydataset = $(this).data().yearlydataset[0];
          for (var i = yearlydataset.length - 1; i >= 0; i--) {
            var d = yearlydataset[i];
            dataSetinLastSelectedCurrency.push(d * data["BTC"]);
          }
        });

        dataSetinLastSelectedCurrency.reverse();
        var idName = $('.nav-link.active').attr("id");
        if (idName == "weekly") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(setLength - 7, setLength)
        } else if (idName == "monthly") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(setLength - 30, setLength)
        } else {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency
        }
        window.lineChart.update();
      })
    } else if (toCurrencyName != "USD") {
      $.ajax({
        url: "https://api.fixer.io/latest?base=USD&symbols=" + toCurrencyName,
        type: 'get',
        dataType: 'json',
      }).done(function (data) {
        var matching = document.getElementsByClassName("coinPrice");
        for (var i = 0; i < matching.length; i++) {
          var converted = matching[i].dataset.coinprice * data["rates"][toCurrencyName];
          matching[i].innerHTML = currencyNameToSym[toCurrencyName] + "" + converted.toFixed(2);
        }

        var matching2 = document.getElementsByClassName("holdingTotal");
        for (var i = 0; i < matching2.length; i++) {
          var converted2 = matching2[i].dataset.holdingtotal * data["rates"][toCurrencyName];
          matching2[i].innerHTML = currencyNameToSym[toCurrencyName] + "" + converted2.toFixed(2);
        }

        var totalAmount = dollarAmount * data["rates"][toCurrencyName];

        $("#total").text(currencyNameToSym[toCurrencyName] + "" + totalAmount.toFixed(2));

        $('[data-chart]').each(function () {
          dataSetinLastSelectedCurrency = [];
          var yearlydataset = $(this).data().yearlydataset[0];
          for (var i = yearlydataset.length - 1; i >= 0; i--) {
            var d = yearlydataset[i];
            dataSetinLastSelectedCurrency.push(d * data["rates"][toCurrencyName]);
          }
        });

        dataSetinLastSelectedCurrency.reverse();
        var idName = $('.nav-link.active').attr("id");
        if (idName == "weekly") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(setLength - 7, setLength)
        } else if (idName == "monthly") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(setLength - 30, setLength)
        } else {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency
        }
        window.lineChart.update();
      })
    } else {
      var t = parseFloat($("#total").data('total')).toFixed(2);
      var holdingTotal = parseFloat($("#holdingTotal").data('holdingtotal')).toFixed(2);
      var coinPrice = parseFloat($("#coinPrice").data("coinprice")).toFixed(2);
      $('[data-chart]').each(function () {
        var yearlyDataset = $(this).data().yearlydataset[0];
        var idName = $('.nav-link.active').attr("id");
        if (idName == "weekly") {
          window.lineChart.data.datasets[0].data = yearlyDataset.slice(setLength - 7, setLength)
        } else if (idName == "monthly") {
          window.lineChart.data.datasets[0].data = yearlyDataset.slice(setLength - 30, setLength)
        } else {
          window.lineChart.data.datasets[0].data = yearlyDataset
        }
        window.lineChart.update();
      });
      $("#total").text("$" + t);
      var matching = document.getElementsByClassName("coinPrice");
      for (var i = 0; i < matching.length; i++) {
        var converted = matching[i].dataset.coinprice;
        matching[i].innerHTML = "$" + converted;
      }

      var matching2 = document.getElementsByClassName("holdingTotal");
      for (var i = 0; i < matching2.length; i++) {
        var converted2 = matching2[i].dataset.holdingtotal;
        matching2[i].innerHTML = "$" + converted2;
      }
    }
  });

  var linechart;
  $('.dropdown-toggle').dropdown()

  $('.nav-link').on('click', function () {
    $('.nav-link').removeClass('active');
    $(this).addClass('active');

    var range = $(this).attr('id');

    updatePortfolioChange(range);

    if (range == "weekly") {
      $('[data-chart]').each(function () {
        var labels = $(this).data().weeklylabels;
        var n = $(this).data().yearlydataset[0].length
        var lastSelected = localStorage.getItem('currency');
        window.lineChart.data.labels = labels;
        if (lastSelected && lastSelected != "USD") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(n - 7, n)
        } else {
          window.lineChart.data.datasets[0].data = $(this).data().yearlydataset[0].slice(n - 7, n)
        }

        window.lineChart.update();
      });
    }

    if (range == "monthly") {
      $('[data-chart]').each(function () {
        var labels = $(this).data().monthlylabels;
        var n = $(this).data().yearlydataset[0].length
        var lastSelected = localStorage.getItem('currency');
        window.lineChart.data.labels = labels;
        if (lastSelected && lastSelected != "USD") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency.slice(n - 30, n)
        } else {
          window.lineChart.data.datasets[0].data = $(this).data().yearlydataset[0].slice(n - 30, n)
        }
        window.lineChart.update();
      });
    }

    if (range == "yearly") {
      $('[data-chart]').each(function () {
        var labels = $(this).data().yearlylabels;
        var lastSelected = localStorage.getItem('currency');
        window.lineChart.data.labels = labels;
        if (lastSelected && lastSelected != "USD") {
          window.lineChart.data.datasets[0].data = dataSetinLastSelectedCurrency
        } else {
          window.lineChart.data.datasets[0].data = $(this).data().yearlydataset[0]
        }
        window.lineChart.update();
      });
    }
  });

  $(document)
    .on('redraw.bs.charts', function () {
      $('[data-chart]').each(function () {
        var originalLineController = Chart.controllers.line;
        Chart.controllers.line = Chart.controllers.line.extend({

          draw: function (ease) {
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
          var data = attrData.dataset ? eval(attrData.weeklydataset) : []
          var datasetOptions = attrData.datasetOptions ? eval(attrData.datasetOptions) : []
          var labels = attrData.weeklylabels ? eval(attrData.weeklylabels) : {}
          var options = attrData.options ? eval('(' + attrData.options + ')') : {}
          var isDark = !!attrData.dark

          var data = {
            labels: labels,
            datasets: data.map(function (set, i) {
              return $.extend({
                data: set,
                fill: true,
                backgroundColor: 'rgba(255,255,255,.3)',
                borderColor: '#fff',
                pointBorderColor: '#fff',
                lineTension: 0.25,
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
                title: function () {
                  return "Total"
                },
                label: function (tooltipItem, data) {
                  var lastSelected = localStorage.getItem('currency');
                  return tooltipItem.xLabel + ": " + currencyNameToSym[lastSelected] + "" + tooltipItem.yLabel.toFixed(2);
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
