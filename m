Return-Path: <linux-pwm+bounces-9672-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 980LBmDfT2ofpgIAu9opvQ
	(envelope-from <linux-pwm+bounces-9672-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 19:50:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D2733FC5
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 19:50:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cEH1Ar+W;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9672-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9672-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA8230134B6
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6A4D991D;
	Thu,  9 Jul 2026 17:49:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C64D990A;
	Thu,  9 Jul 2026 17:49:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619394; cv=none; b=lozyrxaoFNKUELhgTLSc4CuHZKneXP6FpLFfT4VxvoN3SRhQv5TQqcTH4T8FMURkZBbwIaMiy8Iif1Qcfo4if8ne0aI94I0CiYtY6jAryEOLRih22I/NQ1clYkuuV2Vdx9YKitEpU8C+OXEAt3Zg3AI05Kb1ExpjWOulp8jHhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619394; c=relaxed/simple;
	bh=hBd5FZlnvt8qVr2rngfOj7JDFYfjWL3zYZADR3eYLyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNjHDBz8PPjV8hDWULGz8/Am9XecsVbH2lWhd9p5GoST3f5VS74YSgY2yvVI1g4DO+gx+dnzQF0nm9xZRYzSm1rNvhwh8Ebf8OxxHlZ+qVhruBX9SUHzPIZckhNzJyN8kTTI1/8+za2Q6MNvmmzErN3RnoBrCZFmkN2FljIC4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEH1Ar+W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A27C1F000E9;
	Thu,  9 Jul 2026 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619392;
	bh=hBd5FZlnvt8qVr2rngfOj7JDFYfjWL3zYZADR3eYLyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cEH1Ar+WKXKW6YA0WgeZ/lEsARR8htYetFG2gY3KS8ziCfticL5f4wReoaglGBy+a
	 qbMvDnS2oBoZTixdYA2WLV2UmBhpkoljeqcvFP8Qk/F9/W4BY0cKR0+gpW/yS7uQ2b
	 fatfF6XsyZrqqjB1VWF7VNXpvuaIbwUtXcNlhNzqP8bkj+IkdpFjctF0MSCwHqzxnl
	 9Xr60ctiYa8qZPUxWySkCuuCUNqk0Qdu+FtrA1VsJbzErP3b8Pv1aui/DzVrmtkGmk
	 9TgjiBk63COV6FrB7y2ChDEwuVvmNURMi+l7heD7UP2Gbv5pfkO6SixBYJLSMdFYUn
	 6Yx4TRXofoAUw==
Date: Thu, 9 Jul 2026 18:49:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t6031-aic3 compatible
Message-ID: <20260709-scaling-hazy-d36fb3250e7e@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-3-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YvWdE4NKYv9MtnVB"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-3-55b305833123@jannau.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:j@jannau.net,m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9672-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,spud:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A90D2733FC5

--YvWdE4NKYv9MtnVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--YvWdE4NKYv9MtnVB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/fOgAKCRB4tDGHoIJi
0sWmAQDgI9YuXyIQ2dvOC29etmaIiA2e0+V2dcHZZj/zfXGaMgEA+iHj5g9V6QLu
EK0XK2Fi97uP+qZrW6GzdHciVlCoqQ0=
=BvyJ
-----END PGP SIGNATURE-----

--YvWdE4NKYv9MtnVB--

