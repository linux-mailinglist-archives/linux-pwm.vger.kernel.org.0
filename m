Return-Path: <linux-pwm+bounces-2481-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7B7909DD3
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Jun 2024 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0A1C20E86
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Jun 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F03232;
	Sun, 16 Jun 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZLO0kew2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486498462
	for <linux-pwm@vger.kernel.org>; Sun, 16 Jun 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718545940; cv=none; b=C8wFck/G+VnQhreqXun54dfhYLRPvvXBZjnjQ1iEYRpj6pSINN/YZ/7+3t2rfFv9oytG/Obi7/zcReXHg0pzV9YdQIRtBvTP3S2By/HcCaBsLIJtM4lGeo8y59dTOLv8YJpQUOYjQKC324PzpqOJcxVGGuqtKy8lq4emt56fXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718545940; c=relaxed/simple;
	bh=bu9Mog7snMfQs6KDA84F/yaK+IjspoX6fA3XJ0YSwrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxzrqV+F6ojoLlDB7u3y4/TGvG5D3KJg0KdjyOp5ePLLjen+E7Y778HAPdfD0ItMaMgb7OKR5I5k3nXXEwq/BC9epBGCOqYk5O7gUiz3pRdz+SUuS/uWlzwFubnmqZyoDh1A3mYbcDr0MIaZgjDe9EwMO6SZ7sGh7H3hDp2A3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZLO0kew2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6ef46d25efso449804866b.0
        for <linux-pwm@vger.kernel.org>; Sun, 16 Jun 2024 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718545936; x=1719150736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVJOf5/S/BQ++7Tmt06zBPeufq5XHjAatccdENKQCfA=;
        b=ZLO0kew2DOB7kLCNP9mWDxhk462kOEqRrwCbzvyeAlPFhfe27KVvMPZVhKZVkAh7Xl
         0+fxlkdvoOFMaMqlJAnjYsFPdIFKIuIr2Iu3Ra6av4R6ovM6x9x0So90QqM2xhO550Dp
         dmWyg3fx4uPutUIOfd4sxEe7h4S48vNCcgDLTAXpLKyKg1IF2yVp1rRy3b2Gi6ZUUrm7
         KSLluLAs8mcBp0wbE7BOX0/BRSmqlGoyOYJGUi1suZcUWO8nVbVVkipC+f68nu+92koL
         +yn3cs5/36u2anID0Wjgl0ZwJQx/ZuGCSaC/jal6nyZX0VHiuUk5RxoZFKqTYV0p1Vga
         RgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718545936; x=1719150736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVJOf5/S/BQ++7Tmt06zBPeufq5XHjAatccdENKQCfA=;
        b=UsdTK3lZyYVu9BmrIftwTsjFWjp3Cjpahv72bLJR3dtLBNx2LMUdtMIlu4mq9KnhvT
         AHSEZ+9PwJMsnYxE7Q9tdpBFNPZCB81dx/qIcAL20dfqNtOhOlXfwpwZlobVUa3APNi3
         Qq0T2z9UIahmXg1pZnqkKvTR9yCG3pWyZclwirMh0c8lK2EPT91TibC16spZD+DuJgH5
         wzUZgMNPEZvILWbnpfa46A+jPWgSoLkfGXzkIjPqsT4j/T4sA5kFNTALun879+B7Zfzh
         MASjvAOE1eK9dZ2XuPCu3qccAD+gdU5AP5v86heFVOqHtTBD0Xd6s23OLeWXAT4xqlqW
         p3eA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Vl2V8NEgMn4sUFlSNY9pVx+QA+i4PbCW6xpzK2BEmFun6GRy8Oegkw4OvIYU8oUyZgyOUoQP68hlOEu+Z+PR3YLYlibge43q
X-Gm-Message-State: AOJu0Yz21MtC1vQypRmX1DTOUatW4EUlv06pS/gqvMjQS97Q2fLAT51w
	2xczeGp56LX4sMiPcgtRX2smeCtZM3jFDOLdtn6vcK+ABF95dF5yDdw/dQruGPEgdEpcSxup34h
	B6n0=
X-Google-Smtp-Source: AGHT+IH3WlK5nGht5TKwUuvUI31oT45+8B2XU+5qpjxYRhgxr6FETxyNMI61Wq9e4b9BfDJLMiVz1g==
X-Received: by 2002:a17:906:91b:b0:a69:2288:41da with SMTP id a640c23a62f3a-a6f60d1e08bmr477224266b.30.1718545936279;
        Sun, 16 Jun 2024 06:52:16 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41a7asm411104566b.159.2024.06.16.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 06:52:15 -0700 (PDT)
Date: Sun, 16 Jun 2024 15:52:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	William Breathitt Gray <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: stm32-timers: Drop TIM_DIER_CC_IE(x) in favour
 of TIM_DIER_CCxIE(x)
Message-ID: <vhbq2mpiervp5iwsfu2cbcvrxpfq6mr63uqyonyc7xt75jponi@h37z6g43ohdj>
References: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
 <0735860960b1b38570bffa5b0de81a97f6e3230e.1718352022.git.u.kleine-koenig@baylibre.com>
 <20240614093124.GD3029315@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="khghdirpbdghwbcv"
Content-Disposition: inline
In-Reply-To: <20240614093124.GD3029315@google.com>


--khghdirpbdghwbcv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Fri, Jun 14, 2024 at 10:31:24AM +0100, Lee Jones wrote:
> On Fri, 14 Jun 2024, Uwe Kleine-K=F6nig wrote:
>=20
> > These two defines have the same purpose and this change doesn't
> > introduce any differences in drivers/counter/stm32-timer-cnt.o.
> >=20
> > The only difference between the two is that
> >=20
> > 	TIM_DIER_CC_IE(1) =3D=3D TIM_DIER_CC2IE
> >=20
> > while
> >=20
> > 	TIM_DIER_CCxIE(1) =3D=3D TIM_DIER_CC1IE
> >=20
> > . That makes it necessary to have an explicit "+ 1" in the user code,
> > but IMHO this is a good thing as this is the code locatation that
> > "knows" that for software channel 1 you have to use TIM_DIER_CC2IE
> > (because software guys start counting at 0, while the relevant hardware
> > designer started at 1).
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/counter/stm32-timer-cnt.c | 4 ++--
>=20
> The subject should be renamed.

I guess you mean it should be something like:

	counter: stm32-timer-cnt: Drop TIM_DIER_CC_IE(x) in favour of TIM_DIER_CCx=
IE(x + 1)

?

Best regards
Uwe

--khghdirpbdghwbcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZu7gsACgkQj4D7WH0S
/k4MUQf/VqW+at8uAggESZjyPhgYcHEaQ1kceLpTrHqaFJgZmlPa2zZvoQvWskUX
DexhB9bLAR7QtFS7LOgcPBUkhM5pktmjD4H3FMQl7QxmoZqF6pQZQyLagrpmA77s
yc4aqiukIH9LrPU0v7sam+PTe0QbVc6LTlzl0dxS2x0VsIW+PhfPrYLT6jV13rpx
rz6fA/jEgAOA80N9iOaE59VEc6eICE68EZv8NrcAXpx8GHBDLQ643JKssZyfUC7E
f1tcK9tUAUzK4BWhbyRgOdrBCOLOpkgMkrsF4FTKeL0c3jhbtA55jT5EeMXElZcF
SZ8TODt9DDKZ2A77+7WBHfa1Uc7tBA==
=Bi6N
-----END PGP SIGNATURE-----

--khghdirpbdghwbcv--

