-- -- type_industries
-- INSERT INTO type_industries (industry) VALUES ("IT");

-- -- type_sub_industries
-- INSERT INTO type_sub_industries (type_industry_id, sub_industry)
-- VALUES 
--     ((SELECT id FROM type_industries WHERE industry = "IT"), "플랫폼"),
--     ((SELECT id FROM type_industries WHERE industry = "IT"), "SI/SM"),
--     ((SELECT id FROM type_industries WHERE industry = "IT"), "이커머스"),
--     ((SELECT id FROM type_industries WHERE industry = "IT"), "게임"),
--     ((SELECT id FROM type_industries WHERE industry = "IT"), "네트워크");

-- -- types
-- INSERT INTO businesstypes (businesstype) VALUES ("대기업"), ("중견기업"), ("소기업"), ("공공기관");

-- -- companies
-- INSERT INTO companies (type_sub_industry_id, businesstype_id, name, image_thumbnail, net_sales)
-- VALUES
--     (
--         (SELECT id FROM type_sub_industries WHERE sub_industry = "플랫폼"),
--         (SELECT id FROM businesstypes WHERE businesstype = "대기업"),
--         "네이버", "image_thumbnail.jpg", 1000
--     ),
--     (
--         (SELECT id FROM type_sub_industries WHERE sub_industry = "플랫폼"),
--         (SELECT id FROM businesstypes WHERE businesstype = "중견기업"),
--         "카카오", "image_thumbnail.jpg", 1000
--     ),
--     (
--         (SELECT id FROM type_sub_industries WHERE sub_industry = "이커머스"),
--         (SELECT id FROM businesstypes WHERE businesstype = "소기업"),
--         "쿠팡", "image_thumbnail.jpg", 1000
--     ),
--     (
--         (SELECT id FROM type_sub_industries WHERE sub_industry = "이커머스"),
--         (SELECT id FROM businesstypes WHERE businesstype = "공공기관"),
--         "넥슨", "image_thumbnail.jpg", 1000
--     );

-- -- term_careers
-- INSERT INTO term_careers (career) VALUES ("신입");
-- INSERT INTO term_careers (career) VALUES ("경력");
-- INSERT INTO term_careers (career) VALUES ("학력무관");

-- -- term_educations
-- INSERT INTO term_educations (education) VALUES ("고졸");
-- INSERT INTO term_educations (education) VALUES ("대졸");
-- INSERT INTO term_educations (education) VALUES ("석/박사");
-- INSERT INTO term_educations (education) VALUES ("학력무관");

-- -- term_jobpatterns
-- INSERT INTO term_jobpatterns (jobpattern) VALUES ("정규직");
-- INSERT INTO term_jobpatterns (jobpattern) VALUES ("인턴");
-- INSERT INTO term_jobpatterns (jobpattern) VALUES ("계약직");

-- -- term_jobtypes
-- INSERT INTO term_jobtypes (jobtype) VALUES ("개발");
-- INSERT INTO term_jobtypes (jobtype) VALUES ("기획");
-- INSERT INTO term_jobtypes (jobtype) VALUES ("마케팅");

-- -- term_regions
-- INSERT INTO term_regions (region) VALUES ("서울");
-- INSERT INTO term_regions (region) VALUES ("부산");
-- INSERT INTO term_regions (region) VALUES ("대전");

-- -- application_methods
-- INSERT INTO application_methods (method) VALUES ("홈페이지 지원");
-- INSERT INTO application_methods (method) VALUES ("이메일 지원");
-- INSERT INTO application_methods (method) VALUES ("우편 지원");

-- -- application_forms
-- INSERT INTO application_forms (form) VALUES ("상세 요강 참조");

-- -- jobs
-- INSERT INTO jobs
--     (
--         title,
--         content,
--         application_method_id,
--         application_form_id,
--         application_url
--     )
-- VALUES
--     (
--         "네이버 공개 채용",
--         "네이버 공개 채용 본문",
--         (SELECT id FROM application_methods WHERE method = "홈페이지 지원"),
--         (SELECT id FROM application_forms WHERE form = "상세 요강 참조"),
--         "지원페이지 url.url"
--     ),
--     (
--         "카카오 공개 채용",
--         "카카오 공개 채용 본문",
--         (SELECT id FROM application_methods WHERE method = "홈페이지 지원"),
--         (SELECT id FROM application_forms WHERE form = "상세 요강 참조"),
--         "지원페이지 url.url"
--     ),
--     (
--         "쿠팡 공개 채용",
--         "쿠팡 공개 채용 본문",
--         (SELECT id FROM application_methods WHERE method = "홈페이지 지원"),
--         (SELECT id FROM application_forms WHERE form = "상세 요강 참조"),
--         "지원페이지 url.url"
--     );

-- -- jobs__term_careers
-- INSERT INTO jobs__term_careers
--     (
--         term_career_id,
--         job_id
--     )
-- VALUES
--     (
--         (SELECT id FROM term_careers WHERE career = "신입"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     ),
--     (
--         (SELECT id FROM term_careers WHERE career = "경력"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     );

-- -- jobs__term_educations
-- INSERT INTO jobs__term_educations
--     (
--         term_education_id,
--         job_id
--     )
-- VALUES
--     (
--         (SELECT id FROM term_educations WHERE education = "대졸"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     ),
--     (
--         (SELECT id FROM term_educations WHERE education = "석/박사"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     );

-- -- jobs__term_jobpatterns
-- INSERT INTO jobs__term_jobpatterns
--     (
--         term_jobpattern_id,
--         job_id
--     )
-- VALUES
--     (
--         (SELECT id FROM term_jobpatterns WHERE jobpattern = "정규직"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     ),
--     (
--         (SELECT id FROM term_jobpatterns WHERE jobpattern = "인턴"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     ),
--     (
--         (SELECT id FROM term_jobpatterns WHERE jobpattern = "계약직"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     );

-- -- jobs__term_jobtypes
-- INSERT INTO jobs__term_jobtypes
--     (
--         term_jobtype_id,
--         job_id
--     )
-- VALUES
--     (
--         (SELECT id FROM term_jobtypes WHERE jobtype = "개발"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     ),
--     (
--         (SELECT id FROM term_jobtypes WHERE jobtype = "기획"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     ),
--     (
--         (SELECT id FROM term_jobtypes WHERE jobtype = "마케팅"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     );

-- -- jobs__term_regions
-- INSERT INTO jobs__term_regions
--     (
--         term_region_id,
--         job_id
--     )
-- VALUES
--     (
--         (SELECT id FROM term_regions WHERE region = "서울"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     ),
--     (
--         (SELECT id FROM term_regions WHERE region = "부산"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     ),
--     (
--         (SELECT id FROM term_regions WHERE region = "대전"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")

--     );

-- -- application_files
-- INSERT INTO application_files (job_id, formfile)
-- VALUES
--     ((SELECT id FROM jobs WHERE title = "네이버 공개 채용"), "첨부파일1.pdf"),
--     ((SELECT id FROM jobs WHERE title = "네이버 공개 채용"), "첨부파일2.pdf");

-- -- application_questions
-- INSERT INTO application_questions (job_id, question)
-- VALUES
--     ((SELECT id FROM jobs WHERE title = "네이버 공개 채용"), "성취를 이야기해주세요"),
--     ((SELECT id FROM jobs WHERE title = "네이버 공개 채용"), "고난과 역경을 이야기해주세요"),
--     ((SELECT id FROM jobs WHERE title = "네이버 공개 채용"), "미래 계획을 이야기해주세요");

-- -- jobs__compaines
-- INSERT INTO jobs__companies
--     (
--         company_id,
--         job_id
--     )
-- VALUES
--     (
--         (SELECT id FROM companies WHERE name = "카카오"),
--         (SELECT id FROM jobs WHERE title = "카카오 공개 채용")

--     ),
--     (
--         (SELECT id FROM companies WHERE name = "쿠팡"),
--         (SELECT id FROM jobs WHERE title = "쿠팡 공개 채용")

--     ),
--     (
--         (SELECT id FROM companies WHERE name = "네이버"),
--         (SELECT id FROM jobs WHERE title = "네이버 공개 채용")
--     );

ALTER TABLE companies MODIFY type_sub_industry_id INT;
ALTER TABLE companies MODIFY businesstype_id INT;