from rest_framework.response              import Response
from rest_framework.decorators            import api_view, permission_classes
from rest_framework.permissions           import AllowAny, IsAdminUser, IsAuthenticated
from rest_framework.views import APIView

from jobs.serializers import JobSQLSerializer 

# # test
# @api_view(['GET', 'POST', 'PUT', 'PATCH', 'DELETE'])
# @permission_classes([AllowAny])
# def test(request):
#     return Response({}, status=200)


# feat
class JobDetailView(APIView):
    permission_classes = [AllowAny]
    lookup_field       = 'pk'

    def get(self, request, pk):    
        sql_serializer = JobSQLSerializer()
                        
        if sql_serializer.validate():
            sql_serializer.get(pk=pk)
        
        response = sql_serializer.validated_results
        
        return response
    
    def post(self, request):
        sql_serializer = JobSQLSerializer()
        request_data = request.data
        
        if sql_serializer.validate():
            sql_serializer.save(request_data=request_data)
        
        response = sql_serializer.validated_results
        
        return response
    
    def put(self, request):
        sql_serializer = JobSQLSerializer()
        request_data = request.data
        
        if sql_serializer.validate():
            sql_serializer.save(request_data=request_data)
        
        response = sql_serializer.validated_results
        
        return response
    
    def delete(self, request):
        sql_serializer = JobSQLSerializer()
        pk = request.data.get("pk")
        
        if sql_serializer.validate():
            sql_serializer.delete(pk=pk)
        
        response = sql_serializer.validated_results
        
        return response

