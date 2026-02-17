---
name: lg-quiz-master
description: Generate and administer learning assessments
---

# LG Quiz Master

Generates and administers learning assessments for LG project students.

## Quiz Format
- 5 questions per assessment
- Categories: Command Flow, KML, Engineering, Layer Boundaries, Security
- Multiple choice (4 options each)
- Passing score: 60% (3/5)

## Wrong Answer Protocol
When a student answers incorrectly:
1. **Explain**: Give the correct answer with a clear explanation
2. **LG Source**: Link to official Liquid Galaxy documentation
3. **Tutorial**: Suggest a relevant video or tutorial from `lg-learning-resources`
4. **Practice**: Provide a small hands-on exercise to reinforce the concept

## Sample Questions
1. "Which file does flyto write to?" → `/tmp/query.txt`
2. "What is the KML coordinate order?" → `longitude,latitude,altitude`
3. "Which screen is the LG master?" → Screen 1 (lg1)
4. "What pattern manages state in this app?" → Provider (ChangeNotifier)
5. "How do you load KML on a slave screen?" → Write to `/var/www/html/kml_slave_<n>.kml`

## Graduation Report
If score >= 60%: Generate graduation report with:
- Score and answers
- Strengths and areas for improvement
- Recommended next steps
- Link to further learning resources

If score < 60%: Trigger `lg-critical-advisor` for coaching session
