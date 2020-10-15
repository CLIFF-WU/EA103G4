package com.signup.model;

import java.util.List;

public class SignupService {

	private SignupDAO_interface dao;

	public SignupService() {
		dao = new SignupDAO();
	}

	public SignupVO addSignup(String mem_id, String lc_id, String signup_pay, Integer pay_state,
			java.sql.Timestamp pay_time, String sign_seat) {

		SignupVO signupVO = new SignupVO();

		signupVO.setMem_id(mem_id);
		signupVO.setLc_id(lc_id);
		signupVO.setSignup_pay(signup_pay);
		signupVO.setPay_state(pay_state);
		signupVO.setPay_time(pay_time);
		signupVO.setSign_seat(sign_seat);
		dao.insert(signupVO);

		return signupVO;

	}

	public SignupVO updateSignup(String signup_id, String signup_pay, Integer pay_state, java.sql.Timestamp pay_time,
			String sign_seat) {

		SignupVO signupVO = new SignupVO();

		signupVO.setMem_id(signup_id);
		signupVO.setSignup_pay(signup_pay);
		signupVO.setPay_state(pay_state);
		signupVO.setPay_time(pay_time);
		signupVO.setSign_seat(sign_seat);
		dao.update(signupVO);

		return signupVO;

	}
	
	public void deleteSignup(String signup_id) {
		dao.delete(signup_id);
	}
	
	public SignupVO getOneSignup(String signup_id) {
		return dao.findByPrimaryKey(signup_id);
	}
	
	public List<SignupVO> getOneSignupLecture(String lc_id) {
		return dao.findByLecture(lc_id);
	}
	
	public List<SignupVO>getOneSignupMember(String mem_id) {
		return dao.findByMember(mem_id);
	}
	
	public List<SignupVO> getAll() {
		return dao.getAll();
	}

}
