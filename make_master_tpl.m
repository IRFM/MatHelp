function make_master_tpl(dirinit,dirname,texfilelist,m2htmllib_path,template)%
%
if nargin == 4,
    template = 'help';
end
%
if exist(fullfile(m2htmllib_path,'templates',template,'master.tpl'),'file')
    delete(fullfile(m2htmllib_path,'templates',template,'master.tpl'));
end
%
diary(fullfile(m2htmllib_path,'templates',template,'master.tpl')),% create index.html file in help template
%
disp('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"');
disp('                "http://www.w3.org/TR/REC-html40/loose.dtd">');
disp('<html>');
disp('<head>');
disp(['  <title>',dirname,' package</title>']);
disp('  <meta name="keywords" content="{DIRS}">');
disp('  <meta name="description" content="{DIRS}">');
disp('  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">');
disp('  <meta name="generator" content="m2html &copy; 2003 Guillaume Flandin">');
disp('  <meta name="robots" content="index, follow">');
disp('  <link type="text/css" rel="stylesheet" href="{MASTERPATH}m2html.css">');
disp('</head>');
disp('<body>');
disp('<a name="_top"></a>');
%
disp(['<h1>',dirname,' package</h1>']);
%
disp('');
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
master_title = '';
%
if ~isempty(overview_scripts)
    master_title = [master_title,'Overview'];
end
%
if ~isempty(master_title) && exist(fullfile(dirinit,'TUTORIAL'),'dir')
    master_title = [master_title,' & Tutorial'];
elseif isempty(master_title) && exist(fullfile(dirinit,'TUTORIAL'),'dir')
    master_title = [master_title,'Tutorial'];
end
%
if ~isempty(master_title) && ~isempty(texfilelist)
    master_title = [master_title,' & TeX Doc'];
elseif isempty(master_title) && ~isempty(texfilelist)
    master_title = [master_title,'TeX Doc'];
end
%
disp(['<P align=center><A href="codeoverview.html" target=function>',master_title,'</A></P>']);
disp('');
disp('<h2>Matlab Directories</h2>');
disp('<ul style="list-style-image:url({MASTERPATH}matlabicon.gif)">');
disp('<!-- BEGIN rowdir -->');
disp('<li><a href="{L_DIR}" target="menu">{DIR}</a></li>');
disp('<!-- END rowdir -->');
disp('</ul>');
disp('<!-- BEGIN idrow -->');
disp('<!-- BEGIN idcolumn -->');
disp('<!-- {L_IDNAME} {T_IDNAME} {IDNAME} -->');
disp('<!-- END idcolumn -->');
disp('<!-- END idrow -->');

disp('<hr><address>Community support and wiki are available on <strong><a href="{REDMINEPATH}" target="_blank">Redmine</a></strong>.</address>');
disp('</body>');
disp('</html>');
%
diary off
