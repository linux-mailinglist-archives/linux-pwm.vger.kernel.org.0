Return-Path: <linux-pwm+bounces-1751-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25887A30E
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Mar 2024 07:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF5F1F21F0C
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Mar 2024 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170EE14A97;
	Wed, 13 Mar 2024 06:49:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94114A93
	for <linux-pwm@vger.kernel.org>; Wed, 13 Mar 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710312556; cv=none; b=gQMpGrgb7pkOAHMsKci0vFrjufTtBWTG4kEZn1+QDmurwmW/PC7Q6McWbte1uWigaOpSacRQ66C8m+/kE6Jnf0F6RF0Nd6Bv1/n3dxv8ZAxv3kKzTO3w1MXgTJr7RCUXGQdrt9bFmaXv/VmllQ1VcBeZwm+z0wEJZ88Zi/dnhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710312556; c=relaxed/simple;
	bh=YmGhpF67UQkXDrjW1tdhJtif7Mb5bOO6MU/H0fI9Ehw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4iI07LZEHjGx8jtJSXHEqvIBFM3rEfRVNbKeyro+TSw+VlZ9sicZ5LLdcQ6wPdcsV+5+NvYjLxuVlOzXxgAW8wDR5+tvRgudY+jgz0bjmDQWfa23Pd+T6c+3tyCAZfL/LQXY5IiU+37XXgaAYa4cjYXfPCB/+08Z7vMJtpAtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkIQ5-0003qH-Ik; Wed, 13 Mar 2024 07:48:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkIQ3-006404-W6; Wed, 13 Mar 2024 07:48:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkIQ3-005E6s-2f;
	Wed, 13 Mar 2024 07:48:55 +0100
Date: Wed, 13 Mar 2024 07:48:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, andy@kernel.org, daniel.thompson@linaro.org, 
	jingoohan1@gmail.com, deller@gmx.de, robin@protonic.nl, javierm@redhat.com, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <heasef3pdfyj7xyngnvbg527pc5uyy2v6hatz4wr6q3sfkhw3h@f4lnresjcnmb>
References: <20240305162425.23845-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fazplp4fyrovvxv2"
Content-Disposition: inline
In-Reply-To: <20240305162425.23845-1-tzimmermann@suse.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--fazplp4fyrovvxv2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

On Tue, Mar 05, 2024 at 05:22:33PM +0100, Thomas Zimmermann wrote:
> Backlight drivers implement struct backlight_ops.check_fb, which
> uses struct fb_info in its interface. Replace the callback with one
> that does not use fb_info.
>=20
> In DRM, we have several drivers that implement backlight support. By
> including <linux/backlight.h> these drivers depend on <linux/fb.h>.
> At the same time, fbdev is deprecated for new drivers and likely to
> be replaced on many systems.
>=20
> This patchset is part of a larger effort to implement the backlight
> code without depending on fbdev.
>=20
> Patch 1 makes the backlight core match backlight and framebuffer
> devices via struct fb_info.bl_dev. Patches 2 to 9 then go through
> drivers and remove unnecessary implementations of check_fb. Finally,
> patch 10 replaces the check_fb hook with controls_device, which
> uses the framebuffer's Linux device instead of the framebuffer.

I assume the merge plan for this series is via drm-misc in one go?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fazplp4fyrovvxv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXxTFYACgkQj4D7WH0S
/k4WCgf+N9+ghi7jxWwK3i7nnF9402Id/hmnbKSiQ/2mzmtMu7hWnXpywzKwVGNy
JuwbngFjANW8HquzInPZ0cOClpGx2dm5i2YsAqyDnOZO2Jg3zT1VOVZkd+/YzOI4
FWBxp3T0ZUTmE1Fh0ohTEL+lL49F7nJXmeZNUMqWec4BwT09Eu71ZRseDMjL4Ar3
bO9k6WkqF7/v+sWljRUWjvcAvRC/El4JMjyLTb9xS/UarDtjSbxePHZB6d9lf6St
Dm0sgkqb/+jaZhY5kM1d0HJaEE1Wdef63pW2tDIunfj5L5PBveSw8xHMiipSCd4e
9krdHDOzOyL/lPFi7CSq7i85LSyypg==
=uhXV
-----END PGP SIGNATURE-----

--fazplp4fyrovvxv2--

