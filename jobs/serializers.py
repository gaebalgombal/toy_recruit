from jobs.utils import SimpleSQLSerializer

class JobSerializer(SimpleSQLSerializer):
    def __init__(self):
        super().__init__()
        
        self.schema_self = {
            "relation" : "self",
            "table" : "jobs",
            "pk" : None,
            "columns" : ("title", "content", "application_url"),
            "column_strings" : ("title, content, application_url")
        }
        self._table = self.schema_self.get("table")
        self.schema_joins = [
            {
                "relation" : "fk_to_pk",
                "join_table" : "application_methods",
                "column_in_self" : "application_method_id"   
            },
            {
                "relation" : "fk_to_pk",
                "join_table" : "application_forms",
                "column_in_self" : "application_form_id"   
            },
            {
                "relation" : "pk_to_fk",
                "join_table" : "application_files",
                "column_in_join":"job_id",
                "column" : "formfile"
            },
            {
                "relation" : "pk_to_fk",
                "join_table" : "application_questions",
                "column_in_join":"job_id",
                "column" : "question"  
            },
            {
                "relation" : "fk_to_fk",
                "join_table": "term_careers",
                "middle_table": "jobs__term_careers",
                "self_column_in_middle" : "job_id",
                "join_column_in_middle" : "term_career_id"   
            },
            {
                "relation" : "fk_to_fk",
                "join_table": "term_educations",
                "middle_table": "jobs__term_educations",
                "self_column_in_middle" : "job_id",
                "join_column_in_middle" : "term_education_id"
            },
            {
                "relation" : "fk_to_fk",
                "join_table": "term_jobpatterns",
                "middle_table": "jobs__term_jobpatterns",
                "self_column_in_middle" : "job_id",
                "join_column_in_middle" : "term_jobpattern_id"   
            },
            {
                "relation" : "fk_to_fk",
                "join_table": "term_jobtypes",
                "middle_table": "jobs__term_jobtypes",
                "self_column_in_middle" : "job_id",
                "join_column_in_middle" : "term_jobtype_id"
            },
            {
                "relation" : "fk_to_fk",
                "join_table": "term_regions",
                "middle_table": "jobs__term_regions",
                "self_column_in_middle" : "job_id",
                "join_column_in_middle" : "term_region_id"
            },
            {
                "relation" : "fk_to_fk",
                "join_table": "companies",
                "middle_table": "jobs__companies",
                "self_column_in_middle" : "job_id",
                "join_column_in_middle" : "company_id"
            }
        ]