var Dashboard = {
  request: null,
  template: null,
  errorTemplate: null,
  spinner: null,
  refreshTimeout: 10000,

  init: function() {
    Dashboard.request = new XMLHttpRequest();
    Dashboard.request.addEventListener('load', Dashboard.renderBody, false);

    var source = document.getElementById("dashboard-template").innerHTML;
    Dashboard.template = Handlebars.compile(source);

    var errorSource = document.getElementById("dashboard-error-template").innerHTML;
    Dashboard.errorTemplate = Handlebars.compile(errorSource);

    Dashboard.spinner = document.getElementById("spinner");

    Dashboard.update();
    // setInterval(Dashboard.update, Dashboard.refreshTimeout);
  },

  renderBody: function(e) {
    var resp = JSON.parse(e.target.responseText);

    if (resp.error) {
      html = Dashboard.errorTemplate(resp);
    } else {
      html = Dashboard.template(resp);
    }
    document.getElementById("rendered-body").innerHTML = html;

    Dashboard.toggleSpinner();
  },

  update: function() {
    Dashboard.toggleSpinner();
    Dashboard.request.open('GET', "/ajax", true);
    Dashboard.request.send(null);
  },

  toggleSpinner: function() {
    Dashboard.spinner.style.display = (Dashboard.spinner.style.display == "none") ? "block" : "none";
  }
};