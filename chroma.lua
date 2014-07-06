return setmetatable({
    escapes = {
        red = "\x1b[31m",
        green = "\x1b[32m",
        orange = "\x1b[33m",
        navy = "\x1b[34m",
        magenta = "\x1b[35m",
        cyan = "\x1b[36m",
        gray = "\x1b[90m",
        grey = "\x1b[90m",
        light_gray = "\x1b[37m",
        light_grey = "\x1b[37m",
        peach = "\x1b[91m",
        light_green = "\x1b[92m",
        yellow = "\x1b[93m",
        blue = "\x1b[94m",
        pink = "\x1b[95m",
        baby_blue = "\x1b[96m",
        
        highlight = {
            red = "\x1b[41m",
            green = "\x1b[42m",
            orange = "\x1b[43m",
            navy = "\x1b[44m",
            magenta = "\x1b[45m",
            cyan = "\x1b[46m",
            gray = "\x1b[47m",
            grey = "\x1b[47m",
            light_gray = "\x1b[100m",
            light_grey = "\x1b[100m",
            peach = "\x1b[101m",
            light_green = "\x1b[102m",
            yellow = "\x1b[103m",
            blue = "\x1b[104m",
            pink = "\x1b[105m",
            baby_blue = "\x1b[106m",
        },
        
        strikethrough = "\x1b[9m",
        underline = "\x1b[4m",
        bold = "\x1b[1m",
    },
    _sequence = '',
    _highlight = false,
    --[[in the case that the user later overrides `print` or sets `print` to 
    this table we save it for internal use
    ]]
    print = print,
    reset_global = function(self)
        _G.print = self.print
    end
}, 
{
    __call = function(self, ...) return self.print(...) end,

    __index = function(self, index)
        local esc = self._highlight and rawget(self, 'escapes').highlight[index] or rawget(self, 'escapes')[index]
        local clear = "\x1b[0m"
        local root_table = self
        self._highlight = index == 'highlight'
        if esc ~= nil then
            if type(esc) == 'string' then
                self._sequence = self._sequence .. esc
            end
            return setmetatable({}, {
                __call = function(proxy, ...) 
                    _ = self._sequence and io.write(self._sequence)
                    root_table.print(...)
                    root_table._sequence = ''
                    io.write(clear)
                end,
                __index = function(proxy, k)
                    return root_table[k]
                end,
            })
        else
            return rawget(self, index)
        end
    end,
})

