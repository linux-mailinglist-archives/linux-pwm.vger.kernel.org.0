Return-Path: <linux-pwm+bounces-2526-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0565190D6A7
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8003CB2CAF6
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836C6159562;
	Tue, 18 Jun 2024 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZVNtlQw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A452158DD8;
	Tue, 18 Jun 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719690; cv=none; b=bpKuBcnOJzQU7V8y6lfMaGJVE/ctSAfUdumx1qs2RNViMuASoBv6zqcHpc3RUKvtTbwK6AENieMbl9zU70BqpVSB/FpVX8hTM2GRjqYmBHaf7oT+sw9DFvEZaLEk6Imjoao6BNXgqu8Jw8aSwpBGRP1W/ViQPnj5YmOYPuEWzDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719690; c=relaxed/simple;
	bh=e+HSLddOkm2/Sj6Zn5jFRLDHmKKgRXjOeFGjF2yjM4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxdyyFZssR6ILCMMv9HrRJOYNCJf+9nlnsKpq3nBuGDL+5EpEQq29YCN62KCS+Yeq9TiEVQu5LMN8LJ1utApwLotRDS8gSQ7TnM2fyaB/AGHLJDG+AF5FvtZqiUzu6iWRkNzJ0pz9uB0d37pzA1wO3qicCoSX9AzsXoButuqW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZVNtlQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EA3C3277B;
	Tue, 18 Jun 2024 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718719689;
	bh=e+HSLddOkm2/Sj6Zn5jFRLDHmKKgRXjOeFGjF2yjM4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZVNtlQwjcTmZjYMMCZ1ePxskEKgtoJOhbQLImw252VXz8mEaDd+XWr5Ks92lHsae
	 SAi+wlOnNFUeaEipg8JFoItdvbIyZD/7xSMhxz379HThnTOip3guJJslNRCSb2b59c
	 M3NDhZZX2JRHRUBe5PGZhRnOrgPM92bUdGtwrBnRT3arEAlgTlQF0TD3WzFK6JzMXO
	 ye56tndYgPkkCTJgkqaYx9SwAOZfzeWtFhBP4b4O4xgY/LEAFnPsprFuxME49hXGVW
	 fdSCMjNYckIflyycYVbGDPl5k8RxGISdtdkI1MEusJ3g/hksNtF2FhzLoC8JzVuQZL
	 eAcIhE0INBVhA==
Date: Tue, 18 Jun 2024 15:08:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 18/23] regulator: add s2dos05 regulator support
Message-ID: <4eab619f-6da9-4aff-b956-69d8e2ecd47f@sirena.org.uk>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-18-e3f6662017ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QRV+Pq6HQyJzYjJF"
Content-Disposition: inline
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-18-e3f6662017ac@gmail.com>
X-Cookie: If you can read this, you're too close.


--QRV+Pq6HQyJzYjJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2024 at 04:59:52PM +0300, Dzmitry Sankouski wrote:

> index 000000000000..3c58a1bd2262
> --- /dev/null
> +++ b/drivers/regulator/s2dos05-regulator.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * s2dos05.c - Regulator driver for the Samsung s2dos05
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +static int s2m_enable(struct regulator_dev *rdev)
> +{
> +	struct s2dos05_data *info = rdev_get_drvdata(rdev);
> +	struct regmap *regmap = info->regmap;
> +
> +	return regmap_update_bits(regmap, rdev->desc->enable_reg,
> +				  rdev->desc->enable_mask,
> +					rdev->desc->enable_mask);
> +}

Please use the generic regmap helpers rather than open coding them.

> +	reg_np = of_get_child_by_name(dev->parent->of_node, "regulators");
> +	if (!reg_np) {
> +		dev_err(dev, "could not find regulators sub-node\n");
> +		return -EINVAL;
> +	}
> +
> +	err = of_regulator_match(dev, reg_np, rdata, rdev_num);
> +	of_node_put(reg_np);

Use of_match for this rather than open coding.

> +	s2dos05 = devm_kzalloc(dev, sizeof(struct s2dos05_data),
> +				GFP_KERNEL);

> +	rdata = kcalloc(rdev_num, sizeof(*rdata), GFP_KERNEL);
> +	if (!rdata)
> +		return -ENOMEM;

Mixing devm_ and regular allocations seems likely to go wrong, please be
consistent.

--QRV+Pq6HQyJzYjJF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxlL8ACgkQJNaLcl1U
h9BUoQf/eoepXVUUG5VxOIXF3ILdV3eQfuvpBzl2rvMupKg2phY9zGdjfvGb2TUK
OtJF5QmEZoR/bJws+dbUekyyTCUORDrragOz9+cX9RmKfWUVocq3aClTAAUUXCJQ
LNyP0RdsbLYS6+BSXQH5cBzgYjq1cjA+Cj+tKb/henUbQbI6snEcUyYTVgtyetJl
fBLrkaotq7CZeAUroZ95qFtToQSCn7IpzU+Z9ObxIlYdiycoicJwOTmro3Q2JMqW
ySuBH/s2hBHnLi34G6JUIM94j406/nm3wQMn+7Zdw+KnGz1gOxAjFZW3s0lNi7be
lgGIGtE0qxquHQw9TITrSQl2iXbZaA==
=y3Sn
-----END PGP SIGNATURE-----

--QRV+Pq6HQyJzYjJF--

