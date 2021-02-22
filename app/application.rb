class Application
    @@items = []
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        if req.path.match(/items/)
            found = false
            item_name = req.path.split("/items/").last
            @@items.each do |item|
                if item.name == item_name
                    found = true
                    resp.write item.price
                    resp.status = 200
                end
            end
            if found == false
                resp.status = 400
                resp.write 'Item not found'
            end
        else
            resp.write 'Route not found'
            resp.status = 404
        end
        resp.finish
    end
end