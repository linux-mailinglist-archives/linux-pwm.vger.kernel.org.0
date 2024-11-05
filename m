Return-Path: <linux-pwm+bounces-4031-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043759BCE2D
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2024 14:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288101C20F60
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA61D88D0;
	Tue,  5 Nov 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="czOjtMi6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742F1D362B
	for <linux-pwm@vger.kernel.org>; Tue,  5 Nov 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814007; cv=none; b=pLl8jhkH23A3uZIrjG9EiAmKlb7LAfETapI/qxPee/PHNVz77ZR9pmK032CIO49E6MhKDR/nwdzwSQFr4qZv0AhiBiCurWeoxhkzscYov20mbLOlH+au2vyIwYp0Suc28MxmLFNwuAkhsS+MMcMVRLArJOfu1GRGBWrjfnCyKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814007; c=relaxed/simple;
	bh=pc5QJzuXwNlHJJNRBB9dWq4/nKpDZi0X5IjQ8l1OEGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQJ0olqskMP24WSnHwQ+AzsJ51zC7V78UuneoxH1XlisHNrQs2EY2DYX/fdukcDsqjexQ9V8/0NkwxkF+QnBbCoFrUdkmkNkb18Z6czCEpIYwjAUlJk/mJhTYXjotivTd891SalIWcqvRQrX41plLFrtIXIMq4v03nOTTnrKrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=czOjtMi6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e63c8678so6221159e87.0
        for <linux-pwm@vger.kernel.org>; Tue, 05 Nov 2024 05:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730814000; x=1731418800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LffWa1BzTn4fklrk0q0HnGOjhdsWJeiG56vukgWRGWI=;
        b=czOjtMi6bkXjHX7UK6AWIgYs5vPbOOrUEAQ/GzPPkQkbCTNTYMATivJyJ1oVm7dm1A
         lUSiMa6NH6iSvPvGEIN+Rc3OBSxkVfRzJaXeoyDxPMKzEZPsC6Pv5eM2ROBbhBnHHVOr
         80sMUkJDXJAR7uqoC82LfooM3e4erwm/xTr/rGCzvBtl7zA4KVDzDcNEyASbdRlsL5dv
         I9wN7Ha1PLLeITDfG1SjgUqPoJCJYlgnWn8guj0HwtfxtunKnT8gKY1snIQ7AB8bH6R9
         ymVxrmRZ5vzOIl1Us3dtuLAJfxvOr+srbBOGBCgDxlvTBt3FSsaINAu85JYuA7kBpfpo
         GPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730814000; x=1731418800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LffWa1BzTn4fklrk0q0HnGOjhdsWJeiG56vukgWRGWI=;
        b=BljXoMWPwMIScZB+s5qlvL3DjklGZPHvIiUWO5CyY8MehohSBnXUmpi9W6bUlSzabC
         n1lLEygZZRGhGVAYI5S3BAAX7DFO0UC7kInNaHjlD6Vj3g3qlt4ITAYIetcifofHGTjT
         grZ1VxlLE25R9n00Rfoqy375pBsGMjBglqSFFRG21zE7ZySxuIDiuHZXzZ/mQQ4NpeTO
         JLjMLSy8DlMN/qdVL70Isf2Qrv3eD5bhvmCtFKrxoUOpu5uWwwPaaNENhdtVQjRGUaRi
         ROajO3pv7kjJ4MSMhqtAectCJ5QfJesBL9KnN7mMPmHHqMY6V2tu9+/nu81Qq2glxHfi
         npvA==
X-Gm-Message-State: AOJu0Yxk7phPYZk4y9K1IZT9+kpNkDm4n0i12PSFgJK82vMRb/8kLjWP
	ZZ1oKJZDoavfUgSXCNwMHxqKAXktiQM0ye07gac+6nAcO+tkKcXsh/iJQbCEwR8=
X-Google-Smtp-Source: AGHT+IHl77Byq+byhY/wXdB0y1Azbt7HrbTOfHMoIQJkrWEh+tNwRQzlzXIOjX8IX57/1IHIMDKq+A==
X-Received: by 2002:a05:651c:2210:b0:2fb:5035:7e4 with SMTP id 38308e7fff4ca-2fedb75775fmr82247141fa.5.1730814000074;
        Tue, 05 Nov 2024 05:40:00 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:5c5c:563d:c49f:6070])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a36dsm1330624a12.9.2024.11.05.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:39:59 -0800 (PST)
Date: Tue, 5 Nov 2024 14:39:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pwm: Replace deprecated PCI functions
Message-ID: <w35is7slftofgexvxqtmz22nabb7g6c2euihmq5yprlninqjhm@2lqsxedcjy6o>
References: <20241105092641.49541-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikkfvdzkvbg27veq"
Content-Disposition: inline
In-Reply-To: <20241105092641.49541-2-pstanner@redhat.com>


--ikkfvdzkvbg27veq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Replace deprecated PCI functions
MIME-Version: 1.0

Hello,

[adding Bjorn and linux-pci to Cc:]

On Tue, Nov 05, 2024 at 10:26:42AM +0100, Philipp Stanner wrote:
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index fb3eadf6fbc4..9101a89447d6 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -66,20 +66,16 @@ static int dwc_pwm_probe(struct pci_dev *pci, const s=
truct pci_device_id *id)
> =20
>  	pci_set_master(pci);
> =20
> -	ret =3D pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR\n");
> -
>  	info =3D (const struct dwc_pwm_info *)id->driver_data;
>  	ddata =3D devm_kzalloc(dev, struct_size(ddata, chips, info->nr), GFP_KE=
RNEL);
>  	if (!ddata)
>  		return -ENOMEM;
> =20
> -	/*
> -	 * No need to check for pcim_iomap_table() failure,
> -	 * pcim_iomap_regions() already does it for us.
> -	 */
> -	ddata->io_base =3D pcim_iomap_table(pci)[0];
> +	ddata->io_base =3D pcim_iomap_region(pci, 0, "pwm-dwc");
> +	ret =3D PTR_ERR_OR_ZERO(ddata->io_base);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR\n");

I'd say the following is more natural:

	ddata->io_base =3D pcim_iomap_region(pci, 0, "pwm-dwc");
	if (IS_ERR(ddata->io_base))
		return dev_err_probe(dev, PTR_ERR(ddata->io_base), "Failed to iomap PCI B=
AR\n");

(maybe with a local variable for ddata->io_base?)

> +
>  	ddata->info =3D info;
> =20
>  	for (idx =3D 0; idx < ddata->info->nr; idx++) {
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index f7ece2809e6b..823f570afb80 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> [...]
> @@ -25,12 +26,12 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
>  	if (err < 0)
>  		return err;
> =20
> -	err =3D pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> -	if (err)
> -		return err;
> +	io_base =3D pcim_iomap_region(pdev, 0, "pwm-lpss");
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> =20
>  	info =3D (struct pwm_lpss_boardinfo *)id->driver_data;
> -	chip =3D devm_pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], inf=
o);
> +	chip =3D devm_pwm_lpss_probe(&pdev->dev, io_base, info);
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);

I remember I didn't like it when pcim_iomap_table(pdev)[0] was
introduced. Glad it can go away.

Best regards
Uwe

--ikkfvdzkvbg27veq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcqICkACgkQj4D7WH0S
/k6hCwf9FfFhJr9/q/dxxwMCa3IIMUvzzWR1wnuu/eyV0aJrBVzqqdLDfpQcTRm8
0Natb8Lv6Puqpl13cjMNV6V07ikxM85O++K/L+HrpgkdHSxCahTUQ8wZ3z44l9g+
/7GDgvG5Wr0T5cu4vobs6Wnr7QtChVRpj+uAMONujzJypk905MISAy6Yq+olRefx
3278plHKVr8jDtgIc4wWXggDCrvl0tBEdjbC8z9aEgzSqFGilc12FeM+BQdhlZeF
dVuJG4rgpq1Z0Wrbfb6/SZsi6j1ro61Qz+CKer6TaXcno7WBt72rtSL9SzkmheOK
dA29yo+cB1Uy7ipBoD+f156EJaSpbw==
=Y5xS
-----END PGP SIGNATURE-----

--ikkfvdzkvbg27veq--

