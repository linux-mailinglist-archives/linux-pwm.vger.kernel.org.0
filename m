Return-Path: <linux-pwm+bounces-1293-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D7E851B56
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 18:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6C5B258D3
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9F03D996;
	Mon, 12 Feb 2024 17:25:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D43D998
	for <linux-pwm@vger.kernel.org>; Mon, 12 Feb 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758720; cv=none; b=HWb+lT7XS0WL6ZHiB5qeEJJW1esstR6nl0sN+pHog0FpYNLiBhiEb0I7QBiFGWc4qiw9M4R4llXXmQ0u0deTmgR6vN1nXV6LZ+SiwGBuHksgLnJwlWOVQZfW/yLl7OdPt1vlJQdoedoFS1IgOokExKLowjcksUvWERckWD2ofM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758720; c=relaxed/simple;
	bh=87yW5oEy3KgnEZywOGA7ppoWJvVKviyk8MEPfGLPes0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho/PvkSxAR3oWvSJgtmHW5bwyhiqR66fTDrwyC8mnZzF0bML6ta1i256NRNJVlwe8uEJg1U2exeGhY16t8Q/vLQogCHMmK472sxszZbL9uqm0Pq04aG9K9cnMHYGuWO1G6K5nTYCZwOVbNbGgVrUJI9K7Wu1ASc6rKtIXfZpdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZa3E-0005W6-7L; Mon, 12 Feb 2024 18:25:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZa3D-000KX0-Ah; Mon, 12 Feb 2024 18:25:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZa3D-003LAE-0m;
	Mon, 12 Feb 2024 18:25:03 +0100
Date: Mon, 12 Feb 2024 18:25:03 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
	deller@gmx.de, javierm@redhat.com, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 06/10] backlight/pwm-backlight: Remove struct
 backlight_ops.check_fb
Message-ID: <nzebylqpe2jvwuig72jvlmkgwqidehkreqif3wglz5xecv5uop@xopxbalfnczt>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-7-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c5qbx3hsze67vw7s"
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-7-tzimmermann@suse.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--c5qbx3hsze67vw7s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

On Mon, Feb 12, 2024 at 05:16:39PM +0100, Thomas Zimmermann wrote:
> The internal check_fb callback from struct pwm_bl_data is never
> implemented. thus the driver's implementation of check_fb always
> returns true, which is the backlight core's default if no
> implementation has been set. So remove the code from the driver.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>

Looks reasonable.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c5qbx3hsze67vw7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXKVG4ACgkQj4D7WH0S
/k6lcAf/S/waxaRzh8CBsJTpus638Jmp0simMq6KwNoL65Tqp1IznymjbXp6SgXi
h+YyIEzBVLl+oLwayRZdbFqGAl/WvWrJ52XZ5npbBjtI8BtGCaJFr1khzwEqeRjJ
vlNQa08I/stRJPCVF4qHYVzC16pco3hATs44U1BiRt5z6XwVBJqcbkThwGEjX90d
Be74R0eZyOpPJBgPsbRKiz4ALHK8qdurOxFGDdZYeAV1G1AbPli84fZ7Uew2oNfK
DnQTur4DC4FJ3/gbaTKLztvLb+PDhX+PypUsPbdhnDE6PpVXvZywL3i2OaEB43K9
+RhfBDcct5CQxwmOqe8Ts4n7hvAKgQ==
=FXhc
-----END PGP SIGNATURE-----

--c5qbx3hsze67vw7s--

