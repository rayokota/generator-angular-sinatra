# encoding: utf-8
<% _.each(entities, function (entity) { %>
require_relative '<%= entity.name %>'
<% }); %>
