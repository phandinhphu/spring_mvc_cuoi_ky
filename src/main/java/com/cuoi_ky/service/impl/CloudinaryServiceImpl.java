package com.cuoi_ky.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.cuoi_ky.service.CloudinaryService;

@Service
public class CloudinaryServiceImpl implements CloudinaryService {
	
	private final Cloudinary cloudinary;
	
	@Autowired
	public CloudinaryServiceImpl(Cloudinary cloudinary) {
		this.cloudinary = cloudinary;
	}

	@Override
	public Map uploadImage(byte[] data) throws Exception {
		return cloudinary.uploader().upload(
                data,
                ObjectUtils.asMap(
                        "folder", "avatars",
                        "resource_type", "image"
                )
        );
	}

	@Override
	public void deleteImage(String publicId) throws Exception {
		cloudinary.uploader().destroy(
                publicId,
                ObjectUtils.emptyMap()
        );
	}

}
