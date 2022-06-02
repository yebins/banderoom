<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	footer {
		width: 100%;
		height: 300px;
		position: absolute;
		background-color: white;
		box-shadow: 0px -5px 10px rgba(0, 0, 0, 0.2);
	}
</style>
<footer>
<div style="flex-direction: row;display: flex;justify-content: center;background-color: #fafbfb;">
    <div class="h_row_center" style="width: 1000px; height: 300px; display: flex;">

        <div style="position:relative; min-width: 300px; padding-top: 40px; height: 100%">
            <p style="font-size: 12px;font-weight: bold;font-stretch: normal;font-style: normal;line-height: 1.17;letter-spacing: normal;color: #454b50;">
                사업자정보확인
            </p>
            <p style="margin-top: 12px; font-size: 12px;font-weight: bold;font-stretch: normal;font-style: normal;line-height: 1.17;letter-spacing: normal;color: #454b50;cursor: pointer;" onclick="location.href='<%=request.getContextPath() %>/serinfo.do?idx=3'">
                운영정잭
            </p>
            <p style="margin-top: 12px; font-size: 12px;font-weight: bold;font-stretch: normal;font-style: normal;line-height: 1.17;letter-spacing: normal;color: #454b50;cursor: pointer;" onclick="location.href='<%=request.getContextPath() %>/serinfo.do?idx=2'">
                개인정보처리방침
            </p>
            <p style="margin-top: 12px; font-size: 12px;font-weight: bold;font-stretch: normal;font-style: normal;line-height: 1.17;letter-spacing: normal;color: #454b50;cursor: pointer;" onclick="location.href='<%=request.getContextPath() %>/serinfo.do?idx=1'">
                이용약관
            </p>
            <p style="margin-top: 12px; font-size: 12px;font-weight: bold;font-stretch: normal;font-style: normal;line-height: 1.17;letter-spacing: normal;color: #454b50;cursor: pointer;" onclick="location.href='<%=request.getContextPath() %>/serlist.do?bIdx=5&page=1'">
                자주묻는질문
            </p>
            <div style="position:absolute; bottom: 50px;">
                <p style="font-size: 15px;font-weight: normal;font-stretch: normal;font-style: normal;line-height: 1.47;letter-spacing: -0.1px;color: #454b50;">ezen@teamproject.com</p>
            </div>
        </div>

        <div style="position:relative; width: 860px;padding-top: 40px; height: 100%">

            <p style="font-size: 15px;font-weight: 500;font-stretch: normal;font-style: normal;line-height: 1.33;letter-spacing: -0.1px;color: #9ea4aa;">
                (주)이젠팀프로젝트 사업자 정보
            </p>
            <p style="margin-top: 16px;font-size: 12px;font-weight: normal;font-stretch: normal;font-style: normal;line-height: 1.67;letter-spacing: normal;color: #9ea4aa;">
                대표 김대환<br>
                전라북도 전주시 덕진구 백제대로 572 5층<br>
                사업자 등록번호 123-45-54321<br>
                통신판매업신고번호 2022-프로젝트-02020<br>
                (주)이젠팀프로젝트는 통신판매중개자로서, 통신판매의 당사자가 아니라는 사실을 고지하며 상품의 예약, 이용 및 환불 등과 관련한 의무와 책임은 각 판매자에게 있습니다.
            </p>

            <p style="position:absolute; bottom: 50px;font-size: 11px;font-weight: 500;font-stretch: normal;font-style: normal;line-height: 1.36;letter-spacing: normal;color: #9ea4aa;">
                © ezenteamproject Inc.
            </p>

        </div>
    </div>
</div>
</footer>