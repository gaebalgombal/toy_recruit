# [CATCH]

# 프로젝트 요약
- 채용서비스 **CATCH**의 채용공고,기업정보 상세 페이지를 cloning.
- **진행 기간**: 2021.02.10 ~ 02.12

# 개발 목표
## 객체의 책임과 역할을 잘 나누어, 유지보수가 쉽고 재사용이 가능하도록 했습니다.
1. 의존성 분리
- 비즈니스 로직, 요청을 받고 응답을 처리하는 로직, DB를 조작하는 책임을 분리하고, 각각의 작은 객체에 역할을 맡기고, 서로 협업하도록 했습니다.
- 기능을 추가,수정할 때 각각의 객체를 호출하여 사용하면 되기 때문에, 유연하고 빠르게 변화에 대응할 수 있습니다. 
2. 대량의 반복 작업을 캡슐화
- raw SQL로 작업할 경우, 수십 줄의 SQL문을 실행해야 한다. 만약 칼럼명이라도 변경된다면 일일이 찾아보며 수정을 해야하기 때문에 오류가 발생할 수 있습니다.
- 때문에 View 객체에서 DB 스키마를 선언만 하고 Serializer 객체를 호출하면, Serializer 객체가 SQL 작업하는 책임을 지도록 했습니다.
- 어떤 DB 스키마를 선언하던 Serializer가 ‘알아서' SQL작업을 하기 때문에 역시 유연하고 빠르게 변화에 대응할 수 있습니다.

- 객체간 협업 구조
![alt text](https://raw.githubusercontent.com/geekanne/catch_recruit/main/Readme_images/oop_relation.png)

- Serializer 객체 간 상속 구조
![alt text](https://raw.githubusercontent.com/geekanne/catch_recruit/main/Readme_images/oop_inheritance.png)


## 도메인 구조를 반영해 데이터 모델링을 했습니다.

![alt text](https://raw.githubusercontent.com/geekanne/catch_recruit/main/Readme_images/modeling.drawio.png)


# 적용 기술 및 구현 기능
## 기술 스택
- Python, Django, MariaDB
## 구현 기능
- 채용공고 상세 페이지: C.R.U.D (채용 공고, 근무 조건, 접수 방법 등 복수의 테이블 조인)
- 기업정보 상세 피이지: C.R.U.D (기업정보, 업종, 기업 형태 등 복수의 테이블 조인)

# Reference
1. 이 프로젝트는 [CATCH]https://www.catch.co.kr/ 를 참조하여 학습 목적으로 만들었습니다.
