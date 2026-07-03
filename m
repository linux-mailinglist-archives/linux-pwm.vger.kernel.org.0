Return-Path: <linux-pwm+bounces-9536-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pijXOnvOR2pffgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9536-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 17:00:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85E703AB7
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 17:00:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=I9uEped4;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9536-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9536-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A1A3309C76A
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30492367D3;
	Fri,  3 Jul 2026 14:53:21 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A92222590
	for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2026 14:53:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090401; cv=none; b=h5np9OpyYVwJuGqD6h19jD0MfF3QQRkV1SIXiY0MeQhk4a/pWxJq5nt/VnlYZ9qNAdSObXOkpgPIp8sc93V4JYoK9s3IhAzMBfDScXMAjLfkm8Fmb252iT03lK9aOhVKTDCMCX71hYJW5TaiR8PLcJtLj0quigK5c1vxzz1ERSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090401; c=relaxed/simple;
	bh=dr4BeQSiZnpR1IwzMb3FXywWpykA6u0hAgioLbsXY/g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giXt80o6eJawARDGHyEkE3cWSBvOkYy9pJalSer5eiTuMbjsNacgM0H1oXVZouJ/XAXOgtUVQMEB9UdWDUV4TKPQ8F1T5EObPpfbzjg2PklDjWqjboMDq8V4hK5hhoSi48wWdE75z8JcFNHmd06KDaPE2NK0nWyI1oA+TpMUFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I9uEped4; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b77b150aso5317235e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jul 2026 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783090398; x=1783695198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QB59yWoF1xJrXodhOCNsO8AMkW1gWMSY+FjvASquQ6Q=;
        b=I9uEped4GFKy/QJq6J3kzsqIarOXaMA6P7VdfvzDAsdY57C630g6SbvpY3F4cT4Uha
         Y5DJPK7cjAyGqIgAuO30NpvSmeL+ZEOgoqMmlmLSoza5Z8S5khOktJP/NHT5I+PBFD0F
         VrCZOMZJdHmCyZlOejTueT/xvXcjfyJwmq1FNgmSxlzndMtTuvaSp3NTrBzSKkSdLC8B
         lW7TJgOXKqOSjTfh75PoIAjtU7OAWP3llBfxH9P27Iz9UTL2N4HNGaaiVmby46wZX0k+
         YI186HHOA0qV6tcOpPOJA88Hfk5lCmGaL2qBeW/sCpDFr03QVsr6PdT77lDS7NnHPNya
         0vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783090398; x=1783695198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QB59yWoF1xJrXodhOCNsO8AMkW1gWMSY+FjvASquQ6Q=;
        b=ae6I26WxqDSPGQb2QsixVAdQThepaEcTuvtfuSgPwAwF7ECxQhv43lFqClQT8DYUjN
         UGmlDmR6eKWAfCmdBJS4z6b6oczFmyLUy9qrsbLvAJdAACeyh8Z3V0BV8S7JDCr+ZSKJ
         lKyU0+TyGtEAWlWOvq0qiP6Q46h3lYhbQkqcE5Jlp3bCMcdrDxHGrZ/XvsbLZAu5MJbq
         Sn+ihiWzKakodOYiZ5lrVnHDIkaSovSijqjQipU59Bl3+e4lD/1znw7eIjqQJdV6N5N0
         hcwmwd9Zf3ZRdKyhbOfpD+xB0eIuC+ObdcxF9I1UCjwxvgO016O9u7U1YcjB3AVGNGIz
         FpDw==
X-Forwarded-Encrypted: i=1; AFNElJ+03qiaxrrvDeTBMltv/TvDJ3nkfS//gQcA0fvCR63dm5m6ORqMQYAr3wSICm34+vgdLNIjraUF5xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySvXgAk1pNopHZosynxE9FJbrXGND3JUjA7RpAYXcutT5uh9w+
	U165JE/2sBFkoMeIMFncbYv+gafzkm7E+MRTX987yRSrzf6aRp7zyzqLnXLq9iab5Fc=
X-Gm-Gg: AfdE7ckAbGWQ4OvBwOiSHf5fQe3WXZI0ENCO7eLdGySNqvEWL5rZkRinnVLtYCntS8Q
	bfPrtLG/AQSNaZtW/DSVnWYiKRfLHYIu2GXhqYNE5ataKZxtjLklcYepf4rdr30mao4AqJWZ9h5
	CHqoopR/EEJRaz3H8Ofvw6GY1DqzRSks6IaeK7/x3wv5ydoJeqfCg2EXMOGYhkcKhVEQCMcme0B
	1bLp7C3/qa4re9WeVmTmq5n0yNnH0F3soXNENXJb1x97zJR+Cp1XBfLEokZNAvHjif3NMg3g7OZ
	Kz2xk1Q2hG07ayEz+OxE/nlmmpusQ65tjfCRCUjgsctv+pmH+dXc11JgRsU9YWh7h5QxHuSppqv
	Dc4kkKYNqxJ3K7ZQ5b9Iq0ECZIfGibUSersF5HYio7SDGehZcUQITIpszUKHMR7lbcx+VMWPY7C
	Br/BbpRu4pW5c=
X-Received: by 2002:a05:600c:1988:b0:490:e19b:bd99 with SMTP id 5b1f17b1804b1-493d0f43052mr2171635e9.30.1783090398625;
        Fri, 03 Jul 2026 07:53:18 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a44d7sm17320171f8f.9.2026.07.03.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:53:18 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 3 Jul 2026 16:56:44 +0200
To: Julian Braha <julianbraha@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <akfNrGoa0bitVSu9@apocalypse>
References: <cover.1780670224.git.andrea.porta@suse.com>
 <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
 <0b6a7f41-b753-48dc-b46e-77aaf0e999f4@gmail.com>
 <ai-dNlC1_nbQTy5Z@monoceros>
 <6babbdea-fa93-4cd7-8198-5cd3accc34cc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6babbdea-fa93-4cd7-8198-5cd3accc34cc@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9536-lists,linux-pwm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:julianbraha@gmail.com,m:ukleinek@kernel.org,m:andrea.porta@suse.com,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:from_mime,suse.com:dkim,apocalypse:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A85E703AB7

Hi Julian,

On 11:29 Mon 15 Jun     , Julian Braha wrote:
> Hi Uwe,
> 
> On 6/15/26 07:37, Uwe Kleine-König wrote:
> > IMHO selecting REGMAP_MMIO explicitly here is fine because at least to
> > me it's not obvious that MFD_SYSCON enforces REGMAP_MMIO.
> 
> I think it's better to use comments to document non-obvious behavior,
> rather than dead code.
> E.g.:
> 'select MFD_SYSCON # selects REGMAP_MMIO'
> 
> But I guess this is not really worth bikeshedding over.

Honestly I don't have a strong opinion on that, but documenting is basically
the same than just selecting the option (well with the addition of the #), so
not really a difference. If there's no major concern about that I also wouuld
prefer to expicitly declare teh selecion of REGMAP_MMIO. 

Many thanks,
Andrea

> 
> - Julian Braha

