require('mkdnflow').setup({
    to_do = {
        symbols = {'❌', '🟡', '✅'},
    },
    links = {
        conceal = true,
        transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            return(text)
        end
    },
    mappings = {
        MkdnGoBack = false,
    },
})
