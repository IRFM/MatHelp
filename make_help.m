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
function make_help(verbose,dirinit,wikipath,texfilelist,excludedfoldernames,helptools)
%LUKE/MatHelp - Installation script for automatic generation of the on-line help 
%
%Installation script for automatic generation of the on-line documentation
%(pdflatex and tex4html required for a complete build of the documentation)
%
% INPUT:
%
%	- verbose: display the output of the documentation build-up (on/off). Empty is off.
%	- dirinit: path to the folder from which Help must be self-generated
%	- wikipath: path to redmine or forgejo. May be an html link (string)
%	- texfilelist: 
%	- excludedfoldernames: list of folders that are not considered in the self-generated Help
%	- helptools: 
%
% OUTPUT: none
%
% by Y.Savoye-Peysson CEA <yves.savoye-peysson@cea.fr> and Joan Decker EPFL (joan.decker@epfl.ch)
%
warning off
disp('-------------------------------------');
disp('WARNING: Matlab warning are disabled');
disp('-------------------------------------');
%
wikipath_default = 'https://forgejo.yvespeysson.fr/starwars';
%
if nargin == 0,
    verbose = 'off';
    dirinit = pwd;
    wikipath = wikipath_default;
    texfilelist = '';
    excludedfoldernames = '';
    helptools = '';
elseif nargin == 1,
    dirinit = pwd;
    wikipath = wikipath_default;
    texfilelist = '';
    excludedfoldernames = '';
    helptools = '';
elseif nargin == 2,
    wikipath = wikipath_default;
    texfilelist = '';
    excludedfoldernames = '';
    helptools = '';
elseif nargin == 3,
    texfilelist = '';
    excludedfoldernames = '';
    helptools = '';
elseif nargin == 4,
    excludedfoldernames = '';
    helptools = '';
elseif nargin == 5,
    helptools = '';
end
%
% Search htlatex, pdflztex, imagemagick, graphviz paths if not given
%
path_htlatex = '';s_htlatex = 1;
path_pdflatex = '';s_pdflatex = 1;
path_imagemagick = '';s_imagemagick = 1;
path_graphviz = '';s_graphviz = 1;
%
PATH_init = getenv('PATH');
%
if isempty(helptools)
    rootdir = {'','/usr/texbin/','/usr/local/bin/','/usr/bin/','/opt/local/bin/','/opt/bin/'};
    %
    for ir = 1:length(rootdir),
        if s_htlatex,
            [s_htlatex,path_htlatex] = unix(['which ',rootdir{ir},'htlatex']);%htlatex (TeXLive distribution)
        end
        %
        if s_pdflatex,
            [s_pdflatex,path_pdflatex] = unix(['which ',rootdir{ir},'pdflatex']);%pdflatex (TeXLive distribution)
        end
        %
        if s_imagemagick,
            [s_imagemagick,path_imagemagick] = unix(['which ',rootdir{ir},'convert']);%imagemagick
        end
        %
        if s_graphviz,
            [s_graphviz,path_graphviz] = unix(['which ',rootdir{ir},'dot']);%graphviz
        end
        %
    end
else
    if isfield(helptools,'htlatex'),path_htlatex = helptools.htlatex;s_htlatex = 0;setenv('PATH',[getenv('PATH'),':',fileparts(path_htlatex)]);end
    if isfield(helptools,'pdflatex'),path_pdflatex = helptools.pdflatex;s_pdflatex = 0; setenv('PATH',[getenv('PATH'),':',fileparts(path_pdflatex)]);end
    if isfield(helptools,'imagemagick'),path_imagemagick = helptools.imagemagick;s_imagemagick = 0;setenv('PATH',[getenv('PATH'),':',fileparts(path_imagemagick)]);end
    if isfield(helptools,'graphviz'),path_graphviz = helptools.graphviz;s_graphviz = 0;setenv('PATH',[getenv('PATH'),':',fileparts(path_graphviz)]);end
end
%
if isempty(helptools),
    if ~isempty(path_htlatex) && ~s_htlatex,
        setenv('PATH',[getenv('PATH'),':',fileparts(path_htlatex)])
        disp(' ------------------------------------------------------------------------------------------------------')
        disp(' -----> The path of TEXLIVE htlatex function has been succesfully found')
        disp(' ------------------------------------------------------------------------------------------------------')    
    else
        disp(' ------------------------------------------------------------------------------------------------------')
        disp(' -----> WARNING: the environment variable for TEXLIVE is not setup')
        disp(' -----> The latex to html conversion is not possible.')
        disp(' -----> The unix command ''which htlatex'' must give the path before building the help.')
        disp(' ------------------------------------------------------------------------------------------------------')    
    end
    %
    if ~isempty(path_pdflatex) && ~s_pdflatex,
        setenv('PATH',[getenv('PATH'),':',fileparts(path_pdflatex)])
        disp(' ------------------------------------------------------------------------------------------------------')
        disp(' -----> The path of TEXLIVE pdflatex function has been succesfully found')
        disp(' ------------------------------------------------------------------------------------------------------')    
    else
        disp(' ------------------------------------------------------------------------------------------------------')
        disp(' -----> WARNING: the environment variable for TEXLIVE is not setup')
        disp(' -----> The latex to pdf conversion is not possible.')
        disp(' -----> The unix command ''which pdflatex'' must give the path before building the help.')
        disp(' ------------------------------------------------------------------------------------------------------')    
    end
    %
    if ~isempty(path_imagemagick) && ~s_imagemagick,
        setenv('PATH',[getenv('PATH'),':',fileparts(path_imagemagick)])
        disp(' ------------------------------------------------------------------------------------------------------')
        disp(' -----> The path of IMAGEMAGICK convert function has been succesfully found')
        disp(' ------------------------------------------------------------------------------------------------------')    
    else
        disp(' ------------------------------------------------------------------------------------------------------')
        disp(' -----> WARNING: the environment variable for IMAGEMAGICK is not setup')
        disp(' -----> The graphs cannot be displayed.')
        disp(' -----> The unix command ''which convert'' must give the path before building the help.')
        disp(' ------------------------------------------------------------------------------------------------------')    
        return
    end
    %
    if ~isempty(path_graphviz) && ~s_graphviz,
        setenv('PATH',[getenv('PATH'),':',fileparts(path_graphviz)])
        disp(' ------------------------------------------------------------------------------------------------------')
        disp(' -----> The path of GRAPHVIZ dot function has been succesfully found')
        disp(' ------------------------------------------------------------------------------------------------------')        
    else
        disp(' ------------------------------------------------------------------------------------------------------')
        disp(' -----> WARNING: the environment variable for GRAPHVIZ is not setup')
        disp(' -----> The graphs cannot be displayed.')
        disp(' -----> The unix command ''which dot'' must give the path before building the help.')
        disp(' ------------------------------------------------------------------------------------------------------')    
        return
    end
end
%
cd(dirinit);
%
[~,listDir] = get_all_filesname_yp(dirinit,{'.m','.f','.c','.php'},Inf,excludedfoldernames);
%
search_path = listDir;
%
m2htmllib_path = fullfile(fileparts(which('make_help.m')),'m2html');
%
if strcmp(dirinit(end),'/'),dirinit = dirinit(1:end-1);end
%
[~,dirname] = fileparts(dirinit);
%
make_index_html(dirname,m2htmllib_path);
%
overview_scripts = make_codeoverview_html(dirinit,dirname,wikipath,texfilelist,m2htmllib_path)
%
if ~s_htlatex == 0 && ~s_pdflatex == 0 && ~s_imagemagick == 0,
    texfilelist = '';%no tex file can be used
end
%
make_master_tpl(dirinit,dirname,texfilelist,m2htmllib_path)
%
for j = 1:length(search_path),
    %
    not_compatible_filename_list = check_filenames_yp(search_path{j});
    %
    if ~isempty(not_compatible_filename_list), 
        %
        disp('******************************** WARNING ***********************************')
        disp('****************************************************************************')
        for i = 1:length(not_compatible_filename_list),
            disp([' -----> ',not_compatible_filename_list{i}]);
        end
        %
        disp('****************************************************************************')
        disp('****************************************************************************')
        disp(' -----> Before building of the help,')
        disp(' 1) Rename all the files identified with the wrong name.')
        disp(' 2) Check the dependencies.')
        disp(' 3) Commit all the changes in the CVS repository.')
        disp('    WARNING: the whole history of the files whose name has changed must be saved.')
        disp('****************************************************************************')
        disp('****************************************************************************')
        %
        return
    end
end
%
htmldocbuilder_yp('off',dirinit,search_path,wikipath,excludedfoldernames,overview_scripts,verbose);%build html doc
%
pause(2);
%
if exist(fullfile(dirinit,'TUTORIAL'),'dir'),
    copyfile(fullfile(dirinit,'TUTORIAL'),fullfile(dirinit,'Help'))
end
%
if ~s_htlatex == 0 && ~s_pdflatex == 0 && ~s_imagemagick == 0,
    return
else
    texlist = '';
	for itex = 1:length(texfilelist)
        texlist{itex} = fullfile(dirinit,[texfilelist(itex).file,'.tex']);
    end
    %
    if ~isempty(texlist)
        cd(dirinit);
        pdfhtlatex_yp(dirinit,texlist,verbose);%build html and pdf doc from tex files
    end
end
%
setenv('PATH',PATH_init);

