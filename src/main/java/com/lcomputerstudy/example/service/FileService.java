package com.lcomputerstudy.example.service;

import java.util.List;

import com.lcomputerstudy.example.domain.FileVO;

public interface FileService {
	public int fileInsert(FileVO file);
	
	public List<FileVO> selectFileList(FileVO file);
}
