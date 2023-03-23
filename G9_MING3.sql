select * from g9.dealer;
insert into g9.dealer values (2345671,'John Smith', '01 Clifton Street, Malden', 021, 781219223, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://github.com/youngyangyang04'
);

insert into g9.dealer values (2345672,'Brian', '01 Clifton Street, Malden', 021, 781219223, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://youngyangyang'
);

insert into g9.dealer values (2345673,'Williams', '01 Clifton Street, Malden', 021, 781219223, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://youngyangyang04'
);
update g9.dealer set year_joined = to_date('2012-06-21', 'yyyy-mm-dd') where did = 2345672;
update g9.dealer set year_joined = to_date('2009-05-01', 'yyyy-mm-dd') where did = 2345673;

update g9.dealer set address = '01 Pleasant Street, Malden' where did = 2345672;
update g9.dealer set address = '05 Terr Street, Malden' where did = 2345673;

commit;

select * from g9.customer;
insert into g9.customer values(000001,'Harry', 'Potter', '4 Privet Drive', 001, 0987652345, to_date('1998-09-20', 'yyyy-mm-dd'));
insert into g9.customer values(000002,'Ron', 'Weasley', 'Hogwards', 002, 0987652344, to_date('1999-10-20', 'yyyy-mm-dd'));
insert into g9.customer values(000003,'Jack', 'Williams', 'Hogwards', 002, 0987652354, to_date('2001-03-10', 'yyyy-mm-dd'));
commit;

select * from g9.connections;
insert into g9.connections values(3000001, 000001, 2345671, 'can price go any lower?', to_date('2023-02-02', 'yyyy-mm-dd'));
insert into g9.connections values(3000002, 000002, 2345672, 'can I get your number?', to_date('2023-02-03', 'yyyy-mm-dd'));
insert into g9.connections values(3000003, 000002, 2345673, 'how is the car condition?', to_date('2023-01-23', 'yyyy-mm-dd'));

commit;


select * from g9.car_model;
insert into g9.car_model values(4000001,1, 'A6', 'basic', 'sports car', 2500， to_date('2000-03-03', 'yyyy-mm-dd'));
insert into g9.car_model values(4000002,2, 'Corolla', 'standard', 'Sedan', 3000， to_date('2000-03-03', 'yyyy-mm-dd'));
insert into g9.car_model values(4000003,3, 'Mustang', 'luxory', 'coupe', 4000， to_date('2010-12-01', 'yyyy-mm-dd'));

commit;

select interior_color from g9.inventory where vin='LVWEDDSEE3EFA534F';
insert into g9.inventory values('LGWEFSEE3DFA333F2',2345671,4000001,'Black', 'red', 'clean', '2000', to_date('2000-01-03', 'yyyy-mm-dd') , '0');
insert into g9.inventory values('LGWSSSDE3DFAWS3SS',2345673,4000002,'white', 'white', 'clean', '3000', to_date('2019-01-03', 'yyyy-mm-dd') , '0');
insert into g9.inventory values('LVWEDDSEE3EFA534F',2345672,4000003,'Grey', 'Black', 'clean', '3050', to_date('2021-11-21', 'yyyy-mm-dd') , '0');
commit;

select * from g9.Features;
insert into g9.Features values(600001,4000001,4, '22/11', 'gas', '4wd', 'manual', '1', '0', '1','1','0');
insert into g9.Features values(600002,4000003,3, '12/3', 'gas', 'fwd', 'Auto', '0', '0', '0','1','0');
insert into g9.Features values(600003,4000002,2, '12/3', 'gas', '2wd', 'Auto', '1', '1', '0','1','1');

commit;
