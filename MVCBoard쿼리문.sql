--회원테이블
create table member (
	id varchar2(30) not null,    
	pass varchar2(40) not null,  
	name varchar2(50) not null,  
	regidate date default sysdate, 
	primary key (id)
);

--모델2 방식의 파일첨부형 게시판 테이블
create table mvcboard (
	idx number primary key, 
	id varchar2(30) not null,
	title varchar2(200) not null, 
	content varchar2(2000) not null, 
	postdate date default sysdate not null, 
	ofile varchar2(200), 
	sfile varchar2(30), 
	downcount number(5) default 0 not null, 	
	visitcount number default 0 not null
);

/*
외래키 생성
자식인 게시판 테이블의 id컬럼이 부모인 회원 테이블의 id컬럼을 참조하는
외래키를 생성한다. */
alter table mvcboard
    add constraint board_mem_fk foreign key (id)
    references member (id);
    
--게시판 테이블에서 사용할 시퀀스 생성    
create sequence seq_board_num 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;    

--더미 데이터 입력
insert into member (id, pass, name) values ('musthave', '1234', '머스트해브');

insert into mvcboard (idx, id, title, content)
    values (seq_board_num.nextval, 'musthave', '자료실 제목1 입니다.','내용');
insert into mvcboard (idx, id, title, content)
    values (seq_board_num.nextval, 'musthave', '자료실 제목2 입니다.','내용');
insert into mvcboard (idx, id, title, content)
    values (seq_board_num.nextval, 'musthave', '자료실 제목3 입니다.','내용');
insert into mvcboard (idx, id, title, content)
    values (seq_board_num.nextval, 'musthave', '자료실 제목4 입니다.','내용');
insert into mvcboard (idx, id, title, content)
    values (seq_board_num.nextval, 'musthave', '자료실 제목5 입니다.','내용');

commit;

--이름까지 출력을 위한 조인 쿼리문
select Bo.*, Me.name from mvcboard Bo inner join member Me on Bo.id=Me.id 
where idx=2;

