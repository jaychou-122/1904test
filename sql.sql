CREATE TABLE student(
sno INT(20),
sname VARCHAR(20),
ssex VARCHAR(20),
sbirthday DATE,
class VARCHAR(20)
)

CREATE TABLE score(
sno INT(10),
cno INT(10),
degree INT(10)
)

CREATE TABLE course(
cno INT(10),
cname VARCHAR(10),
tho INT(10)
)

CREATE TABLE teacher(
tno INT(10),
tname VARCHAR(10),
tsex VARCHAR(10),
prof VARCHAR(10),
depart VARCHAR(10)
)

-- 1.查询所有“女”教师和“女”同学的名字，性别和出生年月
SELECT sname,ssex,sbirthday FROM student t1 LEFT JOIN score t2 ON t1.sno=t2.sno LEFT JOIN 
course t3 ON t2.cno=t3.cno LEFT JOIN teacher t4 ON t3.tho=t4.tno WHERE t1.ssex='女' OR 
t4.tsex='女'
-- 2.查询成绩比该课程平均成绩低的同学的信息
SELECT t1.* FROM student t1 LEFT JOIN score t2 ON t1.sno=t2.sno  WHERE 
degree<(SELECT AVG(degree)FROM score)GROUP BY t2.cno 
-- 3.查询“张益达”教师任课的学生成绩
SELECT t2.degree FROM student t1 LEFT JOIN score t2 ON t1.sno=t2.sno LEFT JOIN 
course t3 ON t2.cno=t3.cno LEFT JOIN teacher t4 ON t3.tho=t4.tno WHERE t4.tname='张益达'
-- 4.查询学生成绩大于70，小于90的教师信息
SELECT t4.* FROM student t1 LEFT JOIN score t2 ON t1.sno=t2.sno LEFT JOIN 
course t3 ON t2.cno=t3.cno LEFT JOIN teacher t4 ON t3.tho=t4.tno  WHERE t2.degree>70 AND
t2.degree<90
-- 5.查询最高分的学生学号和课程号
SELECT t1.sno,t2.cno FROM student t1 LEFT JOIN score t2 ON t1.sno=t2.sno WHERE t2.degree=(SELECT 
MAX(degree)FROM score)
-- 6.查询所有选修“英语”课程的“男”同学的成绩
SELECT degree FROM student t1 LEFT JOIN score t2 ON t1.sno=t2.sno LEFT JOIN 
course t3 ON t2.cno=t3.cno WHERE t3.cname='英语' AND t1.ssex='男'
-- 7.查询选修了2门课程的学生学号和姓名
SELECT t1.sno,t1.sname FROM student t1 LEFT JOIN score t2 ON t1.sno=t2.sno  GROUP BY t2.cno 
HAVING COUNT(cno)='2'
-- 8.查询每个学生所选的课程并且根据成绩升序排序
SELECT * FROM student t1 LEFT JOIN score t2 ON t1.sno=t2.sno LEFT JOIN 
course t3 ON t2.cno=t3.cno ORDER BY t2.degree


CREATE TABLE yh(
yid INT(10),
yname VARCHAR(20),
phone INT(20),
sex INT(20),
price INT(10),
age INT(10)
)

CREATE TABLE yhb(
bid INT(10),
yid INT(10),
jid INT(10)
)

CREATE TABLE jsb(
jid INT(10),
mingcheng VARCHAR(10)
)

CREATE TABLE jsqx(
qid INT(10),
jid INT(10),
qxid INT(10)
)

CREATE TABLE qx(
qxid INT(10),
quanxian VARCHAR(10)
)


-- 1.查询年龄在40以上的经理的权限个数
SELECT COUNT(t5.qxid) FROM yh t1 LEFT JOIN yhb t2 ON t1.yid=t2.yid LEFT JOIN jsb t3 ON t2.jid=
t3.jid LEFT JOIN jsqx t4 ON t3.jid=t4.jid LEFT JOIN qx t5 ON t4.qxid=t5.qxid WHERE t1.age>'40'
AND t3.mingcheng='经理'
-- 2.查询手机号是‘158’开头，权限为‘创建用户’的角色名称
SELECT t3.mingcheng FROM  yh t1 LEFT JOIN yhb t2 ON t1.yid=t2.yid LEFT JOIN jsb t3 ON t2.jid=
t3.jid LEFT JOIN jsqx t4 ON t3.jid=t4.jid LEFT JOIN qx t5 ON t4.qxid=t5.qxid  WHERE t1.phone
LIKE '158%' AND t5.quanxian='创建用户'
-- 3.删除性别女，薪水低于4000的员工权限为空的信息
\
-- 4.查询权限为‘删除用户’的角色名称为经理的年龄大小并降序排列
SELECT * FROM yh t1 LEFT JOIN yhb t2 ON t1.yid=t2.yid LEFT JOIN jsb t3 ON t2.jid=
t3.jid LEFT JOIN jsqx t4 ON t3.jid=t4.jid LEFT JOIN qx t5 ON t4.qxid=t5.qxid  WHERE
 t5.quanxian='删除用户' AND t3.mingcheng='经理' ORDER BY t1.age

-- 5.将手机号为空的项目负责人的的年龄改为42
UPDATE yh t1 LEFT JOIN yhb t2 ON t1.yid=t2.yid LEFT JOIN jsb t3 ON t2.jid=
t3.jid LEFT JOIN jsqx t4 ON t3.jid=t4.jid LEFT JOIN qx t5 ON t4.qxid=t5.qxid SET t1.age=42 
WHERE t1.phone IS NULL
-- 6.查询权限为‘业绩审查’的角色名称并按 年龄分组
SELECT t3.mingcheng FROM yh t1 LEFT JOIN yhb t2 ON t1.yid=t2.yid LEFT JOIN jsb t3 ON t2.jid=
t3.jid LEFT JOIN jsqx t4 ON t3.jid=t4.jid LEFT JOIN qx t5 ON t4.qxid=t5.qxid  WHERE
t5.quanxian='业绩审查' GROUP BY t1.age
-- 7.查询所有手机信息，手机号为空的默认展示13511111111，性别展示为男，女以及角色名称
SELECT	IFNULL(phone,'135111111'),CASE WHEN sex=1 THEN '男' WHEN sex=2 THEN '女'
END AS age FROM yh
-- 8.查询姓李的用户的权限个数
SELECT COUNT(t5.qxid) FROM yh t1 LEFT JOIN yhb t2 ON t1.yid=t2.yid LEFT JOIN jsb t3 ON t2.jid=
t3.jid LEFT JOIN jsqx t4 ON t3.jid=t4.jid LEFT JOIN qx t5 ON t4.qxid=t5.qxid WHERE t1.yname LIKE
'李%'
