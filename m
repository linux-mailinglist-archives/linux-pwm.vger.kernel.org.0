Return-Path: <linux-pwm+bounces-2710-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECD9286BE
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EFA1C22979
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AE6148836;
	Fri,  5 Jul 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RGmJkZ3r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0D1487C0
	for <linux-pwm@vger.kernel.org>; Fri,  5 Jul 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175128; cv=none; b=SX+EMTe7uoeERqVltihJNgQ8EDOqdndG+8TT6MmKFwpeuvv8ibK0kQe/9KuyDs+32FJ0HiMdn/mS9VIUsOBa1KH9Et4NUmDVY71ieY0xGsCkZZfS8WC3YLN5SDiATlNTt2DZnb1Tli3GdA1RY2RB089PZdVNYqa38T2vnFMFDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175128; c=relaxed/simple;
	bh=ywsX3rqyJDEnXGfB7lQ77XNLltDqNQ0HeFlGYMpcJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1jo/Qbw8fb2YKOp2avCsgFKgSnRxX4Z3su3dNA0NXFkOqGGuFu9chT7OwI+w2Phdvyjs0QGUOrrT28nFQ49AVUryK7JEQ/zN/St4pOUVowZqwXRiAR4UhMGKW7YnZeVD/thvOCkxA+d0QyrN0Mp5ryh/o504L/SDx39ccF/WuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RGmJkZ3r; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso1833257a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jul 2024 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720175123; x=1720779923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywsX3rqyJDEnXGfB7lQ77XNLltDqNQ0HeFlGYMpcJkU=;
        b=RGmJkZ3r3bj40PduIzvLPK0kztdWXK23bUulHnecEBaRipm56OTeBakzp8PvGlqp4V
         Q354leq7vKwD9y0ORvLrn4ivpSpUBj+1exyERBbkJKk1Vz0IVlKqbZsQ0a1FJzBzRNdB
         CABo2wyO5sXbb4I3UgchHtXyGHyZX0DoilWLh9E/ovZE7dSVKFK+VVVPIzISGoIO3Avb
         SB9KQbS8KKI0vqR0vmx+liZUE0EF1LDbYcaJ8Z6OOIUFTTYJogAAs9Sr4cntnH9bDz4p
         1n18Xt1vlLBwQnOtjmq5l62OJ7RbfFBzuQYIRv2njI9sznqyaUzVbUWuYGUnXpInwPfn
         DaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175123; x=1720779923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywsX3rqyJDEnXGfB7lQ77XNLltDqNQ0HeFlGYMpcJkU=;
        b=dVCf09tL1k0GKX8NX+HR+Z+OiLHPdUNOrPx1g4vKud3rs1w+SdpqpigkK81BsDNU42
         FEgruVZG+EHRmeAalA+w97Vw+7vfe9f+CoxHQJEy1FVTSZEC3vPyE/XC+WKz+VxjkvFd
         pPEj3gOVXX1JQcpvTtiqMcVEVZ/K8w3Oh2R8PuIWlkYngIOR+XrP68KinPDx/7Gz5gGv
         O993aPoybuB7mxeuR9B3ettLLTJSY2OYhevQWWmP35JbhlrekCMSdVJHjakFwAmjgACK
         sVp6+pXeNW0Frga+W54GRMEMj/lh95EVVJ/p467QOIJPWOx2+yoF2vzWB/Rt6DWQapvC
         oREw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pzgbpAzGZheo7DvLmzPGZeIpH+HwW87iS1M1HCgfy6aR1nQUG4BjIfObFJjHGCOJjlGVAPifTAsk3Izj4nOhFF4FUo+/6ycK
X-Gm-Message-State: AOJu0YwdWob93npN8lW8Ad8J16y1cYJ05ekONPqg9VymOVlt31K2to7B
	mdDynp+sV257nMq/+TtXKmEJIO+k1V+f513f3Zf828eBvnxx0um6c5rTPpCJ1s/h+aoaxhMotZ3
	B
X-Google-Smtp-Source: AGHT+IHrVKzJibG1DmMinK/eI7ZRdyf9y3+X603s3gHlos0umcceNm4Cu2VqtwH2Bm5lvFEqe26iMA==
X-Received: by 2002:a05:6402:3594:b0:57c:6740:f47c with SMTP id 4fb4d7f45d1cf-58e5c6366a2mr2586980a12.27.1720175122761;
        Fri, 05 Jul 2024 03:25:22 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58ffe0f88d0sm366991a12.85.2024.07.05.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:25:22 -0700 (PDT)
Date: Fri, 5 Jul 2024 12:25:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: xilinx: Simplify using devm_ functions
Message-ID: <vfumnk5botofe5mk746kqivsnzfxvimn2fz57rtxsdzdzxsjvc@ma3ro5df6plm>
References: <20240628063524.92907-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pu6l6bnwpzdrd2g6"
Content-Disposition: inline
In-Reply-To: <20240628063524.92907-2-u.kleine-koenig@baylibre.com>


--pu6l6bnwpzdrd2g6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 28, 2024 at 08:35:23AM +0200, Uwe Kleine-K=F6nig wrote:
> There are devm variants for clk_prepare_enable() and pwmchip_add(); and
> clk_prepare_enable() can be done together with devm_clk_get(). This
> allows to simplify the error paths in .probe() and drop .remove()
> completely.
>=20
> With the remove callback gone, the last user of platform_get_drvdata()
> is gone and so the call to platform_set_drvdata() can be dropped, too.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to pwm/for-next with Sean's R-b.

Best regards
Uwe

--pu6l6bnwpzdrd2g6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHygkACgkQj4D7WH0S
/k7j/Af/fkhiOgbpjlVGDl4SdA66m03wL/TRezmBiA8vf9freUOvBPmfE4iVKrTy
Bq5ONHqq36aQcjE+DBSyUiYPqXf/Bnr8cA5158UdcrskpPlsDb1GLvihH6BciBGZ
abe+miOAQz7cAha1I0C12pQeNLZHtH6W6yjjkBxnHbmSdmAuL4CjtBAiGt1a0Ui6
xf5RGFyfwhwKY+GNW6lrmMbsIfdcxWIQld9Nwq1RwFiycZOo6XaGvUMeY4Rqnl7Y
3xSeYQg1c4nJjXDz539RRWr6P0Q7fLtmyYbxO8lx1X8p/dSrc/u2xfaKQbJ9Rqfi
O1pMvDeWi22ZFZbOw/AGk1e7crR63w==
=/Qlb
-----END PGP SIGNATURE-----

--pu6l6bnwpzdrd2g6--

