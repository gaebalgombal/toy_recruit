-- 테이블 선택
USE catch;

-- character set 설정
SET character_set_client = utf8mb4;
SET character_set_connection = utf8mb4;
SET character_set_results = utf8mb4;
SET collation_database = utf8mb4_general_ci;
SET collation_server = utf8mb4_general_ci;

-- companies/
-- type_industry
CREATE TABLE type_industries(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    industry VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- type_sub_industry
CREATE TABLE type_sub_industries(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    type_industry_id INT NOT NULL,
    CONSTRAINT fk_type_industries__type_sub_industries FOREIGN KEY (type_industry_id) REFERENCES type_industries(id) ON DELETE CASCADE,
    sub_industry VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- companies
CREATE TABLE companies(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    type_sub_industry_id INT NOT NULL,
    CONSTRAINT fk_sub_type_industries__companies FOREIGN KEY (type_sub_industry_id) REFERENCES type_sub_industries(id) ON DELETE CASCADE,
    name VARCHAR(50) NOT NULL,
    image_thumbnail VARCHAR(300) NOT NULL,
    net_sales INT NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs/
-- term_careers
CREATE TABLE term_careers(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    career VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- term_educations
CREATE TABLE term_educations(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    education VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- term_jobpatterns
CREATE TABLE term_jobpatterns(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    jobpattern VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- term_jobtypes
CREATE TABLE term_jobtypes(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    jobtype VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- term_regions
CREATE TABLE term_regions(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    region VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- application_methods
CREATE TABLE application_methods(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    method VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- application_forms
CREATE TABLE application_forms(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    form VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs
CREATE TABLE jobs(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    title VARCHAR(50) NOT NULL,
    content VARCHAR(1000) NOT NULL,
    application_method_id INT,
    CONSTRAINT fk_application_methods__jobs FOREIGN KEY (application_method_id) REFERENCES application_methods(id) ON DELETE CASCADE,    
    application_form_id INT,
    CONSTRAINT fk_application_forms__jobs FOREIGN KEY (application_form_id) REFERENCES application_forms(id) ON DELETE CASCADE,    
    application_url VARCHAR(300) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs__term_careers
CREATE TABLE jobs__term_careers(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    term_career_id INT NOT NULL,
    CONSTRAINT fk_term_careers__jobs FOREIGN KEY (term_career_id) REFERENCES term_careers(id) ON DELETE CASCADE,
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__term_careers FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs__term_educations
CREATE TABLE jobs__term_educations(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    term_education_id INT NOT NULL,
    CONSTRAINT fk_term_educations__jobs FOREIGN KEY (term_education_id) REFERENCES term_educations(id) ON DELETE CASCADE,
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__term_educations FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs__term_jobpatterns
CREATE TABLE jobs__term_jobpatterns(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    term_jobpattern_id INT NOT NULL,
    CONSTRAINT fk_term_jobpatterns__jobs FOREIGN KEY (term_jobpattern_id) REFERENCES term_jobpatterns(id) ON DELETE CASCADE,
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__term_jobpatterns FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs__term_jobtypes
CREATE TABLE jobs__term_jobtypes(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    term_jobtype_id INT NOT NULL,
    CONSTRAINT fk_term_jobtypes__jobs FOREIGN KEY (term_jobtype_id) REFERENCES term_jobtypes(id) ON DELETE CASCADE,
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__term_jobtypes FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs__term_regions
CREATE TABLE jobs__term_regions(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    term_region_id INT NOT NULL,
    CONSTRAINT fk_term_region__jobs FOREIGN KEY (term_region_id) REFERENCES term_regions(id) ON DELETE CASCADE,
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__term_regions FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- application_files
CREATE TABLE application_files(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__application_files FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    formfile VARCHAR(300) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- application_questions
CREATE TABLE application_questions(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__application_questions FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    question VARCHAR(300) NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);