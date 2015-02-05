package com.summer.springangular.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;
import java.util.Calendar;
import com.summer.springangular.model.Announcement;

import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

/**
 * AnnouncementService uses to connect to MongoTemplate bean.
 * add, update , delete operations are done by using MongoTemplate.
 *
 */

@Repository
public class AnnouncementService {
	
	@Autowired
	private MongoTemplate mongoTemplate;
	
	public static final String COLLECTION_NAME = "announcement";

	public void addAnnouncement(Announcement announcement) {
		if (!mongoTemplate.collectionExists(Announcement.class)) {
			mongoTemplate.createCollection(Announcement.class);
		}		
		announcement.setId(UUID.randomUUID().toString());
		Date date = new Date();
		announcement.setStartDate(date);
		announcement.setExpirydate(Calendar.getInstance().getTime());
		mongoTemplate.insert(announcement, COLLECTION_NAME);
	}
	
	public List<Announcement> listAnnouncement() {
		return mongoTemplate.findAll(Announcement.class, COLLECTION_NAME);
	}
	
	public void deleteAnnouncement(Announcement announcement) {
		mongoTemplate.remove(announcement, COLLECTION_NAME);
	}
	
	public void updateAnnouncement(Announcement announcement) {
		mongoTemplate.insert(announcement, COLLECTION_NAME);		
	}
	
	public Announcement findById(String announcementId) {
		return mongoTemplate.findById(announcementId, Announcement.class, COLLECTION_NAME);		
	}
}
