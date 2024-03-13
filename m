Return-Path: <linux-pwm+bounces-1754-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA787B390
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Mar 2024 22:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94406287694
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Mar 2024 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E36F53E0E;
	Wed, 13 Mar 2024 21:36:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E8535B7
	for <linux-pwm@vger.kernel.org>; Wed, 13 Mar 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365809; cv=none; b=jI/Idzd7Oso7XKzhfftBpsvPerWO+gcdfDM+MIC48d+KAg3+g83dqcC20GVnZ86V/UolfglOuKOneIydTolSAaDoAkc2Ev5fUSmJoIK1dvnlOhbaolVVvnkGzyjbpjQX/2xKGqO/1JpXxd4IQdyItatwlBS2omAKafdHBN2tz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365809; c=relaxed/simple;
	bh=glrAd7XBqPELw6mAyBrQxWn5qdaq0KM0oKch/fQW2/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7Nqn/YLu0kJkOHj6XAlKnjQyE0x+w/7MMQNJ7jnOgjF2i8fghH5A5R89lBZFPD6KaoN8KBsd9i7YZFTNxk0ipvcX7Ih7Z2Whn1lcJTEsATYKp9QTLSEH0eNSwPqCTt44bMuZDxudZ3jJU539Dsmeb5EBP2XYhzfyhm9laZhbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkWHD-0001HS-TG; Wed, 13 Mar 2024 22:36:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkWHC-006Bjl-Tv; Wed, 13 Mar 2024 22:36:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkWHC-005gLf-2i;
	Wed, 13 Mar 2024 22:36:42 +0100
Date: Wed, 13 Mar 2024 22:36:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] backlight: lp8788: Drop support for platform data
Message-ID: <7nvqboywxhviyuzkiesy4qfqybxx7vc5sw2seluc3dwnhk3q5h@hlzwxhnm2q6r>
References: <20240313124828.861731-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rrug4xskydudt2mq"
Content-Disposition: inline
In-Reply-To: <20240313124828.861731-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--rrug4xskydudt2mq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Mar 13, 2024 at 01:48:27PM +0100, Uwe Kleine-K=F6nig wrote:
> diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backligh=
t/lp8788_bl.c
> index 31f97230ee50..f3a89677c31c 100644
> --- a/drivers/video/backlight/lp8788_bl.c
> +++ b/drivers/video/backlight/lp8788_bl.c
> @@ -12,7 +12,6 @@
>  #include <linux/mfd/lp8788.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/pwm.h>
>  #include <linux/slab.h>
> =20
>  /* Register address */
> @@ -31,149 +30,41 @@
>  #define MAX_BRIGHTNESS			127
>  #define DEFAULT_BL_NAME			"lcd-backlight"
> =20
> -struct lp8788_bl_config {
> -	enum lp8788_bl_ctrl_mode bl_mode;
> -	enum lp8788_bl_dim_mode dim_mode;
> -	enum lp8788_bl_full_scale_current full_scale;
> -	enum lp8788_bl_ramp_step rise_time;
> -	enum lp8788_bl_ramp_step fall_time;
> -	enum pwm_polarity pwm_pol;
> -};
> -
>  struct lp8788_bl {
>  	struct lp8788 *lp;
>  	struct backlight_device *bl_dev;
> -	struct lp8788_backlight_platform_data *pdata;
> -	enum lp8788_bl_ctrl_mode mode;
>  	struct pwm_device *pwm;

Actually this pwm_device member should be dropped, too. I wonder why
this even passes a W=3D1 build without a warning ...

@Lee: Feel free to fix this up while applying, or tell me if you prefer
an incremental fixup or a complete v2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rrug4xskydudt2mq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXyHGkACgkQj4D7WH0S
/k4u0QgArwWZJ34iALZlyB21fTRNwZLFRkn8DH8i/rtsUENrdd5riGV7cah3K30s
4ctn1nCAv6m4RYIbvPuroR5DzCnzL3wKMzuD/ppwNtKIB9gAxUaJA5cBenfjBy0u
aMlLsKzZzE/UG/m3e3/FOqhn/Z9WZfCJX2mpCikA1w84EO1bYYO6VSTOjye+0gtN
w/9a7picJxEmSYYAG1zARRiQB8bFTQ6oUwjJQ+dkThAN8R5mX2nkDOVH6t0POQrI
iBqTzn9jhT560SNjYmv9TJRE8Xul7jr6zgOq9GwD6F8WvDY4/WNzU/qljrwoKCX8
icE/sHySbg0K2hUhVNRUzTXMBVLL1w==
=dgpE
-----END PGP SIGNATURE-----

--rrug4xskydudt2mq--

