from jobs.utils import SimpleSQLSerializer

class JobSQLSerializer(SimpleSQLSerializer):
    def __init__(self):
        super().__init__()
        
        self.schema_self = {
            "relation" : "self",
            "table" : "jobs",
            "pk" : None,
            "columns" : ("title", "content", "application_url"),
            # "columns_string" : ("title, content, application_url")
        }
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
            }
        ]
        self._table = self.schema_self.get("table")
            
    def select(self, pk=None):
        results = self.validated_select(pk=pk, schema=self.schema_self)    
        results = results[0]
        
        for schema in self.schema_joins:
            temp = self.validated_select(schema = schema)
            results[schema.get("join_table")] = temp
        
        self._validated_results = results
        
        return self._validated_results

    def insert(self, request_data=None):
        pk = self.validated_insert(data=request_data, schema=self.schema_self)
        
        for schema in self.schema_joins:
            table = schema.get("join_table")
            data = request_data.get(table)                
            self.validated_insert(pk=pk, data=data, schema=schema)
            
        self._validated_results = {"detail" : "Post Success"}
            
        return self._validated_results
    
    def update(self, pk=None, request_data=None):
        for schema in self.schema_joins:
            table = schema.get("join_table")
            data = request_data.get(table)                
            self.validated_update(pk=pk, data=data, schema=schema)    

        self._validated_results = {"detail" : "Put Success"}
            
        return self._validated_results
    
    def delete(self, pk=None):
        self.validated_delete(pk=pk)
        
        self._validated_results = {"detail" : "Delete Success"}
