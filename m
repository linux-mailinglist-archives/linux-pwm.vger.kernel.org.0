Return-Path: <linux-pwm+bounces-9630-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qemXFgUMTmrYCAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9630-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 10:36:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86772338C
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 10:36:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dULGxStm;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9630-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9630-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6431F301DC66
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB4401A01;
	Wed,  8 Jul 2026 08:36:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874F211466;
	Wed,  8 Jul 2026 08:36:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499763; cv=none; b=c9j8iNoKy4+bGe5WTO6CcUmIStakyGx8rYJUEG09ZAH8oL7lM4d63elyHSd3mY34s4UbdVYAPkAtitFlLWzp010gmQhP+CfQbVMIwi2KZG2QcmcExKBaVOuC8YHJwq2SCVyFKxbSAHHEvy0ELkDUSmZJyTfFBSILdX8m2hXAKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499763; c=relaxed/simple;
	bh=U8ZcH0qJIFMg/BCv8PRJhEiJwJvtFZC39GY4PAZiVTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGPPRcIb859f7ScoVzp61XgRFe0Cn64ue12GlDlqe66IKiFQRj/lCl4h+Zgr0k8gkAHvE2yTa+YJPsMyUDaBSKVLy3/q6uAbnqpX23qynQVBA7R6hopQXrr3jnq1Grw2dPAFTzLoytV7aYzB2SQ3MhLWzv17179vIofLh4RG/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dULGxStm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5861F000E9;
	Wed,  8 Jul 2026 08:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499762;
	bh=doZQ4pWnfDyC3thHlDpyTXoQ6k8NN+OO+hsnXI6DNRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dULGxStmJuZJVIila+KMloT/qdFmC9dLntSYV06uVoeCaVuQLex3j2+3xBuUE0hbX
	 ruAyc5cwvLJkSdRXGOnYqf8ttMRm0qxCAt4joE69hp7oVjO0cNtr8OcH8UhHLZXtRT
	 CgkQW6DxAjhp7kLfXvjdOmMZ7xbVMr7sl2TB0Z6Q+7swppIvdSjJSvCVrPfKYVWp7v
	 zCjYlEbQjchFflZwhpY2bBhNeGCccA8PYdiUskQmIVXD54ztyidUs01knDj6y+FO2W
	 aFiWSuwYoKz1gA2PQ219br+BTIi/Hg/PgaS61jqlil1oOyx5KNIN7fvCTOwyjvoLCi
	 5aL0ctTVNmnLQ==
Date: Wed, 8 Jul 2026 10:35:57 +0200
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
Subject: Re: [PATCH 03/10] dt-bindings: watchdog: apple,wdt: Add t8132
 compatible
Message-ID: <20260708-axiomatic-dashing-tapir-98bcac@quoll>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-3-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-3-e5655ee56523@cyberchaos.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-9630-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,cyberchaos.dev:email,vger.kernel.org:from_smtp,quoll:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC86772338C

On Sun, Jul 05, 2026 at 03:17:22PM +0200, Yureka Lilian wrote:
> The watchdog on the Apple silicon t8132 (M4) SoC is compatible with the
> existing driver. Add "apple,t8132-wdt" as SoC specific compatible under
> "apple,t8103-wdt" used by the driver.
> 
> The M4 wdt block additionally has a secondary watchdog, which is
> disabled by m1n1 and can safely be ignored by Linux.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


