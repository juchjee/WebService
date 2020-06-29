package com.ubi.erp.orderDelivery.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubi.erp.orderDelivery.dao.OrderDeliveryDao;
import com.ubi.erp.orderDelivery.domain.OrderDeliveryVO;

@Service
public class OrderDeliveryService {

	private OrderDeliveryDao dao;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		dao = sqlSession.getMapper(OrderDeliveryDao.class);
	};

	// 공사 팝업 및 키타
	public OrderDeliveryVO selWorkDeliverySeq(OrderDeliveryVO orderDeliveryVO) {
		return dao.selWorkDeliverySeq(orderDeliveryVO);
	}

	// 공사 발주확인 등록 및 현황
	public List<OrderDeliveryVO> selWorkOrderChkS(OrderDeliveryVO orderDeliveryVO) {
		return dao.selWorkOrderChkS(orderDeliveryVO);
	};

	public void prcsWorkOrderChkS(List<OrderDeliveryVO> list, String id, String custCd) {
		for (OrderDeliveryVO orderDeliveryVO : list) {
			orderDeliveryVO.setId(id);
			orderDeliveryVO.setCustCd(custCd);
			if (orderDeliveryVO.getOutsCon().equals("1")) {
				dao.prcsWorkOrderChkS(orderDeliveryVO);
			} else {
				dao.delWorkOrderChkS(orderDeliveryVO);
			}

		}
	};

	public List<OrderDeliveryVO> selWorkOrderChkR(OrderDeliveryVO orderDeliveryVO) {
		return dao.selWorkOrderChkR(orderDeliveryVO);
	};

	// 공사 납품 등록
	public List<OrderDeliveryVO> selWorkDeliverySMst(OrderDeliveryVO orderDeliveryVO) {
		return dao.selWorkDeliverySMst(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selWorkDeliverySSub(OrderDeliveryVO orderDeliveryVO) {
		return dao.selWorkDeliverySSub(orderDeliveryVO);
	};

	public void prcsWorkDeliveryS(List<OrderDeliveryVO> list, String id) {
		for (OrderDeliveryVO orderDeliveryVO : list) {
			orderDeliveryVO.setId(id);
			if (orderDeliveryVO.getCudKey().equals("INSERT")) {
				String deliSubSeq = dao.selWorkDeliverySubSeq(orderDeliveryVO);
				orderDeliveryVO.setDeliSubSeq(deliSubSeq);
			}
			if (orderDeliveryVO.getEtcKind().equals("COM")) {
				dao.prcsWorkDeliverySCom(orderDeliveryVO);
			} else {
				dao.prcsWorkDeliverySEtc(orderDeliveryVO);
			}
		}
	};

	public List<OrderDeliveryVO> selWorkDeliveryR(OrderDeliveryVO orderDeliveryVO) {
		return dao.selWorkDeliveryR(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selWorkDeliveryRPrint(OrderDeliveryVO orderDeliveryVO) {
		return dao.selWorkDeliveryRPrint(orderDeliveryVO);
	};

	// 남품등록 RFID
	public List<OrderDeliveryVO> selRemiconRMst(OrderDeliveryVO orderDeliveryVO) {
		return dao.selRemiconRMst(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selRemiconRSub(OrderDeliveryVO orderDeliveryVO) {
		return dao.selRemiconRSub(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selRemiconRfidSqNo(OrderDeliveryVO orderDeliveryVO) {
		return dao.selRemiconRfidSqNo(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selRemiconSForm(OrderDeliveryVO orderDeliveryVO) {
		return dao.selRemiconSForm(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selRemiconSGrid(OrderDeliveryVO orderDeliveryVO) {
		return dao.selRemiconSGrid(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selRemiconSumItemQn(OrderDeliveryVO orderDeliveryVO) {
		return dao.selRemiconSumItemQn(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selRemiconSExists(OrderDeliveryVO orderDeliveryVO) {
		return dao.selRemiconSExists(orderDeliveryVO);
	};

	public void prcsRemiconS(List<OrderDeliveryVO> list, String id) {
		for (OrderDeliveryVO orderDeliveryVO : list) {
			orderDeliveryVO.setId(id);
			dao.prcsRemiconS(orderDeliveryVO);
			dao.prcsRemiconSInputBc(orderDeliveryVO);
		}
	};

	public void prcsRemiconSScm(List<OrderDeliveryVO> list, String id) {
		for (OrderDeliveryVO orderDeliveryVO : list) {
			orderDeliveryVO.setId(id);
			dao.prcsRemiconSScm(orderDeliveryVO);
		}
	};

	// 발주입고현황
	public List<OrderDeliveryVO> selInboundRPrint(OrderDeliveryVO orderDeliveryVO) {
		return dao.selInboundRPrint(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selInboundR(OrderDeliveryVO orderDeliveryVO) {
		return dao.selInboundR(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selInvoiceDelNo(OrderDeliveryVO orderDeliveryVO) {
		return dao.selInvoiceDelNo(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selInvoiceDetailForm(OrderDeliveryVO orderDeliveryVO) {
		return dao.selInvoiceDetailForm(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selInvoiceDetailGrid(OrderDeliveryVO orderDeliveryVO) {
		return dao.selInvoiceDetailGrid(orderDeliveryVO);
	};

	// 발주대비 입고현황
	public List<OrderDeliveryVO> selDeliInboundR(OrderDeliveryVO orderDeliveryVO) {
		return dao.selDeliInboundR(orderDeliveryVO);
	};

	public List<OrderDeliveryVO> selRemiconInboundR(OrderDeliveryVO orderDeliveryVO) {
		return dao.selRemiconInboundR(orderDeliveryVO);
	};
}
