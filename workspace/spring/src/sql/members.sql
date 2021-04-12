drop table board2;
drop table members;

create table members
(
	mno number, -- 회원번호(시퀀스 사용)
	mid varchar2(30), -- 회원 아이디
	mname varchar2(30), -- 회원 이름
	memail varchar2(100), -- 이메일
	mdate date -- 가입일
);

alter table members add constraint members_pk primary key(mno);
alter table members add constraint members_mid_uq unique(mid);
alter table members add constraint members_memail_uq unique(memail);

drop sequence members_seq;

create sequence members_seq
increment by 1
start with 1
nomaxvalue
nominvalue
nocycle
nocache;

select mno
	 , mid
	 , mname
	 , memail
	 , mdate
 from MEMBERS
order by mno desc;










