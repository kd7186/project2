package com.lcomputerstudy.example.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;


import com.lcomputerstudy.example.domain.FileVO;


@Mapper
public interface FileMapper {
	public int fileInsert(FileVO file);
	
	public List<FileVO> selectFileList(FileVO file);
}
