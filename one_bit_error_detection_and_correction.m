clc;
clearvars;

message=dec2bin(randi([0,2^12 - 1]),12);

org_matrix=reshape(message,4,3)';
new_matrix1=zeros(4,5);
a1=[];
b1=[];

for i=1:3
    check=0;
    for j=1:4
        new_matrix1(i,j)=bin2dec(org_matrix(i,j));
        check=bitxor(check,bin2dec(org_matrix(i,j)));
    end
    new_matrix1(i,5)=check;
    a1=[a1 check];
end

for i=1:4
    check=0;
    for j=1:3
        new_matrix1(j,i)=bin2dec(org_matrix(j,i));
        check=bitxor(check,bin2dec(org_matrix(j,i)));
    end
    new_matrix1(4,j)=check;
    b1=[b1 check];
end

number=message;

count=0;
for i=1:length(number)
    if number(i)=='1'
        count=count+1;
    end
end

if mod(count,2)==0
    number=[number '0'];
else
    number=[number '1'];
end

fprintf('Original Message= %s\n',number);

err_pos=randi([1,13]);
fprintf('Error Position=%d\n',err_pos)

new_number=number;
if new_number(err_pos)=='1'
    new_number(err_pos)='0';
elseif new_number(err_pos)=='0'
    new_number(err_pos)='1';
end

fprintf('Erroneous Message= %s\n',new_number);

count=0;
for i=1:length(new_number)
    if new_number(i)=='1'
        count=count+1;
    end
end

if mod(count,2)==0
    disp("No error in message!");
else
    disp("Error in message!");
end

new_message=new_number(1:12);
new_message1=new_message;
fprintf('New Message=%s\n',new_message);

matrix=reshape(new_message,4,3)';

new_matrix2=zeros(4,5);
a2=[];
b2=[];

for i=1:3
    check=0;
    for j=1:4
        new_matrix2(i,j)=bin2dec(matrix(i,j));
        check=bitxor(check,bin2dec(matrix(i,j)));
    end
    new_matrix2(i,5)=check;
    a2=[a2 check];
end

for i=1:4
    check=0;
    for j=1:3
        new_matrix2(j,i)=bin2dec(matrix(j,i));
        check=bitxor(check,bin2dec(matrix(j,i)));
    end
    new_matrix2(4,j)=check;
    b2=[b2 check];
end

disp(new_matrix1);
disp(new_matrix2);

for i=1:length(a1)
    if a1(i)==a2(i)
        a=3;
    else
        a=i;
        break
    end
end

for i=1:length(b1)
    if b1(i)==b2(i)
        b=4;
    else
        b=i;
        break
    end
end

detected_err_pos=4*(a-1)+b;
fprintf('Error detected at position = %d\n',detected_err_pos);

if new_message(detected_err_pos)=='0'
    new_message(detected_err_pos)='1';
elseif new_message(detected_err_pos)=='1'
    new_message(detected_err_pos)='0';
end

fprintf('Original Message =             %s\n',message);
fprintf('Received Message =             %s\n',new_message1);
fprintf('Message after error resolved = %s',new_message);