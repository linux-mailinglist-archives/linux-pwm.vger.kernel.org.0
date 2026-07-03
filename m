Return-Path: <linux-pwm+bounces-9544-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Prz+EfjmR2plhQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9544-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 18:44:40 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C4770460F
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 18:44:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ggyc7vlG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9544-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9544-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC19530207EE
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB34D301486;
	Fri,  3 Jul 2026 16:38:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B830674D
	for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2026 16:38:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096739; cv=none; b=tsB20+LquF2klbYPF951xp7lkwXpnYr+9DV9p2lgL/5Sgov7KiGvc/CMU6Jvos0dfUtyIkebbihV8UpHiiyZ1K+8YUtiQztZNGdDS3gDYy0Z1pqsEzYnd5ngbExxBwWRXQXAO9H/CdmHKRWLPqc7S1XC22M9rfvInqLd63YHolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096739; c=relaxed/simple;
	bh=nrFUeTISsssZEEKhYbH1QGl9yO+vtAmYijszoSwDM+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaPRWZmvhTxwiJ0rPynGve8riY/WutyUNipK9j35RG+CgO8r2aaDdzaMj1/1a6LtXQn1Xnv8xia6BC4zoggeZollfVri3hF2vgStDcfYMUNyROLX2r2bFF/qTYDOfffJStudF9u0NU96Bg9BlSNsfitoxKXNU4+2nUz1gi+6biE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggyc7vlG; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so6668475e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jul 2026 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783096737; x=1783701537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Dq50xUh9vnokWwn/2MgFrw6Bt3+wGtcUaeVmHV+z9uw=;
        b=Ggyc7vlGYIbSvGqthNUShze+DJZAsTFUaDbHlq36g348Cdb5niXyXxp+sUWKHgjZWW
         eAktUxb/FEeX2zjqolnvhIFfjnsSUM6IF+vE0DeFqf2e2MklvJ8S24i3B6z6IMQ+ZY57
         9fHaoxM8umqHAHCrQ/dL+d7M3gZqPtFvsf6FWe0+LEzGlVDNpXdJsP7zlzGMXwogqbPm
         6El1qBPJ5EOA+2SusUKKkFY+eO2ZuhsElxh+wP4lOQu4/Rqad1xhZUlR1/P9B07S/iw0
         dos78O+MNfgcRplb6Pal03bPOllpnhKNakd0DUCNuEPonPvHYJHLGjmZ25GfyhNZJvfH
         9QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783096737; x=1783701537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq50xUh9vnokWwn/2MgFrw6Bt3+wGtcUaeVmHV+z9uw=;
        b=Sdy6bL0Uvtnem3JJYh5e95LScwK7RanmFtDeVd7FxQP6ElfR8p9s2kI2RujX79fDIo
         a4E8UuL16u2s7aiIiTs4/jaIvzMp269xnJol7E0CQR0eRPbzcnn9ISy05QePiPE9X0mJ
         +UIlq8pTc+fBgJX7IYtNJ637N9MYPe7pZIc5WWXO/W90z50InGdzl/NjsQhKeC3rUF9R
         ZeBdIxgiIyyDvsKSB1+Y4VVx9snmcJqpYVKOrjiXLj/MSIsaml0x4lhs0Q09dqhOC7xi
         Y/DfAx9VHfctb+UxoTn1YwVJiYEr3GUTmxwwtRc5Gma5QmYz2GdMw8UieMRodIBpGCag
         nu/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/qfKscJ1F575Gjk1XT6CSOnmzo2CFvr+B1Fd7Qq6zyAw7JjdQHUj0pKXLeHsd2iVY8V6Qpd7QT8hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xp4lzgRaDqf/8WtnCC+vuNjg88fq9fVZKUWdlX6jde+Zr6+r
	uUzAV0SI0j4wvz6yALb/jT3j9C0BPo520/cqO/JRwJ8u2combheovUN/
X-Gm-Gg: AfdE7cl7FP3Hq1ZgczHjjEnOZqEfNA9sRz0G0Oq7BhDMPzRGfU0YPVR+ZD9IFhu8Qul
	CePtMKRQSRcl3xkE7lOCbfHfu1IdTk1+ez9Iuy72T8ufT/cavIeuqfRSoGv9PdH9gredTuOTj/W
	SYKYnhjfuNa8hAj/5ZoLkXZirSvNSVYEC29+UHuQIBJASpRiJzs34z9xBDXl5e0LT0lsO07TQeo
	oTMJfSIwJ8GZsXQx0MkXXuSsJyM+bjA3lo6AwaMKJQRokVWao9xJb21444mrNuJByScNusQnaqZ
	s/VvSuCtnw2ZyDmWks42uR8ScJR1lrtZdOSUU35/rNg464Xa1Zqis3SsXqIGL3NkEknei5rN2Vq
	qPyaCYS0nbZCOpj+S30IQugJAmg+6X6qOqRfV5tXC+08b8axvhrdb20TeX2zdWSlmpDe5EE68dx
	mDVq4dWEyb+xnsWlD8ovwLk/dDvNOd4V53OztYx/DIGvs2ELMSyhS+18623ST+esqjdNl2jHBGI
	t8hriJl
X-Received: by 2002:a05:600c:8105:b0:493:aaa2:f034 with SMTP id 5b1f17b1804b1-493d11f6cfamr400035e9.26.1783096736053;
        Fri, 03 Jul 2026 09:38:56 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm82259395e9.10.2026.07.03.09.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 09:38:55 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <c4c658e5-9c67-4e19-aeab-39d98aa71f45@gmail.com>
Date: Fri, 3 Jul 2026 17:38:53 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
To: Andrea della Porta <andrea.porta@suse.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
References: <cover.1780670224.git.andrea.porta@suse.com>
 <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
 <0b6a7f41-b753-48dc-b46e-77aaf0e999f4@gmail.com> <ai-dNlC1_nbQTy5Z@monoceros>
 <6babbdea-fa93-4cd7-8198-5cd3accc34cc@gmail.com>
 <akfNrGoa0bitVSu9@apocalypse>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <akfNrGoa0bitVSu9@apocalypse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9544-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrea.porta@suse.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7C4770460F

Hi Andrea,

On 7/3/26 15:56, Andrea della Porta wrote:
> Honestly I don't have a strong opinion on that, but documenting is basically
> the same than just selecting the option (well with the addition of the #), so
> not really a difference. If there's no major concern about that I also wouuld
> prefer to expicitly declare teh selecion of REGMAP_MMIO. 

My preference seems to be unpopular, so I've adjusted my reviews.

- Julian Braha

