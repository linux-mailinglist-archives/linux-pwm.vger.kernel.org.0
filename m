Return-Path: <linux-pwm+bounces-7973-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAczBBvXb2mgMQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7973-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:27:23 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD54A580
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE282E313
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B644A717;
	Tue, 20 Jan 2026 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQkpfi0O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6B43634B;
	Tue, 20 Jan 2026 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932410; cv=none; b=MCDPJ0NdDCBF9WRLQ85X8q7r2Mk0WFnfXNUrz8ihMHWHE7SyunZ8IiStN8Nl63pmOSZwBb4OWnde61kX6noB7c5YvMsHkeKIsZHnoHaDLE6enmqyHs6tZteRmzmwDo9A9yTn64+JvDIxxpmKZPPseP2U5ydApFtKzXO7Gt/nfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932410; c=relaxed/simple;
	bh=7noY7dwvdtPUFXP+TRLnQO+n09UhiDtPbUSAVkbiet0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbNdgKyPWTD5IBbGLmGUdQSGgBtajHsmZUkTM16GMqr5fm1GaIbaopmMpWH8Z4rnXd+rpKYbI/UxmAXR2nmUNhxEcgFVTA7ocq9jvXgKTQTtQCVpvCFmz8uI3teE2z8PO7ME/ruZVNxo7ZD9VYbDm6Aj3t2SWX96Lu/pjjkJQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQkpfi0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCE7C19422;
	Tue, 20 Jan 2026 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932409;
	bh=7noY7dwvdtPUFXP+TRLnQO+n09UhiDtPbUSAVkbiet0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQkpfi0OPLvOKJ/yAeKm3nJgUQ97DjOmFq8hBGZfHVEDqjoh2Y7LKSeJ8L5vYZwUh
	 LVQiGBzhtrAKLEgbAElUxLL+yoYqJiRfXhUoHUrzhYtj1gZjuaszjkIvRSVOibMm8/
	 YT4Z8io5nER4X5UmCndJDBlMOAnRm8hn4D3C2tNjWjDnkRqw2u1B8Iq+6ckaUAghnh
	 kwxdLES+JeupHTokklIlIybAvj/r8WyNGJNVESdEQxi2vToWdxATkTd4KgRYzPVuMh
	 Ulqe2QOUmzSnar9l+ks+aypt5NCYlhSy+vnxcLKvQUHKavOzDci4jiF5SD+vM+1y+d
	 U4DZqG6iNMZWw==
Date: Tue, 20 Jan 2026 19:06:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] pwm: Update MAINTAINER entry
Message-ID: <vxft2haumyobyfq2kmvtisplvdw6bwuriw7ngghbrtbczewknl@bnc2ou553xm2>
References: <20260115165055.1739004-2-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ij2vdvowd2uioibd"
Content-Disposition: inline
In-Reply-To: <20260115165055.1739004-2-ukleinek@kernel.org>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7973-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B6FD54A580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ij2vdvowd2uioibd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Update MAINTAINER entry
MIME-Version: 1.0

Hello,

On Thu, Jan 15, 2026 at 05:50:54PM +0100, Uwe Kleine-K=F6nig wrote:
> There is little sense in having gpio-mvebu and pwm-backlight explicitly
> listed in the PWM entry. Drop these and add the keywords that actually
> identify a driver as PWM related.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Applied to
	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next
with Bartosz's Ack for the next merge window.

Best regards
Uwe

--ij2vdvowd2uioibd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvxDQACgkQj4D7WH0S
/k7OUAgAhsA97vWW9OMqru4+/CWnSRIx0z7mYpFmCjbyGSnc9v1j9A7ADXB3qjh5
jwf15dvx7kHwzOaoeJ4qPexFFHpliT6lBMUZwHizPXwBnSOT5a/QPNp8TDbcee1U
oZZMhRtv0edJ/wFm9YQU44sK2guyYiBurH+CbniL1qDTyEkWJna0hjEjV1M8l215
2kkTw5nqa1SVJvNHhlEGgwgNQKDTKeuTuT9Y8r+2qNsTjle7EJ3oZLAPSAA55OhP
kHHAEH4IsHVQWSBQyXZKllsamvCD4vdQdq8HFLaUAMkNPSMFlprevLZRwWNrixnI
HAsQ0zHOaLM7hfKnyHcK6C33BgR9Zw==
=YD/i
-----END PGP SIGNATURE-----

--ij2vdvowd2uioibd--

