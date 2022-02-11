from abc import ABCMeta, abstractmethod

from django.db import IntegrityError, OperationalError, connection

from rest_framework.response import Response

class BaseSQLSerializer(metaclass=ABCMeta):
    def __init__(self):
        self._cursor = connection.cursor()
        self._error = False
        self._error_message = None
        self._validated_results = None
        self._table = None

    def validate(self, pk=None):
        query = "SELECT * FROM information_schema.tables WHERE table_name = \"{table}\"".format(table=self._table)
        self._cursor.execute(query)
        table_schema = self._cursor.fetchall()
        
        if len(table_schema) == 0:
            self._error = True
            self._error_message = {"detail" : "Table not found"}
                        
            return False
        
        if pk:
            query = "SELECT DISTINCT * FROM {table} WHERE id = {pk}".format(table=self._table, pk=pk)
            self._cursor.execute(query)
            rows = self._cursor.fetchall()
            
            if len(rows) == 0:
                self._error = True
                self._error_message = {"detail" : "Row not found"}
                            
                return False
            
        return True

    @property
    def validated_results(self):
        if self._error:
            self._validated_results = Response(self._error_message, status=400)
        else:
            self._validated_results = Response(self._validated_results, status=200)
        
        return self._validated_results

    @abstractmethod
    def select_rows(self):
        """Method that should do something"""
    
    @abstractmethod        
    def select_column_names(self):
        """Method that should do something"""

    @abstractmethod
    def serialize_to_json(self, rows, columns):
        """Method that should do something"""

    @abstractmethod
    def validated_select(self):
        """Method that should do something"""

    @abstractmethod
    def select(self):
        """Method that should do something"""

    @abstractmethod
    def insert_rows(self):
        """Method that should do something"""

    @abstractmethod
    def validated_insert(self):
        """Method that should do something"""

    @abstractmethod
    def insert(self):
        """Method that should do something"""

    @abstractmethod
    def update_rows(self):
        """Method that should do something"""

    @abstractmethod
    def validated_update(self):
        """Method that should do something"""

    @abstractmethod
    def update(self):
        """Method that should do something"""

    @abstractmethod
    def validated_delete(self):
        """Method that should do something"""

    @abstractmethod
    def delete(self):
        """Method that should do something"""

class SimpleSQLSerializer(BaseSQLSerializer):         
    def select_rows(self, pk=None, schema=None):
        relation = schema.get("relation", None)

        query = "SELECT DISTINCT * FROM {table} WHERE id = {pk}".format(table=self._table, pk=pk)

        if relation == "pk_to_fk":
            query = """SELECT DISTINCT {join_table}.* FROM {table}
            INNER JOIN {join_table}
            ON {self_table}.id = {join_table}.{column_in_join}
            """.format(
                table = self._table,
                pk = pk,
                join_table = schema.get("join_table"),
                self_table = self._table,
                column_in_join = schema.get("column_in_join")
            )

        if relation == "fk_to_pk":
            query = """SELECT DISTINCT {join_table}.* FROM {table}
            INNER JOIN {join_table}
            ON {self_table}.{column_in_self} = {join_table}.id;
            """.format(
                table = self._table,
                pk = pk,
                join_table = schema.get("join_table"),
                self_table = self._table,
                column_in_self = schema.get("column_in_self")
            )

        if relation == "fk_to_fk":
            query = """SELECT DISTINCT {join_table}.* FROM {table}
            INNER JOIN {middle_table} ON {self_table}.id = {middle_table}.{self_column_in_middle}
            INNER JOIN {join_table} ON {join_table}.id = {middle_table}.{join_column_in_middle};
            """.format(
                table = self._table,
                pk = pk,
                middle_table = schema.get("middle_table"),
                self_table = self._table,
                join_table = schema.get("join_table"),
                self_column_in_middle = schema.get("self_column_in_middle"),
                join_column_in_middle = schema.get("join_column_in_middle")
            )
                    
        self._cursor.execute(query)
        rows = self._cursor.fetchall()
            
        return rows
    
    def select_column_names(self, schema=None):
        relation = schema.get("relation", None)
        
        table = self._table
        
        if relation == "pk_to_fk":
            table = schema.get("join_table")
        if relation == "fk_to_pk":
            table = schema.get("join_table")
        if relation == "fk_to_fk":
            table = schema.get("join_table")

        query = "SELECT column_name FROM information_schema.columns WHERE table_name=\"{table}\";".format(table=table)        
        self._cursor.execute(query)
        column_names = self._cursor.fetchall()
                
        return column_names
    
    def serialize_to_json(self, rows=None, column_names=None):
        results = []
        
        for row in rows:
            result = {}
            
            for column_name, value in zip(column_names, row):
                result[column_name[0]] = value
            
            results.append(result)
        
        return results
    
    def validated_select(self, pk=None, schema=None):
        rows = self.select_rows(pk=pk, schema=schema)        
        column_names = self.select_column_names(schema=schema)
        results = self.serialize_to_json(rows=rows, column_names=column_names)

        return results
    
    def insert_rows(self, pk=None, data=None, schema=None):
        relation = schema.get("relation", None)

        # self
        if relation == "self":                
            column_values = tuple([data.get(column) for column in schema.get("columns")])            
            query = """INSERT INTO {self_table} (title, content, application_url)
            VALUES {column_values}""".format(
                self_table = self._table,
                columns = schema.get("columns"),
                column_values = column_values
            )
                                
        if relation == "pk_to_fk":
            for d in data:
                column = schema.get("column")
                query = """INSERT INTO {join_table} ({column_in_join}, {column})
                VALUES ({pk}, \"{column_value}\")""".format(
                    join_table = schema.get("join_table"),
                    column_in_join = schema.get("column_in_join"),
                    column = schema.get("column"),
                    pk = pk,
                    column_value = d.get(column)
                )    
    
        if relation == "fk_to_fk":
            for d in data:
                query = """INSERT INTO {middle_table} ({self_column_in_middle}, {join_column_in_middle})
                VALUES ({pk}, {join_column_value})""".format(
                    middle_table = schema.get("middle_table"),
                    self_column_in_middle = schema.get("self_column_in_middle"),
                    join_column_in_middle = schema.get("join_column_in_middle"),
                    pk = pk,
                    join_column_value = d.get("id")
                )
            
        if relation == "fk_to_pk":
            for d in data:
                query = "UPDATE {self_table} SET {column_in_self} = {column_value}".format(
                    self_table = self._table,
                    column_in_self = schema.get("column_in_self"),
                    column_value = d.get("id")
                )

        self._cursor.execute(query)

        if relation == "self":                
            query_pk = "SELECT LAST_INSERT_ID();"
            object_pk = self._cursor.execute(query_pk)
            
            return object_pk
        
        return True

    def validated_insert(self, pk=None, data=None, schema=None):
        try:            
            self.insert_rows(pk=pk, data=data, schema=schema)

        except IntegrityError:
            self._error = True
            self._error_message = {"detail" : "IntegrityError"}

        except OperationalError:
            self._error = True
            self._error_message = {"detail" : "DB OperationalError"}

        return True

    def update_rows(self, pk=None, data=None, schema=None):
        relation = schema.get("relation")
        
        if relation == "self":
            for column in schema.get("columns"):
                query = """UPDATE {self_table}
                SET {column} = {value} WHERE id = {pk}""".format(
                    column = column,
                    value = data.get(column),
                    pk = pk
                )
                    
                self._cursor.execute(query)
        
        if relation == "pk_to_fk":
            column_in_join = schema.get("column")
            for d in data:
                query = "DELETE FROM {join_table} WHERE id = {pk}".format(
                    join_table = schema.get("join_table"),
                    pk = pk
                )

                self._cursor.execute(query)

                query = """UPDATE {join_table}
                SET {column_in_join} = \"{value}\" WHERE id = {pk}""".format(
                    join_table = schema.get("join_table"),
                    column_in_join = column_in_join,
                    value = d.get(column_in_join),
                    pk = pk
                )

                self._cursor.execute(query)

        if relation == "fk_to_pk":
            for d in data:
                query = """UPDATE {self_table}
                SET {column_in_self} = {value} WHERE id = {pk}""".format(
                    self_table = self._table,
                    column_in_self = schema.get("column_in_self"),
                    value = d.get("id"),
                    pk = pk
                )

                self._cursor.execute(query)

        if relation == "fk_to_fk":
            join_column_in_middle = schema.get("join_column_in_middle")
                        
            for d in data:
                query = "DELETE FROM {middle_table} WHERE {self_column_in_middle} = {pk}".format(
                    middle_table = schema.get("middle_table"),
                    self_column_in_middle = schema.get("self_column_in_middle"),
                    pk = pk
                )
                
                self._cursor.execute(query)
                
                query = """UPDATE {middle_table}
                SET {join_column_in_middle} = {value} WHERE {self_column_in_middle} = {pk}""".format(
                    middle_table = schema.get("middle_table"),
                    join_column_in_middle = join_column_in_middle,
                    value = d.get("id"),
                    self_column_in_middle = schema.get("self_column_in_middle"),
                    pk = pk
                )

                self._cursor.execute(query)
            
        return True

    def validated_update(self, pk=None, data=None, schema=None):
        try:
            self.update_rows(pk=pk, data=data, schema=schema)
        
        except IntegrityError:
            self._error = True
            self._error_message = {"detail" : "IntegrityError"}

        except OperationalError:
            self._error = True
            self._error_message = {"detail" : "DB OperationalError"}
        
        return True
    
    def validated_delete(self, pk=None):
        
        print("pk", pk)
        
        query = "DELETE FROM {self_table} WHERE id = {pk}".format(
            self_table = self._table,
            pk = pk
        )
        self._cursor.execute(query)
        
        return True