var str = '';
str += '<div id="DivID">';
str += '<OBJECT id="WebPDF" width="100%" height="'+pdfheight+'"  classid="clsid:39E08D82-C8AC-4934-BE07-F6E816FD47A1" codebase="';
str += webRoot + '/widgets/iWebOffice/iWebPDF.ocx#version=8,0,0,580" VIEWASTEXT>';
str += '</object>';
str += '</div>';
document.write(str);