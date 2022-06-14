package com.lcomputerstudy.example.service;

import java.util.List;
import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Pagination;
import com.lcomputerstudy.example.domain.Search;
import com.lcomputerstudy.example.mapper.BoardMapper;

public interface BoardService {
	static BoardService service= null;
	static BoardMapper mapper = null;
	
	public List<Board> selectBoardList(Pagination pagination);
	
	public Board article(Board board);
	
	public void writeAction(Board board);
	
	public void countView(int bId);
	
	public int boardCount(Search search);
	
	public Board reply(Board board);
	
	public void replyAction(Board board);
	
	public void updateAction(Board board);
	
	public int deleteAction(int bId);
}
