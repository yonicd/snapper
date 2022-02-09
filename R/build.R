build_call <- function(type,arg,opts,ui, ...){

  if(nzchar(opts)){
    opts <- sprintf(',%s',opts)
  }

  sprintf(canvas_template, ui, opts, call_contents(type,arg, ...))

}

call_contents <- function(type = c('preview','download'),arg, save_dir){

  switch(type,
         'preview' = {
           sprintf('var img = document.createElement("img");
                    img.src = canvas.toDataURL("png");
                    img.width = parseInt(canvas.style.width);
                    img.height = parseInt(canvas.style.height);
                    $("#%s").empty();
                    $("#%s").append(img);',
                   arg,arg)
         },
         'download' = {
           sprintf('saveAs(canvas.toDataURL("png"), "%s");',arg)
         },
         'save' = {
           sprintf('
           var img = canvas.toDataURL();
           Shiny.setInputValue(
             `snap:snapper`,
             { image: img, filename : "%s", dir : "%s" },
             { priority : "event" }
           );', arg, URLencode(save_dir))
         })

}

canvas_template <- '(function () {
    html2canvas($("%s")[0]%s).then(canvas=>{
      %s
    });
    })();'
