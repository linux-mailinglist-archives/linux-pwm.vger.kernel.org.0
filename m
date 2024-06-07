Return-Path: <linux-pwm+bounces-2381-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CCF900A92
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6C0284458
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF2D19D079;
	Fri,  7 Jun 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vz1LTUe9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46719CCF2
	for <linux-pwm@vger.kernel.org>; Fri,  7 Jun 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778100; cv=none; b=MD5u7twh+pWpHFcFfr1hQq6X1oPNpu+06zXk6RmQfUUuS2fuiA+HZt+u1JkMPg7YKDpRZPr/CpmZZqr+4M/2nfj3a0GtNw8KUB4ZJGYW5ohKwZrE8RrRW4WIkrEk5AMsB3H7oYwUXxTuLxPxs3BULgIqgiuE3ZFfQVrudE5SSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778100; c=relaxed/simple;
	bh=JSjugDn364e1bR2NBfOIb6HAziv7A8jZrYbuA88Eh+4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3noULO6XA/iok4e+C+fiRhzOCx8DT7G5N4s9fKtONE+MmyKxcpuw5yThbOjvs4yqKARAowe2Dc0+iib9HiThxNplGs+LozMmK7Uq8/eG8knpH9MS1VuZMSeChTns05bZqhfu5E5plPeK2cyuXpwa+63lp9kGoH0SfcW+cR+Hgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vz1LTUe9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4216badde75so7014505e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 07 Jun 2024 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717778096; x=1718382896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSjugDn364e1bR2NBfOIb6HAziv7A8jZrYbuA88Eh+4=;
        b=Vz1LTUe9I471TI69Ynuiuhq9MswC4g5uooJcYJjaMDtAqCc6UddtnVD25Egc9n9Idq
         7nufaQ/AnSE1/FanmqWl4vpHz3M9+8rQtAGTIkfehR+dthNkMG59dMXz/lRgwTcrgwhV
         BZ1mlpPYYYAu8Gqx666X+SwcpOJkC+DMYY9nQPIwylAgzj//b1bTGho5pHWXBrXcn72t
         SSKHCnqYgEmsnvxZaca733bYXntpu0UFRn4XIx8wmU5qkvyXMuOBzVBtRROo669ovwYC
         5zq1uGrBmSi5NtQv0M9dsY9IlskcwlPpFpT5VXxd+zQE0zBtpX07S9HzKBYbHyFQm2Ju
         bNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717778096; x=1718382896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSjugDn364e1bR2NBfOIb6HAziv7A8jZrYbuA88Eh+4=;
        b=D0WjnASLzkokkubnJqfz/3/IzJovn/AMbineB3qMLYy4SNRu+WpoNM9U35LlTY82ji
         /WA5fd6sRfXccTHNJ062/yuXVJrPyDOl+jJmlfxkpyyxJi4IiaE2EbPXwRD0FpHk+hUv
         GynXUwMR5emRcorRD0g/LaWgfDrLKweXkqm1NRppyP4yWOav0Bz5clliKADuAXvRaLpt
         wWBvzcOCfnVqwEBL5gu/svB7XeEjLh5WPRBIwdNEN7dGBmn83bmA3NLrGV7lW/QssgDx
         IQte0QgBkuqIr+zo4121akqUQ9wgZjSggwkinXvBGTD088Wpn95o8PwZ4VpY0NdBOpEP
         mxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHNE+iWI8IbF/4whVp7mEe05pl2dNpMm9S3DYoABC1sH0IoAAVOQtVfQEnK+spFkZ9i9C9uGQVL0qph2ervSXOucgXmtlZZDba
X-Gm-Message-State: AOJu0Yzu5AwlLHZFohJ85FzQjU4TWazGVAqvI/jtvzBk+DkhWuicoZRn
	LhR/iYeMfw1p+1HzDbbtP2nLAddg6GEAUd4nVDwzDkQIxPl6lr6FHHuNm7IcYdA=
X-Google-Smtp-Source: AGHT+IGpGEuV4DVZ1kdf6ue+dBm6Ke4RvEdYp3g9xEjXsaFgOxYEd6wAXfkcbKsCsHOsq8Dy8bGbhw==
X-Received: by 2002:a05:600c:3c83:b0:41c:13f6:206d with SMTP id 5b1f17b1804b1-42164a2e9d4mr30060715e9.25.1717778096151;
        Fri, 07 Jun 2024 09:34:56 -0700 (PDT)
Received: from localhost (p200300f65f283b0017c92b05fa289d44.dip0.t-ipconnect.de. [2003:f6:5f28:3b00:17c9:2b05:fa28:9d44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e719sm58262335e9.3.2024.06.07.09.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:34:55 -0700 (PDT)
From: "Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Fri, 7 Jun 2024 18:34:54 +0200
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: add missing MODULE_DESCRIPTION() macros
Message-ID: <vunkvcpe7omv5tbsyw237hhauzyrhf6nujwvyv6vq5zd33udee@5b36qxbz5mjx>
References: <20240607-md-drivers-pwm-v1-1-27237a2bec6a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uegcep6av77uozx5"
Content-Disposition: inline
In-Reply-To: <20240607-md-drivers-pwm-v1-1-27237a2bec6a@quicinc.com>


--uegcep6av77uozx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 07, 2024 at 09:02:33AM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx1.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx27.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-intel-l=
gm.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-mediate=
k.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-pxa.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-samsung=
=2Eo
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-spear.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-viscont=
i.o
>=20
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> This addresses all of the issues in driver/pwm
>=20
> Let me know if you want any of the individual module changes
> segregated into separate patches.

Looks good to me, I applied it to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--uegcep6av77uozx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZjNqkACgkQj4D7WH0S
/k4LyAf+MocX0RpPC44cCBO/dFFZlEnU4+NMAXx+vRXpg0ASWbWuBgbMvXujfpeo
YRQZYgDgLp/7/FndOQIPT59C9fFbWz0UdLPSiT/MkN+cbRAoiaMXD5JqiTrORPFq
RFbNwOtXzQoRAEceczkKFb65oV7rwmyNyIBN9Vv3Ce/o+avvmlqdAziFU/smNwKz
en3MhIonz85eSOessjikio9bmBGGFzT8US8WiD8Ya8zcQUZ/i9aXH/verkoyfsb/
9hIlW/QY+mBn61RQeVHuF6O5W5Trnq4/sPf2TtnicRafEYBtwNFJRZmDviEqVp3g
UVN+CF/yOMS6eo/89WixvZXyYMNuEQ==
=bpJ1
-----END PGP SIGNATURE-----

--uegcep6av77uozx5--

