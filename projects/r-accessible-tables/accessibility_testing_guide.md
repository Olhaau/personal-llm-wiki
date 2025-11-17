# Accessibility Testing Guide for R Tables

This guide provides step-by-step instructions for testing the accessibility of HTML tables using free, easily available screen readers and other accessibility tools.

## Quick Start: 5-Minute Accessibility Test

### Option 1: NVDA (Windows) - Recommended for Beginners

**NVDA** is a free, full-featured screen reader that's perfect for accessibility testing.

#### Installation:
1. **Download NVDA**: Go to [nvaccess.org](https://www.nvaccess.org/download/)
2. **Install**: Run the installer (free, no registration required)
3. **Start**: NVDA will speak immediately upon starting

#### Testing Our Tables:
1. **Open the HTML files** in any web browser (Chrome, Firefox, Edge)
2. **Start NVDA** (Ctrl + Alt + N, or from Start Menu)
3. **Navigate to the table** using these commands:

```
Essential NVDA Commands for Table Testing:
• T = Jump to next table
• Shift + T = Jump to previous table  
• Ctrl + Alt + Arrow Keys = Navigate table cells
• Insert + T = Read table title/caption
• Insert + F5 = List all tables on page
• Insert + Space = Toggle browse mode on/off
```

#### What to Listen For:
- ✅ **Good**: "Table with 18 rows and 3 columns, Demographic and Baseline Characteristics"
- ❌ **Bad**: "Table" (no description or context)

### Option 2: Browser-Based Testing (Any Platform)

Modern browsers have built-in accessibility features that don't require installation.

#### Chrome DevTools Method:
1. **Open HTML file** in Chrome
2. **Press F12** to open DevTools
3. **Go to Lighthouse tab**
4. **Click "Generate report"** and check "Accessibility"
5. **Review the accessibility score and issues**

#### Firefox Accessibility Inspector:
1. **Open HTML file** in Firefox  
2. **Press F12** → Go to **"Accessibility" tab**
3. **Enable accessibility services** (button at top)
4. **Click on table elements** to see accessibility properties
5. **Check for proper roles, labels, and structure**

### Option 3: Online Tools (No Installation Required)

#### WAVE Web Accessibility Evaluator:
1. **Go to**: [wave.webaim.org](https://wave.webaim.org/)
2. **Upload your HTML file** or paste the URL
3. **Click "WAVE this page"**
4. **Review results**: Look for errors (red), alerts (yellow), and features (green)

## Detailed Testing Protocol

### Test 1: Screen Reader Navigation Test

**Time Required**: 10 minutes per table

**What You'll Test**:
- Can users identify what the table contains?
- Can users navigate efficiently between data points?
- Are relationships between headers and data clear?

**Steps**:
1. **Start with eyes closed** (simulate blind user experience)
2. **Have screen reader announce table**
3. **Navigate through first few rows**
4. **Try to answer**: "What does this table show?" and "How many subjects are in each group?"

**Expected Results**:

| Table Version | Expected Experience |
|---------------|-------------------|
| **Original GT** | Confusing navigation, unclear data relationships, missing context |
| **Improved Accessible** | Clear table purpose, easy navigation, data relationships obvious |

### Test 2: Keyboard-Only Navigation Test

**Time Required**: 5 minutes per table

**Steps**:
1. **Close or disconnect your mouse**
2. **Use only keyboard to navigate**:
   - `Tab` = Move forward through interactive elements
   - `Shift + Tab` = Move backward  
   - `Arrow Keys` = Navigate within table (in some browsers)
   - `Enter/Space` = Activate elements

**What to Check**:
- ✅ Can you reach every part of the table?
- ✅ Is the navigation order logical?
- ✅ Can you understand the data without visual cues?

### Test 3: Visual Accessibility Test

**Time Required**: 3 minutes per table

**Steps**:
1. **Zoom to 200%** (Ctrl + Plus sign)
2. **Check if table is still readable** and doesn't require horizontal scrolling
3. **Test with high contrast mode** (Windows: Left Alt + Left Shift + Print Screen)

## Platform-Specific Instructions

### Windows Users

#### NVDA (Free, Recommended)
```bash
# Quick setup commands:
1. Download from nvaccess.org
2. Install and run
3. Open HTML file in browser
4. Press 'T' to find tables
```

**Key Commands**:
- `Insert + F7` = List all headings and landmarks
- `Insert + F5` = List all form fields and tables
- `Ctrl + Alt + Arrow` = Navigate table cells
- `Insert + T` = Read table title

#### JAWS (Trial Available)
```bash
# 40-minute demo mode available
1. Download from freedomscientific.com
2. Similar navigation to NVDA
3. Use 'T' for tables, Ctrl + Alt + Arrow for cells
```

### macOS Users

#### VoiceOver (Built-in, Free)
```bash
# Start VoiceOver:
Cmd + F5

# Table Navigation:
VO + Arrow Keys = Navigate
VO + C = Read column header  
VO + R = Read row header
VO + T = Read table statistics
```

**Testing Steps**:
1. **Start VoiceOver**: `Cmd + F5`
2. **Navigate to table**: `VO + Right Arrow`
3. **Enter table**: `VO + Shift + Down Arrow`
4. **Navigate cells**: `VO + Arrow Keys`

### Linux Users

#### Orca (Built-in on most distributions)
```bash
# Start Orca:
Super + Alt + S

# Table commands:
Alt + Shift + Arrow Keys = Navigate table
Insert + T = Table info
Ctrl + Alt + Arrow = Cell navigation
```

### Mobile Testing

#### iOS - VoiceOver
```bash
Settings → Accessibility → VoiceOver → On
# Or triple-click home button (if configured)

Table Navigation:
• Swipe right/left to move through elements  
• Three-finger swipe up/down for page navigation
• Rotor gesture (two fingers rotating) for table navigation
```

#### Android - TalkBack  
```bash
Settings → Accessibility → TalkBack → On

Table Navigation:
• Swipe right/left between elements
• Swipe up/down to change navigation granularity  
• Use explore by touch for table cells
```

## Testing Checklist

### ✅ Essential Accessibility Features to Verify

**Table Structure**:
- [ ] Table has a descriptive caption
- [ ] Column headers use `<th scope="col">`
- [ ] Row headers use `<th scope="row">`  
- [ ] Complex headers have proper scope relationships

**Screen Reader Announcements**:
- [ ] Table purpose is clear from first announcement
- [ ] Data relationships are obvious
- [ ] Navigation between cells is logical
- [ ] All abbreviations are explained

**Keyboard Navigation**:
- [ ] All table content reachable via keyboard
- [ ] Tab order is logical
- [ ] No keyboard traps
- [ ] Visual focus indicators present

**Visual Design**:
- [ ] Adequate color contrast (4.5:1 minimum)
- [ ] Text readable at 200% zoom
- [ ] No information conveyed by color alone
- [ ] Clear visual hierarchy

## Automated Testing Tools

### Quick Online Checks

1. **WAVE**: [wave.webaim.org](https://wave.webaim.org/)
   - Upload HTML file
   - Instant accessibility report
   - Color-coded issues

2. **aXe DevTools**: 
   - Install browser extension
   - Right-click → Inspect → aXe tab
   - Automated accessibility scan

3. **Lighthouse** (Built into Chrome):
   - F12 → Lighthouse → Accessibility
   - Comprehensive accessibility audit
   - Performance and best practices

### Command Line Testing

If you have Node.js installed:
```bash
# Install axe-cli
npm install -g @axe-core/cli

# Test our HTML files
axe-cli original_gt_table.html
axe-cli improved_accessible_table.html
```

## Expected Test Results

### Original GT Table Results
```
❌ NVDA Announces: "Table"
❌ Missing table caption
❌ Unclear data relationships  
❌ Complex merged cells confuse navigation
❌ No context for abbreviations
🔢 Expected Score: 25-35% accessibility
```

### Improved Accessible Table Results
```
✅ NVDA Announces: "Table, Demographic and Baseline Characteristics"
✅ Clear navigation instructions provided
✅ Data relationships obvious
✅ All headers properly labeled
✅ Alternative formats available
🔢 Expected Score: 80-95% accessibility
```

## Troubleshooting Common Issues

### Screen Reader Not Working?
```bash
# Windows:
1. Restart NVDA (Ctrl + Alt + N to quit, restart from Start menu)
2. Check audio output device
3. Try different browser

# macOS:
1. System Preferences → Security & Privacy → Privacy → Accessibility
2. Ensure browser has permission
3. Restart VoiceOver (Cmd + F5 twice)

# Linux:
1. Check if Orca service is running: systemctl --user status orca
2. Restart accessibility services
```

### Table Navigation Not Working?
- **Switch to browse/document mode** (Insert + Space in NVDA)
- **Try different navigation methods** (Tab vs Arrow keys)
- **Check if JavaScript is enabled** (some table features require it)

## Creating Your Own Test Script

Save this as `test_accessibility.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Accessibility Test</title>
</head>
<body>
    <h1>Test Instructions</h1>
    <ol>
        <li>Start your screen reader</li>
        <li>Navigate to the table below</li>
        <li>Try to answer: What does this table show?</li>
        <li>Navigate through several data cells</li>
        <li>Rate the experience 1-10</li>
    </ol>
    
    <!-- Your table HTML here -->
    
    <h2>Questions to Ask:</h2>
    <ul>
        <li>Could I understand this data without seeing it?</li>
        <li>Was navigation intuitive and efficient?</li>
        <li>Were all abbreviations and terms clear?</li>
        <li>Could I easily find specific information?</li>
    </ul>
</body>
</html>
```

## Best Practices for Regular Testing

### Development Workflow
1. **Test early and often** - Don't wait until the end
2. **Use multiple tools** - Screen readers + automated tools
3. **Test on different platforms** - Windows, Mac, mobile
4. **Include real users** - Nothing beats actual user feedback

### Quick Daily Checks
```bash
# 2-minute accessibility check:
1. Tab through your table - does it make sense?
2. Use browser zoom to 200% - still readable?
3. Right-click → Inspect → Lighthouse → Accessibility
4. Fix any red errors immediately
```

## Resources for Further Learning

### Free Training
- **WebAIM Screen Reader Testing**: [webaim.org/articles/screenreader_testing](https://webaim.org/articles/screenreader_testing/)
- **NVDA User Guide**: [nvaccess.org/documentation](https://www.nvaccess.org/documentation/)
- **W3C Accessibility Guidelines**: [w3.org/WAI/WCAG21/quickref](https://www.w3.org/WAI/WCAG21/quickref/)

### Professional Tools
- **JAWS**: Industry standard, expensive but comprehensive
- **Dragon NaturallySpeaking**: Voice control testing
- **ZoomText**: Vision enhancement testing

## Conclusion

Accessibility testing doesn't have to be complex or expensive. With free tools like NVDA and browser dev tools, you can quickly identify and fix most accessibility issues. The key is to **test regularly**, **listen to your content**, and **put yourself in the shoes of users with different abilities**.

Start with the 5-minute NVDA test, and gradually expand your testing as you become more comfortable with the tools. Remember: if your content is difficult to navigate with a screen reader, it's probably difficult for everyone to use effectively.