from jobs.utils import SimpleSQLSerializer

class CompanySerializer(SimpleSQLSerializer):
    def __init__(self):
        super().__init__()

        self.schema_self = {
            "relation" : "self",
            "table" : "companies",
            "pk" : None,
            "columns" : ("name", "image_thumbnail", "net_sales"),
            "column_strings" : ("name, image_thumbnail, net_sales")

        }
        self._table = self.schema_self.get("table")
        self.schema_joins = [
            {
                "relation" : "fk_to_pk",
                "join_table" : "type_sub_industries",
                "column_in_self" : "type_sub_industry_id"   
            },
            {
                "relation" : "fk_to_pk",
                "join_table" : "businesstypes",
                "column_in_self" : "businesstype_id"   
            }
        ]