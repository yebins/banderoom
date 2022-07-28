# banderoom

URL: http://jjezen.cafe24.com/banderoom
로그인시 커뮤니티 
## 프로젝트 개요

### 기획 의도
1. Banderoom
    > Band + room: 공간 대여와 팀원 모집, 소통이 필요한 음악인들을 위한 사이트<br>
2. 상세
    > **공간 예약**<br>
    > 밴드나 댄스팀처럼 연습 공간을 피룡로 하는 사람들과 그 공간을 제공해 주는 호스트를 위한 중개 사이트<br>
    > **팀원 모집**<br>
    > 함께 활동할 사람을 구하고 싶은 팀을 위한 팀원 모집 시스템<br>
    > **커뮤니티**<br>
    > 공연 홍보 게시판, 악기 중고 거래 게시판, 자유게시판 등 다양한 게시판을 제공하는 커뮤니티의 장<br>
3. 목적
    > **공간 예약관리 시스템**을 통해 사용자가 공간을 예약하고 호스트가 예약을 관리하는 것이 쉽고 편리하게 이루어짐<br>
    > **팀원 모집 시스템, 커뮤니티 기능** 등 편리한 서비스 이용으로 사이트 이용 인원 증가<br>
    > 지금까지 배웠던 모든 것을 활용해 팀으로 웹 서비스를 구현해보고자 함<br>
    > 다양한 API를 익히고 활용<br>

<br>

### 개발 기간
2022.04.11 ~ 2022.06.08

<br>

### 개발 인원
팀: 일조 (4명)

<br>

### 개발 환경
<img height="24px" src="https://img.shields.io/badge/JDK 1.8-007396?style=flat-square&logo=Java&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/Spring Framework-6DB33F?style=flat-square&logo=Spring&logoColor=white"/><br>
<img height="24px" src="https://img.shields.io/badge/Apache Tomcat v8.5-F8DC75?style=flat-square&logo=Apache Tomcat&logoColor=black"/> <img height="24px" src="https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=MySQL&logoColor=white"/>
<br><br>

### 개발 언어
<img height="24px" src="https://img.shields.io/badge/Java-007396?style=flat-square&logo=Java&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=HTML5&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=JavaScript&logoColor=black"/> <img height="24px" src="https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=CSS3&logoColor=white"/>
<br><br>

### 개발 도구
<img height="24px" src="https://img.shields.io/badge/Eclipse IDE-2C2255?style=flat-square&logo=Eclipse IDE&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/Visual Studio Code-007ACC?style=flat-square&logo=Visual Studio Code&logoColor=white"/> <img height="24px" src="https://img.shields.io/badge/Adobe Photoshop-31A8FF?style=flat-square&logo=Adobe Photoshop&logoColor=white"/>
<br><br>

### 활용 기술과 API
`AJAX`&nbsp;&nbsp;`jQuery`&nbsp;&nbsp;`Summernote`&nbsp;&nbsp;`Javamail`&nbsp;&nbsp;<br>
`myBatis`&nbsp;&nbsp;`kakao 로그인 / 지도 / 주소찾기`<br>
`Ncloud sms`&nbsp;&nbsp;`ImgScalr`&nbsp;&nbsp;`moment.js`<br>
`air datepicker`&nbsp;&nbsp;`channel.io`

## 프로젝트 구현

### 구현 기능 (본인이 구현한 기능에 ⭐표시)
- 회원가입 / 로그인 / 비밀번호 찾기
  - 공간 예약용 호스트 사용자와 일반 사용자 회원가입 별도 페이지와 DB로 관리
  - 회원 가입시 이메일 인증과 휴대폰 인증
  - 카카오 계정으로 회원가입 및 로그인
  - 프로필 사진 업로드 및 기본 사진으로 초기화 가능
  - 닉네임 / 비밀번호 등 중복 체크와 유효성 체크
  - 비밀번호 찾기는 이메일 인증을 통해 비밀번호 변경으로 구현

<br>

- 공간 예약 시스템 
  - 공간 등록
    - 호스트가 공간을 등록 신청하면 관리자가 승인 / 거부하도록 구현
    - 공간 등록 시 사진 업로드
  - 공간 예약
    - 공간 사용자는 등록된 공간 목록에서 선택해 자세한 내용을 확인하고 날짜 / 시간 선택 후 예약 가능
  - 공간 검색
    - 지역 / 분류 등 여러 가지 필터를 통해 쉽게 공간을 찾을 수 있도록 함
    - 현재 목록에 표시된 공간들을 지도에서 한 눈에 확인 가능
  - 공간 상세
    - 공간의 기본 정보와 사진, 지도 등 여러 정보를 쉽게 확인 가능
    - 상세 페이지에 Q&A와 후기 섹션을 포함
  - 예약 내역 관리
    - 사용자
      - 자신이 현재 예약중인 항목과 이전에 예약했던 내역들을 한 눈에 확인
    - 호스트
      - 자신의 공간 관리 페이지에서 공간 별 예약 내역을 확인 및 취소 가능
  - 포인트 제도
    - 결제 금액의 일부만큼 포인트가 적립되고, 적립한 포인트를 이후 결제시 사용 가능
    - 포인트 내역 페이지에서 증감 내역 확인
  - 정산 금액 확인
    - 호스트는 자신이 등록한 공간들의 월 별 정산 내역을 확인 가능

<br>

- 팀원 모집 시스템
  - 일반 회원들끼리 팀원을 모집하거나 모집 중인 팀에 지원할 수 있음
  - 팀원 모집
    - 모집 글 등록 시 장르 등 대분류와 파트 등 소분류를 선택하여 각각 인원을 모집하도록 구현
    - 선택한 분류 (댄스팀, 밴드 등) 에 따라 선택 가능한 장르가 달라지며, 선택한 장르에 따라 선택 가능한 파트가 달라짐. 직접 입력도 가능
  - 팀원으로 지원
    - 팀원 모집시 등록한 여러 조건을 각각 선택으로 검색하거나, 검색어를 통해 통합 검색도 가능
  - 지원 목록 확인
    - 자신이 모집 등록한 팀의 지원자 목록을 확인 가능
  - 내 글 목록
    - 자신이 작성한 모집글과 지원서를 모두 확인 가능

<br>

- 커뮤니티 기능 (⭐ 전체)
  - 게시판
    - 공지사항 / 자유게시판 / 공연 홍보 게시판 / 중고거래 등 다양한 게시판 제공
    - 각 게시판의 글 등록 / 수정 / 상세 페이지는 하나의 JSP에서 모두 처리하도록 구현
    - 글 작성은 summernote 에디터를 이용해 사진 등 업로드 가능
    - 댓글과 대댓글에 사진 업로드 가능
    - 자유게시판
      - 일반적인 목록으로 표시하며, 추천수 상위 글 3개를 상단 노출
    - 홍보 게시판
      - 게시판의 성격에 따라 사진이 포함된 카드형 목록으로 표시
      - 게시글에 등록한 첫 번째 사진이 썸네일로 등록되도록 함
    - 중고 거래 게시판
      - 기본적으로 홍보 게시판과 동일하나 거래 상태를 추가적으로 표시
  - 미니 프로필
    - 사이트 어디서나 닉네임을 눌러 미니 프로필 팝업
  - 1:1 쪽지 기능
    - 미니 프로필을 통해 회원 간 1:1 쪽지를 주고받을 수 있음
    - 쪽지함에서 메시지들을 통합 관리 가능
    - 읽지 않은 쪽지 강조 표시
  - 신고 기능
    - 미니 프로필을 통해 비매너 유저를 신고할 수 있음

<br>

- 관리자 기능
  - 1:1 문의
    - 1:1 문의용 채팅 버튼을 항상 배치하여 사용자들이 쉽게 관리자와 소통 가능하도록 함
  - 공간 관리
    - 관리자는 등록된 모든 공간을 조회하고 등록 승인 / 거부 등 관리가 가능
  - 신고 회원 관리
    - 비매너 신고를 받은 사용자들의 목록을 확인하고 글쓰기 권한을 차단하거나 멤버 추방 가능
  - 모든 회원 관리
    - 일반 회원 / 호스트 회원의 모든 목록 확인
    - 회원 별 상세 정보 페이지에서 정보 확인 및 차단 / 추방 가능

<br><br>

### ER Diagram

<img src="https://user-images.githubusercontent.com/46345154/174518295-493b60a5-e59c-4d14-b7a1-dade58f528c5.png">

<span style="color: orange">공간 예약 시스템</span>,
<span style="color: lightgreen">팀원 모집 시스템</span>,
<span style="color: violet">커뮤니티 기능</span>,
<span style="color: gray">기타 기능</span> 별로 색상 표시

<br><br>

### Usecase Diagram

<img src="https://user-images.githubusercontent.com/46345154/174519399-7a77be9e-3e94-4e10-b29c-413ea62abe7c.png" width="60%">
<img src="https://user-images.githubusercontent.com/46345154/174519566-6f9f2a0c-dfce-4403-8e17-30dd07045881.png" width="60%">
<img src="https://user-images.githubusercontent.com/46345154/174519665-9ba07ce4-9a13-4f88-ad24-89dc1bb4833f.png" width="60%">
<img src="https://user-images.githubusercontent.com/46345154/174519766-10581354-8eaf-4fc3-b145-21ded3e4a0d5.png" width="60%">

<br><br>

## 구현 기능 상세 (본인이 구현한 기능에 ⭐ 표시)

### 메인 페이지 / 로그인

<br>

![슬라이드33](https://user-images.githubusercontent.com/46345154/176345310-7343f0be-383c-4b84-8f7e-2a318d7c3194.PNG)
![슬라이드34](https://user-images.githubusercontent.com/46345154/176345313-5867d415-0849-475e-8f3d-a560af09f6ed.PNG)
![슬라이드35](https://user-images.githubusercontent.com/46345154/176345314-ff34a076-52cf-4c72-9acd-326aa10a3b03.PNG)
![슬라이드36](https://user-images.githubusercontent.com/46345154/176345317-4b24b4c5-d46a-412a-b743-d33bfde5e952.PNG)
![슬라이드37](https://user-images.githubusercontent.com/46345154/176345318-156e26ad-794e-48da-b4f2-0f61ad6ff4e1.PNG)
![슬라이드38](https://user-images.githubusercontent.com/46345154/176345320-6cd5e5c2-8e18-45ca-be45-173a2f08f9a1.PNG)
![슬라이드39](https://user-images.githubusercontent.com/46345154/176345322-ef2b46b7-5eed-4da6-a7a9-d71758e5f798.PNG)
![슬라이드40](https://user-images.githubusercontent.com/46345154/176344518-6e0f1c38-17ff-46b2-b532-fb7a137e5a73.PNG)
![슬라이드41](https://user-images.githubusercontent.com/46345154/176344520-5e330a9c-8334-4460-a77b-7c0180eee58f.PNG)
![슬라이드42](https://user-images.githubusercontent.com/46345154/176344522-5152147b-2272-4cdb-8ac1-d2f91e92ac16.PNG)
![슬라이드43](https://user-images.githubusercontent.com/46345154/176344523-33ab09c1-3111-4538-baef-fd1ebe4dab0c.PNG)
![슬라이드44](https://user-images.githubusercontent.com/46345154/176344524-d6ac1695-c1b1-453b-a0d6-af90035d4725.PNG)
![슬라이드45](https://user-images.githubusercontent.com/46345154/176344525-33d4b7f9-81bc-41ad-9118-51721f5c278e.PNG)
![슬라이드46](https://user-images.githubusercontent.com/46345154/176344526-60dd9858-0bab-4fb9-8590-90a75d9409ae.PNG)
![슬라이드47](https://user-images.githubusercontent.com/46345154/176344527-671e7094-4ea9-42dd-9264-5daf456aca1a.PNG)

<br><br>

### 공간 예약 시스템

<br>

![슬라이드49](https://user-images.githubusercontent.com/46345154/176344531-5d8b4d76-9ad5-48d5-850b-57ad7d23fd15.PNG)
![슬라이드50](https://user-images.githubusercontent.com/46345154/176344534-856ea1b5-5b5d-4565-ad9e-69294117b018.PNG)
![슬라이드51](https://user-images.githubusercontent.com/46345154/176344535-dbd7a5f5-30ed-4fce-8da7-c3ece473ff95.PNG)
![슬라이드52](https://user-images.githubusercontent.com/46345154/176344541-edc0b8f7-fc29-40a8-931c-7b24addea65a.PNG)
![슬라이드53](https://user-images.githubusercontent.com/46345154/176344543-7e83beb1-455a-4331-a3d7-3c12e3c74c00.PNG)
![슬라이드54](https://user-images.githubusercontent.com/46345154/176344544-b83fa998-5f15-4bf4-8c10-56b0320a77d2.PNG)
![슬라이드55](https://user-images.githubusercontent.com/46345154/176344545-793bea66-48b0-40de-bf81-6a7f56029cf5.PNG)
![슬라이드56](https://user-images.githubusercontent.com/46345154/176344548-3e75b0cf-d47f-4f4e-97ea-cc99943f09fc.PNG)
![슬라이드57](https://user-images.githubusercontent.com/46345154/176344549-155c8821-2c04-4116-a7f9-e955d3dd05ce.PNG)
![슬라이드58](https://user-images.githubusercontent.com/46345154/176344550-b50bc9c8-0778-429e-9a71-7850d9361d1b.PNG)
![슬라이드59](https://user-images.githubusercontent.com/46345154/176344551-6952b748-358f-41a7-b747-6c0a97ba6de7.PNG)
![슬라이드60](https://user-images.githubusercontent.com/46345154/176344553-4879b183-9410-4d5d-8fd1-b5479da8416b.PNG)
![슬라이드61](https://user-images.githubusercontent.com/46345154/176344555-7999266b-50dc-468f-9436-37a343da5e99.PNG)
![슬라이드62](https://user-images.githubusercontent.com/46345154/176344558-d1fd4be2-2a78-4314-94d6-e6a320f4fc7d.PNG)
![슬라이드63](https://user-images.githubusercontent.com/46345154/176344560-ac17f627-8026-4b00-9c27-5278eefa3907.PNG)
![슬라이드64](https://user-images.githubusercontent.com/46345154/176344561-e2019402-c0bd-435a-8489-29d6ed27f2c2.PNG)
![슬라이드65](https://user-images.githubusercontent.com/46345154/176344563-7344451b-dab4-44a4-8e80-b944a354824f.PNG)
![슬라이드66](https://user-images.githubusercontent.com/46345154/176344565-1f2cfea8-cbd6-4746-8cab-075eaaf5d5de.PNG)
![슬라이드67](https://user-images.githubusercontent.com/46345154/176344567-b0ba453f-348e-4a18-bbba-da692a2cb771.PNG)
![슬라이드68](https://user-images.githubusercontent.com/46345154/176344569-d7519bfc-5176-4d8e-81a8-3c6439d4dc21.PNG)
![슬라이드69](https://user-images.githubusercontent.com/46345154/176344571-0463adfa-793d-4189-a7c2-6d9e890d17c6.PNG)

<br><br>

### 커뮤니티 기능

<br>

![슬라이드71](https://user-images.githubusercontent.com/46345154/176344573-24c13a7f-6b73-4229-ae4f-a10d620d19ee.PNG)
![슬라이드72](https://user-images.githubusercontent.com/46345154/176344574-c245307e-55b1-46d7-8954-52d231a9f9c2.PNG)
![슬라이드73](https://user-images.githubusercontent.com/46345154/176344576-ef28a403-85d6-4b4b-bb5f-0c8402150858.PNG)
![슬라이드74](https://user-images.githubusercontent.com/46345154/176344577-f91f6ae2-4133-49ab-8658-c54549f5d7a9.PNG)
![슬라이드75](https://user-images.githubusercontent.com/46345154/176344578-4bc4a215-c4a4-418b-88b2-394da9569379.PNG)
![슬라이드76](https://user-images.githubusercontent.com/46345154/176344580-462e1a77-1c51-47a7-b2d8-90ec10defb2f.PNG)
![슬라이드77](https://user-images.githubusercontent.com/46345154/176344582-a26334e1-a41e-4c8d-b158-60eec7bce7dc.PNG)
![슬라이드78](https://user-images.githubusercontent.com/46345154/176344587-7e0ddca6-3a28-473d-bee4-fda45dc63411.PNG)
![슬라이드79](https://user-images.githubusercontent.com/46345154/176344589-b7e8ddf4-dcac-4205-bfad-6ad577cbf7f3.PNG)
![슬라이드80](https://user-images.githubusercontent.com/46345154/176344591-529cbe78-7ce8-4cda-8ca8-67c234f20980.PNG)
![슬라이드81](https://user-images.githubusercontent.com/46345154/176344592-a79704c4-7f4d-4c92-a1cd-d36a91639ef8.PNG)

<br><br>

### 팀원 모집 시스템

<br>

![슬라이드83](https://user-images.githubusercontent.com/46345154/176344594-aaa6e08c-ba93-43f3-8525-b61c41e64352.PNG)
![슬라이드84](https://user-images.githubusercontent.com/46345154/176344596-6a16f5c0-7542-4edb-8662-64a4ef9d10f5.PNG)
![슬라이드85](https://user-images.githubusercontent.com/46345154/176344597-3e3108d1-3c67-4269-8eb5-1784706e0ffc.PNG)
![슬라이드86](https://user-images.githubusercontent.com/46345154/176344601-308ef6d6-70f6-4b0e-9a93-1b7369bbce1b.PNG)
![슬라이드87](https://user-images.githubusercontent.com/46345154/176344602-de5ef05d-ca24-48c5-acc0-fcd1d84303d8.PNG)
![슬라이드88](https://user-images.githubusercontent.com/46345154/176344605-42e5c0c4-16af-474d-ab50-bcedf511e594.PNG)
![슬라이드89](https://user-images.githubusercontent.com/46345154/176344606-cd2be37b-e3cf-4949-9606-cfc2b6069fa7.PNG)
![슬라이드90](https://user-images.githubusercontent.com/46345154/176344607-cd441824-1e04-43d4-ae46-605196a83743.PNG)
![슬라이드91](https://user-images.githubusercontent.com/46345154/176344609-15daa478-b2a2-4eb7-b984-11cd9a533a5a.PNG)

<br><br>

### 회원 관리 및 관리자 기능

<br>

![슬라이드93](https://user-images.githubusercontent.com/46345154/176344614-e3a59381-7de6-401c-b75a-e6338fd8284f.PNG)
![슬라이드94](https://user-images.githubusercontent.com/46345154/176344616-2f60783c-d021-49ef-a258-d165f3930ccc.PNG)
![슬라이드95](https://user-images.githubusercontent.com/46345154/176344619-95a2960c-308e-4f94-afdd-d4d85b16c87c.PNG)
![슬라이드96](https://user-images.githubusercontent.com/46345154/176344621-957e66ff-198a-4697-92c1-fd02b4a1c0e6.PNG)
![슬라이드97](https://user-images.githubusercontent.com/46345154/176344624-eabeb18a-0f75-4b2c-92ce-26046751d695.PNG)
![슬라이드98](https://user-images.githubusercontent.com/46345154/176344625-af5e8fd7-6768-4f29-9cdd-a5d0114efa24.PNG)
![슬라이드99](https://user-images.githubusercontent.com/46345154/176344628-d9a6c6bf-a5b1-4f60-a022-55be668c3ebf.PNG)
