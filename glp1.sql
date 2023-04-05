select ee.NIK as "NIK", ee.Name as "Name", ee.JobTitle as "Job Title", ee.[Join Date] as "Join Date", ee.WorkLocation as "Work Location", ee.Area as "Area", ee.region as "Region", cc.title as "Course Title", qq.course_id as "Course ID",

max(case when qq.title like '%Pre Test%' and cc.id = qq.course_id then qq.score 
end) as "Pre Test",

convert(varchar(16), (select top 1 qq2.created from QuizzesQuizresult qq2 where qq2.user_id = uu.id and qq2.course_id = cc.id and qq2.title like '%Pre Test%'
order by qq2.score desc, qq2.created desc
)) as "Created (Pre Test)",

max(case when qq.title like '%Post Test%' and cc.id = qq.course_id then qq.score
end) as "Post Test",

convert(varchar(16), (select top 1 qq2.created from QuizzesQuizresult qq2 where qq2.user_id = uu.id and qq2.course_id = cc.id and qq2.title like '%Post Test%'
order by qq2.score desc, qq2.created desc
)) as "Created (Post Test)",

sum(case when qq.title like '%Post Test%' and cc.id = qq.course_id then 1
end) as "Num Of Attempt (Post Test)",

(case when max(case when qq.title like '%Post Test%' and cc.id = qq.course_id then qq.score end) >= 70 then 'Lulus' else 'Belum Lulus'
end) as "Status",

(case when (max(case when qq.title like '%Post Test%' and cc.id = qq.course_id then qq.score end) >= 70) OR (sum(case when qq.title like '%Post Test%' and cc.id = qq.course_id then 1 end) >= 3) then 'Completed' else 'Incomplete' 
end) as "Completion",

case when max(case when qq.title like '%Post Test%' and cc.id = qq.course_id then qq.score end) is null then 0 else 1 
end AS "Is Participant"

--into HCIR.dbo.mbeat_PBI_GLP1

from dbo.QuizzesQuizresult as qq
full join dbo.UsersMbeat as uu on uu.id = qq.user_id
full join dbo.ContentsCourse2 as cc on cc.id = qq.course_id
full join dbo.DataEmployee as ee on ee.NIK = uu.username
where ee.[Resign Date] is null and (ee.EmploymentStatus = 'Contract' or ee.EmploymentStatus = 'Mitra' or ee.EmploymentStatus = 'Permanent' or ee.EmploymentStatus = 'Probation')
and ee.JobTitle != 'Management Trainee External In Class' and (ee.JG = '8' or ee.JG = '9' or ee.JG = '10') and cc.title like 'GLP 1%' and 

((ee.JobTitle = 'Account Marketing Representative' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1475')) or
(ee.JobTitle = 'Account Verificator (AcTor)' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1486')) or
(ee.JobTitle = 'Admin Centro' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1499')) or
(ee.JobTitle = 'Admin Corporate' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1476')) or
(ee.JobTitle = 'Admin Corporate Staff' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1476')) or
(ee.JobTitle = 'ARE (Car Product)' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1502')) or
(ee.JobTitle = 'ARE (Motorcycle Product)' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1487')) or
(ee.JobTitle = 'Asset Management Admin' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1760')) or
(ee.JobTitle = 'Branch Telesales Executive (Agency) Car' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1489')) or
(ee.JobTitle = 'CA Factory' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1475')) or
(ee.JobTitle = 'Cashier' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1484' OR cc.id = '1483' OR cc.id = '1482')) or
(ee.JobTitle = 'Compliance Corporate' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1478')) or
(ee.JobTitle = 'Compliance Mobil' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1497')) or
(ee.JobTitle = 'Compliance Motor' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1498')) or
(ee.JobTitle = 'Credit Marketing Syariah Ijarah' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '2421')) or
(ee.JobTitle = 'Credit Marketing Sharia Ijarah' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '2421')) or
(ee.JobTitle = 'Custodian Staff' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1507')) or
(ee.JobTitle = 'Custodian Staff HO' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1507')) or
(ee.JobTitle = 'Customer Marketing Executive' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '2775')) or
(ee.JobTitle = 'Customer Service' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1480')) or
(ee.JobTitle = 'FAM Sharia & Other' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1761')) or
(ee.JobTitle = 'Field Asset 1-90 Car Product' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1534')) or
(ee.JobTitle = 'Field Asset Management 1-90 Car' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1534')) or
(ee.JobTitle = 'Field Asset Management Car' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1534')) or
(ee.JobTitle = 'Field Asset 1-90 Motorcycle Product' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1534')) or
(ee.JobTitle = 'Field Asset Management 1-90 Motorcycle' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1534')) or
(ee.JobTitle = 'Field Asset Management Motorcycle' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1534')) or
(ee.JobTitle = 'Field Asset Management Digital' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1761')) or
(ee.JobTitle = 'Field Audit Staff' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1508')) or
(ee.JobTitle = 'Front Office Support' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1481')) or
(ee.JobTitle = 'Gerai Admin' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1920')) or
(ee.JobTitle = 'Inventory Staff' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1493')) or
(ee.JobTitle = 'Marketing Executive' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1491')) or
(ee.JobTitle = 'Marketing Relation Executive' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1503')) or
(ee.JobTitle = 'Verifikator Car' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '2547' OR cc.id = '2549' OR cc.id = '2545' OR cc.id = '2551' OR cc.id = '2546' OR cc.id = '2552' OR cc.id = '2553' OR cc.id = '2550' OR cc.id = '2548')) or
(ee.JobTitle = 'Verifikator Motorcycle' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '2556' OR cc.id = '2556' OR cc.id = '2554' OR cc.id = '2560' OR cc.id = '2555' OR cc.id = '2561' OR cc.id = '2559' OR cc.id = '2557')) or
(ee.JobTitle = 'Warehouse Staff' and (cc.title LIKE 'GLP 1 Soft%' OR cc.id = '1759')) or

(ee.JobTitle != 'Account Marketing Representative' OR 
ee.JobTitle != 'Account Verificator (AcTor)' OR 
ee.JobTitle != 'Admin Centro' OR 
ee.JobTitle != 'Admin Corporate' OR 
ee.JobTitle != 'Admin Corporate Staff' OR 
ee.JobTitle != 'ARE (Car Product)' OR 
ee.JobTitle != 'ARE (Motorcycle Product)' OR 
ee.JobTitle != 'Asset Management Admin' OR 
ee.JobTitle != 'Branch Telesales Executive (Agency) Car' OR 
ee.JobTitle != 'CA Factory' OR 
ee.JobTitle != 'Cashier' OR 
ee.JobTitle != 'Compliance Corporate' OR 
ee.JobTitle != 'Compliance Mobil' OR 
ee.JobTitle != 'Compliance Motor' OR 
ee.JobTitle != 'Credit Marketing Syariah Ijarah' OR 
ee.JobTitle != 'Credit Marketing Sharia Ijarah' OR 
ee.JobTitle != 'Custodian Staff' OR 
ee.JobTitle != 'Custodian Staff HO' OR 
ee.JobTitle != 'Customer Marketing Executive' OR 
ee.JobTitle != 'Customer Service' OR 
ee.JobTitle != 'FAM Sharia & Other' OR 
ee.JobTitle != 'Field Asset 1-90 Car Product' OR 
ee.JobTitle != 'Field Asset Management 1-90 Car' OR 
ee.JobTitle != 'Field Asset Management Car' OR 
ee.JobTitle != 'Field Asset 1-90 Motorcycle Product' OR 
ee.JobTitle != 'Field Asset Management 1-90 Motorcycle' OR 
ee.JobTitle != 'Field Asset Management Motorcycle' OR 
ee.JobTitle != 'Field Asset Management Digital ' OR 
ee.JobTitle != 'Field Audit Staff' OR 
ee.JobTitle != 'Front Office Support' OR 
ee.JobTitle != 'Gerai Admin' OR 
ee.JobTitle != 'Inventory Staff' OR 
ee.JobTitle != 'Marketing Executive' OR 
ee.JobTitle != 'Marketing Relation Executive' OR 
ee.JobTitle != 'Verifikator Car' OR 
ee.JobTitle != 'Verifikator Motorcycle' OR 
ee.JobTitle != 'Warehouse Staff') and (cc.title LIKE 'GLP 1 Soft%'))

group by ee.NIK, ee.Name, ee.JobTitle, cc.title, ee.Region, ee.WorkLocation, ee.Area, ee.[Join Date], ee.[Resign Date], ee.EmploymentStatus, ee.JG, qq.user_id, qq.course_id, uu.id, cc.id
order by ee.Name asc
