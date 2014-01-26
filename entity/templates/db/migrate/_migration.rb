class Create<%= _.capitalize(pluralize(name)) %> < ActiveRecord::Migration
  def change
    create_table :<%= pluralize(name) %> do |t|
      <% _.each(attrs, function (attr) { %>
      t.<% if (attr.attrType == 'Enum') { %>string<% } else { %><%= attr.attrType.toLowerCase() %><% } %> :<%= attr.attrName %>
      <% }); %>
    end
  end
end
