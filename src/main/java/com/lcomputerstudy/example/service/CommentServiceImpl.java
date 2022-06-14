package com.lcomputerstudy.example.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lcomputerstudy.example.domain.Comment;
import com.lcomputerstudy.example.mapper.CommentMapper;

@Service("CommentServiceImpl")
public class CommentServiceImpl implements CommentService {

	@Autowired CommentMapper commentmapper;
	@Override
	public List<Comment> selectCommentList(Comment comment) {
		return commentmapper.selectCommentList(comment);
	}
	
	@Override
	public void commentAction(Comment comment) {
		commentmapper.commentAction(comment);
	}
	
	@Override
	public void commentReplyAction(Comment comment) {
		commentmapper.commentReplyAction(comment);
	}
	
	@Override
	public void commentUpdateAction(Comment comment) {
		commentmapper.commentUpdateAction(comment);
	}
	
	@Override
	public void commentDelete(Comment comment) {
		commentmapper.commentDelete(comment);
	}
}



