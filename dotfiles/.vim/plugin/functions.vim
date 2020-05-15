" Load up a URL on the current line in chrome
function! Browser ()
    let url = matchstr(getline("."), '\%\(http:\/\/\|www\.\|https:\/\/\)[^ ,;\t()]*')
    if url != ""

        let containsHttp = matchstr(url, '\%^http')

        " If there's no http prefix then plonk one on
        if containsHttp == ""
            let url = "http://" . url
        endif

        " If we have a URL then launch in chrome
        exec "!open '/Applications/Google\ Chrome.app' ".url
    else
        echo "No URL found on line"
    endif
endfunction
