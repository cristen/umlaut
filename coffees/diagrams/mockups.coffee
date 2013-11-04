class Mockup
    constructor: (@x, @y, @text, @fixed=true) ->
        @margin = x: 10, y: 5
        @anchors =
            N: =>
                x: @x
                y: @y - @height() / 2
            S: =>
                x: @x
                y: @y + @height() / 2
            E: =>
                x: @x + @width() / 2
                y: @y
            W: =>
                x: @x - @width() / 2
                y: @y

    pos: ->
        x: @x
        y: @y

    set_txt_bbox: (bbox) ->
        @_txt_bbox = bbox

    txt_width: ->
        @_txt_bbox.width + 2 * @margin.x

    txt_height: ->
        @_txt_bbox.height + 2 * @margin.y

    txt_x: ->
        0

    txt_y: ->
        - @_txt_bbox.height / 2

    width: ->
        @txt_width()

    height: ->
        @txt_height()

    direction: (x, y) ->
        delta = @height() / @width()

        if @x <= x and @y <= y
            if y > delta * (x - @x) + @y
                return 'S'
            else
                return 'E'
        if @x >= x and @y <= y
            if y > delta * (@x - x) + @y
                return 'S'
            else
                return 'W'
        if @x <= x and @y >= y
            if y > delta * (@x - x) + @y
                return 'E'
            else
                return 'N'
        if @x >= x and @y >= y
            if y > delta * (x - @x) + @y
                return 'W'
            else
                return 'N'

    objectify: ->
        name: @constructor.name
        x: @x
        y: @y
        text: @text
        href: @href
        fixed: @fixed


class Use extends Mockup
    constructor: ->
        super()
        @text = ""
        @id = "#fallout"

    txt_x: ->
        super() - @height() / 4 + @txt_height() / 6

    txt_width: ->
        Math.max(0, super() - @txt_height() / 3)

    pos: ->
        x: @x
        y: @y

    href: ->
        @href
        
    path: ->
        bottom = @height() / 2 - @txt_height() + @margin.y


class Phone extends Use
    constructor: ->
        super()
        @id = "#phone"


class Browser extends Use
    constructor: ->
        super()
        @id = "#browser"

class Mockups extends Diagram
    label: 'Mockups diagrams'

    constructor: ->
        super()

        @linkstyle = 'diagonal'
        @types =
            elements: [Use, Phone, Browser]
            links: [Association, Inheritance]

Diagram.diagrams['Mockups'] = Mockups
