// Nihongo Study - Main JavaScript File

// Utility Functions
const NihongoStudy = {
    // Show toast notification
    showToast: function(message, type = 'success') {
        const toast = document.createElement('div');
        toast.className = `alert alert-${type} position-fixed top-0 end-0 m-3`;
        toast.style.zIndex = '9999';
        toast.innerHTML = `
            <i class="fas fa-${type === 'success' ? 'check' : 'exclamation'}-circle me-2"></i>
            ${message}
        `;
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.classList.add('fade-out');
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    },

    // Play audio from URL or use TTS
    playAudio: function(audioUrl, text, buttonElement) {
        // If audio URL exists and is valid, play it
        if (audioUrl && audioUrl.trim() !== '' && !audioUrl.startsWith('/audio/')) {
            const audio = new Audio(audioUrl);
            audio.play().catch(err => {
                console.error('Error playing audio:', err);
                // Fallback to TTS if audio fails
                this.playTextToSpeech(text, buttonElement);
            });
            return;
        }
        
        // Otherwise use Text-to-Speech
        this.playTextToSpeech(text, buttonElement);
    },

    // Play text using Web Speech API (Text-to-Speech)
    playTextToSpeech: function(text, buttonElement) {
        if (!text || text.trim() === '') {
            this.showToast('Không có văn bản để phát âm', 'warning');
            return;
        }

        // Check if browser supports Speech Synthesis
        if (!('speechSynthesis' in window)) {
            this.showToast('Trình duyệt của bạn không hỗ trợ phát âm', 'warning');
            return;
        }

        // Cancel any ongoing speech
        window.speechSynthesis.cancel();

        // Create speech utterance
        const utterance = new SpeechSynthesisUtterance(text);
        
        // Set language to Japanese
        utterance.lang = 'ja-JP';
        
        // Set voice properties
        utterance.rate = 0.9; // Slightly slower for clarity
        utterance.pitch = 1.0;
        utterance.volume = 1.0;

        // Try to use Japanese voice if available
        const voices = window.speechSynthesis.getVoices();
        const japaneseVoice = voices.find(voice => 
            voice.lang.startsWith('ja') || voice.name.includes('Japanese')
        );
        if (japaneseVoice) {
            utterance.voice = japaneseVoice;
        }

        // Update button state
        if (buttonElement) {
            buttonElement.classList.add('playing');
            const icon = buttonElement.querySelector('i');
            if (icon) {
                icon.classList.remove('fa-volume-up');
                icon.classList.add('fa-volume-down', 'fa-spin');
            }
        }

        // Handle speech end
        utterance.onend = function() {
            if (buttonElement) {
                buttonElement.classList.remove('playing');
                const icon = buttonElement.querySelector('i');
                if (icon) {
                    icon.classList.remove('fa-volume-down', 'fa-spin');
                    icon.classList.add('fa-volume-up');
                }
            }
        };

        // Handle speech error
        utterance.onerror = function(event) {
            console.error('Speech synthesis error:', event);
            if (buttonElement) {
                buttonElement.classList.remove('playing');
                const icon = buttonElement.querySelector('i');
                if (icon) {
                    icon.classList.remove('fa-volume-down', 'fa-spin');
                    icon.classList.add('fa-volume-up');
                }
            }
            NihongoStudy.showToast('Không thể phát âm', 'danger');
        };

        // Speak
        window.speechSynthesis.speak(utterance);
    },

    // Stop current speech
    stopSpeech: function(buttonElement) {
        window.speechSynthesis.cancel();
        if (buttonElement) {
            buttonElement.classList.remove('playing');
            const icon = buttonElement.querySelector('i');
            if (icon) {
                icon.classList.remove('fa-volume-down', 'fa-spin');
                icon.classList.add('fa-volume-up');
            }
        }
    },

    // Format time
    formatTime: function(seconds) {
        const minutes = Math.floor(seconds / 60);
        const secs = seconds % 60;
        return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
    },

    // Confirm action
    confirmAction: function(message, callback) {
        if (confirm(message)) {
            callback();
        }
    },

    // Add to vocabulary list
    addToVocabList: function(vocabId) {
        // Simulate API call
        setTimeout(() => {
            this.showToast('Đã thêm từ vào sổ tay của bạn!', 'success');
        }, 500);
    },

    // Remove from vocabulary list
    removeFromVocabList: function(vocabId) {
        this.confirmAction('Bạn có chắc muốn xóa từ này khỏi sổ tay?', () => {
            setTimeout(() => {
                this.showToast('Đã xóa từ khỏi sổ tay', 'info');
            }, 500);
        });
    },

    // Initialize tooltips
    initTooltips: function() {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    },

    // Initialize all components
    init: function() {
        this.initTooltips();
        console.log('Nihongo Study initialized');
    }
};

// Auto-initialize on DOM ready
document.addEventListener('DOMContentLoaded', function() {
    NihongoStudy.init();
});

// Make it globally accessible
window.NihongoStudy = NihongoStudy;
