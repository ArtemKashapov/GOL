function row = tableRowAsHTML(rowData, varargin)
    if isempty(varargin)
        row={['<HTML><table border=0 width=400 bgcolor=#CCECFE><TR><TD> ',rowData{1},' </TD></TR> </table></HTML>'],...
                 ['<HTML><table border=0 width=400 bgcolor=#CCECFE><TR><TD> ',rowData{2},' </TD></TR> </table></HTML>'],...
                 ['<HTML><table border=0 width=400 bgcolor=#CCECFE><TR><TD> ',rowData{3},' </TD></TR> </table></HTML>'],...
                 ['<HTML><table border=0 width=400 bgcolor=#CCECFE><TR><TD> ',rowData{4},' </TD></TR> </table></HTML>'],...
                 ['<HTML><table border=0 width=400 bgcolor=#CCECFE><TR><TD> ',rowData{5},' </TD></TR> </table></HTML>']};
         return;
    elseif length(varargin)==1% change row color
        row={['<HTML><table border=0 width=400 bgcolor=',varargin,'><TR><TD>',rowData{1},'</TD></TR> </table></HTML>'],...
                 ['<HTML><table border=0 width=400 bgcolor=',varargin,'><TR><TD>',rowData{2},'</TD></TR> </table></HTML>'],...
                 ['<HTML><table border=0 width=400 bgcolor=',varargin,'><TR><TD>',rowData{3},'</TD></TR> </table></HTML>'],...
                 ['<HTML><table border=0 width=400 bgcolor=',varargin,'><TR><TD>',rowData{4},'</TD></TR> </table></HTML>'],...
                 ['<HTML><table border=0 width=400 bgcolor=',varargin,'><TR><TD>',rowData{5},'</TD></TR> </table></HTML>']};
         return;
    elseif length(varargin)==3% change row color % varargin = [rowColor , colomnIdx, colomnColor]
        row={'<HTML><table border=0 width=400 bgcolor=',varargin{1},'><TR><TD>',rowData{1},'</TD></TR> </table></HTML>',...
                 '<HTML><table border=0 width=400 bgcolor=',varargin{1},'><TR><TD>',rowData{2},'</TD></TR> </table></HTML>',...
                 '<HTML><table border=0 width=400 bgcolor=',varargin{1},'><TR><TD>',rowData{3},'</TD></TR> </table></HTML>',...
                 '<HTML><table border=0 width=400 bgcolor=',varargin{1},'><TR><TD>',rowData{4},'</TD></TR> </table></HTML>',...
                 '<HTML><table border=0 width=400 bgcolor=',varargin{1},'><TR><TD>',rowData{5},'</TD></TR> </table></HTML>'};
        row(varargin(2))={'<HTML><table border=0 width=400 bgcolor=',varargin{3},'><TR><TD>',rowData{varargin{2}},'</TD></TR> </table></HTML>'};
    return;
    else
      disp('wrong row color assignation')  ;
    end

end