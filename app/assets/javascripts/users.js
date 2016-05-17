var makeGraph = function(search_items, search_scores) {
    var date = [];
    var sentiment = [];

    for (var i = 0; i < search_scores.length; i++) {
      date.push(search_scores[i].created_at);
      sentiment.push(parseInt(search_scores[i].sentiment_score));
    }

    trace1 = {
      type: 'scatter',
      x: date,
      y: sentiment,
      mode: 'lines',
      name: 'YOLO',
      line: {
        color: 'rgb(219, 64, 82)',
        width: 3
      }
    };

    var layout = {
      width: 500,
      height: 500
    };

    var data = [trace1];
$( document ).ready(function() {
    Plotly.newPlot('stats', data, layout);
  });
  };
// $( document ).ready(function() {
//   // makeGraph();
// });
