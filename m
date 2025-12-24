Return-Path: <linux-pwm+bounces-7828-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F943CDBDFE
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 10:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1BBA3002518
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A133D33343D;
	Wed, 24 Dec 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xombkDZ4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602F32D0E2
	for <linux-pwm@vger.kernel.org>; Wed, 24 Dec 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766570328; cv=none; b=GOxrJiZ/FhDGYM+VDfdgkeHrDBkqs4qs2JPe8HTGzvYAvDHXNTbkmyy7ztbZQEDXM2H16qZqylnf4fmOLG6jRSW1E3ShpVcVLR1oTpzVGvuN0C0TbKcbUua0aoOaEejZxm9duz04sEh6T2se2XABbXrhXM8+nkCx9OjI0jNTS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766570328; c=relaxed/simple;
	bh=3W9jCb+QmhgFO07BnEKeRfiQa/LuwbGaIH7AYV4ri+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoXoyoMzo+DgSFdYwNWJv3Dr480CAzZIhq6aMHQ9NV3nLPRhxN8qghxpuBlnvFDCwiv7djomGY59/j9PAPO2gbtl6kmLXxyqGN0cYjPe5vjLJ07y/KIg007Dzln6Vl2mGkyrMg6z3I6IpsiIrZJXD+/oQIxhO7DWShqKmX38/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xombkDZ4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so41698905e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 24 Dec 2025 01:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766570325; x=1767175125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3W9jCb+QmhgFO07BnEKeRfiQa/LuwbGaIH7AYV4ri+U=;
        b=xombkDZ4chWs1DpjcjBpRfJ9VBlZJZ6SVzqcOkvjHkl+AjQCq5W/oUf4N8+kdy52ib
         wkNlMgynxeMNUYm2DDlZK8PrV6bdjSrf6nIN5ld5lvhSfDdQagSn8LjCNpRVc8LLSBlf
         JrQ+7HJrWXfREdItZidRUR2KDy67fWrRLF+MCTi2W5kvr4uSSwPy8RmQYfANLg2cUBps
         gQlXemTFcJCWPiX6gsbSPXizBwwEZ/vjJWC1B5hD9yhmiRuM/92kejr/hfEKjNS2+qPm
         i1qzzKOkj4cp5RcwVYfKpqLxhEZO1ZkkABURbFJYrNwMvP8+9za77hKh0vTPgK+DQl1B
         eEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766570325; x=1767175125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3W9jCb+QmhgFO07BnEKeRfiQa/LuwbGaIH7AYV4ri+U=;
        b=ENTTZtbEYelE2T6jCmi/4EG5qaW4JW6kgEgMwBakL8H5QI0PMm3J/QSIWJI3u0alRo
         6LGMxZpXCOCAoX2C+PgaZ6zhJQ8J/m8YF/wQqg9DzZ/n5M3gtK+opqoeASDfn5rJE7PD
         57O9qLZiqkzFnY7WrX/ngnBXSEM92e7ROte5WBQbybPGm2EEPWRdBG4hoeF7pLo/662w
         Tb2bt/3Qne5dsSVZdnwSQjZvINtoAU9gD/8yd+qU8rp2fZsSwOX7Kz+L/K/4VxnbrV5r
         KNuUj7VkQH1VjD9ykihF961wYSGrHDIcplxgokxyn13nYtPQrGXRGAVghGob8s1cKC1R
         CKQA==
X-Forwarded-Encrypted: i=1; AJvYcCUdpk2TkhZjO31kfqhLW30igVm8EtsMC+rl/lsEocSSvYf4dp3m3IB8j3ZHwtWf8KM9tOPJuskogUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0nriy2drm4WZOhiIoizILOgq+4ZFU5Mg5wAjmJ3IuDtwkt14g
	oRZJ9iGRBrDwc+xtaBQhFhbb6mLydfuuhD7Qx/ta8akAEKibwGGksNKv2v4M48EzjWk=
X-Gm-Gg: AY/fxX5sMXD48oMIuc0cJpdUqbpY872NOGCRmFnWSDpR0lyozCDbWOhsuRg7+/YUjal
	FDo5smX7PzLUAW1/v6Sveum4O8AEP/E7SG6U/TCGXfhbK4JjRhoizS7Utv1aeyLGe+d4guWy9yU
	ScG6RzWuhtTT7/czAhtR31dPh2G8U/mUlcLM3bQELR5OlbiwXfpK1XRqyp8oeIoNfti87q0xFKa
	shGmRPWBEGnC2wBo73WVVGRkC0xIuLylVnc7qmkhJz3+FG2Oe9Pqzgc6MlOKc5b0RNviuNchhAM
	d9c0lNMWowgqbTNylbfSuatRoQn2zYjsU6dkvjQ9Z+jgAb07lG7mq4Zi1oZCCQDbk2rLLAgptBm
	rLlN6qVSJVrBavBaXX+SDi15ms9UpKQPUaQBj/hvd0Fv9GoTntx8XvcYRTgpkoxJOHU0+zg7KWu
	p1XghRCq37Kek1xPscrJA60feJkG3O16MLv7EfPSZ/X5n4kypB
X-Google-Smtp-Source: AGHT+IFfcuTV7Ug+hHX5tZTCG4tq3O4PaTRJvfFv6G9+yLiBklGAMOZE/zio57FP/aM+ckx9YK7JaQ==
X-Received: by 2002:a05:600c:1988:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47d216f9b5cmr104213055e9.2.1766570322064;
        Wed, 24 Dec 2025 01:58:42 -0800 (PST)
Received: from localhost (ip-185-104-138-126.ptr.icomera.net. [185.104.138.126])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47be395d9cfsm138801615e9.0.2025.12.24.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:58:41 -0800 (PST)
Date: Wed, 24 Dec 2025 10:58:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Introduce Allwinner H616 PWM controller
Message-ID: <5ih4qxr7572x6fakxjsx2vrxnt3yey2dtvdyaiwyuvulivh3ef@hebpjfdginev>
References: <20251217082504.80226-1-richard.genoud@bootlin.com>
 <6113404.MhkbZ0Pkbq@jernej-laptop>
 <160e221e-98a8-4097-8340-94ac7d208136@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="isiyzcztmhye4ftq"
Content-Disposition: inline
In-Reply-To: <160e221e-98a8-4097-8340-94ac7d208136@bootlin.com>


--isiyzcztmhye4ftq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/4] Introduce Allwinner H616 PWM controller
MIME-Version: 1.0

Hello Richard,

On Mon, Dec 22, 2025 at 10:17:07AM +0100, Richard GENOUD wrote:
> Le 21/12/2025 =C3=A0 20:12, Jernej =C5=A0krabec a =C3=A9crit=C2=A0:
> [...]
>=20
> That's why I put aside the pwm-clock and I went for this instead.

I havn't tried to understand the issue in detail, but would it help to
use assigned-clocks to make pwm-clk suitable? Assuming this allows to
drop all the clk stuff from the driver that would we very appreciated.

Best regards
Uwe

--isiyzcztmhye4ftq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlLuU0ACgkQj4D7WH0S
/k5ZeggAmSXzq+7SM5fhXqm2YGPnsK8wxgPcAF1ZdU4MGph24TU4R91q/56X2Ayd
OUxDHsO4bEZXGwd0taoVdkCJf3WcDipjGJ+lfKgRCT5569BE5seDZDASgIlnPu6O
ZRog3BGrI85GM5Gq/sG8zpiqdbeK2/49huTSo2VRN28+elurTzP7MXMEVdJ4ZLPR
fmvo/ERCkz4giB8YgjM75WsImYiEehzraLTJ1EXhBq5WxbqMMwEKy6s7NT6t5H1+
U+/8buxQllY52OKOyqLBBWbQpaAqSc28evvjUOikxuLAMk/I2FbPHnDoJRUz7GRO
Ufu2ihMbS+cRebq2spwZSq1RoiCx/g==
=uvSc
-----END PGP SIGNATURE-----

--isiyzcztmhye4ftq--

