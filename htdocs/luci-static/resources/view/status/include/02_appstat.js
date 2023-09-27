'use strict';
'require view';
'require uci';

return view.extend({
  title: _('Application Status'),
  handleSaveApply: null,
  handleSave: null,
  handleReset: null,
  load: function () {
    // Initialize the 'this' variable for access within promises
    var self = this;

    // Create a URL with the desired fields
    var apiUrl = '/cgi-bin/luci/admin/services/appstat/appstatus';

    // Create a new XMLHttpRequest object
    var xhr = new XMLHttpRequest();

    // Set up the GET request
    xhr.open('GET', apiUrl, true);

    // Set the response type to JSON
    xhr.responseType = 'json';

    // Define the onload event handler
    xhr.onload = function () {
      if (xhr.status === 200) {
        self.appData = xhr.response; // Save APP data to the 'appData' variable
      }
    };

    // Send the request
    xhr.send();

    // Use UCI to fetch the 'appstat' configuration from OpenWrt or LEDE system
    return uci.load('appstat').then(function () {
      self.appInfoConfig = uci.get('appstat', 'config');
    });
  },
  render: function (data) {
    if (!this.appData || !this.appInfoConfig) {
      // If APP data or 'appstat' configuration is not available yet, display a loading message or other content
      return 'Loading application information...';
    }

    // Create a table with selected information from ip-api.com
    var table = E('table', { 'class': 'table' });

    // List of properties to display with corresponding labels
    var propertiesToShow = {
      'Cloudflare': 'cloudflared',
      'Docker': 'dockerd',
      'Ngrok': 'ngrok',
      'OpenClash': 'clash',
      'Samba': 'smbd',
      'ZeroTier': 'zerotier-one'
    };

    // Create a mapping between propertiesToShow and appInfoConfig values
    var propertyToConfigMapping = {
      'cloudflared': 'cloudflared',
      'dockerd': 'dockerd',
      'ngrok': 'ngrok',
      'clash': 'clash',
      'smbd': 'smbd',
      'zerotier-one': 'zerotier'
    };

    // Iterate through properties to display
    for (var label in propertiesToShow) {
      if (propertiesToShow.hasOwnProperty(label)) {
        var key = propertiesToShow[label];
        var value = this.appData[key];

        // Check if the key exists in the mapping and use the mapped value
        var configKey = propertyToConfigMapping[key];
        if (value !== undefined && this.appInfoConfig[configKey] === '1') {
          // Create a <td> element with appropriate class for value color
          var labelTd = E('td', { 'class': 'td left', 'width': '33%' }, [label]);
          var valueTd = E('td', {
            'class': 'td left',
            'style': 'color: ' + (value === 'Running' ? 'green' : 'red') + ';'
          }, [value]);

          // Append the <td> elements to the table row
          table.appendChild(E('tr', { 'class': 'tr' }, [labelTd, valueTd]));
        }
      }
    }

    return table;
  }
});
