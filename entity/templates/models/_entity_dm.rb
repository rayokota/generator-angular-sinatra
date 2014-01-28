# encoding: utf-8
class <%= _.capitalize(name) %>
  include DataMapper::Resource

  property :id, Serial
  <% _.each(attrs, function (attr) { %>
  property :<%= attr.attrName %>, <% if (attr.attrType == 'Enum') { %>Enum[<% var delim = ''; _.each(attr.enumValues, function (value) { %><%= delim %>:<%= value %><% delim = ', '; }) %>]<% } else { %><%= attr.attrType %><% }; %><% if (attr.required) { %>, required: true<% }; %><% if (attr.maxLength) { if (attr.minLength) { %>, length: <%= attr.minLength %>..<%= attr.maxLength %><% } else { %>, length: <%= attr.maxLength %><% } };%>
  <% }); %>
end
