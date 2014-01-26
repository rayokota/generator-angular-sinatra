class <%= _.capitalize(name) %> < ActiveRecord::Base
  <% _.each(attrs, function (attr) { %>
  <% if (attr.required) { %>validates :<%= attr.attrName %>, presence: true<% }; %>
  <% if (attr.maxLength) { %>validates :<%= attr.attrName %>, length: { <% if (attr.minLength) { %>minimum: <%= attr.minLength %>, <% } %>maximum: <%= attr.maxLength %> }<% };%>
  <% }); %>
end
