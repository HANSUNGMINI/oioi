package com.itwillbs.oi.Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.itwillbs.oi.service.MailService;
import com.itwillbs.oi.service.OipayService;
import com.itwillbs.oi.service.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService service;
	@Autowired
	private MailService mailService;
	@Autowired
	private OipayService oipayService;
	
	@GetMapping("login")
	public String goLogin() {
		return "user/login";
	}
	
	// 간편 로그인
	@GetMapping("easy_login")
	public String goEasyLogin() {
		return "user/easy_login";
	}
	
	// 카카오 로그인 처리 메서드
    @PostMapping("kakao_login")
    @ResponseBody
    public ResponseEntity<?> kakaoLogin(@RequestBody String tokenJson, HttpSession session) {
    	JSONObject tokenObj = new JSONObject(tokenJson);
        String accessToken = tokenObj.getString("token");
        System.out.println("로그인 토큰 : " + accessToken);
        try {
            String userInfo = getUserInfo(accessToken);
            System.out.println("사용자 정보 : " + userInfo);
            if (userInfo != null) {
                JSONObject userJson = new JSONObject(userInfo);
                // 카카오 사용자 정보를 이용하여 로그인 처리
                String userId = String.valueOf(userJson.getLong("id")); // ID 값을 문자열로 변환하여 저장
                String userEmail = userJson.getJSONObject("kakao_account").getString("email");
                String userNick = userJson.getJSONObject("properties").getString("nickname");
                String thumbnailImage = userJson.getJSONObject("properties").getString("thumbnail_image"); // 썸네일 이미지 URL 가져오기
                
                System.out.println(userEmail);
                System.out.println(userNick);
                
                // 카카오 사용자 정보를 Map에 저장
                Map<String, Object> kakaoUserInfo = new HashMap<>();
                kakaoUserInfo.put("US_ID", userId);
                kakaoUserInfo.put("US_EMAIL", userEmail);
                kakaoUserInfo.put("US_NAME", userNick);
                kakaoUserInfo.put("US_NICK", userNick + " (Kakao)");
                kakaoUserInfo.put("US_PROFILE", thumbnailImage);
                
                // DB에 사용자 정보 삽입 또는 업데이트
                Map<String, Object> loggedInUser = null;
				try {
					loggedInUser = service.loginOrRegister(kakaoUserInfo);
				} catch (Exception e) {
					e.printStackTrace();
				}
                
                if (loggedInUser != null) {
                    // 로그인 성공 후 세션에 사용자 정보 저장
                    session.setAttribute("US_ID", loggedInUser.get("US_ID"));
                    session.setAttribute("US_EMAIL", loggedInUser.get("US_EMAIL"));
                    session.setAttribute("US_NICK", loggedInUser.get("US_NICK"));
                    session.setAttribute("US_STATUS", loggedInUser.get("US_STATUS"));
                    session.setAttribute("KAKAO_LOGIN", true);
                    session.setAttribute("KAKAO_ACCESS_TOKEN", accessToken); // 액세스 토큰 세션에 저장
                    // 세션에 저장된 US_ID와 US_NICK 콘솔에 출력
                    System.out.println("로그인 시 세션 토큰 : " + session.getAttribute("KAKAO_ACCESS_TOKEN"));
                    System.out.println("세션에 저장된 US_ID: " + session.getAttribute("US_ID"));
                    System.out.println("세션에 저장된 US_EMAIL: " + session.getAttribute("US_EMAIL"));
                    System.out.println("세션에 저장된 US_NICK: " + session.getAttribute("US_NICK"));

                    // 성공 응답 반환
                    JSONObject responseJson = new JSONObject();
                    responseJson.put("success", true);
                    responseJson.put("user", userJson);
                    return ResponseEntity.ok(responseJson.toString());
                } else {
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("{\"success\": false}");
                }
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("{\"success\": false}");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("{\"success\": false}");
        }
    }
    
    @GetMapping("naver_callback")
	public String naverCallback(HttpServletRequest request, HttpSession session) {
		String clientId = "jYR_TimjsvzQr8BV06yT"; // 네이버 애플리케이션 클라이언트 아이디값
		String clientSecret = "gr5_JyaxfB"; // 네이버 애플리케이션 시크릿값
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = "http://c3d2401t1.itwillbs.com/oioi/naver_callback"; // 네이버 애플리케이션 콜백 URI
//		String redirectURI = "http://localhost:8081/oioi/naver_callback"; // 네이버 애플리케이션 콜백 URI
	
		try {
			String apiUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
	                  + "&client_id=" + clientId
	                  + "&client_secret=" + clientSecret
	                  + "&redirect_uri=" + URLEncoder.encode(redirectURI, "UTF-8")
	                  + "&code=" + code
	                  + "&state=" + state;
	
			URL url = new URL(apiUrl);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
	
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
	
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			br.close();
	
			String response = sb.toString();
	
	          // JSON 형태로 파싱하여 콘솔에 출력
			System.out.println("네이버 로그인 성공! 사용자 정보:");
			System.out.println(response);
	
	          // JSON 데이터 파싱
			JsonObject jsonObject = JsonParser.parseString(response).getAsJsonObject();
			String accessToken = jsonObject.get("access_token").getAsString();
			String tokenType = jsonObject.get("token_type").getAsString(); // 예시에서는 사용하지 않음
	
	          // 사용자 정보 요청
			String userInfoUrl = "https://openapi.naver.com/v1/nid/me";
			URL userInfoApiUrl = new URL(userInfoUrl);
			HttpURLConnection userInfoCon = (HttpURLConnection) userInfoApiUrl.openConnection();
			userInfoCon.setRequestMethod("GET");
			userInfoCon.setRequestProperty("Authorization", tokenType + " " + accessToken);
	
			int userInfoResponseCode = userInfoCon.getResponseCode();
			BufferedReader userInfoBr;
			if (userInfoResponseCode == 200) {
				userInfoBr = new BufferedReader(new InputStreamReader(userInfoCon.getInputStream()));
			} else {
				userInfoBr = new BufferedReader(new InputStreamReader(userInfoCon.getErrorStream()));
			}
	
			StringBuilder userInfoSb = new StringBuilder();
			String userInfoLine;
			while ((userInfoLine = userInfoBr.readLine()) != null) {
				userInfoSb.append(userInfoLine);
			}
			userInfoBr.close();
	
			String userInfoResponse = userInfoSb.toString();
			System.out.println("네이버 사용자 정보:");
			System.out.println(userInfoResponse);
	
	          // JSON 데이터 파싱하여 필요한 정보 추출
			JsonObject userInfoJson = JsonParser.parseString(userInfoResponse).getAsJsonObject();
			JsonObject responseJson = userInfoJson.getAsJsonObject("response");
			String userId = responseJson.get("id").getAsString();
			String userName = responseJson.get("name").getAsString();
			String userNick = responseJson.get("nickname").getAsString() + " (Naver)";
			String userEmail = responseJson.get("email").getAsString();
			String userProfile = responseJson.get("profile_image").getAsString();
	
	          // 유저정보 map에 저장
			Map<String, Object> naverUserInfo = new HashMap<>();
			naverUserInfo.put("US_ID", userId);
			naverUserInfo.put("US_NAME", userName);
			naverUserInfo.put("US_NICK", userNick);
			naverUserInfo.put("US_EMAIL", userEmail);
			naverUserInfo.put("US_PROFILE", userProfile);
	
	          // 네이버 사용자 정보를 DB에 저장
			Object result;
			if (service.isExistUserId(userId) > 0) {
	              // 이미 존재하는 사용자일 경우 업데이트
				result = service.updateUserFromNaver(naverUserInfo);
			} else {
	              // 존재하지 않는 사용자일 경우 삽입
				result = service.insertUserFromNaver(naverUserInfo);
			}
	
	          // 결과에 따라 처리
			if (result != null) {
	              // 세션에 저장
				session.setAttribute("US_STATUS", service.selectStatus(userId));
				session.setAttribute("NAVER_LOGIN", true);
				session.setAttribute("US_ID", userId);
				session.setAttribute("US_NICK", userNick);
	              // 세션 정보 확인
				System.out.println("네이버 로그인 성공! 사용자 정보:");
				System.out.println("userId: " + userId);
				System.out.println("userName: " + userName);
				System.out.println("userNick: " + userNick);
				System.out.println("userEmail: " + userEmail);
					
				return "redirect:/"; // 로그인 후 리다이렉트할 경로
			} else {
	              return "err/fail"; // DB 처리 실패 등의 예외 상황
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "err/fail"; // 예외 발생 시 처리
		}
    }
    
    private String getUserInfo(String accessToken) throws IOException {
        String requestUrl = "https://kapi.kakao.com/v2/user/me";
        URL url = new URL(requestUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", "Bearer " + accessToken);
        connection.setDoOutput(true);

        int responseCode = connection.getResponseCode();
        if (responseCode == 200) { // 성공
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            return response.toString();
        } else {
            return null;
        }
    }

    // 카카오 로그아웃 메서드
    private void kakaoLogout(String accessToken) throws IOException {
        String requestUrl = "https://kapi.kakao.com/v1/user/logout";
        URL url = new URL(requestUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Authorization", "Bearer " + accessToken);
        connection.setDoOutput(true);

        int responseCode = connection.getResponseCode();
        if (responseCode != 200) {
            throw new IOException("Failed to logout from Kakao: " + responseCode);
        }
    }

    @GetMapping("kakao_logout")
    public String logout(HttpSession session, HttpServletRequest request) {
    	// 카카오 로그인을 통해 세션에 저장된 액세스 토큰 가져오기
        String kakaoAccessToken = (String) session.getAttribute("KAKAO_ACCESS_TOKEN");
        String userId = (String) session.getAttribute("US_ID");
        String userNick = (String) session.getAttribute("US_NICK");

        // 세션에 저장된 정보 콘솔에 출력
        System.out.println("로그아웃 시 받아온 토큰 : " + kakaoAccessToken);
        System.out.println("세션에 저장된 US_ID: " + userId);
        System.out.println("세션에 저장된 US_NICK: " + userNick);

        // 세션 무효화
        session.invalidate();

        // 새로운 세션을 생성하여 무효화된 세션의 정보가 null인지 확인
        HttpSession newSession = request.getSession(false);
        if (newSession == null) {
            System.out.println("세션 무효화 성공!");
        } else {
            System.out.println("세션 무효화 실패");
            System.out.println("KAKAO_ACCESS_TOKEN: " + newSession.getAttribute("KAKAO_ACCESS_TOKEN"));
            System.out.println("US_ID: " + newSession.getAttribute("US_ID"));
            System.out.println("US_NICK: " + newSession.getAttribute("US_NICK"));
        }

        if (kakaoAccessToken != null) {
            try {
                kakaoLogout(kakaoAccessToken);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return "redirect:/";
    }
    
    
    
	//회원가입 폼
	@GetMapping("register")
	public String goRegister() {
		return "user/register";
	}
	
	@GetMapping("check_id")
	public String check_id() {
		return "user/check_id";
	}
	
	// 실제 유효성검사를 마친후 중복확인 DB작업을 하기 위한 매핑주소
	@PostMapping("check_id")
	public String checkIdPro(String user_id, Model model, HttpServletResponse response) {
		boolean isEmptyId = service.isEmptyId(user_id);
		model.addAttribute("userId", user_id);
		model.addAttribute("isValid", !isEmptyId);
		
		return "redirect:/check_id";
	}
	
	@GetMapping("check_nick")
	public String check_nick() {
		return "user/check_nick";
	}
	
	// 실제 유효성검사를 마친후 중복확인 DB작업을 하기 위한 매핑주소
	@PostMapping("check_nick")
	public String checkNickPro(String user_nick, Model model, HttpServletResponse response) {
		boolean isEmptyNick = service.isEmptyNick(user_nick);
		model.addAttribute("userNick", user_nick);
		model.addAttribute("isValidNick", !isEmptyNick);
		
		return "redirect:/check_nick";
	}
	
	
	@PostMapping("register")
	public String joinPro(@RequestParam Map<String, Object> userMap, Model model, BCryptPasswordEncoder passwordEncoder) {
		System.out.println(userMap);
		String userEmail = (String) userMap.get("user_email");
		String userPhone = (String) userMap.get("user_phone");
		
		boolean isEmptyEmail = service.isEmptyEmail(userEmail);
		boolean isEmptyPhoneNum = service.isEmptyPhoneNum(userPhone);
		
		if(!isEmptyEmail) {
			model.addAttribute("msg", "이미 가입된 이메일 입니다.");
			return "err/fail";
		}
		
		if(!isEmptyPhoneNum) {
			model.addAttribute("msg", "이미 가입된 전화번호입니다.");
			return "err/fail";
		}
		
		String securePasswd = passwordEncoder.encode((String)userMap.get("user_passwd"));
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("US_ID", (String)userMap.get("user_id"));
		resultMap.put("US_PASSWD", securePasswd);
		resultMap.put("US_NAME", (String)userMap.get("user_name"));
		resultMap.put("US_NICK", (String)userMap.get("user_nick"));
		resultMap.put("US_EMAIL", userEmail);
		resultMap.put("US_POST_CODE", (String)userMap.get("user_post_code"));
		resultMap.put("US_ADDRESS1", (String)userMap.get("user_address1"));
		resultMap.put("US_ADDRESS2", (String)userMap.get("user_address2"));
		resultMap.put("US_GENDER", (String)userMap.get("user_gender"));
		resultMap.put("US_PHONE", userPhone);
		resultMap.put("US_PROFILE", "https://ssl.pstatic.net/static/pwe/address/img_profile.png");
		resultMap.put("US_LAT", (String)userMap.get("US_LAT"));
		resultMap.put("US_LNG", (String)userMap.get("US_LNG"));
		if(service.registUser(resultMap) > 0) {
			model.addAttribute("msg", "회원가입에 성공하셨습니다!");
			model.addAttribute("US_NICK", (String) resultMap.get("US_NICK")); 
			return "user/regist_success";
		} else {
			model.addAttribute("msg", "회원가입 실패!");
			return "err/fail";
		}
	}
	
	@ResponseBody
	@PostMapping("SendAuthMail")
	public ResponseEntity<Map<String, Object>> sendAuthMail(@RequestBody Map<String, Object> userMap) {
		
		Map<String, Object> response = new HashMap<>();
		
		try {
			Map<String, Object> mailAuthInfoMap = mailService.sendAuthMail(userMap);
			service.registMailAuthInfo(mailAuthInfoMap);
			response.put("success", true);
			response.put("auth_code", mailAuthInfoMap.get("auth_code"));
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "인증메일 발송에 실패했습니다. 다시 시도해주세요.");
			
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}
	@PostMapping("login")
	public String loginPro(@RequestParam Map<String, String> loginData, HttpSession session, Model model, BCryptPasswordEncoder passwordEncoder, HttpServletResponse response) {
	    String userId = loginData.get("user_id");
	    String userPasswd = loginData.get("user_passwd");
	    String rememberId = loginData.get("rememberMe");
	    // 서비스를 통해 회원 정보 가져오기
	    Map<String, String> dbUser = service.selectUser(userId); 
	    if(dbUser == null || !passwordEncoder.matches(userPasswd, dbUser.get("US_PASSWD"))) { // 로그인 실패
	        model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다.\\n입력하신 내용을 다시 확인해주세요.");
	        return "err/fail";
	    } else if ("2".equals(dbUser.get("US_STATUS"))) {
	        model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
	        return "err/fail";
	    } else { // 로그인 성공
	        // 세션 객체에 로그인 성공한 아이디 및 닉네임 저장
	    	String bankAccessToken = oipayService.selectBankAccessToken(userId);
	    	session.setAttribute("BUI_ACCESS_TOKEN", bankAccessToken);
	        session.setAttribute("US_ID", userId);
	        session.setAttribute("US_NICK", dbUser.get("US_NICK"));
	        session.setAttribute("US_STATUS", dbUser.get("US_STATUS"));
	        
	        System.out.println("로그인 아이디: " + userId);
	        System.out.println("회원정보" + dbUser);
	        
	        // 세션의 유효 시간 설정 (예: 1시간)
            int sessionTimeoutSeconds =  6000000 * 60; // 1시간
            session.setMaxInactiveInterval(sessionTimeoutSeconds);
	        
	        Cookie cookie = new Cookie("cookieId", userId);
	        if(rememberId != null) { // 체크박스 체크 상태일 경우 쿠키 설정
	        	cookie.setMaxAge(60 * 60 * 24); // 60초 * 60분 * 24시간 = 86000초 = 1일
	        } else {
	        	cookie.setMaxAge(0);
	        }
	        response.addCookie(cookie);
	        System.out.println(cookie);
	        // 메인페이지 리다이렉트
	        return "redirect:/";
	    }
	}
	
	@GetMapping("lost_id")
	public String lost_id() {
		return "user/lost_id";
	}
	
	@PostMapping("lost_id")
	public String lostIdPro(@RequestParam Map<String, Object> userMap, Model model) {
		System.out.println("받은 userMap 정보 : " + userMap);
		Map<String, Object> user = service.findId(userMap);
		System.out.println("조회된 user정보 : " + user);
		if(user != null) {
			mailService.sendForgotId(user);
			model.addAttribute("msg", "이메일 전송이 완료되었습니다.");
			model.addAttribute("targetURL", "login");
			return "err/success";
		} else {
			model.addAttribute("msg", "이름 또는 E-Mail 주소를 잘못 입력하셨습니다.");
			return "err/fail";
		}
	}
	
	@GetMapping("lost_passwd")
	public String lostPasswd() {
		return "user/lost_passwd";
	}
	
	@PostMapping("lost_passwd") 
	public String lostPwPro(@RequestParam Map<String, Object> userMap, Model model) {
		System.out.println("받은 userMap 정보 : " + userMap);
		Map<String, Object> user = service.findPasswd(userMap);
		System.out.println("조회된 user 정보 : " + user);
		if(user != null) {
			mailService.sendForgotPw(user);
			model.addAttribute("msg", "이메일 전송이 완료되었습니다.");
			return "err/success"; 
		} else {
			model.addAttribute("msg", "ID, 이름 또는 E-Mail 주소를 잘못 입력하셨습니다.");
			return "err/fail";
		}
	}
	
	@GetMapping("change_passwd")
	public String changePw(@RequestParam Map<String, String> userMap, Model model) {
		model.addAttribute("userId", userMap.get("user_id"));
		return "user/change_passwd";
	}
	
	@PostMapping("change_passwd")
	public String chagePwPro(@RequestParam Map<String, String> userMap, BCryptPasswordEncoder passwordEncoder, Model model) {
		System.out.println("받은 userMap 정보 : " + userMap);
		String securePasswd = passwordEncoder.encode(userMap.get("user_passwd"));
		
		Map<String, Object> user = new HashMap<>();
		user.put("US_ID", userMap.get("user_id"));
		user.put("US_PASSWD", securePasswd);
		System.out.println("user 저장정보 : " + user);
		int updateCount = service.modifyPasswd(user);
		System.out.println("Count 정보 : " + updateCount);
		if(updateCount <= 0) {
			model.addAttribute("msg", "비밀번호 변경 실패");
			return "err/fail";
		}
		
		return "redirect:/login";
	}
	
//    @GetMapping("/store")
//    public String showUserStorePage(@RequestParam("userId") String userId, Model model) {
//        // 여기서 userId는 사용자의 고유 식별자입니다. 이를 기반으로 사용자 정보를 조회하고 JSP에 전달합니다.
//        
//        // 예시에서는 사용자 정보를 임의로 생성하여 모델에 추가합니다.
//        Map<String, Object> user = new HashMap<>();
//        user.put("US_NICK", "사용자 닉네임");
//        user.put("US_PROFILE", "사용자 프로필 이미지 Base64 데이터"); // 실제 이미지 데이터는 여기에 추가
//        
//        // 모델에 사용자 정보 추가
//        model.addAttribute("user", user);
//
//        // 여기서 "user/store"는 JSP 파일의 경로입니다. 실제 프로젝트에서는 경로에 맞게 수정해야 합니다.
//        return "user/store";
//    }
	
//   ======================================== Jackson 이용한 네이버 회원가입 및 로그인 메서드
//	@GetMapping("naver_callback")
//    public String naverCallback(HttpServletRequest request, HttpSession session) {
//        String clientId = "jYR_TimjsvzQr8BV06yT"; // 네이버 애플리케이션 클라이언트 아이디값
//        String clientSecret = "gr5_JyaxfB"; // 네이버 애플리케이션 시크릿값
//        String code = request.getParameter("code");
//        String state = request.getParameter("state");
//        String redirectURI = "http://localhost:8081/oi/naver_callback"; // 네이버 애플리케이션 콜백 URI
//
//        try {
//            String apiUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
//                    + "&client_id=" + clientId
//                    + "&client_secret=" + clientSecret
//                    + "&redirect_uri=" + URLEncoder.encode(redirectURI, "UTF-8")
//                    + "&code=" + code
//                    + "&state=" + state;
//
//            URL url = new URL(apiUrl);
//            HttpURLConnection con = (HttpURLConnection) url.openConnection();
//            con.setRequestMethod("GET");
//
//            int responseCode = con.getResponseCode();
//            BufferedReader br;
//            if (responseCode == 200) { // 정상 호출
//                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//            } else { // 에러 발생
//                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
//            }
//
//            StringBuilder sb = new StringBuilder();
//            String line;
//            while ((line = br.readLine()) != null) {
//                sb.append(line);
//            }
//            br.close();
//
//            String response = sb.toString();
//            
//            // JSON 형태로 파싱하여 콘솔에 출력
//            System.out.println("네이버 로그인 성공! 사용자 정보:");
//            System.out.println(response);
//
//            // JSON 데이터 파싱
//            ObjectMapper objectMapper = new ObjectMapper();
//            JsonNode jsonNode = objectMapper.readTree(response);
//            String accessToken = jsonNode.get("access_token").asText();
//            String tokenType = jsonNode.get("token_type").asText(); // 예시에서는 사용하지 않음
//
//            // 사용자 정보 요청
//            String userInfoUrl = "https://openapi.naver.com/v1/nid/me";
//            URL userInfoApiUrl = new URL(userInfoUrl);
//            HttpURLConnection userInfoCon = (HttpURLConnection) userInfoApiUrl.openConnection();
//            userInfoCon.setRequestMethod("GET");
//            userInfoCon.setRequestProperty("Authorization", tokenType + " " + accessToken);
//
//            int userInfoResponseCode = userInfoCon.getResponseCode();
//            BufferedReader userInfoBr;
//            if (userInfoResponseCode == 200) {
//                userInfoBr = new BufferedReader(new InputStreamReader(userInfoCon.getInputStream()));
//            } else {
//                userInfoBr = new BufferedReader(new InputStreamReader(userInfoCon.getErrorStream()));
//            }
//
//            StringBuilder userInfoSb = new StringBuilder();
//            String userInfoLine;
//            while ((userInfoLine = userInfoBr.readLine()) != null) {
//                userInfoSb.append(userInfoLine);
//            }
//            userInfoBr.close();
//
//            String userInfoResponse = userInfoSb.toString();
//            System.out.println("네이버 사용자 정보:");
//            System.out.println(userInfoResponse);
//
//            // JSON 데이터 파싱하여 필요한 정보 추출
//            JsonNode userInfoJson = objectMapper.readTree(userInfoResponse);
//            String userId = userInfoJson.get("response").get("id").asText();
//            String userNick = userInfoJson.get("response").get("nickname").asText() + " (네이버)";
//            String userEmail = userInfoJson.get("response").get("email").asText();
//            String userProfile = userInfoJson.get("response").get("profile_image").asText();
//            
//            // 유저정보 map에 저장
//            Map<String, Object> naverUserInfo = new HashMap<>();
//            naverUserInfo.put("US_ID", userId);
//            naverUserInfo.put("US_NAME", userNick);
//            naverUserInfo.put("US_NICK", userNick);
//            naverUserInfo.put("US_EMAIL", userEmail);
//            naverUserInfo.put("US_PROFILE", userProfile);
//            
//            // 네이버 사용자 정보를 DB에 저장
//            Object result;
//            if (service.isExistUserId(userId) > 0) {
//                // 이미 존재하는 사용자일 경우 업데이트
//            	 result = service.updateUserFromNaver(naverUserInfo);
//            } else {
//                // 존재하지 않는 사용자일 경우 삽입
//            	 result = service.insertUserFromNaver(naverUserInfo);
//            }
//            
//            // 결과에 따라 처리
//            if (result != null) {
//                // 세션에 저장
//            	session.setAttribute("NAVER_LOGIN", true);
//            	session.setAttribute("US_ID", userId);
//                session.setAttribute("US_NICK", userNick);
//                // 세션 정보 확인
//                System.out.println("네이버 로그인 성공! 사용자 정보:");
//                System.out.println("userId: " + userId);
//                System.out.println("userNick: " + userNick);
//                System.out.println("userEmail: " + userEmail);
//                return "redirect:/"; // 로그인 후 리다이렉트할 경로
//            } else {
//                return "err/fail"; // DB 처리 실패 등의 예외 상황
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "err/fail"; // 예외 발생 시 처리
//        }
//    }
}
