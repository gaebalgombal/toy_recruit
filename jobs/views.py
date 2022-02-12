from rest_framework.views import APIView

from jobs.serializers import JobSQLSerializer 

# feat
class JobDetailView(APIView):
    permission_classes = [AllowAny]
    lookup_field       = 'pk'

    def get(self, request, pk):    
        sql_serializer = JobSQLSerializer()
                        
        if sql_serializer.validate(pk=pk):
            sql_serializer.select(pk=pk)
        
        response = sql_serializer.validated_results
        
        return response
    
    def post(self, request):
        sql_serializer = JobSQLSerializer()
        request_data = request.data
        
        if sql_serializer.validate():
            sql_serializer.insert(request_data=request_data)
        
        response = sql_serializer.validated_results
        
        return response
    
    def put(self, request, pk):        
        sql_serializer = JobSQLSerializer()
        request_data = request.data
        
        if sql_serializer.validate(pk=pk):
            sql_serializer.update(request_data=request_data, pk=pk)
        
        response = sql_serializer.validated_results
        
        return response
    
    def delete(self, request, pk):
        sql_serializer = JobSQLSerializer()
        
        if sql_serializer.validate(pk=pk):
            sql_serializer.delete(pk=pk)
        
        response = sql_serializer.validated_results
        
        return response

