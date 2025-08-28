Return-Path: <linux-pwm+bounces-7177-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09BB3973D
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Aug 2025 10:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E7816E7B7
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Aug 2025 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3D2E229E;
	Thu, 28 Aug 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+HJy0Ew"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFEE2BB13;
	Thu, 28 Aug 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370477; cv=none; b=gMNWP+e+o2a5DpljYnyL3M82eL8SMoc05pcNi8SMBErByaT6oC5gUCidL/fhk1uAdXqQCh2JWBmLNBnh5+j1z2O4i4PbMQBUsdxaSizlM++snr+HcqwLxfUk4d84SdsVqhMSc0BEL6EcX19OPfAaizGf/IkihP5vNybYcZvbmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370477; c=relaxed/simple;
	bh=3Tr7ht9RaQ1mmZzlO0RWE9wqu1IpyyKJ3Q2xB3+M7QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKfVGegQvWqRGjdTM0q4Np7JNPp7xx8oHsEjnEZAWg6txIP2LVC8AWl5+UUYaa4AGSVRTMm7VYeSipBwguuEld0/s7/Nn3AbBNpSv1VcZoA8C9NkEoVbCgJaMqaxgPMbBQQaXOpKAVRbemIUILDkowdMAz6qCMxoIAudhbYXruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+HJy0Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17307C4CEEB;
	Thu, 28 Aug 2025 08:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756370476;
	bh=3Tr7ht9RaQ1mmZzlO0RWE9wqu1IpyyKJ3Q2xB3+M7QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+HJy0Ew6hxAO2ybuI1qit4HkoBlZ+7pblW6gIadxFLxIlQlYDAJ55feMih3YrlkG
	 U/OQWKmE/4fIKVNQMqQzwFvDc3o/1U7xVm6gSEdDeCI5Z9IunyRsh7TlxXEIlRwDBU
	 tKeZ1J3RpTChQ3ALGyv/P+B5yQea2XBiaxUz745RBIt9UJxfNT0OPIwEEmcvgoZ1JO
	 BxDiW8gmo2zQlj6iqsRWaEwTjnAX+ojxq9lDBHc2d/9//CpdDzqXwjxd9Cfe9yAPzE
	 /Yj45O64u0VGI9XSt2XEMa2C7ZoHxNLnyQY9zT+LQU5UQ6McM9rQtRxUj2hTcNzLhc
	 7VcwBTal4Mo4Q==
Date: Thu, 28 Aug 2025 10:41:10 +0200
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jean Delvare <jdelvare@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Nikita Travkin <nikita@trvn.ru>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mathew McBride <matt@traverse.com.au>
Subject: Re: [PATCH v3] dt-bindings: mfd: Move embedded controllers to own
 directory
Message-ID: <aLAWJn4yKukvaIro@finisterre.sirena.org.uk>
References: <20250825081201.9775-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ok3vOuHD1C4RwPWT"
Content-Disposition: inline
In-Reply-To: <20250825081201.9775-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Filmed before a live audience.


--ok3vOuHD1C4RwPWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 25, 2025 at 10:12:02AM +0200, Krzysztof Kozlowski wrote:

> Move several embedded controller bindings (like ChromeOS EC, Gateworks
> System Controller and Kontron sl28cpld Board Management) to new
> subdirectory "embedded-controller" matching their purpose.

Acked-by: Mark Brown <broonie@kernel.org>

--ok3vOuHD1C4RwPWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiwFiYACgkQJNaLcl1U
h9CEPwf+J550xIwuw8AaUZo+9pOj1PHT+041UckMzvPlutaXGGQ0l4+E8dgv/+F5
axHPEuZztWIxiajWwLHso4HcDQbXtz7U1ALEbjoR8G7/JPWMxQpS0eO5N1bRmUOj
rc6R/jGPW+GoVTTmHjq0++Xh2GRWNt6QnW4HzGnn0RwHwxsRYmk1Yr6y2j94fhNP
QiAb/bFASf2nQ7bV1md6JI9BUwyrwJgqBI0/pXB7fzptET77UeuwX+D3S3Pl/zll
mFnmPDlfcdfIRP3D4HydviJc9WBRhkXmcnRa51abojkg2IcABSiTgbW4juQomD9G
7CJMLCouGZOv5SS74saYf09DXOJltw==
=G0XQ
-----END PGP SIGNATURE-----

--ok3vOuHD1C4RwPWT--

