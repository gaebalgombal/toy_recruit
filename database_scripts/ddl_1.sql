-- 테이블 생성
use catch;

-- companies/
-- type_industry
CREATE TABLE type_industries(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    industry VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- type_sub_industry
CREATE TABLE type_sub_industries(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    type_industry_id INT NOT NULL,
    CONSTRAINT fk_type_industries__type_sub_industries FOREIGN KEY (id) REFERENCES type_industries(id) ON DELETE CASCADE,
    sub_industry VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- companies
CREATE TABLE companies(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    type_sub_industry_id INT NOT NULL,
    CONSTRAINT fk_sub_type_industries__companies FOREIGN KEY (id) REFERENCES type_sub_industries(id) ON DELETE CASCADE,
    name VARCHAR(50) NOT NULL,
    image_thumbnail VARCHAR(300) NOT NULL,
    net_sales INT NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs/
-- term_careers
CREATE TABLE term_careers(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    career VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- term_educations
CREATE TABLE term_educations(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    education VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- term_jobpatterns
CREATE TABLE term_jobpatterns(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    jobpattern VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- term_jobtypes
CREATE TABLE term_jobtypes(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    jobtype VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- term_regions
CREATE TABLE term_regions(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    region VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- application_methods
CREATE TABLE application_methods(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    method VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- application_forms
CREATE TABLE application_forms(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    form VARCHAR(50) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs
CREATE TABLE jobs(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    title VARCHAR(50) NOT NULL,
    content VARCHAR(1000) NOT NULL,
    term_career_id INT NOT NULL,
    CONSTRAINT fk_term_careers__jobs FOREIGN KEY (id) REFERENCES term_careers(id) ON DELETE CASCADE,
    term_education_id INT NOT NULL,
    CONSTRAINT fk_term_educations__jobs FOREIGN KEY (id) REFERENCES term_educations(id) ON DELETE CASCADE,
    term_jobpattern_id INT NOT NULL,
    CONSTRAINT fk_term_jobpatterns__jobs FOREIGN KEY (id) REFERENCES term_jobpatterns(id) ON DELETE CASCADE,
    term_jobtype_id INT NOT NULL,
    CONSTRAINT fk_term_jobtypes__jobs FOREIGN KEY (id) REFERENCES term_jobtypes(id) ON DELETE CASCADE,
    term_salary INT NOT NULL DEFAULT 0,
    application_method_id INT NOT NULL,
    CONSTRAINT fk_application_methods__jobs FOREIGN KEY (id) REFERENCES application_methods(id) ON DELETE CASCADE,    
    application_form_id INT NOT NULL,
    CONSTRAINT fk_application_forms__jobs FOREIGN KEY (id) REFERENCES application_forms(id) ON DELETE CASCADE,    
    application_url VARCHAR(300) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- jobs__term_regions
CREATE TABLE jobs__term_regions(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    term_region_id INT NOT NULL,
    CONSTRAINT fk_term_regions__jobs__term_regions FOREIGN KEY (id) REFERENCES term_regions(id) ON DELETE CASCADE,
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__jobs__term_regions FOREIGN KEY (id) REFERENCES jobs(id) ON DELETE CASCADE,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- application_files
CREATE TABLE application_files(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__application_files FOREIGN KEY (id) REFERENCES jobs(id) ON DELETE CASCADE,
    formfile VARCHAR(300) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);

-- application_questions
CREATE TABLE application_questions(
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (id),
    job_id INT NOT NULL,
    CONSTRAINT fk_jobs__application_questions FOREIGN KEY (id) REFERENCES jobs(id) ON DELETE CASCADE,
    question VARCHAR(300) NOT NULL,
    create_at DATETIME NOT NULL,
    update_at DATETIME,
    delete_at DATETIME,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE   
);