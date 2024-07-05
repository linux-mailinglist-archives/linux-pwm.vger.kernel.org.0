Return-Path: <linux-pwm+bounces-2703-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C5E9283C5
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8201F23CAA
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD413B59B;
	Fri,  5 Jul 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zBZerZ0n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203B13C8E1
	for <linux-pwm@vger.kernel.org>; Fri,  5 Jul 2024 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168629; cv=none; b=PgCsk3HIQ0K065j/WX/js04mt03KYFDJittQb2hFRAYx5jq6gAHqpO/aCYKpw9GXRDhEs8Xk16sZxFww677aMj5vhQ8eeZTKnIMyf4etv15ECIRgyPMHnDZEO0yuQEk2/IIj9ce+j4Fg2PTq67U0n/hyETjwZw03GlrhAwpmiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168629; c=relaxed/simple;
	bh=N8rCHa1I4sgFtzb1vM3z2YWBnAsUvprjZ+nJxT2CuHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGlsluWbfLiacfuCcGQwwjqKRODwZHNeEe0DWyLnTOM2v71iCjjqfNSnZvS4HTtZHwNQxVw4K2ye/H52EgEVXd2lB79/i1X3yo6Cl+5tCK97fXvuiZ5/c3Jl+3EL08/NbeAHQYLbMoemKVLoQzlslolWrI9KRppLizmMVd7r/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zBZerZ0n; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a75131ce948so159431866b.2
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jul 2024 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720168625; x=1720773425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N8rCHa1I4sgFtzb1vM3z2YWBnAsUvprjZ+nJxT2CuHU=;
        b=zBZerZ0nFjdR00wRzYBdM/lzmhU8rNdjf8p0AqiBIhDrwGD7AoL9/AHue/E2Zv2Gh0
         klm/SLw5ayh4FBBpCSIoMEoDgwufa0xSTFBZqQh7bIIgoFpOVml7tJalu1S2VQklgDUb
         tsZXgCrmLIJUDbow+wvjFQspwUV3ySoQYY6lf7786j3uuLXvtG08rGKuonCcAwZh94bW
         hbWw+h3K0FAtyvhTTivKgV8Q1mOmeDt46FDFhBVvJNihbQ3D6+lRs5UV6qSEilav7CP8
         FlRj6uBaoZ+FyaYkN2om1SYwUQxb5SH8QzDFBwp/PajGLkn5y2Bk8zmwGyXtfWdk4Zan
         SWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168625; x=1720773425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8rCHa1I4sgFtzb1vM3z2YWBnAsUvprjZ+nJxT2CuHU=;
        b=ZiejeC0W8N6IUeZKLzvx9kITUzD4GaCnxAUrrdykiDDFChY0Bm1Hi4E1vQlItqK5mV
         g2R/FAhCL3eFFpSXHWB4D44iuHKz/VHynbHtl9hPFSb1oHVccYMnZTjIQLpci4AFFDKv
         9xISQue+fo8PvSe+M2A6Rmmo/dpI3G/01vCLBdEFzwC9xV+DE4feRUEoGCbmHI/wshFh
         yBfroKvrga8KD8Pp56VcFFEePew4W1/Ig983dnskrfXIreQ6k98/lsZi0GjgEMnfXaJR
         JH4Bbx4kQvvNwHxQXu0JYvSajLROnLDmBVufBUUGLxmHuYr2/03KJHU40TtatYR477/2
         5RqA==
X-Forwarded-Encrypted: i=1; AJvYcCXvWg9sizZxK+tfU1jW6w9eXuqME97E83dBUKxl+ZmawffSDuKV0+kv0wWNRgcpBz29qrq2rHplfr7L/Pvz96A17XCH1nKhmtxA
X-Gm-Message-State: AOJu0YzsOkfG+DDdzRn/OpDmSdu9cQ46WoOqIqVqamAyZ/b0MmhAK7bY
	QzkvuDhQe6WpuFf8S+UJLp6xYLOf+14IbdVITEs5bXFxZ7bTChJijx+go6rGZks=
X-Google-Smtp-Source: AGHT+IFXFoWhebyQr0YuYTGjy3MLP45R+JoDvwfT0VEQ9Xipcm+cS/RYvVODpxwLxGtYhBStzQssyQ==
X-Received: by 2002:a17:907:3f8e:b0:a72:4d91:6223 with SMTP id a640c23a62f3a-a77ba712396mr273313666b.62.1720168625352;
        Fri, 05 Jul 2024 01:37:05 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aafba04asm661823066b.97.2024.07.05.01.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:37:04 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:37:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [PATCH v2] pwm: imx-tpm: Enable pinctrl setting for sleep state
Message-ID: <uai2zamrzwoqqs5hdhszokti7jldta3jxeurronrsxxqbkd4rj@vl63xy5gmm7i>
References: <20240702164514.11007-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lzkne5ihs23cswnk"
Content-Disposition: inline
In-Reply-To: <20240702164514.11007-1-shenwei.wang@nxp.com>


--lzkne5ihs23cswnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jul 02, 2024 at 11:45:14AM -0500, Shenwei Wang wrote:
> Apply the pinctrl setting of sleep state when system enters
> suspend state.
> Restore to the default pinctrl setting when system resumes.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---

I applied this patch to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks for your contribution
Uwe

--lzkne5ihs23cswnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHsK0ACgkQj4D7WH0S
/k6kpQf/Sil4hCVBSHGfXe4/yB7Y2iSISkBFv+Wb/GBq+HHHjM6cx6tA3O9I5X5Y
G/PvSSt07CGpzjzGGpRK06hDVuqxQoYj3A1iqtTSEjuqW3ui+QqDG1RZ7ScE05GR
VpAslfs8cb+AivFgy2IIlsEgFKkR7qYfFwFFKyMeKIqUh8JQlynD2G0pFpNxKv3z
pey5Z2lgttmUhnzIBfityangmUl5Csqzh3MtfOMRsUk35ypyNvQK5Egjmi2QXBdo
g1tZWkCv6S8z0eFpFO5yC30+WQi/Fi88fpcu/TUBAmAqGnpMPE545E3YNIJ1018F
UiiDyQHhYQ8jfkKJF9naDJMAFeCSwg==
=pREe
-----END PGP SIGNATURE-----

--lzkne5ihs23cswnk--

