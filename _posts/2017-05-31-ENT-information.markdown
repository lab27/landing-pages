---

categories: entwicklung
section: temp
title: 'Vertiefte Informationen'
date: '2017-05-30 00:20:00'
---
Wenn Sie auf dem Laufenden gehalten werden wollen zu den anstehenden Auswilderungen, unseren Pre-Release Aktivitäten oder Entwicklungen im Post-Release Monitoring, registrieren Sie sich hier mit Ihrer E-Mail Adresse. Sie bekommen dann regelmässig unsere Orang-Utan News und Mailings zugestellt.  

<div class="action-buttons text-center space-above">
    <a href="{{site.mailchimpURL}}" target="_blank">
        <button class="bos-button space-left">{% include svg_icon.html name="signup" %} <span>updates erhalten</span></button>
    </a>
</div>

### Downloads

{% for link in site.data.downloads %}
<li>
<a href="uploads/{{link.link}}" target="_blank">
{{link.name}}
</a>
</li>
{% endfor %}