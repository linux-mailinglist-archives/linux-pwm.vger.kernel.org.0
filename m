Return-Path: <linux-pwm+bounces-9709-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vCdnKAUAVmrFxgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9709-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 11:23:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9754A752CDE
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 11:23:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=BhxCTw10;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9709-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9709-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF4CA301CCF5
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF943F8CC;
	Tue, 14 Jul 2026 09:22:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545643F8AE
	for <linux-pwm@vger.kernel.org>; Tue, 14 Jul 2026 09:22:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020947; cv=none; b=qMXao22+LLEA7wqDTyw5XkARynDzBkQ/NniPXxbydsCU7gsD/dg0XIMSYZe0KiNn0iJSQocny/GVQqAYr3IM8OTitDfpEEQWnhpJxMM3Kkp/mOp/3n0NBOXSWGGNbqj4+7US1vFZSfXsGIPPvjh4nckzVT1YESwpCwMg8crsETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020947; c=relaxed/simple;
	bh=uGWUfxnxIY0NKJB4tV1A7WYuOfk3qaqaeqns9woe9G0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4ZUbGX3PukMj2kIflYR2xmZqGAcHdqjqPRjgNJ+CTkSbBx20fiJNRLMdhwfFl+VmryCjQ936E0afyjYSjYnJZDj/NMeRAx1JOOqe5/RGzChLS87hXZ30d7sPogPtvw/DAT0n+aKFUP+5AFEJC4TuiyUuYUwpLNnfTX7gGdRKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BhxCTw10; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b7612475so31834545e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 14 Jul 2026 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784020940; x=1784625740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a6rmzsH2Z8JYzFqIg2uMkj0gt9jdeZsll9yf1qnb10c=;
        b=BhxCTw10pMGuJ7cWbSUGb7gGi/Cj/kbJHXgvc42Y01vMdyqMjCLZNlelC/X99G4JJp
         q1wHIDQ3tQXEozuLxJPoyo25EONtRNBnpzdUw8FgZGOKS/XisSJ5ETUWgvEkHCL+n3h2
         Mzl/YZKK9G8DkigQQpMMVYiGMS/evTk6Vn7UAxrpamUC+lCYFAOaQpImG6YCASQR3c4G
         rULR0Jk1UKH/RVvM8Sg5ToAnCnAI3XmEQ/IBMsySYN5Q2UmHcJdCkF5GEpXi/Jhu6DD9
         ezfBrQO++TlIiXUX/fWX5334IdfmpjRxNODVthDTqYfuXVDc05WQLDESOfnnNuEcOO4a
         /WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020940; x=1784625740;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a6rmzsH2Z8JYzFqIg2uMkj0gt9jdeZsll9yf1qnb10c=;
        b=mgUypCc7ooGPLlDHOqH1aAez0hwnCOkJnLH7yel35oGOFF0T4CcniLa0CoFIggP4Fx
         dW9+Wd9Tow2jT4RDQf1rcANmCKsMIiRK7Ds5qTMiVYQQ4lFbb6Dv/vvwqfqfWhynQ68M
         I6Lry2qCHgdm5dKZB4aktY2kmb70zaLL6+lby+MydILcLYDfKalIL5EtrV+AtmbRKbVH
         0EB6YSJfvXBBBF/YcS4caxXFmT4Q8zMWN/aFT7NHpbW3rJX84wwAVPn1SHX76TXWzkuT
         c12vhSoeaKvnBSbqYhTZlMOWHjfVj/YWoXAxsAXh3JPxGkFxTiDkKY3tY1wBiYSg6rsf
         L7ZA==
X-Forwarded-Encrypted: i=1; AHgh+RpHVpEj77BfrOpbgo1AVWjtdMm4CtqLMiX7SGpNFIb/RHu9mPd17XVirtfEhNuWJZeSnbuodf7ZnGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+qzUee8B6PhlmBt939A4o8mAshvCtOJhYpop2pvFHxa3+N63
	jwM5KlaNP06psIQfLEAoj1TvtNppXQEy4ZZGtV4bw1RN63LPHY9Npz2Tkz15qnJHAJs=
X-Gm-Gg: AfdE7cmgUm1bsQVBn4coza7bEWOLmhmtqcpHv5PAwD5+hXm+87+1Pg7ygoTvitET6lG
	aliDGamZoEhchmFHJsDdNL4e8njofuVu5NCj7mVxyiDc+++YOtWawXBKbTdEhE2QmxkI/UTDrBI
	mbD/ZxBxnhm207Zg/4LkEgXSXYpzV4Yp+SaUMkX1t71i4rYqpJkzsGifQ1S9XvU7A99Ji3pBhzk
	7HTermp70sRt/HAQZiFAHovOshVBGlazhHzo1l1gPls3JsbuPY03bW2EMm9IP4qcXb8A/AQleIC
	oHD95pHtRNMXv46ISvY6lRU7Fb6b2UbB9CUK+MYeIQswqGEp8oOhS7QWuj/COQPBGdDuNFqfyQs
	NiD3QGEQxQ+ogyWgANswNChrrOXrkHsfWWBBT0FmFxUsxxZFi24eU3fRRB/hqaet8IZMLDGHQiU
	XfmT2NJv5+vE4=
X-Received: by 2002:a05:600c:524b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-495159060f6mr32557165e9.24.1784020940226;
        Tue, 14 Jul 2026 02:22:20 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2dd8376sm214271875e9.2.2026.07.14.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:22:19 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 14 Jul 2026 11:25:48 +0200
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com,
	Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v6 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <alYAnJ66npeYbncs@apocalypse>
References: <cover.1783097764.git.andrea.porta@suse.com>
 <5171610d8bebdd10eea44bff5236502d765b5918.1783097764.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5171610d8bebdd10eea44bff5236502d765b5918.1783097764.git.andrea.porta@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9709-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea.porta@suse.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:sean@mess.org,m:julianbraha@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,lists.infradead.org,raspberrypi.com,suse.de,suse.com,mess.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[raspberrypi.com:email,suse.com:from_mime,suse.com:email,suse.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email,apocalypse:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9754A752CDE

Hi Uwe,

On 19:05 Fri 03 Jul     , Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> The Raspberry Pi RP1 southbridge features an embedded PWM
> controller with 4 output channels, alongside an RPM interface
> to read the fan speed on the Raspberry Pi 5.
> 
> Add the supporting driver.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/pwm/Kconfig   |   9 +
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-rp1.c | 435 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 445 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rp1.c
> 

<...snip...>

> +	.driver = {
> +		.name = "rp1-pwm",
> +		.of_match_table = rp1_pwm_of_match,
> +		.pm = pm_ptr(&rp1_pwm_pm_ops),
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(rp1_pwm_driver);
> +
> +MODULE_DESCRIPTION("RP1 PWM driver");
> +MODULE_AUTHOR("Naushir Patuck <naush@raspberrypi.com>");
> +MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.35.3
>

I didn't get any feedback after I replied to Sashiko's latest concerns, which I
don't think are relevant. Can we proceed with this patch or are there other 
concerns about it?

Many thanks,
Andrea

