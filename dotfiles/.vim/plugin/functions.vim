" Load up a URL on the current line in chrome
function! Browser ()
    let url = matchstr(getline("."), '\%\(http:\/\/\|www\.\|https:\/\/\)[^ ,;\t()'']*')
    if url != ""
        " If we have a URL then launch in chrome
        exec '!google-chrome "'.url.'"'
    else
        echo "No URL found on line"
    endif
endfunction
