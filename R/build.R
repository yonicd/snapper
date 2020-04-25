build_call <- function(type,arg,opts,ui){

  if(nzchar(opts)){
    opts <- sprintf(',%s',opts)
  }

  sprintf(cavnas_template, ui, opts, call_contents(type,arg))

}

call_contents <- function(type = c('preview','download'),arg){

  switch(type,
         'preview' = {
           sprintf('$("#%s").empty();\n$("#%s").append(canvas);',arg,arg)
         },
         'download' = {
           sprintf('saveAs(canvas.toDataURL(), "%s");',arg)
         })

}

cavnas_template <- '(function () {
    html2canvas($("%s")[0]%s).then(canvas=>{
      %s
    });
    })();'
