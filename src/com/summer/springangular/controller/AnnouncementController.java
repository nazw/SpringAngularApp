package com.summer.springangular.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.summer.springangular.model.Announcement;
import com.summer.springangular.service.AnnouncementService;
import com.summer.springangular.util.ApplicationConstants;

/**
 * AnnouncementController uses to map the Http requests and redirect to the appropriate method.
 * uses json data type to transfer data.
 * uses to Autowire AnnouncementService to call service method.
 *
 */

@Controller 
public class AnnouncementController {

	@Autowired
	private AnnouncementService announcementService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView welcome() {		
		return new ModelAndView("index");
	}
	
	@RequestMapping(value = "/announcements", method = RequestMethod.GET, produces = {"application/xml", "application/json" }) 
	public @ResponseBody List<Announcement> getAnnouncementList(ModelMap model) {		
		List announcementsList = announcementService.listAnnouncement();	
        return announcementsList;  
    }  
    
	@RequestMapping(value = "/postAnnouncementFormData", method = RequestMethod.POST)  
	public @ResponseBody Announcement createAnnouncement(@RequestBody Announcement announcement) {
    	if(StringUtils.hasText(announcement.getId())) {
    		announcementService.updateAnnouncement(announcement);
    	} else {
    		announcementService.addAnnouncement(announcement);
    	}
        return announcement;  
    }
        
	@RequestMapping(value = "/deleteAnnouncement", method = RequestMethod.POST)  
	public String deleteAnnouncement(@RequestBody Announcement announcement) { 		
    	announcementService.deleteAnnouncement(announcement);  
        return ApplicationConstants.SUCCESS; 
    } 
    
	@RequestMapping(value = "/announcement", method = RequestMethod.POST)
	public @ResponseBody Announcement findAnnouncement(@RequestBody String announcementId) {		
		Announcement announcement=announcementService.findById(announcementId);		
		return announcement;
	}
}
