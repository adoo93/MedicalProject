package com.medical.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.medical.dto.GuestReserveDto;
import com.medical.dto.GuestReserveDto1;
import com.medical.dto.HospitalReserveDto;
import com.medical.service.ReserveService;

@Controller
@RequestMapping("/reserve")
public class ReserveController {
	@Autowired
	ReserveService reService;

	@RequestMapping(value = "/reserveList")
	public String reserveList(String yadmNm, Model model) {
		ArrayList<String> list = (ArrayList<String>) reService.getHospitalDate(yadmNm);
		String hospital_id = reService.getHospitalId(yadmNm);
		model.addAttribute("hospital_id", hospital_id);
		model.addAttribute("dateList", list);
		model.addAttribute("yadmNm", yadmNm);
		return "guest_reserve";
	}
	
	@RequestMapping(value = "/guestReserve")
	public String guestReserve(String guest_id, int hospital_reserve_id, String hospital_id, String date, String yadmNm, Model model) {
		GuestReserveDto dto = new GuestReserveDto();
		dto.setGuest_id(guest_id);
		dto.setReserve_id(hospital_reserve_id);
		reService.insertGuestInfo(dto);
		model.addAttribute("hospital_reserve_id", hospital_reserve_id);
		model.addAttribute("hospital_id", hospital_id);
		model.addAttribute("yadmNm", yadmNm);
		model.addAttribute("guest_id", guest_id);
		return "guest_reserve_commit";
	}
	
	@RequestMapping(value = "/admin")
	public String admin(String id, String name, Model model) {
		List<GuestReserveDto1> list = reService.getGuestReserveAction(id);	//예약현황 불러오는 sql컬럼이 섞여있어서 새로운 Dto1을 만들어서  사용
		model.addAttribute("dto", reService.getGuestReserveAction(id));
		//병원 측에서 예약 정보를 불러옴
		model.addAttribute("name", name);
		model.addAttribute("dto", list);
		model.addAttribute("id", id);
		return "admin";
	}
	
	@RequestMapping(value = "/InsertReserveInfo")
	public String InsertReserveInfo() {
		return "hospital_reserve";
	}
	
	@RequestMapping(value = "/ReserveInfo")
	public String reserve(HospitalReserveDto dto, Model model) {
		//병원 측에서 예약 정보를 입력
		reService.insertReserveInfo(dto);
		model.addAttribute("reserveDto", dto);
		return "hospital_reserve_commit";
	}
	@RequestMapping(value="/reserveCheck")
	public String check(String id,Model model,GuestReserveDto1 reserveDto) {
		List<GuestReserveDto1> list = reService.reserveCheking(id); 	//예약현황 불러오는 sql컬럼이 섞여있어서 새로운 Dto1을 만들어서  사용
		model.addAttribute("reserveDto", reService.reserveCheking(id));
		//환자 측에서 자신이 예약한 정보를 조회
		model.addAttribute("reserveDto", list);
		model.addAttribute("id",id);
		return "reserveCheck";
	}
	
	@RequestMapping(value="/delete")
	public String del1(String guest_reserve_id ,Model model) {
		model.addAttribute("id",guest_reserve_id);		
		return "reserveDelete";
	}


}
