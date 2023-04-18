--create or replace view bfi_pbi_other_course_detail_2 as
select uu.username as "NIK", uu.first_name as "Nama", cc.title as "Course Title", cc.id as "Course ID",

case when max(case when qq.quiz_id = qq2.id and qq.title like '%(Pre Test)' and cc.id = qq.course_id then (qq.score)
end) is null then '-' else max(case when qq.quiz_id = qq2.id and qq.title like '%(Pre Test)' and cc.id = qq.course_id then (qq.score)
end)::text end as "Pre Test",

case when max(case when qq.title like '%(Pre Test)' then to_char(qq.created, 'DD/MM/YYYY')
end) is null then '-' else max(case when qq.title like '%(Pre Test)' then to_char(qq.created, 'DD/MM/YYYY')
end)::text end as "Tanggal (Pre Test)",

case when max(case when qq.quiz_id = qq2.id and qq.title like '%(Post Test)' and cc.id = qq.course_id then (qq.score)
end) is null then '-' else max(case when qq.quiz_id = qq2.id and qq.title like '%(Post Test)' and cc.id = qq.course_id then (qq.score)
end)::text end as "Post Test",

case when max(case when qq.title like '%(Post Test)' then to_char(qq.created, 'DD/MM/YYYY')
end) is null then '-' else max(case when qq.title like '%(Post Test)' then to_char(qq.created, 'DD/MM/YYYY')
end)::text end as "Tanggal (Post Test)",

case when max(case when qq.quiz_id = qq2.id and qq.title like '%(Post Test)' and cc.id = qq.course_id then qq.score else null end) is null then 'Belum Akses' else 
     case when max(case when qq.quiz_id = qq2.id and qq.title like '%(Post Test)' and cc.id = qq.course_id then qq.score else null end) >= 70 then 'Lulus' else 'Belum Lulus'
     end 
end as "Status",

coalesce(sum(case when qq.quiz_id = qq2.id and qq.title like '%(Post Test)' and cc.id = qq.course_id then 1
end), 0) as "Num of Attempt (Post Test)",

case when max(case when qq.quiz_id = qq2.id and qq.title like '%(Post Test)' and cc.id = qq.course_id then qq.score end) is null then 0 else 1 
end AS "Is Participant"

from quizzes_quizresult qq
full join contents_course cc on cc.id = qq.course_id
full join quizzes_quiz qq2 on qq2.id = qq.quiz_id
full join users_user uu on uu.id = qq.user_id
--where uu.username = '083277'
where 
uu.username not like 'mbeat%' and
cc.title != 'GPOP : APU-PPT' and
cc.title != 'GPOP : Company Profile' and
cc.title != 'GPOP : Core Value' and
cc.title != 'GPOP : Proses Bisnis' and
cc.title != 'GPOP : Product Knowledge' and
cc.title != 'GPOP : Overview System BFI' and
cc.title != 'GPOP : Fraud Awareness' and
cc.title != 'GPOP : Standar Etika Pelayanan' and
cc.title != 'GPOP : Peraturan Perusahaan' and
cc.title != 'tes' and
cc.title != 'Trial Quiz Mixed' and
cc.title != 'Trial : Quiz' and
cc.title != 'Dummy : Quiz' and
cc.title not like 'GLP 1%' and 
cc.title not like 'GREAT People Orientation Program (GPOP)%' and 
cc.title not like '2gen%' and --uu.username = '5001091'
cc.title not like '3gen%' and 
cc.title not like '2spc%' and 
cc.title not like '3spc%' and 
cc.title not like '2SPC%' and
uu.username != '06478' and
uu.username != '7002565' and
uu.username != '86168' and
uu.username != '89928' and
uu.username != '91228' and
uu.username != 'bfi-admin'
group by uu.first_name, uu.username, cc.title, cc.id