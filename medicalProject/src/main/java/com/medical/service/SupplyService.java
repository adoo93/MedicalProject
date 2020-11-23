package com.medical.service;

import java.util.List;

import com.medical.dto.MemberDto;
import com.medical.dto.SupplyDto;

public interface SupplyService {
	public List<SupplyDto> supplyAll();
	public MemberDto AddressAction(String id);
}
