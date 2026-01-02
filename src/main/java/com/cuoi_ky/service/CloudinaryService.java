package com.cuoi_ky.service;

import java.util.Map;

public interface CloudinaryService {
	
	Map uploadImage(byte[] data) throws Exception;
	void deleteImage(String publicId) throws Exception;

}
