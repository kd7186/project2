package com.lcomputerstudy.example.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.swing.filechooser.FileSystemView;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Comment;
import com.lcomputerstudy.example.domain.FileVO;
import com.lcomputerstudy.example.domain.Pagination;
import com.lcomputerstudy.example.domain.Search;
import com.lcomputerstudy.example.domain.User;
import com.lcomputerstudy.example.service.BoardService;
import com.lcomputerstudy.example.service.CommentService;
import com.lcomputerstudy.example.service.FileService;
import com.lcomputerstudy.example.service.UserService;
import java.io.IOException;

@org.springframework.stereotype.Controller
public class Controller {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired UserService userservice;
	@Autowired BoardService boardservice;
	@Autowired PasswordEncoder encoder;
	@Autowired FileService fileservice;
	@Autowired CommentService commentservice;
	
	@GetMapping({"/","/{optPage}"})
	public String home(Model model,Authentication authentication,Search search,@PathVariable(required = false) Optional<Integer> optPage) {
		int page = optPage.isPresent() ? optPage.get() : 1;
		
		int count = 0;
		Pagination pagination = new Pagination();
		/*search = new Search();
		search.setFind(request.getParameter("find"));
		search.setSearch(request.getParameter("search"));*/
		count = boardservice.boardCount(search);
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.setSearch(search);
		pagination.init();
		List<Board> list = boardservice.selectBoardList(pagination);
		model.addAttribute("list", list);
		model.addAttribute("pageNum",pagination.getPageNum());
		model.addAttribute("pagination",pagination);
		if (authentication != null) {
		User user = (User) authentication.getPrincipal();
		model.addAttribute("uName", user.getuName());}
		logger.debug("debug");
	    logger.info("info");
	    logger.error("error");
		return "/index";
	}
	
	@RequestMapping("/beforeSignUp") 
	public String beforeSignUp() {
		return "/signup";
	}
	
	@RequestMapping("/signup")
	public String signup(User user) {	    
	      String encodedPassword = encoder.encode(user.getPassword());
	      
	      user.setPassword(encodedPassword);
	      user.setAccountNonExpired(true);
	      user.setEnabled(true);
	      user.setAccountNonLocked(true);
	      user.setCredentialsNonExpired(true);
	      user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));   
	      
	      userservice.createUser(user);
	      userservice.createAuthorities(user);
	 

	    return "/login";
	}
	
	@RequestMapping(value="/login")
	   public String beforeLogin(Model model) {
	      return "/login";
	   }
	
	@Secured({"ROLE_ADMIN"})
	   @RequestMapping(value="/admin")
	   public String admin(Model model) {
	      return "/admin";
	   }
	   
	@Secured({"ROLE_USER"})
	   @RequestMapping(value="/user/info")
	   public String userInfo(Model model) {
	      
	      return "/user_info";
	   }
	   
	   @RequestMapping(value="/denied")
	   public String denied(Model model) {
	      return "/denied";
	   }
	
	@RequestMapping("/article/{bId}")
	public String article(Model model, Authentication authentication,Board board,FileVO file,Comment comment,@PathVariable int bId) {
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());
			model.addAttribute("uAuth", user.getuAuth());
			}
		Board article = boardservice.article(board);
		model.addAttribute("article", article);
		List<FileVO> filelist= fileservice.selectFileList(file);
		model.addAttribute("filelist", filelist);
		boardservice.countView(bId);
		List<Comment> list1 = commentservice.selectCommentList(comment);
		model.addAttribute("list1", list1);
		return "/article";
	}
	
	@RequestMapping("/write")
	public String write(Model model, Authentication authentication) {
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		return "/write";
	}
	
	@PostMapping("/writeaction")
	public String writeaction(Authentication authentication, Model model,Board board,MultipartFile[] files) throws Exception{
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		FileVO file = new FileVO();
		User user = (User) authentication.getPrincipal();
		board.setbWriter(user.getuName());
		if(files == null) {
		boardservice.writeAction(board);
		} else {
			boardservice.writeAction(board);
			for(MultipartFile f : files) {
		String fileName = f.getOriginalFilename();
		String fileNameExtension = FilenameUtils.getExtension(fileName).toLowerCase();
		File destinationFile;
		String destinationFileName;
		String fileUrl = "C:\\Users\\l6-morning\\Documents\\work12\\project1\\src\\project1\\src\\images\\";
		
		do {
			destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + fileNameExtension;
			destinationFile = new File(fileUrl+ destinationFileName);
		} while (destinationFile.exists());
		
		destinationFile.getParentFile().mkdirs();
		f.transferTo(destinationFile);
		file.setFileName(destinationFileName);
		file.setFileRealName(fileName);
		file.setFileUrl(fileUrl);
		fileservice.fileInsert(file);}
		}
		return "redirect:/1";
	}
	
	@RequestMapping("/reply/{bId}")
	public String selectReply(Model model, Authentication authentication,Board board,@PathVariable int bId) {
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		Board reply = boardservice.reply(board);
		model.addAttribute("reply", reply);
		return "/reply";
	}
	
	@PostMapping("/replyaction")
	public String replyaction(Authentication authentication, Model model,Board board,@RequestPart MultipartFile files) throws Exception{
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		FileVO file = new FileVO();
		User user = (User) authentication.getPrincipal();
		board.setbWriter(user.getuName());
		if(files.isEmpty()) {
		boardservice.replyAction(board);
		} else {
		String fileName = files.getOriginalFilename();
		String fileNameExtension = FilenameUtils.getExtension(fileName).toLowerCase();
		File destinationFile;
		String destinationFileName;
		String fileUrl = "C:/Users/l6-morning/Documents/work12/lcomputerstudy/src/main/resources/static/img/";
		
		do {
			destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + fileNameExtension;
			destinationFile = new File(fileUrl+ destinationFileName);
		} while (destinationFile.exists());
		
		destinationFile.getParentFile().mkdirs();
		files.transferTo(destinationFile);
		boardservice.replyAction(board);
		file.setFileName(destinationFileName);
		file.setFileRealName(fileName);
		file.setFileUrl(fileUrl);
		fileservice.fileInsert(file);
		}
		return "redirect:/1";
	}
	
	@RequestMapping("/edit/{bId}")
	public String selectEdit(Model model, Authentication authentication,Board board,@PathVariable int bId) {
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		Board article = boardservice.article(board);
		model.addAttribute("article", article);
		return "/edit";
	}
	
	@PostMapping("/editaction")
	public String editaction(Authentication authentication, Model model,Board board) throws Exception{
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		User user = (User) authentication.getPrincipal();
		boardservice.updateAction(board);
		return "redirect:/1";
	}
	
	@RequestMapping("/delete/{bId}")
	public String deleteaction(Authentication authentication, Model model,@PathVariable int bId) throws Exception{
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		User user = (User) authentication.getPrincipal();
		boardservice.deleteAction(bId);
		return "redirect:/1";
	}
	
	@PostMapping("/commentaction")
	public String commentaction(Authentication authentication,Model model,Comment comment) throws Exception {
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		User user = (User) authentication.getPrincipal();
		comment.setCommentWriter(user.getuName());
		commentservice.commentAction(comment);
		List<Comment> list1 = commentservice.selectCommentList(comment);
		model.addAttribute("list1", list1);
		return "/commentaction";
	}
	
	@PostMapping("/commentreplyaction")
	public String commentreplyaction(Authentication authentication,Model model,Comment comment) throws Exception {
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		User user = (User) authentication.getPrincipal();
		comment.setCommentWriter(user.getuName());
		commentservice.commentReplyAction(comment);
		List<Comment> list1 = commentservice.selectCommentList(comment);
		model.addAttribute("list1", list1);
		return"/commentaction";
	}
	
	@PostMapping("/commentupdateaction")
	public String commentupdateaction(Authentication authentication,Model model,Comment comment) throws Exception {
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		User user = (User) authentication.getPrincipal();
		commentservice.commentUpdateAction(comment);
		List<Comment> list1 = commentservice.selectCommentList(comment);
		model.addAttribute("list1", list1);
		return"/commentaction";
	}
	
	@RequestMapping("/commentdelete")
	public String commentdelete(Authentication authentication,Model model,Comment comment) throws Exception {
		if (authentication != null) {
			User user = (User) authentication.getPrincipal();
			model.addAttribute("uName", user.getuName());}
		User user = (User) authentication.getPrincipal();
		commentservice.commentDelete(comment);
		List<Comment> list1 = commentservice.selectCommentList(comment);
		model.addAttribute("list1", list1);
		return"/commentaction";
	}
}
