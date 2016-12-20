package kr.co.wisenut.search.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;

import kr.co.wisenut.editor.service.EditorService;
import kr.co.wisenut.search.model.SearchForm;
import kr.co.wisenut.search.service.SearchService;
import kr.co.wisenut.util.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class SearchController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Autowired
	SearchService searchService;
	
	@Autowired
	EditorService editorService;
	
	@RequestMapping(value = "/search")
	public ModelAndView search(@ModelAttribute SearchForm form, ModelAndView mav){
		mav.setViewName("search/search");
		
		try {
			searchService.search(form);
			
			HashMap<String,String> categoryGroupby = new HashMap<String,String>();
			String strCategoryGroupby = "";
			if(form.isCategorySearch() && null != form.getCategoryGroupby() && !"".equals(form.getCategoryGroupby()) ){
				String[] arrCategoryGroupby = form.getCategoryGroupby().split("!");
				for(String cg : arrCategoryGroupby){
					categoryGroupby.put(cg.split(":")[0], cg.split(":")[1]);
				}
				strCategoryGroupby = form.getCategoryGroupby();
			}else{
				categoryGroupby = searchService.getCategoryGroupby();
				Iterator<String> iter = categoryGroupby.keySet().iterator();
				StringBuffer cateBf = new StringBuffer();
				while(iter.hasNext()){
					String cate = iter.next();
					cateBf.append(cate+":"+categoryGroupby.get(cate)+"!");
				}
				strCategoryGroupby = cateBf.toString().replaceAll("!$", "");
			}
			
			mav.addObject("maxRuntime", editorService.getMaxRuntime());
			mav.addObject("form", form);
			mav.addObject("resultList", searchService.getResultList());
			mav.addObject("categoryResult", categoryGroupby);
			mav.addObject("strCategoryGroupby", strCategoryGroupby);
			mav.addObject("totalCount", searchService.getTotalResultCount());
			mav.addObject("paging", searchService.getPageLinks(form.getPage(), searchService.getTotalResultCount(), 10, 10));
		} catch (Exception e) {
			logger.error(StringUtil.getStackTrace(e));
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/ark/event", method = RequestMethod.POST)
	public void getEventArk(@RequestParam String query, HttpServletResponse response) {
		
		try {
			response.getWriter().print(searchService.getArkHtmlResult(query, "event"));
		} catch (UnsupportedEncodingException e) {
			logger.error(StringUtil.getStackTrace(e));
		} catch (IOException e) {
			logger.error(StringUtil.getStackTrace(e));
		}

	}
	
	@RequestMapping(value = "/ark/person", method = RequestMethod.POST)
	public void getPersonArk(@RequestParam String query, HttpServletResponse response) {
		
		try {
			response.getWriter().print(searchService.getArkHtmlResult(query, "person"));
		} catch (UnsupportedEncodingException e) {
			logger.error(StringUtil.getStackTrace(e));
		} catch (IOException e) {
			logger.error(StringUtil.getStackTrace(e));
		}

	}
}

