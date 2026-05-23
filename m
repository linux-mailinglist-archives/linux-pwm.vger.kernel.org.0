Return-Path: <linux-pwm+bounces-9088-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KrsFhLcEWq+rQYAu9opvQ
	(envelope-from <linux-pwm+bounces-9088-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 18:55:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B9B5BFEBE
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 18:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45B47300613E
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C94D223DCE;
	Sat, 23 May 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTVy7vRc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375A1FE471;
	Sat, 23 May 2026 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555344; cv=none; b=uIFxGd8gvcC3jIVaIagUPVhC35/KYw8CfZCd0+hZHNkVay8hNjdsMdNPJr/UVW9JNibU4bnlabhjtIlevXsN1PtP6Dj0GxYE8740fkOlP6T5Ze2RDbr96Y7lITtwSgKy/N2TrAqB5rq5WtCapXlLaI0gHGmfWSaLjDiAspGGpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555344; c=relaxed/simple;
	bh=vGJn79psLNSGbdvWUcF05fHU7TO0h9kIvtXy0kpqX9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwBQkW4XIxOAAG20QhvODy1Eq8hk0Lip3xooxFIsxk7nV5sMxzMAqes2O0js4aJbbymTVfuiGRE4QI/eI+r4DxwtLUDT9tTBh4GeypL/2FrpClPUjpG77TC0u0jhVcpePEHI0cLKheGl166352Rf21LhMD2l/LdyhWr3I4EptwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTVy7vRc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 63BF11F000E9;
	Sat, 23 May 2026 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779555343;
	bh=Q/gT+YsJzWyplKB1RZZSInjxfqO5+hC3r72glf2BYWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HTVy7vRcXSz+roUzS1mOxYzquBSpIPb1CsfPhBY6xVHldUWGGT1OJH/jzf9/cfUki
	 ep0oaugIHYFiH7fiEJIEjxkyIUYLe6lPtDnBkbmbOwcwFkiuUVs62SQUaBtpsMNmWX
	 poRy6jfKLruZRuzaSAhulgUY9gp7Zi2M2pSgnnoUyMsjL/0Gu790WbAod3GjHvmVwV
	 tBs4b7thfoqamJWH/alR0aJT+34kQwlyfbo2EeJhk+nWF3z7mGZjjnS2sMeyOBfaPl
	 /dArJAtqcB5jOuQUl34hL5i7JDTkPHHNmbhVtzcmh04HDPFegpuGoijxulFaA29WOb
	 j/9jA0KhZJyUQ==
Date: Sat, 23 May 2026 18:55:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ronaldo Nunez <rnunez@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: imx27: Fix variable truncation in .apply()
Message-ID: <ahHV_GIwdWvTu-ms@monoceros>
References: <20260522191348.6227-1-rnunez@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ph6z6kisszpxnay5"
Content-Disposition: inline
In-Reply-To: <20260522191348.6227-1-rnunez@baylibre.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9088-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,pengutronix.de,gmail.com,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,baylibre.com:email]
X-Rspamd-Queue-Id: 01B9B5BFEBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ph6z6kisszpxnay5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: imx27: Fix variable truncation in .apply()
MIME-Version: 1.0

Hello Ronaldo,

On Fri, May 22, 2026 at 04:13:48PM -0300, Ronaldo Nunez wrote:
> Fix a variable truncation when calculating period in microseconds as
> part of the solution for the ERR051198 in .apply() callback.
>=20
> Example scenario:
>  - Period of 3us (PWMPR =3D 196 and prescaler =3D 1)
>  - Expected value in tmp: 198000000000 (NSEC_PER_SEC * (196 + 2) * 1)
>  - Actual value is 431504384 (truncation to u32)
>=20
> Signed-off-by: Ronaldo Nunez <rnunez@baylibre.com>

Thanks for your patch. I added

Fixes: a25351e4c774 ("pwm: imx27: Workaround of the pwm output bug when dec=
rease the duty cycle")

to the trailers and applied it to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes

=2E I haven't made up my mind if I create another pull request to get the
patches from the pwm/fixes branch into 7.1. If not, it will go into
7.2-rc1.

Sashiko found a few more issues in the imx27 driver, would you like to
address these, too?

Best regards
Uwe

--ph6z6kisszpxnay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoR3AkACgkQj4D7WH0S
/k7D5gf/WdM3ZZEgTDtL5u4whmCMC9ht8ov24VkAyIcSW1arTUVCvj3+h1336tAU
kF/jUUgeWjBxXpScxX2A94GB6iv5tTzHI0lKFGqqOVSBL7EWKiJG8u+raDdk+S+R
sm4QZVqWMBulgGHlb+ZGQhEh7RSf0Shu3rHeGfb3Pfffp7lRlzuN4+ebPSvbzlC2
uKOJYa3FwVnu6KkNsj41tMLl+wgD7GYhr5h5vFwHYx3oBmNJQfjhmzXBqJFxkgIF
rC70EW6LkxHTxuxQPxzX2SR0bpH3ezjzbUS3pdE7B6nsRGW5FBW676bvPCJWoFKz
r6YFGGJX5XwZdGIrtPNzU1159pXtEg==
=eJk0
-----END PGP SIGNATURE-----

--ph6z6kisszpxnay5--

