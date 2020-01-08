function save(data)
[FILENAME, PATHNAME, filterindex] = uiputfile( ...
    {'*.bmp','Image Files (*.bmp)';
    '*.bmp', 'Bitmap-files (*.bmp)';...
    '*.*',  'All Files (*.*)'},...
    'Save as');

if filterindex == 0
    return
end

type = 'bmp';
I = find(FILENAME == '.', 1);
if isempty(I)
    FILENAME = [PATHNAME FILENAME '.' type];
else
    FILENAME = [PATHNAME FILENAME];
end
imwrite(mat2gray(data).*256,gray(256),FILENAME,'bmp');