function CodeBlock(el)
    if el.classes[1] == "yaml" and el.classes[2] == "animate" then
        return pandoc.RawBlock("html", "<div data-animate data-src=\"".. el.attr.attributes["src"] .. "\" ><!-- " .. el.text .. " --></div>")
    end
end