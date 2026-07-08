Return-Path: <linux-pwm+bounces-9632-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ozJONY8MTmr+CAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9632-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 10:38:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B707233F3
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 10:38:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KBSpgNuo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9632-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9632-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7D8630074B2
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CF4403AFE;
	Wed,  8 Jul 2026 08:38:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15E402B9E;
	Wed,  8 Jul 2026 08:38:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499908; cv=none; b=CtueDbWOUBmVcN3YoE6SA6TFL9mcL4TH82naKQhgAGxXPp2iTUtCNFp7GGpc2OxovPlVXPpv0LhKrEH7qFChr3xdQXO9sxT4qbYuzrXOw+DfRogeXYgUrVJJhTp4qDTYmQvWIf6biShdDOhRHuhiTNG9URpDoxZ+75RZlgSk6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499908; c=relaxed/simple;
	bh=Cq8lNJL29C5GdLYz//CXSgXQ+vc7ZGanEWtw6vg0Ep4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWRzyIne+7npajRbW7/5hUvb8Z4Z35xL4UzDeaUJm2NhogUav5u97lJ2FvxyIj7Ih5Z0AjuvnEa8ie0tEYtPUTKgrGnQ/MJUPuhC9ouG5VJaLpy+zOo62DmcWssDUnFB6+OFC/8HvzaMrb9FIlvhmtnFSfVQwHvwB/viTfXyHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBSpgNuo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90E21F000E9;
	Wed,  8 Jul 2026 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499902;
	bh=Cq8lNJL29C5GdLYz//CXSgXQ+vc7ZGanEWtw6vg0Ep4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KBSpgNuoOJMPkcRZuN8/ioT/PjByYiKAC0lmwLnBbpx536Szv1wEKbdkGByNM+xqM
	 sDBH2eughwXOd6Puvl5nH8IvLWo2FmLR/yaTybIQHJhviynLQg7+5WTPa2YEwkkWLt
	 fc0oXk1fpbY1SwTcXgTAeQvKYsxBNkOsHz8RxOt6jZOXgmWn6h1+apOSz1tMF2KnKu
	 eXux2RhL1acYS+Keak/Pai/IoDCWklCrdQsstFARS1vLTKL3wyFrrhEgNt3Hyx2s2x
	 RNAAsU1F6gHBw+KCcO93naTT4d9uYWm8ojfNvs9Wq6C/egtLTwtfZXhE571xcsUWNN
	 HHTxv/pPiGHfg==
Date: Wed, 8 Jul 2026 10:38:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: power: apple,pmgr-pwrstate: Add t8132
 compatible
Message-ID: <20260708-auburn-raven-of-ecstasy-2ef404@quoll>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-5-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-5-e5655ee56523@cyberchaos.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:yureka@cyberchaos.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lpieralisi@kernel.org,m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:marcan@marcan.st,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9632-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,quoll:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67B707233F3

On Sun, Jul 05, 2026 at 03:17:24PM +0200, Yureka Lilian wrote:
> The device power state management of the PMGR blocks on Apple's t8132
> SoC (M4) is compatible with the existing driver.

"... with t8103."

Drop driver references.

> Add "apple,t8132-pmgr-pwrstate" as SoC specific compatible under the
> existing "apple,t8103-pmgr-pwrstate" used by the driver.

And drop this. Driver references are discouraged, unless you actually do
something relevanto implemented ABI.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


