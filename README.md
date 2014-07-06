lua-chromaprint
===============

Simple colour text printing for ANSI compatible terminals.  Lua5.2.

This project is an attempt to simplify colour test formatting on ANSI mode consoles allowing easy data-driven formatting of text.

<h4>Example</h4>
```lua
    --[[ Here we are overriding the standard Lua print function.  
        All existing print() calls will continue to work normally, though, so 
        this is probably a safe override.
    ]]
    print = require("chroma") 
    
    --Let's print a scary greeting
    print.red("hello, world!")
    
    --Perhaps that wasn't aggressive enough?
    print.red.underline.bold("I said 'Hello, World!...'\n\n")
    --Maybe that was too much; perhaps a cooler tone?
    print.blue.bold.highlight.navy("Oh, I'm afraid I just blue myself")
    
    --[[ We can also do that in a different order because the formatting 
         table indexes are generated dynamically
    ]]
    print.green.bold("Such a poor choice of words\n\n")
    --Let's print today's headline
    
    print.highlight.gray(string.rep(' ', 80))
    print.yellow.bold.underline.highlight.navy("Do you know the muffin man?")
    print.highlight.gray(string.rep(' ', 80)..'\n\n')
    
    --If we want to just use print as normal, then why not?
    print('"Normal Printing never seemed so possible"')
    print('\n\n')

--[[Perhaps the best part of using the library, is the dynamic lookups,
which allow us to autoformat code. Take the following text from wikipedia'
https://en.wikipedia.org/wiki/Colours#Color_naming
]]

wiki = [[
    Colors vary in several different ways, including hue (shades of red, orange, yellow, green, blue, and violet), saturation, brightness, and gloss. Some color words are derived from the name of an object of that color, such as "orange" or "salmon", while others are abstract, like "red".

In the 1969 study Basic Color Terms: Their Universality and Evolution, Brent Berlin and Paul Kay describe a pattern in naming "basic" colors (like "red" but not "red-orange" or "dark red" or "blood red", which are "shades" of red). All languages that have two "basic" color names distinguish dark/cool colors from bright/warm colors. The next colors to be distinguished are usually red and then yellow or green. All languages with six "basic" colors include black, white, red, green, blue, and yellow. The pattern holds up to a set of twelve: black, gray, white, pink, red, orange, yellow, green, blue, purple, brown, and azure (distinct from blue in Russian and Italian, but not English).
]]

print.print = function(s) return io.write(s .. ' ') end
colours = {red=1, yellow=1, pink=1, green=1, orange=1, blue=1, gray=1}
for x in wiki:gmatch('%w+') do
    if colours[x] then
        print[x](x)
    else
        print(x)
    end
end

print('\n\n')

--Now, it's time for some rainbows ()
oldprint = print.print
print.print = io.write
  
    for i = 1, 79 do
        print.highlight[(
            {'red', 'yellow', 'pink', 'green', 
            'orange','blue', 'gray', 'purple'}
        )[1 + math.floor(math.abs(math.random()) * 6)]](" ")
  end
  print('\n')
```

The above code will output something like the following on an ANSI compatible terminal:
![ScreenShot](/img/example_output.png)
