const XMLHttpRequest = require("xhr2");

function getHoursStamp() {
  let a = new Date();
  return "" + a.getFullYear() + (a.getMonth() + 1) + a.getDate() + a.getHours();
}
function getLBP() {
  get(
    "https://lirarate.org/wp-json/lirarate/v2/rates?currency=LBP&_ver=t" +
      getHoursStamp(),
    function (response) {
      var r = JSON.parse(response);
      try {
        var buy = "Buy: " + r.buy[r.buy.length - 1][1];
        var sell = "Sell: " + r.sell[r.sell.length - 1][1];
        console.log(`${buy} 💱 ${sell}`);
      } catch (e) {
        console.log(e);
      }
    }
  );
}

function get(url, callback) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", url, true);
  xhr.setRequestHeader(
    "Authorization",
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbGlyYXJhdGUub3JnIiwiaWF0IjoxNjIwOTQxNDM5LCJuYmYiOjE2MjA5NDE0MzksImV4cCI6MTY1MzA4MjIzOSwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMiJ9fX0.l0U9oMeNMbkGGpUtrllYh7cqt7blxuZCqSlOO-7hbsI"
  );
  xhr.onload = function () {
    if (xhr.status === 200) {
      callback(xhr.response);
    }
  };
  xhr.send();
}

getLBP();
