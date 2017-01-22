function [overview_scripts] = make_codeoverview_html(dirinit,dirname,redminepath,texfilelist,m2htmllib_path,template)%
%
if nargin == 5,
    template = 'help';
end
%
if exist(fullfile(m2htmllib_path,'templates',template,'codeoverview.html'),'file')
    delete(fullfile(m2htmllib_path,'templates',template,'codeoverview.html'));
end
%
diary(fullfile(m2htmllib_path,'templates',template,'codeoverview.html')),% create codeoverview.html file in help template
%
disp('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"');
disp('        "http://www.w3.org/TR/html4/loose.dtd">');
disp('<html lang="en">');
disp('<head>');
disp('	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">');
disp(['	<title>',dirname,' Package</title>']);
disp('</head>');
disp('<body>');
%
disp(['<H1>',dirname,' Package: Tutorial & TeX Help</H1>']);
%
io = 1;
overview_scripts = '';
%
if exist(fullfile(dirinit,'INSTALL.m'),'file')
    overview_scripts(io).path = fullfile(dirinit,'INSTALL.m');overview_scripts(io).format = '';
    io = io + 1;
end
%
if exist(fullfile(dirinit,'README.m'),'file')
    overview_scripts(io).path = fullfile(dirinit,'README.m');overview_scripts(io).format = '';
    io = io + 1;
end
%
if exist(fullfile(dirinit,'VERSIONS.m'),'file')
    overview_scripts(io).path = fullfile(dirinit,'VERSIONS.m');overview_scripts(io).format = '';
    io = io + 1;
end
%
if exist(fullfile(dirinit,'AUTHORS.m'),'file')
    overview_scripts(io).path = fullfile(dirinit,'AUTHORS.m');overview_scripts(io).format = '';
end
%
if ~isempty(overview_scripts)
    disp('');
    disp('<H2>Overview</H2>');
    disp('');
    for io = 1:length(overview_scripts),
        if strfind(overview_scripts(io).path,'README.m'),
            disp('<a href="OVERVIEW_files/README.html">Read me</a><br>');
        end
        if strfind(overview_scripts(io).path,'AUTHORS.m'),
            disp('<a href="OVERVIEW_files/AUTHORS.html">Author list</a><br>');
        end
        if strfind(overview_scripts(io).path,'VERSIONS.m'),
            disp('<a href="OVERVIEW_files/VERSIONS.html">Version (CVS tags)</a><br>');
        end
        if strfind(overview_scripts(io).path,'INSTALL.m'),
            disp('<a href="OVERVIEW_files/INSTALL.html">Code installation</a><br>');
        end
    end
    disp('');
    disp('<hr>');
else
    disp('');
    disp('<H2>Overview not available</H2>');
    disp('');
    disp('<hr>');
end
%
if exist(fullfile(dirinit,'TUTORIAL'),'dir'),
    disp('');
    disp('<H2>Tutorial</H2>');
    disp('');
    disp('<a href="tutorial.html">Tutorial</a><br>');
    disp('');
    disp('<hr>');
else
    disp('');
    disp('<H2>Tutorial not available</H2>');
    disp('');
    disp('<hr>'); 
end
%
if ~isempty(texfilelist)
    disp('');
    disp(['<H2>',dirname,' help (HTML)</H2>']);
    disp('');   
    for itex = 1:length(texfilelist),
        disp(['<a href="LaTeX/',texfilelist(itex).file,'.html" target="_blank">',texfilelist(itex).title,'</a><br>']);
    end
    disp('');
    disp('<hr>');
    disp(['<H2>',dirname,' help (pdf)</H2>']);
    disp('');   
    for itex = 1:length(texfilelist),
        disp(['<a href="LaTeX/',texfilelist(itex).file,'.pdf" target="_blank">',texfilelist(itex).title,'</a><br>']);
    end
    disp('');
end
%
disp(['<hr><address>Community support and wiki are available on <strong><a href="',redminepath,'" target="_blank">Redmine</a></strong>.</address>']);
disp(['<hr><address>Last update: ',date,'</address>'])
%
disp('</body>');
disp('</html>');
%
diary off
