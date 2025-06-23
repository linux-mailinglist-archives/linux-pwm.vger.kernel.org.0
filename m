Return-Path: <linux-pwm+bounces-6472-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C57AE397C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 11:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60CB16BAF2
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987DB232376;
	Mon, 23 Jun 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx2/chWc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998823185F;
	Mon, 23 Jun 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669647; cv=none; b=euwGW5cR+7utJO5FmoRG9zhOhumzGIb5p0gv3NPhDxdkJS7HOkHJL50KQ+JknxvTVqe2TTZ2aU1/3mf2UeNPZHC3bCkHoh3LPZL6Nk/1DFuX02a0YLG/cnNxDTeluErxpVSORgWzrzi9pf4HUPpta0L9p8Li6nZGKbfNsFgIAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669647; c=relaxed/simple;
	bh=sxwgv5/EWN0cFhMI+LneIZDfkkSD8HvMjYXUdRrxSs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IotMzeRZ+XFVM6EYyCou8/DP+/h+tjh5t5kk6PvPIzLw1SAm40tKUt6SZo3WLQCb5BDXGD2Lnf7XQZ7L50XVBa2d57HeRvkWsfbk9yanWz4PAIZ328d89w1zYNmXPlgTM0u0JmcvcLVmFn8epR6OtpyKjcAsxfXGtM3TxrI3r9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx2/chWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4E2C4CEEA;
	Mon, 23 Jun 2025 09:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669647;
	bh=sxwgv5/EWN0cFhMI+LneIZDfkkSD8HvMjYXUdRrxSs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rx2/chWcZ1WD8KdlozmjuTJXHOu2P5LFNE1hktq/Q35XNLesZ7/dZrJYHKi/zIacd
	 s5Z6M+hiQpmxDALbzXYMUP1TmRzC3v/sptwAETk4SGfb8d/+lwOJeFwMr+cYiVoAkx
	 JqKBK+d7Sp95AaQktbdXNJqe8u7LbOOCBLH/v6Gv/hSp8Fj3WY9MUzlx9LaBrFARp9
	 rXZRTEaP+IeFi75BmgLMxM6oX9C1FXNlYHcHDEMAvFz8CnHIuOXa8/DdjXS4CqHJa/
	 wtjkb0PvjSUZHMGuVVDyTeQT5wJOrTygcjg0R6x9pWFKp6K1X7eu3EkoykLQJ/Tav4
	 Y+Gr0BNagIBUQ==
Date: Mon, 23 Jun 2025 11:07:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v3] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <cviovwci5fgtyina7p7zqjns7cwveivy3vetqhhagwmrlc2gm2@jrqgorif7xff>
References: <20250619-mc33xs2410-hwmon-v3-1-301731e49f8f@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xci5up7sokrk3mt4"
Content-Disposition: inline
In-Reply-To: <20250619-mc33xs2410-hwmon-v3-1-301731e49f8f@liebherr.com>


--xci5up7sokrk3mt4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: mc33xs2410: add support for temperature sensors
MIME-Version: 1.0

hello Dimitri,

On Thu, Jun 19, 2025 at 07:32:42PM +0200, Dimitri Fedrau via B4 Relay wrote:
> @@ -29,6 +30,8 @@
> =20
>  #include <linux/spi/spi.h>
> =20
> +/* ctrl registers */
> +
>  #define MC33XS2410_GLB_CTRL			0x00
>  #define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
>  #define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_=
MODE, 1)
> @@ -51,6 +54,21 @@
> =20
>  #define MC33XS2410_WDT				0x14
> =20
> +#define MC33XS2410_TEMP_WT			0x29
> +#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
> +
> +/* diag registers */
> +
> +/* chan in { 1 ... 4 } */
> +#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
> +#define MC33XS2410_OUT_STA_OTW			BIT(8)
> +
> +#define MC33XS2410_TS_TEMP_DIE			0x26
> +#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)

Keep the registers in address order please

> +/* chan in { 1 ... 4 } */
> +#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)

I wonder if it would be cleaner if this was abstracted using mfd. Then
the hwmon driver could live in drivers/hwmon

Liebe Gr=FC=DFe
Uwe

--xci5up7sokrk3mt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhZGUoACgkQj4D7WH0S
/k6vqQgAtE8/aapccZDwS7kmxq/6HM2vEasDezS4zGnqv/4V8w0gp8+tuXT0Yn6u
mXh66QOM/5OHYW37rPIYU458yjPBM52aWgvHwLiwDsV2nbFCz9wJeHX4OH6tSeE0
38DlmL0RWllp6LY7iEwcOFf7uk0M8sVEUBWgTsC+LQWhEw+oQsIe4rHMl29L2ubR
bxVpPQ5IlTvH6rmu1sXxjDiWXOYMoZTPI2HzJwpkLb6o+BLmmvJh5xzGuvUm/ucU
Zp6/ltBKADlZbrx65bXeaIeQKdrY/siCxX6Y3QSp4qWAXzG+Y0GD++3LYZE9v+AB
JpAfLZHHCVYPpaMRkAvWD6ito9kPPw==
=tKLs
-----END PGP SIGNATURE-----

--xci5up7sokrk3mt4--

