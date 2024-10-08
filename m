Return-Path: <linux-pwm+bounces-3545-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7E995896
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 22:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702A2281633
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554721642B;
	Tue,  8 Oct 2024 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="18fWZBkO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF9215021
	for <linux-pwm@vger.kernel.org>; Tue,  8 Oct 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419890; cv=none; b=FH8wQe9dMm/FWhQMfygiYgDMo7bSBiuy5tyRJI98f29q6eay4dCFg0/so2HaoGY20II8UUcPl6xuNai89N8myM8QIfzExcbaZHrhY+T5jg545JNrmvSL+psB9qIJTUpal0SmMVL1w61WQVf/0nZKqtYSnEajPEV8UKHJlSoKhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419890; c=relaxed/simple;
	bh=jBKc56vBxPYaOUWcC+VFZKlnp8sdizUoPysD1KL2n2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9hxaFCZfFLwnFxoE8pcsaXAydYU0GwOgr6rmCIpMx5h37u2P1xfx0CYRFXuLNDr9PGcovNB3FjmTovUUbKSdbeWgDCwU6ohDhLNESS2h6hWDxuFyTM1f5joi0uLr58h9u/KFnYHmubIdTLd+NWQR8uJat4+UppM/s1D+YqgT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=18fWZBkO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9951fba3b4so404169066b.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2024 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728419885; x=1729024685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBKc56vBxPYaOUWcC+VFZKlnp8sdizUoPysD1KL2n2Y=;
        b=18fWZBkO9cDHNP5XkQ39MRLClR2iDC1zySqkncD3SsZKu5Rgs7Dl8pH8lKJp2p962M
         ZQCXVVOIGzjU5UY81OJcQw0kiLkVxi82epBgL4dI4RqabJSCfzsJV/w4rEU39jnWCoY7
         yG6e+6Huic3MWrYC1oSE1/3jjgRJEPNAKN3ZTXu7yDRI5rDcTHA6JVJ03K88LUsNIndN
         hxu1wyd0FmRvkB0XvGhYzl60f9BZXhmzkblJFg6rToFyXPRB5BLZ/aQ9AquxPwlKwAUC
         26vZdSJyysWVJfHabIaR2zJD8Gkd7meZi0reyXepjlExZa64VCzKDkCcaGkjDZZZyvzq
         ni5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728419885; x=1729024685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBKc56vBxPYaOUWcC+VFZKlnp8sdizUoPysD1KL2n2Y=;
        b=XVecb+5WiP9E0xaeSuUY9x0DlgQ/qxOe/6pWvPv6bmqkaXpt6zxa/JAfwTRfN0QgLp
         iJXrHgwPpyvm569Mi5l9tEJJjjnS5vp/P6HsptbEznMN0IG8Y+4fWnpbCXeLdUWOUqoM
         dS7Kb40MuJqBsRB33zUklEioDEtv6UCn6kgF23MYf6574AYpUo5PYiTxnOlK+iQHawrm
         Q65MCZh8ggbGJwGYZ9nsRQEiZmj70sHs+azB5T4sUsyPF/EJ4WUiJ4P3SyO/CdbcZCJy
         xV5PRyQHskNZl/ys/pEkf+kXoQApSckeqdC05wUX4V2Cx4BhxwYyyV5XCjE/rlXSRg/o
         pytQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxhleFe3d0iXDPUdoMlLiWmcdc1dIgbA+VM9+TVxmEUzXTwOe4pax6CKdPS6hKQS61UfH9nw5M988=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFNF7icMI/u09Wdix3+vgxTIYIUUSns69IQPTXbmF8P7QU8Gq
	sIMB46t5bYWLLosx2a5+A26OZHdsHccUO8C5UhlfNEGXETRzUi/H9oyJ6bAC324=
X-Google-Smtp-Source: AGHT+IFQsuFQDnMORn6KRqls83kXMRALTmz1xji/Zv3nzyXsaV17OwyYMIY5gtZ7u9n9SjQRNHRlFg==
X-Received: by 2002:a17:907:94d4:b0:a8d:250a:52b2 with SMTP id a640c23a62f3a-a998d114bbemr3268366b.6.1728419884897;
        Tue, 08 Oct 2024 13:38:04 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:c420:a9b6:c5e1:5b65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a996274deeesm196971266b.103.2024.10.08.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:38:04 -0700 (PDT)
Date: Tue, 8 Oct 2024 22:38:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.cirrus.com, 
	iommu@lists.linux.dev, imx@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org, 
	asahi@lists.linux.dev, rafael@kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 00/51] treewide: Switch to __pm_runtime_put_autosuspend()
Message-ID: <ttmnzgsdyng5vab63pvj7csrotbsmwnultjelvdotrvyg2snac@iv7afgect5f3>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com>
 <20241007184924.GH14766@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ocqjla6tcmukjn3"
Content-Disposition: inline
In-Reply-To: <20241007184924.GH14766@pendragon.ideasonboard.com>


--2ocqjla6tcmukjn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 07, 2024 at 09:49:24PM +0300, Laurent Pinchart wrote:
> On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> > On Fri, 4 Oct 2024 at 11:41, Sakari Ailus <sakari.ailus@linux.intel.com=
> wrote:
> > >
> > > Hello everyone,
> > >
> > > This set will switch the users of pm_runtime_put_autosuspend() to
> > > __pm_runtime_put_autosuspend() while the former will soon be re-purpo=
sed
> > > to include a call to pm_runtime_mark_last_busy(). The two are almost
> > > always used together, apart from bugs which are likely common. Going
> > > forward, most new users should be using pm_runtime_put_autosuspend().
> > >
> > > Once this conversion is done and pm_runtime_put_autosuspend() re-purp=
osed,
> > > I'll post another set to merge the calls to __pm_runtime_put_autosusp=
end()
> > > and pm_runtime_mark_last_busy().
> >=20
> > That sounds like it could cause a lot of churns.
> >=20
> > Why not add a new helper function that does the
> > pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy()
> > things? Then we can start moving users over to this new interface,
> > rather than having this intermediate step?
>=20
> I think the API would be nicer if we used the shortest and simplest
> function names for the most common use cases. Following
> pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is that
> most common use case. That's why I like Sakari's approach of repurposing
> pm_runtime_put_autosuspend(), and introducing
> __pm_runtime_put_autosuspend() for the odd cases where
> pm_runtime_mark_last_busy() shouldn't be called.

That's ok for me. However this patch series isn't the optimal path to
there because most drivers (i.e. those that already today do
pm_runtime_mark_last_busy() in combination with
pm_runtime_put_autosuspend()) have to be patched twice.

The saner route is: Only convert the drivers with a sole
pm_runtime_put_autosuspend() (i.e. without pm_runtime_mark_last_busy())
to __pm_runtime_put_autosuspend(). Then add the mark_last_busy() bits to
pm_runtime_put_autosuspend() and then drop the explicit calls to
pm_runtime_mark_last_busy() before pm_runtime_put_autosuspend().

(Note this doesn't take into account Rafael's position that
pm_runtime_put() might be the saner option. My argument applies for that
conversion analogously.)

Best regards
Uwe

--2ocqjla6tcmukjn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcFmCEACgkQj4D7WH0S
/k6xnwf/QOZhbtT562rFFa3JIiBatDxTcqyEXoXClrP7jSyQFY/VFzq2S2jRHOFt
wM6zQUX1bTUqDtC4HozJIbQDjLxd3qFgc5RoTRLV8VhRJbcq9cOo5Nf1h4KJ5Ip9
nhpzoHwUHoEjEHj1f9UvEWfnFAVCSLFxgb14ZDHZyb2pQue3G5OYI2f2cJYT8YVB
xQktDFp7rUu4xWDTzoIxNKvR1Ipy5fGxdf9R2/+IQhW64sWuDG2ZH6tAmfn6mEb8
ecspbesJx+NMbZ06Zl7wqBvyj/DpQGgPaCnWUQ5cI0Of/kOzqxh4+65JK68CLLs0
/Goin2zz55IZITGC5zHuAA07bW/c7Q==
=7Wup
-----END PGP SIGNATURE-----

--2ocqjla6tcmukjn3--

