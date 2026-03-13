Return-Path: <linux-pwm+bounces-8243-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB3WBPzZs2mzbgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8243-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:33:48 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FD2808F6
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A05E53050433
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054F388E7B;
	Fri, 13 Mar 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp/LmurD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7614384252;
	Fri, 13 Mar 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394163; cv=none; b=UBsn1I/QVM+t4Sj5c5lFbY2oYxUWPEJluhNeRQI1Ku/WlSHSGq3gUdk7sMLzUUkpAAy3dxvWCzYqcnhhQ4GtfQ6SRX1WkaIYBw67F/f2Jh61KucKrpyWQpiVqaYfJbChEDU5Abs1h5cwcwoMH6c5FQykp3RWLEK567x10KY8+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394163; c=relaxed/simple;
	bh=frhd8OxDBdX57aN8gbIx2le8ab8QIEcHtmJ/36F4Ihk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffMx6N2V8rO7RibZxvk2l8LYr8R6VZnlSEdTMa1n+hSd9vLsVJFIpaPA1juPkGjkdviL62cBNZgxDyLd3XzilBNS3tifX7+sdb9nbw/0xoG239Ih1lKJmwaikpilIJqIP/kYOeRGedzVZR0NfRo5HQ2JPBgXL4ThcU5F84dYuCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp/LmurD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1A1C19421;
	Fri, 13 Mar 2026 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773394163;
	bh=frhd8OxDBdX57aN8gbIx2le8ab8QIEcHtmJ/36F4Ihk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pp/LmurDSqvT7xtRXFN8jRx79+oe1Kr6VSF11gqEnVCHJhgP4FaFg+14bQuxYSM33
	 zbYekz75dXZuz/ybY2tyTSoOoa293XoVwnDQLL6rRplxs5oehdN8q8JbY6XKXhH//z
	 R04UG4ulcz6iPHLLWBSV2Y7xSXCDSvzbOZxb6m5fYKWVNrsyesRGP/Wr+XuH0/16OP
	 df3PNWVhL3DzcQ4YVyH3RfLscazPQX340w2LRiK+XFEnZTjXh7RH27FAemEf7Z7I8S
	 stGbxcSpWaIVAvee99B8Bb//v2dItGGaHsHcMBfwn+0hg4Ao+YEuNy0xMG+6w5BqZN
	 kD7dWQwkN3JEA==
Date: Fri, 13 Mar 2026 10:29:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: amlogic: Document A4 A5 and T7 PWM
Message-ID: <abPY02eTeMueV00u@monoceros>
References: <20260312-pwm_binding-v1-1-515cb65add98@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kh67322ms2zdpxhv"
Content-Disposition: inline
In-Reply-To: <20260312-pwm_binding-v1-1-515cb65add98@amlogic.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-8243-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amlogic.com:email]
X-Rspamd-Queue-Id: 828FD2808F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--kh67322ms2zdpxhv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: amlogic: Document A4 A5 and T7 PWM
MIME-Version: 1.0

Hello,

On Thu, Mar 12, 2026 at 03:10:28AM +0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Document amlogic,a4-pwm amlogic,a5-pwm and amlogic,t7-pwm
> compatible, which falls back to the meson-s4-pwm group.
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> After the clock module is merged, the PWM node will be submitted
> together with the nodes of other modules. For now, we submit the
> PWM DT binding first.

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--kh67322ms2zdpxhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmz2O4ACgkQj4D7WH0S
/k6IQggApdVTQdn3qqM6257JfW6g1+1eEHGs/PxFCO/wgejDwj8+8ZEbzgQN7H5z
1iR856ffVEv3C7WUbgtVoHHeghRAKeKuZA5N5NCeEEZynnAQxMEHgl7nGqSN29ac
UQYV4zu3VieZ86jKU7MWsKf49gAZc/++EfVf+EMrp+GYpZBN2FzprOlQTOOCJVhX
4yahqf2wltgmTwKRckPq+e43NobluhJoOan1m725Kj8i8dTi1k9bLQku/lTLopZS
0jQbtbiIruPLGnXndcBtZ76CPWSYDU/Dzo9kZA2AwbtuMNbLX4aNXg1PCwRCrACL
vmerRCkEIt8oW5oLKQDBhSAkVjVx0Q==
=UysZ
-----END PGP SIGNATURE-----

--kh67322ms2zdpxhv--

