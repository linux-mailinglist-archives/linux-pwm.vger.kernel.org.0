Return-Path: <linux-pwm+bounces-2651-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9791E9C7
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68CA2829CE
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC1382485;
	Mon,  1 Jul 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DEkHqXYF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568B1366
	for <linux-pwm@vger.kernel.org>; Mon,  1 Jul 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866738; cv=none; b=QY7Pd/5g38qBEzQdboGECXSzOtsy75iZTrx8+Bt6OnZE2ScjbXAEaB8q4ea2sO9cY9iBZQ57844yW0sbzmP/iaAXrgee35JOkaBS6fisaBRw1q3L9n27890YeHTNWaTt3cz7XtE/8vw8i/vhrx3Oy1nGxgzAJkWC+WzRhEwLj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866738; c=relaxed/simple;
	bh=QZySv70Ao8F90chExN804qXvzZ2AC8LdFY40TUG2sU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqLZsiF/cc82J8ynFs+sOomPihDQdgPNOrC7Hdll0AyPZRS4HriwviB2RKvVIkv+SSphoUjfheIXpkQGC+qE3fI843Ay06sP4tPuqSNi82qQVrnWCMhkuUO8iTNdNi9OvvUN1Gtx2NsiuPmcuxeL6nvybCwvo36bm/IFsd8ry5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DEkHqXYF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7241b2fe79so371600166b.1
        for <linux-pwm@vger.kernel.org>; Mon, 01 Jul 2024 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719866733; x=1720471533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QA3rQcJ2PGuabVUic3t7CU8jEmUAM+rP5I8eyjHvpt8=;
        b=DEkHqXYFqxj3R2VSKpbV/TOY56k1wpWNrqiBriampWj55ywPmHN1vHN3eQ3VWEjVw1
         Quyi25ed654X+XjlV0a7kyYCYFRuPUUiVsILepFPO8StxTfspnP9yfejHFyke3cpmFC+
         zqfTbtM07KfG3+N5BmHB2xfQv+wQtc7/bfNne8mplCzgJ7FYJxCzEqrn2J0qP0sUPtrC
         ed+bOt05ALMsgDlNVMqPWzY/7X2Jqeq4sVV6nQ3ImBKdtLfb2Ncxp++9duQGKf5y5BuG
         8mO6X8R+/XW8S9XPsZsMS5ScczD7qTKd7fFQYE7BxmS2lE/5gvXo3AuOJHVtULq0aAMX
         +QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866733; x=1720471533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA3rQcJ2PGuabVUic3t7CU8jEmUAM+rP5I8eyjHvpt8=;
        b=G3Ej3pyEMtVRxlWn8w3qGHEtv9XMfDRHRiirleC/qz7xrxS2qyw505FRTEMyqVMPiz
         qeWMGjM2UKjhu3Fzs3QJt6hnRZj0dzjYb1HtMfbrzGzMfhGSOJ4sF5DFUf03Sguvc2Gn
         OVLH3sDJ/ShWzIdWSU6X2u1pxXbxiFTR/j6hSDUsoTq0hqbDvDYjD+D1jmxZGjlpw9kD
         xfp+HfNQ7vyX4RUQV7FH/Z+jshRTc7eC/p2eI5GwZH1k+t5QI3TvxPc7NnhkoWERzh33
         7jCjFZmS0f1MUyZBCLOedqipWV3RoUOI1KR2dWmS2AJgmi8IWGHou3o3WcX10vTLaE62
         i94w==
X-Forwarded-Encrypted: i=1; AJvYcCVcx3LcVg8fN3VrdcLrdR0DW1IU/vSRkXaLtBdOEALT1DHG9hccUp+fR75zXsioCwgNjb6lRl1hSxpUS6wgE5CusihrR516x7og
X-Gm-Message-State: AOJu0YxuDWM3vGmo1kO+rRKt8qyYuoL4gloa2aFf4Glb4eKmoN0YqxYM
	QsE9Y9zvA3g9VNHnllMbQQvioL45qceHfz8+m34ArOe6pMoeTwyAa/jmtd5aafw=
X-Google-Smtp-Source: AGHT+IFCEPxpqCTJF1ih21dkFS8hIegUWvXYCQ0ZLHtxp1c8x9erK5AfAGL5mmlQSXKipx7/97DM0Q==
X-Received: by 2002:a17:906:190b:b0:a6f:4e1f:e60b with SMTP id a640c23a62f3a-a7514474201mr402020966b.36.1719866733208;
        Mon, 01 Jul 2024 13:45:33 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab08ce96sm359017866b.154.2024.07.01.13.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:45:32 -0700 (PDT)
Date: Mon, 1 Jul 2024 22:45:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [PATCH] pwm: imx-tpm: Enable pinctrl setting for sleep state
Message-ID: <ewrvieusxer74yi7dlp55sfgy4n7u3o56ytrfqijkurapy77wi@f4hgxlamr2cx>
References: <20240514200534.73847-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="omyqdy4rsqphw56l"
Content-Disposition: inline
In-Reply-To: <20240514200534.73847-1-shenwei.wang@nxp.com>


--omyqdy4rsqphw56l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 14, 2024 at 03:05:34PM -0500, Shenwei Wang wrote:
> Apply the pinctrl setting of sleep state when system enters
> suspend state.
> Restore to the default pinctrl setting when system resumes.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index c50ddbac43c8..19245790c67c 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -393,7 +393,7 @@ static int pwm_imx_tpm_suspend(struct device *dev)
> =20
>  	clk_disable_unprepare(tpm->clk);
> =20
> -	return 0;
> +	return pinctrl_pm_select_sleep_state(dev);
>  }
> =20
>  static int pwm_imx_tpm_resume(struct device *dev)
> @@ -401,6 +401,10 @@ static int pwm_imx_tpm_resume(struct device *dev)
>  	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
>  	int ret =3D 0;
> =20
> +	ret =3D pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D clk_prepare_enable(tpm->clk);
>  	if (ret)
>  		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);

If .resume() failed (consider clk_prepare_enable() failing), and
the resume is retried later: Is there an unexpected (though maybe
harmless) imbalance because pinctrl_pm_select_default_state() isn't
undone in .resume()'s error path?

Best regards
Uwe

--omyqdy4rsqphw56l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaDFWkACgkQj4D7WH0S
/k50jQgAnXkVLOJ88QBZ9v4dnYEkZbYVa0Bu71kfnE9wNjh0HIp8PRY3l7Bv2yfm
0PPGnlE2bGBPK2bk47/Eax5bb62aJI289VRFiUwJKC6KnwnRcnxhxNvJKIp+LrTH
H08Abx12NlJIPdIT4fQX1N/t73bjTgVqiF2nTJVYdz12+zcLK7Hg3RtGfoIL3Nhn
mD14IrTQCfdCi7redh8L/joCMnQNrYPIV2wp73+fKV2vZlNvdVLPzl+XYmXfYnVh
yqwJgxcPEFBFcOGAv+qDctn4cScX0axDL+4MvGVC+2qorOrDuFw823DICchazexe
UiYNeKCqEmoHWUiHdCsckBeheH4MJg==
=LYsK
-----END PGP SIGNATURE-----

--omyqdy4rsqphw56l--

