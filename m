Return-Path: <linux-pwm+bounces-2152-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD708B884C
	for <lists+linux-pwm@lfdr.de>; Wed,  1 May 2024 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225581F2232D
	for <lists+linux-pwm@lfdr.de>; Wed,  1 May 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDC51036;
	Wed,  1 May 2024 09:58:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D750285
	for <linux-pwm@vger.kernel.org>; Wed,  1 May 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557517; cv=none; b=dfiM0TOyNyYlArMcafu9EXKOff5KgaNpoiBrv3KI0Y7ucAu6nELHgBRERjVAqFaRJz/DZjK3r9qhLaga4lPQKPrtl+V1UI+wdTEjWU3G8DswndT6Xhz5nzjqDUPGjZlnjVDB1wNuxBa5/6gabc6IZYk9nsqQGbsHD+MMGrQS2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557517; c=relaxed/simple;
	bh=997AxUxZNYWfepdvrLIvDQasEoqkHqLQFHOlyZLQii8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eP11WwXT72lY+Exv9Ufd7cnmsuh7tf+d8gS6EleRvyja1941JRY8qVrPo8zii8RWuhY9w6/N0MwI936GK0PGzqekXgohaspIizJY6whcGSJa4eqK8l2ZPxzwu03W1Nd3d1TpmJU+qA/jwJHHy25pejVURD911nG3R26wKKctA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s26jD-00040r-Kk; Wed, 01 May 2024 11:58:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s26jA-00FJjN-G6; Wed, 01 May 2024 11:58:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s26jA-00CwN4-1J;
	Wed, 01 May 2024 11:58:16 +0200
Date: Wed, 1 May 2024 11:58:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/6] dt-bindings: pwm: Cleanup pwm-cells required twice
Message-ID: <urvvjmfhc43klpcf25rko52caj7bzxajnailzyxjm5oihk4fkw@bgxjhiu3cqtu>
References: <cover.1714450308.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="szdxq7yrzhrxeuwp"
Content-Disposition: inline
In-Reply-To: <cover.1714450308.git.zhoubinbin@loongson.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--szdxq7yrzhrxeuwp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 30, 2024 at 03:32:01PM +0800, Binbin Zhou wrote:
> When I was submitting the Loongson PWM dt-binding, Rob reminded me that
> the pwm-cells property was already required in pwm.yaml and did not need
> to be repeated.
>=20
> This patchset attempts to clean up the required pwm-cells attribute twice.
>=20
> Thanks.
>=20
> Binbin Zhou (6):
>   dt-bindings: pwm: bcm2835: Do not require pwm-cells twice
>   dt-bindings: pwm: google,cros-ec: Do not require pwm-cells twice
>   dt-bindings: pwm: marvell,pxa: Do not require pwm-cells twice
>   dt-bindings: pwm: mediatek,mt2712: Do not require pwm-cells twice
>   dt-bindings: pwm: mediatek,pwm-disp: Do not require pwm-cells twice
>   dt-bindings: pwm: snps,dw-apb-timers: Do not require pwm-cells twice
>=20
>  Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml    | 1 -
>  Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml       | 1 -
>  Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml   | 1 -
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml     | 1 -
>  Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml           | 1 -
>  .../devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml         | 1 -
>  6 files changed, 6 deletions(-)

Applied the series to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml seems to be
another candidate for a similar cleanup.

Thanks for your cleanup,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--szdxq7yrzhrxeuwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYyEjYACgkQj4D7WH0S
/k50+Af9HAfb7hEZqoitZrZpQJGfAEQ4ovY7rkYe+Funx/am38HWMgeJRHB6XBSQ
jZw2m4EmIMtLtwSdGfutbpVQ4go2PGkNlIBZARLm9ha2Rutrc/XLjR8xv8XRDKJd
HsdgLJ18P8XlCs59Y4bWoRNlov4s67pxXgebbtFpd4RREffQegvbcSB7E9Li1S36
yWTUg5WVzSFmj+ABSJvV/1RBGptlriz0mqT83TB+h6JdjYfPvjeQcsVICJw0XKG4
88+d7I+JV0N8swVlC/dHTemuqF4Kqvyet3maAoFedVxsSjFkQ/A0jtOSlpPlyQjY
P4ZZGiWsDHHlImMQGlisbyH2oWHpoQ==
=sHX3
-----END PGP SIGNATURE-----

--szdxq7yrzhrxeuwp--

