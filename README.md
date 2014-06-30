lua-chromaprint
===============

simple colour text printing for ANSI compatible terminals.  Lua5.2.
<h4>Example</h4>
```lua
  print = require("chromaprint")
  print.red("hello,world")
  print.bold.blue("Oh, I'm afraid I just blue myself")
  print.green.bold.underline.strikethrough.highlight.red("BIG BLOCKS")
  print.highlight.gray(string.rep('HEADER', 80))
  --If we want to just use print as normal, then why not?
  print("Back to normal")
  
  --now some rainbows
  oldprint = print.print
  print.print = io.write
  
  for i = 1, 80 do
  print.highlight[
    table.pack('red', 'yellow', 'pink', 'green', 'orange','blue')[1 + math.floor(math.abs(math.random()) * 6)]
  ](string.char(31 + math.floor(math.abs(math.random()) * 95)))
  end
  print()

--https://en.wikipedia.org/wiki/Colours#Color_naming
wiki = [[Colors vary in several different ways, including hue (shades of red, orange, yellow, green, blue, and violet), saturation, brightness, and gloss. Some color words are derived from the name of an object of that color, such as "orange" or "salmon", while others are abstract, like "red".

In the 1969 study Basic Color Terms: Their Universality and Evolution, Brent Berlin and Paul Kay describe a pattern in naming "basic" colors (like "red" but not "red-orange" or "dark red" or "blood red", which are "shades" of red). All languages that have two "basic" color names distinguish dark/cool colors from bright/warm colors. The next colors to be distinguished are usually red and then yellow or green. All languages with six "basic" colors include black, white, red, green, blue, and yellow. The pattern holds up to a set of twelve: black, gray, white, pink, red, orange, yellow, green, blue, purple, brown, and azure (distinct from blue in Russian and Italian, but not English).]]

print.print = function(s) return io.write(s .. ' ') end
colours = {red=1, yellow=1, pink=1, green=1, orange=1, blue=1}
for x in wiki:gmatch('%w+') do
    if colours[x] then
        print[x](x)
    else
        print(x)
    end
end
```
