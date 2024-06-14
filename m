Return-Path: <linux-pwm+bounces-2455-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66191908949
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 12:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1ACB25C0A
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D125192B9C;
	Fri, 14 Jun 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IY1s9lpB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF235FBB7
	for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359571; cv=none; b=oNR65+bU+mM1DeBYjkI5O2DhPmDkHhJTgLTHJ80kVIo7G+Ye2OuzEGLyufDD5/0Vzs9ckLA6dHQYFn9FtS39maiRO06VfolWIKUPF2P+Mtme+CICoZwxPr814KErHA43WigF7IK8Rhj02Xiznmw7jJH4UIOhU1zKXkximDT4R1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359571; c=relaxed/simple;
	bh=VLNaXn/lm7t6E5mAaLknHXlsRSaNaczlupRMV67F4k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+Pw5yKWeG8pnhtRt2C95Do6WGyy6Nl3cCFvS1LwrT4Q+v6o8YgOfuRCW3CpZdicrzN/HQ5xJtGViGmMMt12uzYKElj4GBefeIdXlx6SvOGHaAgx4c1nLx+lq7KBMTUp8xfj29Iv5RgFHUONEQFhNkakj+fvt6ude6oyz7ZCzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IY1s9lpB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6ef46d25efso259188466b.0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718359566; x=1718964366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1RQFOycNLmuTPDyek4OedVGRn07iS0hgYarPk74x8U=;
        b=IY1s9lpBron5deEc23/86zrRwF7AbBCj6PaimAZSdy8WkeaLQX31s4Gcg2T1KZb5vN
         L62A1HHxQacPN2BWI5K90d077All63i7thJLddlVQANejPB6jPr/k9LR/XDB+ptrw5BN
         yd8r4aztyuZyMZvbdGQp3Zh1dNdOMZib6dmiBYYlbgcAkjq+RfpUD6IEWI8FddwveeW9
         hgv16XTBNOgPDtiIm8tTqpDZia0y9dM/C0zBAR/izke4ElIRwHXv9mrdro0H0KTa5Ehr
         T8mAquxGiVgUk5I0MBYXVVJTzmfRpRcFDW9ZiZ+QQB9BOdMhrf01ncLnPLJ31h/RP3gp
         c1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359566; x=1718964366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1RQFOycNLmuTPDyek4OedVGRn07iS0hgYarPk74x8U=;
        b=jqpFwSPRuCfwYhuJ0OlbR6C3iUYOChN996ymrxgOi6cqAqC3ScCzVcy0bCYCXkeEN8
         uOqOGLU6YLp42Y9Hn5oWrBg5PvDoRuXLkaGxWvy/IQl926SrOmRBdbhMXVH/371zM/33
         TiEb/A8u0NmHkW8AGYZREcTJX0GJbRmSqKwTn923t84ERXzpvAuE2HmZsbKO1CdgSDTz
         avGYi6tLFcuSGiExgBlyDaKexpFnIRGwtSyFfBmto0f/K5gWuMxHYYsZUH/ie9XFwgZF
         +FlQyhH2gMnuNeEbDGneVM8A4Cv0V+lRBq2/xrQV1FPuKA36QhSZC68tpkocNh5HaUmd
         CreA==
X-Forwarded-Encrypted: i=1; AJvYcCX2xytOBNM70R0a+FFt1ssGvSsZuxjRsCG+cED5DYxz1OBQzvO45aRRitcdSd+WVpjDdSuVYlrM2tQnnOO96IP+5759Pf/kuWAY
X-Gm-Message-State: AOJu0Yy5Fjusj4FiiDUtj09bC4zoQCQAN+H6ZjaNGW2feO4zui77T/GF
	Bnk2lXdpJ4pz/qmykNo5crvr6hR3sm70UJmb9srCIbgw/U8aRSqfEvRwdJosbJI=
X-Google-Smtp-Source: AGHT+IEBKcircL4D5yvI1Uh0Bdlj+m1RTUCtN9vKd4L45BNE7heuj8fMqHurvRePVoeMMv4jFlhDyw==
X-Received: by 2002:a17:906:184a:b0:a6f:5a9d:37f9 with SMTP id a640c23a62f3a-a6f60dc5128mr122290766b.48.1718359565241;
        Fri, 14 Jun 2024 03:06:05 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecb46fsm167018666b.129.2024.06.14.03.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:06:04 -0700 (PDT)
Date: Fri, 14 Jun 2024 12:06:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sean Young <sean@mess.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] bus: ts-nbus: Use pwm_apply_might_sleep()
Message-ID: <xj5mqnte5dgs4yzuku6g7gnprgm43tdbunxmo6o4thzreyraok@kttvkz5dhaei>
References: <20240614090829.560605-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56vgrc46vq6e7trh"
Content-Disposition: inline
In-Reply-To: <20240614090829.560605-1-sean@mess.org>


--56vgrc46vq6e7trh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[To: +=3D Arnd]

On Fri, Jun 14, 2024 at 10:08:29AM +0100, Sean Young wrote:
> pwm_apply_state() is deprecated since commit c748a6d77c06a ("pwm: Rename
> pwm_apply_state() to pwm_apply_might_sleep()").
>=20
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/bus/ts-nbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
> index baf22a82c47a7..b8af44c5cdbd0 100644
> --- a/drivers/bus/ts-nbus.c
> +++ b/drivers/bus/ts-nbus.c
> @@ -294,7 +294,7 @@ static int ts_nbus_probe(struct platform_device *pdev)
>  	state.duty_cycle =3D state.period;
>  	state.enabled =3D true;
> =20
> -	ret =3D pwm_apply_state(pwm, &state);
> +	ret =3D pwm_apply_might_sleep(pwm, &state);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "failed to configure PWM\n");

Thanks. I guess the patch becoming
8129d25e32b7fd0f77bc664252321f3a16bb26b8 was created a while before
pwm_apply_might_sleep() was a thing.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Arnd, you merged the last changes to that driver. Do you want to care
for that one, too? If not I can apply it via my pwm tree.

Best regards
Uwe

--56vgrc46vq6e7trh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZsFgcACgkQj4D7WH0S
/k6Ciwf/V640UlA3t7jmkjfZ8cO8YihHm54XgFoqLTh48Akc4MU9mW4UaZWM+IC3
3hMfpLUzyPmUGsupnsfcyKOWa8trOtzTaiwB6M33NqO6qkdnQfPlOUzSLoYzwXqX
xUMlUF9MKxCu0BoOiqgRq+AJLn5Egurwt3MmTSfqolf3dZd7GijmIzVCUh/KM6bq
vt/NoG2nks4bUURM4Kn+jz2yNoSIVmFZx7IwEeekV5NpxMldCbJQ5LdK6opvnyRR
0ebjw1qXO2wxucowDaXYNJcC6K2qOlwvxlONZFiO7E/7H/tmWnD6f7KM/fEG1hvC
r+D+dyMoPviFNgnheoCEVCqjKGcm1w==
=6gnx
-----END PGP SIGNATURE-----

--56vgrc46vq6e7trh--

