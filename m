Return-Path: <linux-pwm+bounces-8482-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCQwJaHY0mlmbgcAu9opvQ
	(envelope-from <linux-pwm+bounces-8482-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Apr 2026 23:48:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1077539FEA5
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Apr 2026 23:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 028573004C2D
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Apr 2026 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37E38229C;
	Sun,  5 Apr 2026 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2cd3RH0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB23277C96;
	Sun,  5 Apr 2026 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775425694; cv=none; b=ToE19DqcJRL+Pm8KfIGEUpB542vhiIpFoC8+GYnWdksXfX5UIXbFU1BWZC5pVAuUXTGbQ1Z7sXH0Yk/aG47SEysS1fYLJkfqPOZiAKPI1dQ03ksckzh/zQbdQR+8uK4HZOzlvSrW15VSeye5dRQJ3/PIAfKxcgO5muu8dhvPOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775425694; c=relaxed/simple;
	bh=RGKOBQD3Q6ynJpf+CVXJt8bXlPhMYn8DmenV7P8v5uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGCsz9jeLroXThm9kbIxgnp6M6yoZXWdm+joBwa+o8EHCUuXkleXIIdvL0vmogIFWVGSGHFqACL/weAgym3eTlAXYyKKyUEjqjrDl0d8iCil4wQaK4b3l4rbBqTWxk0aXcEBCYuZA2j/dpcwQpNu/rTGkrdIMPhB+IPgXo2g+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2cd3RH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35856C116C6;
	Sun,  5 Apr 2026 21:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775425693;
	bh=RGKOBQD3Q6ynJpf+CVXJt8bXlPhMYn8DmenV7P8v5uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2cd3RH0ZY08IBHKfzRhqB1K337C4FVOO0qZeUhgJ98d7JrCfsytmVl2STQdmGtT2
	 V+RVFGYTZ23wOpPPrLOHGoV4eHcy5cM5eDMC5lgLCR3eExlwsZDWHMq/d8gJkI6VvU
	 Zr7nuTWMp8UHOXg2PgAqXkVwTHFQfta+3FhqerqtiqYEcKur4+NSrxhJf651hyCb/v
	 7ZPdMtvFW0KK7UoiiyKpcsTOvTX4CcSoAbmsG8PKl1VCZduFJh3m5iRKZ/8ZmmQKoh
	 5BLFJWEjdcSrWIeVPfAGO9mIhfLf0lzEtHjznnaru3ByDryUnP7MesLZZmLK2NadNG
	 f67igLD70FYKQ==
Date: Sun, 5 Apr 2026 23:48:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH 3/3] arm64: dts: broadcom: rp1: Add PWM node
Message-ID: <adLYU8EUzk7kIuwl@monoceros>
References: <cover.1775223441.git.andrea.porta@suse.com>
 <ef79e974c6680202294a4cfde7cc791753bf1b3e.1775223441.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a2ld2b4dw2q6x2ai"
Content-Disposition: inline
In-Reply-To: <ef79e974c6680202294a4cfde7cc791753bf1b3e.1775223441.git.andrea.porta@suse.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8482-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1077539FEA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--a2ld2b4dw2q6x2ai
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 3/3] arm64: dts: broadcom: rp1: Add PWM node
MIME-Version: 1.0

Hello,

The "rp1" in the Subject is very irritating. Better make this:

	arm64: dts: broadcom: rpi-5: Add rp1 PWM node

or similar.
Best regards
Uwe

--a2ld2b4dw2q6x2ai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnS2JgACgkQj4D7WH0S
/k7/BAgAraQetvLdiGHxyhhuRl+/9A1OzV4ZpgpJrRstQExDxilsE9zghRdQUCrx
NbXRR2E5MTy9JtG2qDM0oW587E2dF96ywTvExIY3LQIsz7qjHLb+fF20bbp8bKOX
A7WEwiBze2iC1QbIETJJjmgMBoSIx9fGK2kZXexhor2xucynUQunuMGPLBu1i/HU
rAyhYUblL8/RqRlpfTt8Zx1eyo3UaavEznhai+isamY6euA8e8LWK6mvj6YKUAD3
J7TGSn6vmzbR2WFeAL5XHql8OM7wfwurPoxCYVE/L8Btc53r3g4AzIaefq+HmzfW
xC7bOVcru5Oiv5/QMxSoB0vt+PExMg==
=d13v
-----END PGP SIGNATURE-----

--a2ld2b4dw2q6x2ai--

