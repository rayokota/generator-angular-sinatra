# encoding: utf-8
class <%= _.capitalize(baseName) %> < Sinatra::Application
  get '/<%= baseName %>/<%= pluralize(name) %>' do
    format_response(<%= _.capitalize(name) %>.all, request.accept)
  end

  get '/<%= baseName %>/<%= pluralize(name) %>/:id' do
    entity ||= <%= _.capitalize(name) %>.<%= orm == 'ar' ? 'find' : 'get' %>(params[:id]) || halt(404)
    format_response(entity, request.accept)
  end

  post '/<%= baseName %>/<%= pluralize(name) %>' do
    body = MultiJson.load request.body.read
    entity = <%= _.capitalize(name) %>.create(
      <% _.each(attrs, function (attr) { %>
      <%= attr.attrName %>: body['<%= attr.attrName %>'],
      <% }); %>
    )
    status 201
    format_response(entity, request.accept)
  end

  put '/<%= baseName %>/<%= pluralize(name) %>/:id' do
    body = MultiJson.load request.body.read
    entity ||= <%= _.capitalize(name) %>.<%= orm == 'ar' ? 'find' : 'get' %>(params[:id]) || halt(404)
    halt 500 unless entity.update(
      <% _.each(attrs, function (attr) { %>
      <%= attr.attrName %>: body['<%= attr.attrName %>'],
      <% }); %>
    )
    format_response(entity, request.accept)
  end

  delete '/<%= baseName %>/<%= pluralize(name) %>/:id' do
    entity ||= <%= _.capitalize(name) %>.<%= orm == 'ar' ? 'find' : 'get' %>(params[:id]) || halt(404)
    halt 500 unless entity.destroy
    status 204
  end
end
