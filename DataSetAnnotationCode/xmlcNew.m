%%
%�ô��������voc2007���ݼ��е�xml�ļ���
%txt�ļ�ÿ�и�ʽΪ��000002.jpg dog 44 28 132 121
%��ÿ����ͼƬ����Ŀ�����͡���Χ��������ɣ��ո����
%���һ��ͼƬ�ж��Ŀ�꣬���ʽ���£�����������Ŀ�꣩
%000002.jpg dog 44 28 132 121
%000002.jpg car 50 27 140 110
%��Χ������Ϊ���ϽǺ����½�
%���ߣ�С����_
%CSDN:http://blog.csdn.net/sinat_30071459
%%
clc;
clear;
%ע���޸������ĸ�����
imgpath='Alll\Train2\';%ͼ�����ļ���
imgpathN='Alll\JPEGImages4\';
txtpath='test-3_m.txt';%txt�ļ�
xmlpath_new='Alll\Annotations5\';%�޸ĺ��xml�����ļ���
foldername='VOC2007';%xml��folder�ֶ���

fidin=fopen(txtpath,'r');
lastname='begin';
j=1;
nameN='Cup2';
while ~feof(fidin)
     tline=fgetl(fidin);
%      if j==1
%          tline=tline(1,4:45);
%      end
    no=6500+j;
    nama=num2str(no);
    fno=[imgpathN,'00',nama,'.jpg'];
    Fnew=['00',nama,'.jpg'];
     str = regexp(tline, ' ','split');
%      str=cell(1,size(str2,2)-1);
%      str{1}=str2{1};
%      for zx=1:1:size(str2,2)-3
%         str{zx+1}=str2{zx+3};
%      end
     filepath=[imgpath,str{1}];
     if exist(filepath,'file')
   %  Fnew=str{1};
     img=imread(filepath);
     [h,w,d]=size(img);
          scale=1;     
       imshow(img);
%       imwrite(img,fno,'jpg');
      rectangle('Position',[str2double(str{3})*scale,str2double(str{4})*scale,(str2double(str{5})-str2double(str{3}))*scale,(str2double(str{6})-str2double(str{4}))*scale],'LineWidth',4,'EdgeColor','r');
        str{3}=num2str(floor(str2num(str{3})*scale));
        str{4}=num2str(floor(str2num(str{4})*scale));
        str{5}=num2str(floor(str2num(str{5})*scale));
        str{6}=num2str(floor(str2num(str{6})*scale));
      if size(str,2)>6
          nu=floor((size(str,2)-6)/5);
            for i=1:1:nu
                rectangle('Position',[str2double(str{5*i+3})*scale,str2double(str{5*i+4})*scale,(str2double(str{5*i+5})-str2double(str{5*i+3}))*scale,(str2double(str{5*i+6})-str2double(str{5*i+4}))*scale],'LineWidth',4,'EdgeColor','b');
                str{5*i+3}=num2str(floor(str2num(str{5*i+3})*scale));
                str{5*i+4}=num2str(floor(str2num(str{5*i+4})*scale));
                str{5*i+5}=num2str(floor(str2num(str{5*i+5})*scale));
                str{5*i+6}=num2str(floor(str2num(str{5*i+6})*scale));
            end
      end
      str{1}=str{1};
     pause(0.1);
        if strcmp(str{1},lastname)%����ļ�����ȣ�ֻ������object
           object_node=Createnode.createElement('object');
           Root.appendChild(object_node);
           node=Createnode.createElement('name');
           node.appendChild(Createnode.createTextNode(sprintf('%s',nameN)));
           object_node.appendChild(node);
          
           node=Createnode.createElement('pose');
           node.appendChild(Createnode.createTextNode(sprintf('%s','Unspecified')));
           object_node.appendChild(node);
          
           node=Createnode.createElement('truncated');
           node.appendChild(Createnode.createTextNode(sprintf('%s','0')));
           object_node.appendChild(node);

           node=Createnode.createElement('difficult');
           node.appendChild(Createnode.createTextNode(sprintf('%s','0')));
           object_node.appendChild(node);
          
           bndbox_node=Createnode.createElement('bndbox');
           object_node.appendChild(bndbox_node);

           node=Createnode.createElement('xmin');
           node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{3}))));
           bndbox_node.appendChild(node);

           node=Createnode.createElement('ymin');
           node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{4}))));
           bndbox_node.appendChild(node);

           node=Createnode.createElement('xmax');
           node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{5}))));
           bndbox_node.appendChild(node);

           node=Createnode.createElement('ymax');
           node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{6}))));
           bndbox_node.appendChild(node);
        else %����ļ������ȣ�����Ҫ�½�xml
  %        copyfile(filepath, 'JPEGImages');
            %�ȱ�����һ�ε�xml
           if exist('Createnode','var')
              tempname=lastname;
              tempname=strrep(tempname,'.jpg','.xml');
              xmlwrite(tempname,Createnode);   
           end
            
            
            Createnode=com.mathworks.xml.XMLUtils.createDocument('annotation');
            Root=Createnode.getDocumentElement;%���ڵ�
            node=Createnode.createElement('folder');
            node.appendChild(Createnode.createTextNode(sprintf('%s',foldername)));
            Root.appendChild(node);
            node=Createnode.createElement('filename');
            node.appendChild(Createnode.createTextNode(sprintf('%s',str{1})));
            Root.appendChild(node);
            source_node=Createnode.createElement('source');
            Root.appendChild(source_node);
            node=Createnode.createElement('database');
            node.appendChild(Createnode.createTextNode(sprintf('My Database')));
            source_node.appendChild(node);
            node=Createnode.createElement('annotation');
            node.appendChild(Createnode.createTextNode(sprintf('VOC2007')));
            source_node.appendChild(node);

           node=Createnode.createElement('image');
           node.appendChild(Createnode.createTextNode(sprintf('flickr')));
           source_node.appendChild(node);

           node=Createnode.createElement('flickrid');
           node.appendChild(Createnode.createTextNode(sprintf('NULL')));
           source_node.appendChild(node);
           owner_node=Createnode.createElement('owner');
           Root.appendChild(owner_node);
           node=Createnode.createElement('flickrid');
           node.appendChild(Createnode.createTextNode(sprintf('NULL')));
           owner_node.appendChild(node);

           node=Createnode.createElement('name');
           node.appendChild(Createnode.createTextNode(sprintf('xiaoxianyu')));
           owner_node.appendChild(node);
           size_node=Createnode.createElement('size');
           Root.appendChild(size_node);

          node=Createnode.createElement('width');
          node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(w))));
          size_node.appendChild(node);

          node=Createnode.createElement('height');
          node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(h))));
          size_node.appendChild(node);

         node=Createnode.createElement('depth');
         node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(d))));
         size_node.appendChild(node);
         
          node=Createnode.createElement('segmented');
          node.appendChild(Createnode.createTextNode(sprintf('%s','0')));
          Root.appendChild(node);
          object_node=Createnode.createElement('object');
          Root.appendChild(object_node);
          node=Createnode.createElement('name');
          node.appendChild(Createnode.createTextNode(sprintf('%s',nameN)));
          object_node.appendChild(node);
          
          node=Createnode.createElement('pose');
          node.appendChild(Createnode.createTextNode(sprintf('%s','Unspecified')));
          object_node.appendChild(node);
          
          node=Createnode.createElement('truncated');
          node.appendChild(Createnode.createTextNode(sprintf('%s','0')));
          object_node.appendChild(node);

          node=Createnode.createElement('difficult');
          node.appendChild(Createnode.createTextNode(sprintf('%s','0')));
          object_node.appendChild(node);
          
          bndbox_node=Createnode.createElement('bndbox');
          object_node.appendChild(bndbox_node);

         node=Createnode.createElement('xmin');
         node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{3}))));
         bndbox_node.appendChild(node);

         node=Createnode.createElement('ymin');
         node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{4}))));
         bndbox_node.appendChild(node);

        node=Createnode.createElement('xmax');
        node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{5}))));
        bndbox_node.appendChild(node);

        node=Createnode.createElement('ymax');
        node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{6}))));
        bndbox_node.appendChild(node);
        if size(str,2)>6
            nu=floor((size(str,2)-6)/5);
            for i=1:1:nu
          object_node=Createnode.createElement('object');
          Root.appendChild(object_node);
          node=Createnode.createElement('name');
          node.appendChild(Createnode.createTextNode(sprintf('%s',nameN)));
          object_node.appendChild(node);
          
          node=Createnode.createElement('pose');
          node.appendChild(Createnode.createTextNode(sprintf('%s','Unspecified')));
          object_node.appendChild(node);
          
          node=Createnode.createElement('truncated');
          node.appendChild(Createnode.createTextNode(sprintf('%s','0')));
          object_node.appendChild(node);

          node=Createnode.createElement('difficult');
          node.appendChild(Createnode.createTextNode(sprintf('%s','0')));
          object_node.appendChild(node);
          
          bndbox_node=Createnode.createElement('bndbox');
          object_node.appendChild(bndbox_node);

         node=Createnode.createElement('xmin');
         node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{5*i+3}))));
         bndbox_node.appendChild(node);

         node=Createnode.createElement('ymin');
         node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{5*i+4}))));
         bndbox_node.appendChild(node);

        node=Createnode.createElement('xmax');
        node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{5*i+5}))));
        bndbox_node.appendChild(node);

        node=Createnode.createElement('ymax');
        node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(str{5*i+6}))));
        bndbox_node.appendChild(node);
            end
        end
       lastname=str{1};
        end
        %�������һ��
        if feof(fidin)
            tempname=lastname;
            tempname=strrep(tempname,'.jpg','.xml');
            xmlwrite(tempname,Createnode);
        end
         j=j+1;
     end
end
fclose(fidin);

file=dir(pwd);
for i=1:length(file)
   if length(file(i).name)>=4 && strcmp(file(i).name(end-3:end),'.xml')
    fold=fopen(file(i).name,'r');
    fnew=fopen([xmlpath_new file(i).name],'w');
    line=1;
    while ~feof(fold)
        tline=fgetl(fold);
        if line==1
           line=2;
           continue;
        end
        expression = '   ';
        replace=char(9);
        newStr=regexprep(tline,expression,replace);
        fprintf(fnew,'%s\n',newStr);
    end
    fprintf('�Ѵ���%s\n',file(i).name);
    fclose(fold);
    fclose(fnew);
	delete(file(i).name);
   end
end
