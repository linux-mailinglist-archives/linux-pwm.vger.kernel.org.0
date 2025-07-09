Return-Path: <linux-pwm+bounces-6799-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78BCAFE133
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 09:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB35A4E51A4
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877326F463;
	Wed,  9 Jul 2025 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="orQ8efhA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB32AD2F;
	Wed,  9 Jul 2025 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045797; cv=none; b=dkJUkOmo1bheFKsHo6leVnT0qkxh/jMtSNPSugAbLUD/Q7T4dT90OCp7shgH7m2siiBaAS7nYZabv+AD54t3+OGP3Rpx0NujuBpt9PopaloEnnWzg64J4HG8Tnz+tECzqSHHjtIWd+lkHrR3DnU9K2hqnGG/lJT4ibRM9GvFT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045797; c=relaxed/simple;
	bh=q0ZQ0QrJfAp5C5X+jeNN4b0UDlY8E81ZtxAgCpRn+y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8kvz1XvWl/NecN80QR5LYcFfpiNmJkYVW2J99uRmYg4xZaLWJwdp9SA514WU0NBMEPd7tPZhM8yuvvZ2jpDAPbpFTJQ9t5+7YFADC/KJ2yttbyeBACgr/byiBb8J+gob4qmBUNsppxX0weldXa1LmrVFgxHZNKd20xYkP1tOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=orQ8efhA; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=BS97jhDzzUjHilWkR1sT96zjI2f6GoRHScLPeEPg0RU=; b=orQ8efhAs5v/QafXjseL9pXPI/
	CgaVQ97Na5+Upe7AffCWgKzKclIueLLeSr2poR4A3+cdqCc5Tkufd4htI5GsURYhYZW5mxkfhnpXr
	5ezQccvInW7nwm1p1x2TFO8fAwLZvKI2sgNWQjAz0GoCsWvZNaJMra6m81ANjGODJ7PXvaQCYKESJ
	0Gw3nLDwyfs/UPk9uulyn8UZn2BGbrLZNcX6UYjg6sP0Iz3tUvBvwWyV8RcrddWFU59MvqiHEHiIz
	w5ZCETu3nbXgEWuguQe87tnyoP0eTCScwST/H1L3E3qYohjbgctjSV+rW8AT+0KMgP8cGSrTCqfSb
	Eef0xYSQ==;
Received: from i53875a79.versanet.de ([83.135.90.121] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZP8t-0001Yu-5E; Wed, 09 Jul 2025 09:22:59 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 4/7] soc: rockchip: add mfpwm driver
Date: Wed, 09 Jul 2025 09:22:57 +0200
Message-ID: <8203440.zQ0Gbyo6oJ@diego>
In-Reply-To: <20250602-rk3576-pwm-v2-4-a6434b0ce60c@collabora.com>
References:
 <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
 <20250602-rk3576-pwm-v2-4-a6434b0ce60c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Nicolas,

Am Montag, 2. Juni 2025, 18:19:15 Mitteleurop=C3=A4ische Sommerzeit schrieb=
 Nicolas Frattaroli:
> With the Rockchip RK3576, the PWM IP used by Rockchip has changed
> substantially. Looking at both the downstream pwm-rockchip driver as
> well as the mainline pwm-rockchip driver made it clear that with all its
> additional features and its differences from previous IP revisions, it
> is best supported in a new driver.
>=20
> This brings us to the question as to what such a new driver should be.
> To me, it soon became clear that it should actually be several new
> drivers, most prominently when Uwe Kleine-K=C3=B6nig let me know that I
> should not implement the pwm subsystem's capture callback, but instead
> write a counter driver for this functionality.
>=20
> Combined with the other as-of-yet unimplemented functionality of this
> new IP, it became apparent that it needs to be spread across several
> subsystems.
>=20
> For this reason, we add a new platform bus based driver, called mfpwm
> (short for "Multi-function PWM"). This "parent" driver makes sure that
> only one device function driver is using the device at a time, and is in
> charge of registering the platform bus devices for the individual device
> functions offered by the device.
>=20
> An acquire/release pattern is used to guarantee that device function
> drivers don't step on each other's toes.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---

> +/**
> + * mfpwm_register_subdev - register a single mfpwm_func
> + * @mfpwm: pointer to the parent &struct rockchip_mfpwm
> + * @target: pointer to where the &struct platform_device pointer should =
be
> + *          stored, usually a member of @mfpwm
> + * @name: sub-device name string
> + *
> + * Allocate a single &struct mfpwm_func, fill its members with appropria=
te data,
> + * and register a new platform device, saving its pointer to @target. The
> + * allocation is devres tracked, so will be automatically freed on mfpwm=
 remove.
> + *
> + * Returns: 0 on success, negative errno on error
> + */
> +static int mfpwm_register_subdev(struct rockchip_mfpwm *mfpwm,
> +				 struct platform_device **target,
> +				 const char *name)
> +{
> +	struct rockchip_mfpwm_func *func;
> +	struct platform_device *child;
> +
> +	func =3D devm_kzalloc(&mfpwm->pdev->dev, sizeof(*func), GFP_KERNEL);
> +	if (IS_ERR(func))
> +		return PTR_ERR(func);
> +	func->irq =3D mfpwm->irq;
> +	func->parent =3D mfpwm;
> +	func->id =3D atomic_inc_return(&subdev_id);
> +	func->base =3D mfpwm->base;
> +	func->core =3D mfpwm->chosen_clk;
> +	child =3D platform_device_register_data(&mfpwm->pdev->dev, name, func->=
id,
> +					      func, sizeof(*func));
> +
> +	if (IS_ERR(child))
> +		return PTR_ERR(child);
> +
> +	*target =3D child;
> +
> +	return 0;
> +}
> +
> +static int mfpwm_register_subdevs(struct rockchip_mfpwm *mfpwm)
> +{
> +	int ret;
> +
> +	ret =3D mfpwm_register_subdev(mfpwm, &mfpwm->pwm_dev, "pwm-rockchip-v4"=
);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mfpwm_register_subdev(mfpwm, &mfpwm->counter_dev,
> +				    "rockchip-pwm-capture");
> +	if (ret)
> +		goto err_unreg_pwm_dev;
> +
> +	return 0;
> +
> +err_unreg_pwm_dev:
> +	platform_device_unregister(mfpwm->pwm_dev);
> +
> +	return ret;
> +}

I still had this lingering feeling that this _is_ a MFD just with added
sprinkles, so asked Lee on IRC about it:

	<lag> Looks like an MFD to me
	<lag> Yes, you can use an MFD core driver to control state / manage single=
=2Duse resources

So, citing Jean Luc Picard, "Make it so" ... please :-)

Heiko



