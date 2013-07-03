var Dashboard = {
  request: null,
  template: null,

  init: function() {
    Dashboard.request = new XMLHttpRequest();
    Dashboard.request.addEventListener('load', Dashboard.renderBody, false);

    var source = document.getElementById("dashboard-template").innerHTML;
    Dashboard.template = Handlebars.compile(source);

    Dashboard.update();
    setInterval(Dashboard.update, 5000);
  },

  renderBody: function(e) {
    var resp = JSON.parse(e.target.responseText);
    document.getElementById("rendered-body").innerHTML = Dashboard.template(resp);
  },

  update: function() {
    Dashboard.request.open('GET', "/ajax", true);
    Dashboard.request.send(null);
  }
};