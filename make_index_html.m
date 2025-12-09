% /////////////////////////////////////////
%
% Software name : MatHelp, part of LUKE
%
% Authors : Yves Savoye-Peysson and Joan Decker
%
% Copyright holders : Commissariat a l'Energie Atomique et aux Energies Alternatives (CEA), France
%
% CEA authorizes the use of the LUKE software under the CeCILL-C open source license https://cecill.info/licences/Licence_CeCILL-C_V1-en.html  
%
% The terms and conditions of the CeCILL-C license are deemed to be accepted upon downloading the software and/or exercising any of the rights granted under the CeCILL-C license.
% 
% /////////////////////////////////////////
%
function make_index_html(dirname,m2htmllib_path,template)%
%
if nargin == 2,
    template = 'blue';%'help';
end
%
if exist(fullfile(m2htmllib_path,'templates',template,'index.html'),'file')
    delete(fullfile(m2htmllib_path,'templates',template,'index.html'));
end
%
diary(fullfile(m2htmllib_path,'templates',template,'index.html')),% create index.html file in help template
%
disp('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"');
disp('                "http://www.w3.org/TR/REC-html40/loose.dtd">');
disp('<html>');
disp('<head>');
disp(['  <title>Matlab Documentation of ',dirname,'</title>']);
disp('  <meta name="keywords" content="matlab, m2html, documentation">');
disp(['  <meta name="description" content="Matlab Documentation of ',dirname,'">']);
disp('  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">');
disp('  <meta name="generator" content="m2html &copy; 2003 Guillaume Flandin">');
disp('  <meta name="robots" content="index, follow">');
disp('  <link type="text/css" rel="stylesheet" href="m2html.css">');
disp('</head>');
disp('<frameset cols="20%, 80%">');
disp('  <frame scrolling="yes" name="menu" src="menu.html"></frame>');
disp('  <frame scrolling="yes" name="function" src="about:blank"></frame>');
disp('</frameset>');
disp('<noframe>');
disp('Sorry, your browser doesn''t support frames.');
disp('Go to <a href="menu.html">menu.html</a> for the documentation of all the Matlab functions.');
disp('</noframe>');
disp('</html>');
%
diary off
