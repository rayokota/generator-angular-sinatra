# encoding: utf-8
require_relative 'index'
<% _.each(entities, function (entity) { %>
require_relative '<%= pluralize(entity.name) %>'
<% }); %>
