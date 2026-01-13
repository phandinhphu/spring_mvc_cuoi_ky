package com.cuoi_ky.util;

/**
 * Utility class for Japanese text processing
 */
public class JapaneseUtils {

    /**
     * Check if text contains Japanese characters (Hiragana, Katakana, or Kanji)
     */
    public static boolean isJapanese(String text) {
        if (text == null || text.isEmpty()) {
            return false;
        }

        for (char c : text.toCharArray()) {
            // Hiragana: U+3040 to U+309F
            // Katakana: U+30A0 to U+30FF
            // Kanji: U+4E00 to U+9FAF
            if ((c >= '\u3040' && c <= '\u309F') || // Hiragana
                    (c >= '\u30A0' && c <= '\u30FF') || // Katakana
                    (c >= '\u4E00' && c <= '\u9FAF')) { // Kanji
                return true;
            }
        }
        return false;
    }

    /**
     * Normalize Japanese text (remove extra spaces, etc.)
     */
    public static String normalizeText(String text) {
        if (text == null) {
            return null;
        }
        return text.trim().replaceAll("\\s+", " ");
    }

    /**
     * Extract only Japanese characters from text
     */
    public static String extractJapanese(String text) {
        if (text == null || text.isEmpty()) {
            return "";
        }

        StringBuilder result = new StringBuilder();
        for (char c : text.toCharArray()) {
            if ((c >= '\u3040' && c <= '\u309F') || // Hiragana
                    (c >= '\u30A0' && c <= '\u30FF') || // Katakana
                    (c >= '\u4E00' && c <= '\u9FAF')) { // Kanji
                result.append(c);
            }
        }
        return result.toString();
    }

    /**
     * Extract Kanji characters from text
     */
    public static String extractKanji(String text) {
        if (text == null || text.isEmpty()) {
            return "";
        }

        StringBuilder result = new StringBuilder();
        for (char c : text.toCharArray()) {
            if (c >= '\u4E00' && c <= '\u9FAF') { // Kanji range
                result.append(c);
            }
        }
        return result.toString();
    }

    /**
     * Check if character is Hiragana
     */
    public static boolean isHiragana(char c) {
        return c >= '\u3040' && c <= '\u309F';
    }

    /**
     * Check if character is Katakana
     */
    public static boolean isKatakana(char c) {
        return c >= '\u30A0' && c <= '\u30FF';
    }

    /**
     * Check if character is Kanji
     */
    public static boolean isKanji(char c) {
        return c >= '\u4E00' && c <= '\u9FAF';
    }
}
