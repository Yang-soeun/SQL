# ⭐ SQL

<details>

<summary> ✏ 데이터 모델링의 이해 </summary>
<div markdown="1">

### 📑 모델링의 특징
- 현실세계를 일정한 형식에 맞추어 표현하는 추상화의 의미를 가질 수 있다.
- 복잡한 현실을 제한된 언어나 표기법을 통해 이해하기 쉽게하는 단순화의 의미를 가지고 있음
- 애매모호함을 배제하고 누구나 이해가 가능하도록 정확하게 현상을 기술하는 정확성의 의미를 가짐

### 📑 데이터 모델링을 하는 주요한 이유
- 업무정보를 구성하는 기초가 되는 정보들에 대해 일정한 표기법에 의해 표현함으로써 정보시스템 구축의 대상이 되는 업무 내용을 정확하게 분석하는것
- 분석된 모델을 가지고 실제 데이터 베이스를 생성하여 개발 및 데이터관리에 사용하기 위한 것.
- 데이터모델링 자체로서 업무의 흐름을 설명하고 분석하는 부분에 의미를 가지고 있다.

### 📑 데이터 모델링 유의점
#### 1️⃣ 중복(Duplication)
- 데이터 모델은 같은 데이터를 사용하는 사람, 시간 그리고 장소를 파악하는데 도움을 줌으로써 데이터베이스가 여러 장소에 같은 정보를 저장하는 잘못을 하지 않도록 한다.
#### 2️⃣ 비유연성(Inflexibility)
- 데이터 모델을 어떻게 설계했느냐에 따라 사소한 업무변화에도 데이터 모델이 수시로 변경됨으로써 유지보수의 어려움을 가중시킬 수 있다.
- 데이터의 정의를 데이터의 사용 프로세스와 분리함으로써 데이터 모델링은 데이터 혹은 프로세스의 작은 변화가 애플리케이션과 데이터베이스에 중대한 변화를 일으킬 수 있는 가능성을 줄인다.
#### 3️⃣ 비일관성(Inconsistency)
- 데이터의 중복이 없더라도 비일관성은 발생가능.
- 사용자가 처리하는 프로세스 혹은 이와 관련된 프로그램과 테이블의 연계성을 높이는 것은 데이터 모델이 업무변경에 대해 취약하게 만드는 단점에 해당된다.

### 개념-논리-물리데이터 모델
![image](https://user-images.githubusercontent.com/87464750/184346183-5b440bb1-a072-4e26-848f-45739acd34eb.png)

### 데이터독립성 구성요소
![image](https://user-images.githubusercontent.com/87464750/184346611-daee7396-3bca-4dca-b79a-87c97a926654.png)

### 📑 ERD
- 1976년 피터첸에 의해 Entity-Relationship Model이라는 표기법이 만들어졌다
- 관계의 명칭은 관계 표현에 있어서 매우 중요한 부분에 해당된다.
- 가장 중요한 엔터티를 왼쪽 상단에 배치하고, 이것을 중심으로 다른 엔터티를 나열하면서 전개하면 사람의 눈이 따라가기에 편리한 데이터 모델을 작성할 수 있다.

#### 작성순서
1. 엔터티를 그린다.
2. 엔터티를 적절하게 배치한다.
3. 엔터티간 관계를 설정한다.
4. 관계명을 기술한다.
5. 관계의 참여도를 기술한다.
6. 관계의 필수여부를 기술한다.

### 📑 엔터티
#### 특징
- 반드시 해당 업무에서 필요하고 관리하고자 하는 정보이어야 한다.
- 유일한 식별자에 의해 식별이 가능해야 한다.
- 영속적으로 존재하는 인스턴스의 집합이어야 한다.(한개가 아니라 두개 이상)
- 엔터티는 업무 프로세스에 의해 이용되어야 한다.
- 엔터티는 반드시 속성이 있어야 한다.
- 엔터티는 다른 엔터티와 최소 한개 이상의 관계가 있어야 한다.
- ❗ 통계성 엔터티 도출, 코드성 엔터티 도출, 시스템 처리시 내부 필요에 의한 엔터티 도출과 같은 경우는 관계를 생략할 수 있다.

#### 엔터티의 분류
- `유뮤형에 따른 분류`
    - `유형엔터티`
        - 물리적인 형태가 있고, 안정적이며 지속정으로 활용되는 엔터티로 업무로부터 구분하기가 용이하다.
        - > ex) 사원, 물품, 강사
    - `개념엔터티`
        - 물리적인 형태는 존재하지 않고, 관리해야 할 개념적 정보로 구분이 되는 엔터티
        - > ex) 조직, 보험상품
    - `사건엔터티`
        - 업무를 수행함에 따라 발생되는 엔터티로 비교적 발생량이 많으며 각종 통계자료에 이용될 수 있다.,
        - > ex) 주문, 청구, 미납
- `발생시점에 따른 분류`
    - `기본엔터티`
        - 업무에 원래 존재하는 정보로서 다른 엔터티와 관계에 의해 생성되지 않고 독립적으로 생성 가능
        - 자신은 타 엔터티의 부모의 역할을 하게 된다.
        - 다른 엔터티로부터 주식별자를 상속받지 않고 자신의 고유한 주식별자를 가지게 된다.
        - > ex) 사원, 부서, 고객, 상품, 자재
    - `중심엔터티`
        - 기본엔터티로부터 발생되고 그 업무에 있어서 중심적인 역할을 한다.
        - 데이터의 양이 많이 발생되고 다른 엔터티와의 관계를 통해 많은 해위엔터티를 생성한다.
        - > ex) 계약, 사고, 에금원장, 청구, 주문, 매출
    - `행위엔터티`
        - 두 개 이상의 부모엔터티로부터 발생되고 자주 내용이 바뀌거나 데이터량이 증가된다.
        - 분석초기 단계에서 잘 나타나지 않으며 상세 설계단계나 프로세스와 상관모델링을 진행하면서 도출될 수 있다.
        - > ex) 주문목록, 사원변경이력
    
#### 엔터티의 명명
- 가능하면 현업업무에서 사용하는 용어를 사용한다.
- 가능하면 약어를 사용하지 않는다.
- 단수명사를 사용한다.
- 모든 엔터티에서 유일하게 이름이 부여되어야 한다.
- 엔터티 생성의미대로 이름을 부여한다.

### 📑 속성
- 업무에서 필요로 하는 인스턴스에서 관리하고자 하는 의마상 더이상 분리되지 않는 최소의 데이터 단위.

#### 엔터티, 인스턴스, 속성, 속성값의 관계
- 엔터티에 대한 자세하고 구체적인 정보를 나타낸다
- 속성도 집합니다.
- 한개의 엔터티는 두 개 이상의 인스턴스의 집합이어야 한다.
- 한개의 속성은 한개의 속성값을 가진다.

#### 특성에 따른 분류
- `기본속성`
    - 업무로부터 추출한 모든 속성.
    - 엔터티에서 가장 일반적이고 많은 속성을 차지한다.
    - 코드성 데이터, 인테티를 식별하기 위한 부여된 일련번호, 그리고 다른 속성을 계삲거나 영향을 받아 생성된 속성을 제외한 모든 속성
    - ❗ 업무로부터 분석한 속성이라도 이미 업무상 코드로 정의한 속성이 많다. 이러한 경우도 속성의 값이 원래 속성을 나타내지 못하므로 기본속성이 되지 않느다.
- `설계속성`
    - 업무상 필요한 데이터 이외에 데이터 모델링을 위해, 업무를 규칙화하기 위해 속성을 새로 만들거나 변형하여 정의하는 속성.
    - 대개 코드성 속성은 원래 속성을 업무상 필요에 의해 변형하여 만든 설계속성이고 일련번호와 같은 속성은 단일한 식별자를 부여하기 위해 모델 상에서 새로 정의하는 설계속성이다.
- `파생속성`
    - 다른 속성에 영향을 받아 발생하는 속성으로 보통 계산된 값들이 이에 해당된다.
 
 #### 도메인
 - 각 속성이 가질 수 있는 값의 범위
 - 엔터티 내에서 속성에 대한 데이터타입과 크기 그리고 제약사항을 지정하는 것.
 
 #### 속성의 명명
 - 해당업무에서 사용하는 이름을 부여한다.
 - 서술식 속성명은 사용하지 않는다.
 - 약어사용은 가급적 제한한다.
 - 전체 데이터모델에서 유일성을 확보하는 것이 좋다.
 
 ### 📑 관계
 - 관계는 존재에 의한 관계와 행위에 의한 관계로 구분될 수 있으나 ERD 에서는 관계를 연결할 때, 존재와 행위룰 구분하지 않고 단일화된 표기법 사용
 - UML에는 클래스 다이어그램의 관계 중 연관관계와 의존관계가 있고 이것은 실선과 점선의 표기법으로 다르게 표현된다.
 
 #### 설명
 - 관계는 존재적 관계와 행위에 의한 관계로 나누어볼 수 있다.
 - 관계의 표기법은 관계명, 관계차수, 선택사양 3가지 개념을 사용한다.
 
 #### 관계의 표기법
 - 관계명
    - 관계의 이름
 - 관계차수
    - 1:1, 1:M, M:N
 - 관계선택사양
    - 필수관계, 선택관계
    
#### 두 개의 엔터티 사이에 정의한 관계를 체크하는 사항
- 두 개의 엔터티 사이에 관심 있는 연관규칙이 존재하는가?
- 두 개의 엔터티 사이에 정보의 조합이 발생되는가?
- 업무기술서, 장표 관계연결을 가능하게 하는 동사가 있는가?
- 업무기술서, 장표에 관계연결에 대한 규칙이 서술되어 있는가?

#### 관계 읽기
- 기준 엔터티를 한개 또는 각으로 읽는다.
- 대상 엔터티의 관계참여도 즉 개수(하나, 하나 이상)을 읽는다.
- 관계선택사양과 관계명을 읽는다.

### 📑 식별자
#### 주식별자 특징
![image](https://user-images.githubusercontent.com/87464750/184355369-e1c9e0de-4eb9-4204-a6ed-41538eff2204.png)

#### 식별자의 분류체계
![image](https://user-images.githubusercontent.com/87464750/184355443-b8db8119-38ad-4d23-9e3c-4185ea3b552c.png)

#### 식별자와 비식별자관계 비교
![image](https://user-images.githubusercontent.com/87464750/184356002-8344b558-2e5c-482d-9cef-305ed66e55eb.png)



 </div>
</details>

<details>

<summary> ✏ 데이터 모델과 성능 </summary>
<div markdown="1">
  
### 📑 성능 데이터 모델링

#### 성능 데이터모델링
- 데이터의 증가가 빠를수록 성능저하에 따른 성능개선비용은 증가한다.
- 데이터모델은 성능을 튜닝하면서 변경이 될 수 있는 특징이 있다.
    -  > 테이블 분할, 테이블 병합, 테이블 추가
- 분석/설계 단계에서 성능을 고려한 데이터모델링을 수행할 경우 성능 저하에 따른 Rework 비용을 최소화할 수 있는 기회를 가지게 된다.

#### 데이터 모델링의 순서
- 데이터 모델링을 할 떄 정규화를 정확하게 수행한다.
- 데이터베이스 용량산정을 수행한다.
- 데이터베이스에 발생되는 트랜잭션의 유형을 파악한다.
- 용량과 트랜잭션의 유형에 따라 반정규화를 수행한다.
- 이력모델의 조정, PK/FK조정, 슈퍼타입/서브타입 조정 등을 수행한다.
- 성능관점에서 데이터 모델을 검증한다.

#### 성능데이터 모델링 할때 고려사항
- 용량산정은 전체적인 데이터베이승 발생되는 트랜잭션의 유형과 양을 분석하는 자료가 되므로 성능데이터 모델링을 할 때 중요한 작업이 될 수 있다.
- 물리적인 데이터 모델링을 할 때 PK/FK의 칼럼 순서조정, FK인덱스 생성 등은 성능 향상을 위한 데이터 모델링 작업에 중요한 요소가 된다.
- 이력데이터는 시간에 따라 반복적으로 발생이 되기 때문에 대량 데이터일 가능성이 높아 특별히 성능을 고려하여 칼럼 등을 추가하도록 설계해야한다.

### 📑 정규화
#### 1차 정규화: 중복속성에 대한 분리
#### 2차 정규화: 기본키에 대한 부분집합으로 존재하는 속성들을 분리시키고자 하는것(함수의 종속성을 만족시키도록)

### 📑 반정규화
- 정규화된 엔터티, 속성, 관계에 대해 시스템의 성능향상과 개발과 운영의 단순화를 위해 중복, 통합, 분리 등을 수행하는 데이터 모델링의 기법
- 데이터 무결성이 깨질 수 있는 위험을 무릅쓰고 데이터를 중복하여 반정규화를 적용하는 이유
    - 데이터를 조회할 때 디스크  I/O 량이 많아서 성능이 저하되거나
    - 경로가 너무 멀어 조인으로 인한 성능저하가 예상되거나
    - 칼럼을 계산하여 읽을 때 성능이 저하될 것이 예상되는 경우
        
        
#### 테이블 반졍규화
![image](https://user-images.githubusercontent.com/87464750/185892498-36540384-2e99-4655-8ffd-01c23eafa5e3.png)

#### 칼럼의 반정규화
![image](https://user-images.githubusercontent.com/87464750/185892556-f92659e6-c0df-4c3f-9077-d9c4758e97c9.png)



#### 반정규화 절차
##### 1️⃣ 반정규화 대상조사
- 범위처리빈도수 조사
- 대량의 범위 처리 조사
- 통계성 프로세스 조사
- 테이블 조인 개수

##### 2️⃣ 다른 방법유도 검토
- 뷰(view) 테이블
    - 지나치게 많은 조인이 걸려 데이터를 조회하는 작업이 기술적으로 어려울 경우
- 클러스터링 적용
    - 대량의 데이터처리나 부분처리에 의해 성능이 저하되는 경우
- 인덱스의 조정
    - 대량의 데이터처리나 부분처리에 의해 성능이 저하되는 경우
- 파티셔닝
    - 대량의 데이터는 Primary key 성격에 따라 부분적인 테이블로 분리할 수 있다.
- 응용애플리케이션
    - 로직을 구사하는 방법을 변경함으로써 성능을 향상


##### 3️⃣ 반정규화 적용
- 테이블 반정규화
- 속성의 반정규화
- 관계의 반정규화

#### 📑 반정규화: 테이블 분할
##### 테이블에 대한 수평분할/수직분할의 절차
- 데이터 모델링을 완성한다.
- 데이터베이스 용량산정을 한다.
- 대량 데이터가 처리되는 테이블에 대해서 트랜잭션 처리 패턴을 분석한다.
- 칼럼 단위로 집중화된 처리가 발생하는지, 로우단위로 집중화된 처리가 발생되는지 분석하여 집중화된 단위로 테이블을 분리하는 것을 검토.

- `수직분할`
    - 칼럼단위, 1:1관계
- `수평분할`
    - 디스크 I/O 분산, 데이터 접근 효율성
        
##### 로우체이닝: 로우의 길이가 너무 길어서 데이터 블록 하나에 데이터가 모두 저장되지 않고 두 개 이상의 블록에 걸쳐 하나의 로우가 저장되어 있는 형태.
##### 로우마이그레이션: 데이터 블록에서 수정이 발생하면 수정된 데이터를 해당 데이터 블록에서 저장하지 못하고 다른 블록의 빈 공간을 찾아 저장하는 방식.

#### 📑 슈퍼타입/서브타입 모델의 성능고려 방법
- 개별로 발생되는 트랜잭션에 대해서는 개별 테이블로 구성
- 슈퍼타입+서브타입에 대해 발생되는 트랜잭션에 대해서는 슈퍼타입+서브타입 테이블로 구성
- 전체를 하나로 묶어 트랜잭션이 발생할때는 하나의 테이블로 구성

![image](https://user-images.githubusercontent.com/87464750/185896633-27291fcf-2efe-4d69-a19e-4f04d74b0994.png)

#### 📑 인덱스 특성을 고려한 PK/FK 데이터베이스 성능향상
- PK 순서를 결정하는 기준을 인덱스 정럴규조를 이해한 상태에서 인덱스를 효율적으로 이용할 수 있도록 PK 순서를 지정해야한다.
- 인덱스의 특징은 여러개의 속성이 하나의 인덱스로 구성되어 있을때 앞쪽에 위치한 속성의 값이 비교자로 있어야 인덱스가 좋은 효율을 나타낼 수 있다.
- 앞쪽에 위치한 속성 값이 가급적 '=' 아니면 'BETWEEN'가 들어와야 인덱스를 이용할 수 있는 것이다.

`UNION ALL`: 정렬작업 발생x
'UNION' : 정렬작업 발생o

### 📑 분산데이터베이스
#### 장점
- 지역 자치성, 점증적 시스템 용량 확장
- 신뢰성과 가용성
- 효용성과 융통성
- 빠른 응답 속도와 통신비용 절감
- 데이터의 가용성과 신뢰성 증가
- 시스템 규모의 적절한 조절
- 각 지역 사용자의 요구 수용 증대

#### 단점
- 소프트웨어 개발 비용
- 오류의 잠재성 증대
- 처리 비용의 증대
- 설계, 관리의 복잡성과 비용
- 불규칙한 응답속도
- 통제의 어려움
- 데이터 무결성에 대한 위협

### 효율성 증대
- 공통코드, 기준정보 등 마스터 데이터는 분산데이터베이스에 복제분산을 적용한다.
- 거의 실시간 업무적인 특성을 가지고 있을 때 분산 데이터베이스를 사용하여 구성할 수 있다.
- 백업 사이트를 구성할 때 간단하게 분산기능을 적용하여 구성할 수 있다.



 </div>
</details>

<details>

<summary> ✏ SQL 기본 </summary>
<div markdown="1">
  


 </div>
</details>

<details>

<summary> ✏ SQL 활용 </summary>
<div markdown="1">
  


 </div>
</details>

<details>

<summary> ✏ SQL 최적화 기본원리 </summary>
<div markdown="1">
  


 </div>
</details>
