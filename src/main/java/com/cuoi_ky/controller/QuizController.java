package com.cuoi_ky.controller;

import com.cuoi_ky.model.QuizQuestion;
import com.cuoi_ky.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Quiz Controller
 * Following Dependency Inversion Principle
 */
@Controller
@RequestMapping("/quiz")
public class QuizController {

    private final QuizService quizService;

    @Autowired
    public QuizController(QuizService quizService) {
        this.quizService = quizService;
    }

    @GetMapping("/")
    public String quizList(Model model) {
        long totalQuestions = quizService.getTotalQuestionsCount();
        model.addAttribute("totalQuizzes", totalQuestions / 10); // Assuming 10 questions per quiz
        model.addAttribute("completedQuizzes", 0); // Will track this later
        return "quiz/index";
    }

    @GetMapping("/start")
    public String startQuiz(Model model) {
        // Get random questions from database
        List<QuizQuestion> questions = quizService.getRandomQuizQuestions(10);
        
        model.addAttribute("questions", questions);
        model.addAttribute("currentQuestion", 0);
        model.addAttribute("totalQuestions", questions.size());
        model.addAttribute("score", 0);
        return "quiz/start";
    }

    @GetMapping("/result")
    public String result(Model model) {
        // Result will be passed via request parameters after quiz submission
        // For now, showing mock data
        model.addAttribute("score", 8);
        model.addAttribute("total", 10);
        model.addAttribute("percentage", 80);
        model.addAttribute("passed", true);
        return "quiz/result";
    }
}

