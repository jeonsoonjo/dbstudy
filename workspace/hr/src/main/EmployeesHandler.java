package main;

import java.util.List;
import java.util.Scanner;

import dao.EmployeesDao;
import dto.EmployeesDto;

public class EmployeesHandler {

	// field
	private EmployeesDao dao=EmployeesDao.getInstance();
	private Scanner sc=new Scanner(System.in);
	
	// method
	private void menu() {
		System.out.println("===== 사원관리 =====");
		System.out.println("0. 프로그램 종료");
		System.out.println("1. 부서 조회");
		System.out.println("=================");
	}
	
	// 실행
	public void execute() {
		while(true) {
			menu();
			System.out.println("선택(0~2) >>> ");
			switch(sc.nextInt()) {
			case 0 : System.out.println("프로그램을 종료합니다"); return;
			case 1 : inquiryByDepartmentId(); break;
			}
		}
	}
	
	// 사원 정보 검색
	public void inquiryByDepartmentId() {
		System.out.println("조회할 부서번호(10~110) 입력 >>> ");
		int departmentId=sc.nextInt();
		List<EmployeesDto> list=dao.selectEmpByDepartmentId(departmentId);
		System.out.println("총 사원 수 : "+list.size());
		for(EmployeesDto dto:list) {
			System.out.println(dto);
		}
	}
	
}
