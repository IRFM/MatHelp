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
function make_mathelp_help(verbose)
%LUKE/MatHelp - Installation script for automatic generation of the on-line documentation 
%
%Installation script for automatic generation of the on-line documentation using MatHelp library
%
% INPUT:
%
%	- verbose: display the output of the documentation build-up (on/off). Empty is off.
%
% OUTPUT: none
%
% by Y.Savoye-Peysson CEA <yves.savoye-peysson@cea.fr> and Joan Decker EPFL (joan.decker@epfl.ch)
%
if nargin == 0,
    verbose = 'off';
end
%
pathmetis0 = which('metis4itm');%remove metis4itm in the Matlab search because it uses also m2html nut in a different way
if length(pathmetis0) > 0,
	imetis4itm = strfind(pathmetis0,'metis4itm');
    warning off
	rmpath(genpath([pathmetis0(1:imetis4itm(1)-1),'metis4itm']));
	warning on
end
%
excludedfoldernames = {};%list of excluded folders. Update if necessary 
%
disp('************************* EXCLUDED FOLDER NAMES **************************')
for ie = 1:length(excludedfoldernames),
    disp([' - ',excludedfoldernames{ie}])
end
disp('**************************************************************************')
%
dirinit = pwd;
%
helptools = '';%specific display tools (like TeX, GraphViz or ImageMagick which are considered by default)
%
% List of pdf text files that can be viewed from the web browser. 
%
% Format: 
%       texfilelist(i).file = path to the file without extension;
%       texfilelist(i).title = name of the link in the webpage;
%
%
texfilelist = '';
%
ref_folder = what('MatHelp');
%wikipath = 'https://spcsrv.epfl.ch/redmine';%path to the redmine website 
wikipath = 'https://forgejo.yvespeysson.fr/starwars';%path to the forgejo website 
%
if isempty(wikipath),disp('WARNING: the ''wikipath'' path is empty.');end
%
make_help(verbose,ref_folder(1).path,wikipath,texfilelist,excludedfoldernames,helptools);
%
cd(dirinit);
