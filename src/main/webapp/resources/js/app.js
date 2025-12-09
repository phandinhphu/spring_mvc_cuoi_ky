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

    // Play audio
    playAudio: function(audioUrl) {
        if (!audioUrl || audioUrl === '' || audioUrl.startsWith('/audio/')) {
            this.showToast('Chức năng phát âm sẽ được triển khai với audio file thực tế', 'info');
            return;
        }
        const audio = new Audio(audioUrl);
        audio.play().catch(err => {
            console.error('Error playing audio:', err);
            this.showToast('Không thể phát âm thanh', 'danger');
        });
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
