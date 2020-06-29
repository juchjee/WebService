package site.mng.amM4.amM406.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.IConstants;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;

@Service("AmM406Service")
public class AmM406Service extends EgovAbstractServiceImpl implements IConstants{

	/** AmM406DAO */
	@Resource(name = "AmM406DAO")
	private AmM406DAO amM406DAO;
	
	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;
	
	public List<?> eBanner(Map<String, Object> params) throws Exception {
        return amM406DAO.eBanner(params);
    }
	
	public List<?> eBannerList(UnCamelMap<String, Object> paramMap) throws Exception {
		return amM406DAO.eBannerList(paramMap);
	}
	
	public CamelMap<String, Object> eBannerListMap(UnCamelMap<String, Object> paramMap) throws Exception {
		return amM406DAO.eBannerListMap(paramMap);
	}
	
	public String amM406S(UnCamelMap<String, Object> newParamMap, UnCamelMap<String, Object> bannerImgMap, UnCamelMap<String, Object> newBannerMobileImg, String savePath, String transInfo, String bannerCd) throws Exception {
		String attchCd = newParamMap.getString("ATTCH_CD");
		String attchMobileCd = newParamMap.getString("ATTCH_MOBILE_CD");
		if("".equals(bannerCd)){
			bannerCd = commService.getStrPrCode("EBL");
			newParamMap.put("bannerCd", bannerCd);
		}
		if(bannerImgMap != null && bannerImgMap.size() > 0){
			if(transInfo.equals(INSERT) || "".equals(attchCd)){
				attchCd = commService.getStrPrCode("ATT");
				newParamMap.put("attchCd", attchCd);
			}
			bannerImgMap.put("attchCd", attchCd);
			bannerImgMap.put("attchId", savePath);
			commService.tableSaveData("ASW_G_ATTCH", bannerImgMap, null, new String[]{"ATTCH_CD"} , null, null);
			commService.setGdataModHis("ASW_G_ATTCH", bannerCd, bannerImgMap, transInfo);
		}
		if(newBannerMobileImg != null && newBannerMobileImg.size() > 0){
			if(transInfo.equals(INSERT) || "".equals(attchMobileCd)){
				attchMobileCd = commService.getStrPrCode("ATT");
				newParamMap.put("ATTCH_MOBILE_CD", attchMobileCd);
			}
			newBannerMobileImg.put("ATTCH_CD", attchMobileCd);
			newBannerMobileImg.put("ATTCH_ID", savePath);
			commService.tableSaveData("ASW_G_ATTCH", newBannerMobileImg, null, new String[]{"ATTCH_CD"} , null, null);
			commService.setGdataModHis("ASW_G_ATTCH", bannerCd, newBannerMobileImg, transInfo);
		}
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("REG_ID", "$iui");
		matchingColumName.put("REG_DT", "$idate");
		commService.tableSaveData("ASW_BANNER_LIST", newParamMap, matchingColumName, new String[]{"BANNER_CD"} , null, null);
		commService.setGdataModHis("ASW_BANNER_LIST", bannerCd, newParamMap, transInfo);
		return bannerCd;
	}
}
