// Content Script - Runs on all web pages
// Detects Japanese text selection and shows translation tooltip

let tooltip = null;
let currentSelection = null;

// Listen for keyboard shortcut (Alt + w)
document.addEventListener('keydown', (event) => {
	if (event.altKey && (event.key === 'w' || event.key === 'W')) {
		handleTextSelection(event);
	}
});

// Close tooltip when clicking outside
document.addEventListener('mousedown', (e) => {
	if (tooltip && !tooltip.contains(e.target)) {
		removeTooltip();
	}
});

function handleTextSelection(event) {
	// Get selected text
	const selection = window.getSelection();
	const selectedText = selection.toString().trim();

	// Remove existing tooltip
	removeTooltip();

	// Check if text is selected and contains Japanese
	if (!selectedText || selectedText.length === 0) {
		return;
	}

	if (!containsJapanese(selectedText)) {
		return;
	}

	// Save current selection
	currentSelection = selectedText;

	// Get selection position
	const range = selection.getRangeAt(0);
	const rect = range.getBoundingClientRect();

	// Show loading tooltip
	showLoadingTooltip(rect);

	// Request translation
	requestTranslation(selectedText, rect);
}

function containsJapanese(text) {
	// Check for Hiragana, Katakana, or Kanji
	const japaneseRegex = /[\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FAF]/;
	return japaneseRegex.test(text);
}

function showLoadingTooltip(rect) {
	tooltip = createTooltipElement();
	tooltip.classList.add('jl-loading');
	tooltip.innerHTML = `
    <div class="jl-tooltip-header">Japanese Learning</div>
    <div class="jl-tooltip-content">
      <div class="jl-loading-spinner"></div>
      <p>Translating...</p>
    </div>
  `;

	document.body.appendChild(tooltip); // Append first to calculate size
	positionTooltip(tooltip, rect);

	// Ensure visibility and animation
	requestAnimationFrame(() => {
		tooltip.classList.add('jl-show');
	});
}

function showTranslationTooltip(data, rect) {
	removeTooltip();

	tooltip = createTooltipElement();

	if (!data.success) {
		tooltip.innerHTML = `
      <div class="jl-tooltip-header">Error</div>
      <div class="jl-tooltip-content">
        <p class="jl-error">${data.message || 'Translation failed'}</p>
      </div>
    `;
	} else {
		let wordsHtml = '';

		if (data.words && data.words.length > 0) {
			wordsHtml = data.words.map(word => `
        <div class="jl-word-item ${word.existsInDb ? 'jl-existing' : 'jl-new'}">
          <div class="jl-word-main">
            <span class="jl-word-text">${escapeHtml(word.word)}</span>
            ${word.existsInDb ? '<span class="jl-badge">已保存</span>' : '<span class="jl-badge jl-new-badge">新</span>'}
          </div>
          <div class="jl-word-meaning">${escapeHtml(word.meaning)}</div>
          ${word.romaji ? `<div class="jl-word-romaji">${escapeHtml(word.romaji)}</div>` : ''}
          ${word.hiragana ? `<div class="jl-word-reading">${escapeHtml(word.hiragana)}</div>` : ''}
        </div>
      `).join('');
		}

		tooltip.innerHTML = `
      <div class="jl-tooltip-header">
        日本語 Translation
        <button class="jl-close-btn" onclick="this.closest('.japanese-learning-tooltip').remove()">×</button>
      </div>
      <div class="jl-tooltip-content">
        ${data.fullTranslation ? `
          <div class="jl-full-translation">
            <strong>Full:</strong> ${escapeHtml(data.fullTranslation)}
          </div>
        ` : ''}
        ${wordsHtml ? `
          <div class="jl-words-section">
            <strong>Words:</strong>
            ${wordsHtml}
          </div>
        ` : ''}
      </div>
      <div class="jl-tooltip-footer">
        <small>${data.words ? data.words.filter(w => !w.existsInDb).length : 0} new word(s) added to database</small>
      </div>
    `;
	}

	positionTooltip(tooltip, rect);
	document.body.appendChild(tooltip);

	// Animate in
	setTimeout(() => tooltip.classList.add('jl-show'), 10);
}

function createTooltipElement() {
	const div = document.createElement('div');
	div.className = 'japanese-learning-tooltip';
	div.id = 'jl-tooltip-' + Date.now();
	return div;
}

function positionTooltip(tooltip, rect) {
	const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
	const scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;

	// Viewport dimensions
	const viewportWidth = window.innerWidth;
	const viewportHeight = window.innerHeight;

	// Make sure tooltip is visible and in DOM to calculate size
	tooltip.style.position = 'absolute';
	tooltip.style.zIndex = '2147483647';
	tooltip.style.visibility = 'hidden';

	const needsAppend = !tooltip.parentNode;
	if (needsAppend) document.body.appendChild(tooltip);

	const tooltipRect = tooltip.getBoundingClientRect();
	const tooltipHeight = tooltipRect.height;
	const tooltipWidth = tooltipRect.width;

	const margin = 10;

	// Calculate available space
	const spaceBelow = viewportHeight - rect.bottom;
	const spaceAbove = rect.top;
	const spaceRight = viewportWidth - rect.right;
	const spaceLeft = rect.left;

	let top, left;
	let positionFound = false;

	// 1. Try Below
	if (spaceBelow >= tooltipHeight + margin) {
		top = rect.bottom + scrollTop + margin;
		left = rect.left + scrollLeft;
		// Constrain horizontal
		if (left + tooltipWidth > scrollLeft + viewportWidth) {
			left = scrollLeft + viewportWidth - tooltipWidth - margin;
		}
		if (left < scrollLeft) left = scrollLeft + margin;
		positionFound = true;
	}
	// 2. Try Above
	else if (spaceAbove >= tooltipHeight + margin) {
		top = rect.top + scrollTop - tooltipHeight - margin;
		left = rect.left + scrollLeft;
		// Constrain horizontal
		if (left + tooltipWidth > scrollLeft + viewportWidth) {
			left = scrollLeft + viewportWidth - tooltipWidth - margin;
		}
		if (left < scrollLeft) left = scrollLeft + margin;
		positionFound = true;
	}
	// 3. Try Right (Side)
	else if (spaceRight >= tooltipWidth + margin) {
		top = rect.top + scrollTop;
		left = rect.right + scrollLeft + margin;
		// Constrain vertical
		if (top + tooltipHeight > scrollTop + viewportHeight) {
			top = scrollTop + viewportHeight - tooltipHeight - margin;
		}
		if (top < scrollTop) top = scrollTop + margin;
		positionFound = true;
	}
	// 4. Try Left (Side)
	else if (spaceLeft >= tooltipWidth + margin) {
		top = rect.top + scrollTop;
		left = rect.left + scrollLeft - tooltipWidth - margin;
		// Constrain vertical
		if (top + tooltipHeight > scrollTop + viewportHeight) {
			top = scrollTop + viewportHeight - tooltipHeight - margin;
		}
		if (top < scrollTop) top = scrollTop + margin;
		positionFound = true;
	}

	// 5. Fallback: If nothing fits perfectly without overlap
	if (!positionFound) {
		// Prefer going below or above even if it requires scrolling or minor overlap?
		// Or try to place it in the largest available space?

		// Let's try to stick it to the side with the most space if vertical is tight
		if (spaceRight > spaceLeft && spaceRight > 200) { // arbitrary min width
			top = rect.top + scrollTop;
			left = rect.right + scrollLeft + margin;
		} else if (spaceLeft > 200) {
			top = rect.top + scrollTop;
			left = rect.left + scrollLeft - tooltipWidth - margin;
		} else {
			// Revert to vertical clamping logic (original fallback)
			if (spaceBelow > spaceAbove) {
				top = rect.bottom + scrollTop + margin;
				// Clamp to viewport
				top = Math.min(top, scrollTop + viewportHeight - tooltipHeight - margin);
			} else {
				top = rect.top + scrollTop - tooltipHeight - margin;
				// Clamp to viewport
				top = Math.max(scrollTop + margin, top);
			}
			left = rect.left + scrollLeft;
		}

		// Final horizontal clamp for fallback
		if (left + tooltipWidth > scrollLeft + viewportWidth) {
			left = scrollLeft + viewportWidth - tooltipWidth - margin;
		}
		if (left < scrollLeft) left = scrollLeft + margin;
	}

	// Apply final coordinates
	tooltip.style.top = top + 'px';
	tooltip.style.left = left + 'px';
	tooltip.style.visibility = 'visible';
}

function removeTooltip() {
	if (tooltip) {
		tooltip.remove();
		tooltip = null;
	}
}

function requestTranslation(text, rect) {
	// Get server URL from storage
	chrome.storage.sync.get(['serverUrl'], (result) => {
		const serverUrl = result.serverUrl || 'http://localhost:8080';

		fetch(`${serverUrl}/api/translate`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
				'Accept': 'application/json'
			},
			body: JSON.stringify({
				text: text,
				userId: null  // Can be set if user is logged in
			})
		})
			.then(response => response.json())
			.then(data => {
				showTranslationTooltip(data, rect);
			})
			.catch(error => {
				console.error('Translation error:', error);
				showTranslationTooltip({
					success: false,
					message: 'Failed to connect to server. Please check your settings.'
				}, rect);
			});
	});
}

function escapeHtml(text) {
	if (!text) return '';
	const div = document.createElement('div');
	div.textContent = text;
	return div.innerHTML;
}

// Log that content script is loaded
console.log('Japanese Learning Extension loaded');
