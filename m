Return-Path: <linux-pwm+bounces-3453-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DF1990328
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DB2B2362F
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A421D2B2D;
	Fri,  4 Oct 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aDt7Md7f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B491D2B21
	for <linux-pwm@vger.kernel.org>; Fri,  4 Oct 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045539; cv=none; b=CobmqyJOenJKBPFNnHYk3Nuau5Zp9XPmk6zYso+SL8wqRTB/XepQvmgFnz8w2X4uh3B4tsMQlbZP8dC1j0w62xAKEK4b+4zdEL4ZsTOxCmZBVBBnGvmsgptQFxVVNWLlTjbN7kiw6hvqQ6M5HRuWOjLwXnsy/pgEaf6HZY+4kuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045539; c=relaxed/simple;
	bh=ZVl9z/rrlDmehpBsQuA2mbT22q0l4SdLWmmeR/AHELA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPeDQ4iyJDAQIbmndVhJpTtEbIyyRQGyE+P1DanqVOMFcAwSiZX1/2nljRbGS23hRSoupjjLhnfvQvygoblFlHFe68hPPtwUae6OHTKoBcotFokn2wc2urolkIentXZ8+4xgUr3tj+HJe15eoQ9aixOpzsNki852mSrnoHFcvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aDt7Md7f; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53988c54ec8so2433156e87.0
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2024 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728045534; x=1728650334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mK9KZammEBULrhO2Wt8CEJNNz7BRCuFipfG18nOn9BM=;
        b=aDt7Md7fyHuQLvmm0M7UyoIFXEucXqKvvXiTGA6cWLhTh/cKdshdvtKRZ+XC8p1TST
         +bizS3lHaqy9AxXXQnYmbRJ4mwOjCn8JN9MXjzRavDK8osrq+IEvgACbHO7MGpFPEdhj
         cxO/aVmQBpvBQ6axQJ7o8wnoNuCZvV3h9x7YOx043LfFpmpZ4k4Pdj8wFeY1XrXC6YTD
         C6a+GTiyRpb9b9v80EtoyK2jwi51Fk8CZqwULT3EqWuR0qyymWjHVSPf9yaqoVRXAJYr
         vcaUW7FPJLr4UaPb5IbkRqpCJBQ3z0KIPvQfzmHUps0y8whMBPfzHUn6HesZDMyjy2qZ
         WHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045534; x=1728650334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK9KZammEBULrhO2Wt8CEJNNz7BRCuFipfG18nOn9BM=;
        b=J/gWDx//MXLMdXS+iRY4cWWDYvj8SeG1j1OJ4BqvCyy/JvsYU5r6JzSElOldzRMUFU
         vTLUFP1ZBbTrFRF+d29/pszShSHbFj0Ea7cvbwbIMisY0kADZmEtPZROFRhAXjFscIuk
         /+BDlrZ3KIePHJ1wbom+kScVQIsq31Vtj3yFkahfcT9DmMnC1IX4Y6npoY6jSgX/Wpuo
         e3TUD9Rlt49SXy+8kCA4QxhS8k9NViOwKI6cexFA2hCczu4rQhYxA8rZMuxY/m89PzDf
         eXJe+5I7Wom/bYBc4lab3f0vJ3zylM85lC+s9SgVKNxkr5QwChd3I0VHcDwp/PMaSv11
         WV+Q==
X-Gm-Message-State: AOJu0YxOhLuUxosyS+UUp1TxofgsYmH5WpJI/4Hun61b+ahIvvPBT8/d
	2WB6TaRmrSHtZvu+wB4SzHFfUbWAum/3s3007YviAKR1ICOXUdElssSGCxLhlRk=
X-Google-Smtp-Source: AGHT+IHcW4vD/rTwFNWS2OaCi5Jdw34r12nb7/je9aKGu7zVtc6Hwxncte+NdpHXpFW0lm9xbDHpwQ==
X-Received: by 2002:a05:6512:398b:b0:536:a695:9429 with SMTP id 2adb3069b0e04-539ab8625a4mr1731102e87.10.1728045534270;
        Fri, 04 Oct 2024 05:38:54 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b43f2dsm14801855e9.31.2024.10.04.05.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:38:53 -0700 (PDT)
Date: Fri, 4 Oct 2024 14:38:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 36/51] pwm: img: Switch to __pm_runtime_put_autosuspend()
Message-ID: <c7a6glvdcnxinivxqbueox4iic2cfpx2qnthz7actsq3yw5yjj@guqmgxvebdzt>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <20241004094134.113963-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5p4ryos2rremjmow"
Content-Disposition: inline
In-Reply-To: <20241004094134.113963-1-sakari.ailus@linux.intel.com>


--5p4ryos2rremjmow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Cc +=3D Rafeel + linux-pm]

On Fri, Oct 04, 2024 at 12:41:34PM +0300, Sakari Ailus wrote:
> pm_runtime_put_autosuspend() will soon be changed to include a call to
> pm_runtime_mark_last_busy(). This patch switches the current users to
> __pm_runtime_put_autosuspend() which will continue to have the
> functionality of old pm_runtime_put_autosuspend().
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/pwm/pwm-img.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index 71542956feca..9bd177ebad0d 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -140,7 +140,7 @@ static int img_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	img_pwm_writel(imgchip, PWM_CH_CFG(pwm->hwpwm), val);
> =20
>  	pm_runtime_mark_last_busy(pwmchip_parent(chip));
> -	pm_runtime_put_autosuspend(pwmchip_parent(chip));
> +	__pm_runtime_put_autosuspend(pwmchip_parent(chip));
> =20
>  	return 0;
>  }
> @@ -176,7 +176,7 @@ static void img_pwm_disable(struct pwm_chip *chip, st=
ruct pwm_device *pwm)
>  	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
> =20
>  	pm_runtime_mark_last_busy(pwmchip_parent(chip));
> -	pm_runtime_put_autosuspend(pwmchip_parent(chip));
> +	__pm_runtime_put_autosuspend(pwmchip_parent(chip));
>  }
> =20
>  static int img_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,

OK, there will soon be a function that does

	pm_runtime_mark_last_busy(dev);
	pm_runtime_put_autosuspend(dev);

(in today's semantic). Your plan is to call that new function
pm_runtime_put_autosuspend().

I think the conversion would be simpler and maybe also semantically
clearer if you call the new function e.g.

	pm_runtime_mark_last_busy_put_autosuspend(...)

(ok, something shorter would be nice, too). Then you could add the
function already today and don't have to go through each driver twice
for the API change.

Alternatively only convert pm_runtime_put_autosuspend() calls that are
not immediately preceeded by pm_runtime_mark_last_busy() and drop the
mark bit after pm_runtime_put_autosuspend() was changed.
(Assuming that calling pm_runtime_mark_last_busy() twice while the API
conversion is ongoing doesn't hurt.)

Best regards
Uwe

--5p4ryos2rremjmow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb/4dkACgkQj4D7WH0S
/k4eiggAsFU1flBrbDR85Qa8aiEylgT1a3fs1ol5qd3VDfRb1hP2ZgscXBvN7Mtj
LN3Sw3m0+8RLTAzIu7/L2B3MaxwdqKZIgnJW/nJ6/oywUvLhmCnRn7A+MMWn/Mqg
ZLj16387tIKIKzoLAftqBeJlZTKtR88hLDwW/Ycbiay/fyu4jhse9ki4ychX0Ndl
CZKvcRAYm9Q8Ua4iS9rN3rjljk+yTVu4AQKlr0sWeu0LO6xOqmc+U9WEgU3Zzw7/
5xJ3biFTA9HUpNvgbghbqNejii74gSh24+RQVNQOClC8nlMbatHjxXM9ThoumK7H
gSiYfAutV6DU24guLnhFFkWk7Fu4XQ==
=IWJ7
-----END PGP SIGNATURE-----

--5p4ryos2rremjmow--

