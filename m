Return-Path: <linux-pwm+bounces-9702-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Ov/BP8EVWroiwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9702-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 17:32:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1B74D11A
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 17:32:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PvjiS1yS;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9702-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9702-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B95543008638
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B633DEFFA;
	Mon, 13 Jul 2026 15:25:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7B3D1A8F;
	Mon, 13 Jul 2026 15:25:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956338; cv=none; b=FA1AHI4UXri3Aa3ZJJtf3ys2wSxkvVtXmumBdYtDsC8hpSIIWBj32kGibVFteuIijm4t0xDrDtDfEXWS+g7z6M7V1+MsQZEtFJNPdSipXyxQC5kYP+j8F0/oqEYheL7DqNoysqCYP4TJQuD7iJ8BPchv9gpMwXl/yPceb5SIdTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956338; c=relaxed/simple;
	bh=Zi/qfWwdQ19G7Vyq0p/X1lZ10s0FMS+KMEXOfsuB8lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeNdPcKNwXvINwzfSXXg7XtzKDvDjyHsmkQuU+KpqbQxxcToLhOI+Z8eLLbXjsB9qetz30Na/J4VcIa0DiI+AuV9Sqe8fcF3aEJHpAt77OYi3+EeSvaWft31szxzzu9YVYWpPqVYm/TIJto38nLDy2yhDr0egw7oPsS+J2+XyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvjiS1yS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BA0DC1F000E9;
	Mon, 13 Jul 2026 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956330;
	bh=S43y0m3tyKSbLzLPY8izdYm9kJrJvv8tLOFrmfdNees=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PvjiS1ySjBxGgAFmCGinmhv4SzIJetqPWK2oOsciLLvUzevNxwZzKrnKco5PyQaU6
	 BKsTYAPKR2J6Kh0mjgr/UclLbvazIBakYOB+FcrL5D+5dtZhW3gOkHsROEsZgQZE6D
	 9UBWSqOBS6Wf13NAaVRxumh0TmZ/MB8ICez37rS9TBQGhpjtmgHm9U+g7PMrBhBPjY
	 uy+wc1HWfhUwM6vsLtQ6MtxzDg/5AXZh+rSFcOxkVwqu8HUBUeRFxFftRsTY0k6QQo
	 ctKIosS1KYbxU7YFv8CMc5GjmrYw89ZD9XyUP81gcPo4lHL9ueX8D/Tpd1ngcd09qE
	 kLD7Z/PTiO+mg==
Date: Mon, 13 Jul 2026 17:25:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] clocksource/drivers/samsung_pwm: switch to
 raw_spinlock_t type
Message-ID: <alUC6X7GgvxPUelM@monoceros>
References: <CGME20260713085705eucas1p26616e64d55f903a6f87dd67e8f8da1a9@eucas1p2.samsung.com>
 <20260713085653.1145015-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oqbewf4c2d6juqpk"
Content-Disposition: inline
In-Reply-To: <20260713085653.1145015-1-m.szyprowski@samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9702-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:m.szyprowski@samsung.com,m:krzk@kernel.org,m:peter.griffin@linaro.org,m:alim.akhtar@samsung.com,m:daniel.lezcano@kernel.org,m:tglx@kernel.org,m:bigeasy@linutronix.de,m:linux-arm-kernel@lists.infradead.org,m:linux-samsung-soc@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0F1B74D11A


--oqbewf4c2d6juqpk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clocksource/drivers/samsung_pwm: switch to
 raw_spinlock_t type
MIME-Version: 1.0

Hello,

On Mon, Jul 13, 2026 at 10:56:53AM +0200, Marek Szyprowski wrote:
>  drivers/clocksource/samsung_pwm_timer.c | 22 +++++++++++-----------
>  drivers/pwm/pwm-samsung.c               | 22 +++++++++++-----------
>  include/clocksource/samsung_pwm.h       |  2 +-
>  3 files changed, 23 insertions(+), 23 deletions(-)

Assuming this will be applied via the clocksource tree:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--oqbewf4c2d6juqpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpVA2UACgkQj4D7WH0S
/k5qfQf+O0q9IgJiIhTIoZb+PFNLzFpJUfTgt80QNJfsw0CNjUnDubvaD00Jx6CB
0+3gpys6WaM2CnAeAFNuwdQd5gknOHyywKF6iWw6E9CWCjAK8Y2QfvuCHCkoLdp/
ahqtz6RRZr7wm58CesLNihyINKtzOZirlvtrzk4ES2pLB7okf86yajwDAnV6NsfM
spfGp7exy3/fv4zYkFzYu2mVS7sUDuxI9AwjwAlOpFNKIUg35dFi2SAnWZbmZUPA
/NpyBmClhBY84AJqyX2qce3qGpt8UNgFtwW4RwE+3N+EN0mdj+hnSf7kLdYOyBuN
N6SV9wAHRF2h8eUWrss8woO01oVNDg==
=BfQ7
-----END PGP SIGNATURE-----

--oqbewf4c2d6juqpk--

