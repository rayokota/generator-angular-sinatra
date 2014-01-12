# encoding: utf-8
class <%= _.capitalize(name) %>
  include DataMapper::Resource

  property :id, Serial
  <% _.each(attrs, function (attr) { %>
  <% if (attr.attrType == 'Enum') { %>property :<%= attr.attrName %>, Enum[<% var delim = ''; _.each(attr.enumValues, function (value) { %><%= delim %>:<%= value %><% delim = ', '; }) %>]<% } else { %>
  property :<%= attr.attrName %>, <%= attr.attrType %>
  <% }}); %>
end
