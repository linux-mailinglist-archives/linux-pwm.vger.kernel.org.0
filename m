Return-Path: <linux-pwm+bounces-9641-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SMa4KSFaTmqSLAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9641-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 16:09:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5F727207
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 16:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mkgCQ1Cm;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9641-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9641-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2590030CEE41
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368C44D00D;
	Wed,  8 Jul 2026 14:00:21 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8040B6E3
	for <linux-pwm@vger.kernel.org>; Wed,  8 Jul 2026 14:00:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519221; cv=none; b=tKSbCCI0115BXeka+L/Yxegi9GNgGq649sErA52CWMbvlA0VlAbrQSKHfBZ/6A5sc99uo2LuPMaafCOIWl+ZCh5dLwmS14c7sVm6RwVmp3NCrCph0Va6fDME6pNooVFoBfczCMRj7M1BcUu6qfQmCAO3PJE9echyW8/HpTM2u+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519221; c=relaxed/simple;
	bh=+v9vy7krakGFeXF6TzAUAnw0/rePpUUz3AXWVtluiys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9BJNeCwaqmlP2QKKezVlezUFlCqk24H+WHS4TF+zufAzqP8PHEw2gnAy5xY2pVNs8oe1xZh9iP04xe4uqwIstyWCWaJbdMd9tZbYeciaMuSwTb0O55qzRBg3uBq/5Bwm3f6Yq2P8+aTZmP6eLbjESSDMsP6i4Tgj1wqlYvq74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkgCQ1Cm; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b9d265355so737651a91.2
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jul 2026 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783519219; x=1784124019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MXKeSE96P/DSTkSX0hfZLI8OogkntC/gTUwapWrQ2Q8=;
        b=mkgCQ1CmdnIweyRa4WhpzMCueBmIKRUM6wi1Isnd1iWqA1FPSnSJg54FDGYWG6Z4iy
         HDlpifybzxvrVq687Fjz3r3RSoRFePAxf3Gx0zTNDLbrfZcorj1kug5UH68tOWnspxUT
         gR/0B6cZDpiJ6s70n7Kvy6XyaWH95+svuBhugOEdxmt6WxHReE/XSTzjOMy7qxGTY0FV
         9HHuS95GEE4IGTmO3jgkw+oq5ngFjc80PA5jyiLbKivWL+1UjspBLSX6WAThfchxLdqI
         6qqE0n+hN9B9i2RpRne24V2WwpfZJrTnVUQVFF41/L+9n7Aqw+GcSSg6SHa4WyR6pQdH
         Ltag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519219; x=1784124019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXKeSE96P/DSTkSX0hfZLI8OogkntC/gTUwapWrQ2Q8=;
        b=ScMLkafFrdvHA0ZtcBonO8Tr5Ezlc8mI2LJ5j763n8KDifEdMkDLv2qejA/J51TPk6
         58Yh1Ld7CfsHRmK/LZSaucD5baXaNPsPX1ObMbW78Kv6yzRMjt+MMtic+QqZnm1GYBL4
         jQ8dS70upJffbQHlwn5caAVSjb0S6MCKOO+Bg1YwXk3w0EakxJoM1j0rQuKmEhKtO+x5
         GrWU7vJX98RjhxGV3P2FcukwN++IroV5aZsWqvh8L0m5M/nwLE3JcXZDpQ73j8PeJfnV
         7UEKMjeUdZAlxczswMPFxVEbanjJwsUjNz3BPLXxCPgeEAfVl6u/bwKzcz+DG5JXS04F
         aPCg==
X-Forwarded-Encrypted: i=1; AHgh+RoZJ3golikYa1ZBUX7OvO6ghlH85Jgw+kei9l6sGPa9ThwM456n02X3AvrQonDo8zbMdwLosVIeXS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVgIQp+3CgwMVXDgCwVGds7LVzaAd6+OwKQgeqTzxVw1hUeQc
	odMyPZkInTRdZkmmIMpTy/wdwO6YbCPjWqhCLLIC7/R8sOp0DPGGfFkh
X-Gm-Gg: AfdE7clrlMG6+8Or5FAYqoxaALF8rrU3Q28gKBHRji3TU2H73f2U/bI5SjgF/4af8kz
	J4eKQ6Z2HRNnm3B8AhujghLLY1rXCDFXngU6DpCmqhdlaIjI8LHNrb713Onlka7BJZ5WPqH/2W3
	wVERwR5SKiUGv74iFX3w4OqT5clabAtJ6WOd7wOQL2ldqVPnyAPOteoVFV8XFe9yNGpnh9KQoS3
	aIggiaiaelPPdPnaLMOyafFHvrTkyhaW9Rw2X4PaMeirsSouFS0zwWHfNwUunZmlKIjZA/xvDkJ
	oQpCZX6fLM7Lng16OWJ+8bAbgljKvAdUtYLK8AdMuEQt9xmDFC7YETrZbcbRXr/xFkcnW9y70u5
	j+xztZs/jRZwLShWsTu1uG5xBNEFWGmVelUw9GjcoN9pxWv/RzDiqCBZzE3ldAVqvV5lYA4ASWL
	x3lfrSsG8BRdYWwZy9xqpA2XEzFA==
X-Received: by 2002:a17:90b:3512:b0:37f:ec5e:12d9 with SMTP id 98e67ed59e1d1-3894034404bmr2572315a91.16.1783519218978;
        Wed, 08 Jul 2026 07:00:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-388fdc9a066sm569937a91.1.2026.07.08.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:00:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:00:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: watchdog: apple,wdt: Add t8132
 compatible
Message-ID: <a03c19ee-cf74-4f26-826d-f2bfb816fb3f@roeck-us.net>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-3-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-3-e5655ee56523@cyberchaos.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9641-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yureka@cyberchaos.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lpieralisi@kernel.org,m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:marcan@marcan.st,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linux@roeck-us.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14F5F727207

On Sun, Jul 05, 2026 at 03:17:22PM +0200, Yureka Lilian wrote:
> The watchdog on the Apple silicon t8132 (M4) SoC is compatible with the
> existing driver. Add "apple,t8132-wdt" as SoC specific compatible under
> "apple,t8103-wdt" used by the driver.
> 
> The M4 wdt block additionally has a secondary watchdog, which is
> disabled by m1n1 and can safely be ignored by Linux.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter

