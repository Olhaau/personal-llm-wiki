# Simple Accessibility Testing Guide for R Tables

This guide shows you exactly how to test the accessibility of our GT tables using free, easy-to-install screen readers. No technical experience required!

## 🚀 Quick Start: 10-Minute Test

### Best Option: NVDA Screen Reader (Windows)

**Why NVDA**: Free, full-featured, and perfect for testing. Used by millions of blind users worldwide.

#### Step 1: Install NVDA (5 minutes)
1. **Go to**: [nvaccess.org/download](https://www.nvaccess.org/download/)
2. **Click**: "Download" button (it's completely free, no registration)
3. **Run**: The downloaded installer
4. **Follow**: Installation wizard (just click "Next" through everything)
5. **NVDA will start talking immediately** - this is normal!

#### Step 2: Test Our Tables (5 minutes)

**Open both HTML files**:
- `original_gt_table.html` 
- `improved_accessible_table.html`

**Basic NVDA Commands** (just these 4):
```
T = Find next table
Ctrl + Alt + Arrow Keys = Move around table cells
Insert + T = Read table title
Escape = Stop reading
```

**Testing Script**:
1. **Open first table** in your browser
2. **Press T** - NVDA will find the table
3. **Listen to what NVDA announces**
4. **Use Ctrl + Alt + Arrow keys** to move around
5. **Ask yourself**: "Could I understand this data if I couldn't see it?"

#### What You'll Hear

**Original GT Table (Bad Example)**:
```
NVDA Says: "Table"
❌ No description of what the table contains
❌ Confusing navigation between cells
❌ Unclear what "41.2 (6.14)" means
❌ Can't tell which treatment group you're in
```

**Improved Accessible Table (Good Example)**:
```
NVDA Says: "Table, Demographic and Baseline Characteristics"
✅ Clear description of table purpose
✅ Easy navigation with obvious relationships
✅ Explains that "41.2 (6.14)" is "Mean (Standard Deviation)"
✅ Always know which treatment group you're looking at
```

## 🖥️ Alternative Options (If You Can't Use NVDA)

### Option 1: Chrome Browser (Any Platform)

**Built-in accessibility testing** - no downloads required!

#### Steps:
1. **Open table HTML file** in Chrome
2. **Press F12** (opens Developer Tools)
3. **Click "Lighthouse" tab**
4. **Check "Accessibility" box**
5. **Click "Generate report"**

**You'll get**:
- Accessibility score (0-100)
- List of specific problems
- Suggestions for fixes

**Expected Results**:
- Original table: ~25/100 score
- Improved table: ~85/100 score

### Option 2: macOS VoiceOver (Built-in, Free)

#### Quick Setup:
```
Cmd + F5 = Turn on VoiceOver
Cmd + F5 again = Turn off VoiceOver
```

#### Navigation:
```
VO + Right Arrow = Move to next item
VO + Shift + Down Arrow = Enter table
VO + Arrow Keys = Navigate table cells
VO + T = Read table statistics
```

**Testing Steps**:
1. **Open HTML file** in Safari or Chrome
2. **Start VoiceOver**: `Cmd + F5`
3. **Navigate to table**: `VO + Right Arrow`
4. **Enter table**: `VO + Shift + Down Arrow`
5. **Listen and navigate**

### Option 3: Online Testing (No Installation)

#### WAVE Web Accessibility Evaluator
1. **Go to**: [wave.webaim.org](https://wave.webaim.org/)
2. **Click "Browse" and select your HTML file**
3. **Click "WAVE this page!"**
4. **Review the visual report**

**Color-coded results**:
- 🔴 Red icons = Serious errors
- 🟡 Yellow icons = Warnings  
- 🟢 Green icons = Good features

## 📝 Simple Test Script

### Test 1: The "Blind Navigation" Test (5 minutes)

**Goal**: Can someone understand the table without seeing it?

**Steps**:
1. **Close your eyes** (seriously!)
2. **Start screen reader** 
3. **Navigate to table**
4. **Try to answer these questions**:
   - What does this table show?
   - How many people are in each group?
   - What's the average age in the placebo group?
   - Are there more men or women in the study?

**Expected Results**:

| Question | Original Table | Improved Table |
|----------|---------------|----------------|
| What does this table show? | ❌ Unclear | ✅ "Demographic characteristics" |
| How many in each group? | ❌ Hard to find | ✅ "N=90" clearly stated |
| Average age in placebo? | ❌ Confusing format | ✅ "41.2 (6.14)" explained |
| More men or women? | ❌ Must calculate | ✅ Easy to compare numbers |

### Test 2: The "Keyboard Only" Test (3 minutes)

**Goal**: Can someone navigate without a mouse?

**Steps**:
1. **Hide your mouse** (put it in a drawer)
2. **Use only keyboard**:
   - `Tab` = Move forward
   - `Shift + Tab` = Move backward
   - `Arrow Keys` = Navigate within tables
3. **Try to reach all data**

**Pass/Fail Criteria**:
- ✅ Can reach every number in the table
- ✅ Navigation order makes sense
- ✅ Don't get "trapped" anywhere
- ✅ Can tell what each number represents

### Test 3: The "Zoom Test" (2 minutes)

**Goal**: Is the table readable for people with low vision?

**Steps**:
1. **Open HTML file in browser**
2. **Zoom to 200%** (Ctrl + Plus sign)
3. **Check if**:
   - Text is still readable
   - No horizontal scrolling needed
   - All information still visible

## 🎯 Specific Tests for Our Tables

### Testing the Original GT Table

**Open**: `original_gt_table.html`

**NVDA Test Checklist**:
- [ ] Press `T` - Does NVDA say what the table is about?
- [ ] Navigate cells - Are relationships clear?
- [ ] Find age data - Can you tell it's "Mean (SD)"?
- [ ] Compare groups - Easy to switch between Placebo and Drug 1?

**Expected Experience**: Confusing, lots of "unknown" labels

### Testing the Improved Accessible Table

**Open**: `improved_accessible_table.html`

**NVDA Test Checklist**:
- [ ] Press `T` - Clear table description?
- [ ] Navigate cells - Obvious what each number means?
- [ ] Find age data - Clearly labeled as "Mean (Standard Deviation)"?
- [ ] Compare groups - Easy to understand treatment differences?

**Expected Experience**: Clear, logical, easy to understand

## 📊 Quick Comparison Test

### Side-by-Side Testing (10 minutes)

**Setup**: Open both HTML files in separate browser tabs

**Test Protocol**:
1. **Start with original table**
2. **Navigate for 2 minutes**, note frustrations
3. **Switch to improved table**  
4. **Navigate for 2 minutes**, note improvements
5. **Compare your experience**

**Scoring**:
Rate each table 1-10 on:
- **Clarity**: Could you understand the data?
- **Navigation**: Was moving around easy?
- **Context**: Did you always know where you were?
- **Completeness**: Could you find all information?

**Expected Scores**:
- Original Table: 2-3/10 average
- Improved Table: 8-9/10 average

## 🛠️ Troubleshooting

### Screen Reader Not Working?

**NVDA Issues**:
```bash
# Try these fixes:
1. Restart NVDA (Ctrl + Alt + N, then restart)
2. Check volume/audio settings
3. Try different browser (Chrome vs Firefox)
4. Restart computer if all else fails
```

**VoiceOver Issues (Mac)**:
```bash
# Try these fixes:
1. System Preferences → Security & Privacy → Accessibility
2. Make sure browser has permission
3. Turn VoiceOver off/on (Cmd + F5 twice)
```

### Can't Find Tables?

**If screen reader can't find tables**:
1. **Make sure HTML file is fully loaded**
2. **Try refreshing the page**
3. **Use manual navigation** (Tab key to move through page)
4. **Check file opened correctly** (should see table visually)

### Navigation Feels Broken?

**Common fixes**:
1. **Switch to browse mode** (Insert + Space in NVDA)
2. **Use different navigation** (Tab vs Arrow keys)
3. **Try table mode** (some screen readers have special table mode)

## 📋 Testing Results Template

### Test Results Sheet

**Date**: ___________  
**Tester**: ___________  
**Screen Reader Used**: ___________

#### Original GT Table
- **First Impression** (What NVDA announced): ___________
- **Clarity** (1-10): ___________
- **Navigation Ease** (1-10): ___________
- **Biggest Problem**: ___________

#### Improved Accessible Table
- **First Impression** (What NVDA announced): ___________
- **Clarity** (1-10): ___________
- **Navigation Ease** (1-10): ___________
- **Best Feature**: ___________

#### Overall Comparison
- **Which table would you prefer as a blind user?**: ___________
- **Main improvement needed**: ___________
- **Would you recommend the accessible version?** Yes/No: ___________

## 🎓 What Good Accessibility Sounds Like

### NVDA Announcements for Good Tables

**When you press 'T' to find table**:
```
✅ Good: "Table with 20 rows and 3 columns, 
         Demographic and Baseline Characteristics, 
         Comparing Placebo and Drug 1 groups"

❌ Bad: "Table"
```

**When navigating to data cell**:
```
✅ Good: "Placebo Group N=90, Age Years, Mean Standard Deviation, 41.2 6.14"

❌ Bad: "41.2 (6.14)"
```

**When moving between columns**:
```
✅ Good: "Drug 1 Group N=90, same row"

❌ Bad: [no context about which group]
```

## 🔧 Creating Your Own Test

### Mini Test Script

Save this HTML to test any table:

```html
<!DOCTYPE html>
<html>
<head><title>Accessibility Test</title></head>
<body>
<h1>Screen Reader Test Instructions</h1>
<ol>
    <li>Start screen reader (NVDA, VoiceOver, etc.)</li>
    <li>Press 'T' to find table</li>
    <li>Listen to announcement</li>
    <li>Navigate 3-4 cells</li>
    <li>Rate experience 1-10</li>
</ol>

<!-- Insert your table HTML here -->

<h2>Questions to Answer:</h2>
<ul>
    <li>What is this table about?</li>
    <li>How many groups/columns?</li>
    <li>Can you find specific data points?</li>
    <li>Is navigation logical?</li>
</ul>
</body>
</html>
```

## 🏆 Success Criteria

### Your table passes if:
- ✅ **Screen reader announces table purpose immediately**
- ✅ **Navigation between cells is logical and obvious**
- ✅ **All data has clear context** (no mystery numbers)
- ✅ **User always knows which group/category they're in**
- ✅ **Abbreviations and terms are explained**
- ✅ **Alternative formats are available** (like our CSV file)

### Red flags (fix immediately):
- ❌ Screen reader just says "table" with no description
- ❌ Data cells have no context ("41.2" means what?)
- ❌ Can't tell which column/row you're in
- ❌ Navigation jumps around randomly
- ❌ Complex merged cells confuse the structure

## 📞 Getting Help

If you run into issues:

1. **NVDA Help**: [nvaccess.org/documentation](https://www.nvaccess.org/documentation/)
2. **WebAIM Testing Guide**: [webaim.org/articles/screenreader_testing](https://webaim.org/articles/screenreader_testing/)
3. **Browser Accessibility**: Search "[your browser] accessibility testing"

Remember: If it's hard for the screen reader, it's hard for real users too!

---

**🎯 Bottom Line**: The improved table should feel like having a knowledgeable person describing the data to you, while the original table should feel confusing and frustrating. That's the difference good accessibility makes!