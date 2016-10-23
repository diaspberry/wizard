 /*
  * Diaspberry Wizard
  *
  * Copyright (C) 2016 Lukas Matt <lukas@zauberstuhl.de>,
  * Matthias Neutzner <matthias.neutzner@gmail.com>
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */

$(document).ajaxStart(function() {
  $(".spinner").fadeIn('slow');
});
$(document).ajaxStop(function() {
  $(".spinner").hide();
});

$.ajax({
  method: 'get',
  url: '/updater/check',
  success: function(data) {
    console.debug(data);

    if (data.update) {
      $('#update').attr({
        class: 'btn btn-success',
        value: $('#update').val() + data.version,
      });
      $('#update').fadeIn('slow');
    } else {
      $('#next').fadeIn('slow');
    }
  },
  error: function(data) {
    console.debug(data);
    $('#next').fadeIn('slow');
  }
});

$('#update').click(function() {
  $.ajax({
    method: 'post',
    url: '/updater/run',
    success: function(data) {
      $('#next').fadeIn('slow');
      $('#update').hide();
    },
    error: function(data) {
      // TODO what happens if the update fails
    }
  });
});
