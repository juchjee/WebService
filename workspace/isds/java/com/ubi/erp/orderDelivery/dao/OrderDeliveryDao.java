package com.ubi.erp.orderDelivery.dao;

import java.util.List;

import com.ubi.erp.orderDelivery.domain.OrderDeliveryVO;

public interface OrderDeliveryDao {
	// 공사 발주확인 등록 웹/모바일
	public List<OrderDeliveryVO> selWorkOrderChkS(OrderDeliveryVO orderDeliveryVO);

	public void prcsWorkOrderChkS(OrderDeliveryVO orderDeliveryVO);

	public void delWorkOrderChkS(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selWorkOrderChkR(OrderDeliveryVO orderDeliveryVO);

	// 공사 납품등록
	public OrderDeliveryVO selWorkDeliverySeq(OrderDeliveryVO orderDeliveryVO);

	public String selWorkDeliverySubSeq(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selWorkDeliverySMst(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selWorkDeliverySSub(OrderDeliveryVO orderDeliveryVO);

	public void prcsWorkDeliverySCom(OrderDeliveryVO orderDeliveryVO);

	public void prcsWorkDeliverySEtc(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selWorkDeliveryR(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selWorkDeliveryRPrint(OrderDeliveryVO orderDeliveryVO);

	// 남품등록 RFID
	public List<OrderDeliveryVO> selRemiconRMst(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selRemiconRSub(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selRemiconRfidSqNo(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selRemiconSForm(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selRemiconSGrid(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selRemiconSumItemQn(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selRemiconSExists(OrderDeliveryVO orderDeliveryVO);

	public void prcsRemiconS(OrderDeliveryVO orderDeliveryVO);

	public void prcsRemiconSInputBc(OrderDeliveryVO orderDeliveryVO);

	public void prcsRemiconSScm(OrderDeliveryVO orderDeliveryVO);

	// 발주입고현황
	public List<OrderDeliveryVO> selInboundRPrint(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selInboundR(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selInvoiceDelNo(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selInvoiceDetailForm(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selInvoiceDetailGrid(OrderDeliveryVO orderDeliveryVO);

	// 발주대비 입고현황
	public List<OrderDeliveryVO> selDeliInboundR(OrderDeliveryVO orderDeliveryVO);

	public List<OrderDeliveryVO> selRemiconInboundR(OrderDeliveryVO orderDeliveryVO);

};
