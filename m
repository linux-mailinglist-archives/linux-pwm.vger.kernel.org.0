Return-Path: <linux-pwm+bounces-1077-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29C83CE46
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 22:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377A8B26550
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D213A248;
	Thu, 25 Jan 2024 21:13:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484413A242
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217223; cv=none; b=iQzMuU3rKwzws9kq2u+nizwYQvAG0+vZLPsR3mrM4uk3hMpUbKsoDIrC9jMY4Mlv3JQdyV9KBg+d+aN8GcjI6jBMsviuQ1WNJm0vxcPc47RFoRo9itXHGBHtzysu1bK+Xt27ecykMGEigxSW3ts2XlDEc+DiPPt0jHaHHZtEejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217223; c=relaxed/simple;
	bh=XfTpl7ZCji0713DaXc5kyRqYgTqhfhPAce0nC47R2Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJt0sy7Zh/6MjgupmkDqbuJc29ywQ8xMi6N0wM3IU5bYxPhd6nKNDpy9f1ZZvXm7lN+YsiiXMXi/rrCY5e3TvL9peIl0+l3Nab7+WpWeC/1bIB5n1euxw27OWD2drjunja7pDt3VGgJyrmre28qKt/J+B+ePG5zguOIMJ2Ttpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT72W-0002Y5-4f; Thu, 25 Jan 2024 22:13:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT72U-002N34-VD; Thu, 25 Jan 2024 22:13:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT72U-00893Q-2o;
	Thu, 25 Jan 2024 22:13:34 +0100
Date: Thu, 25 Jan 2024 22:13:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, zhaochen su <zhaochen.su29@gmail.com>, 
	Zhaochen Su <Zhaochen.Su@unisoc.com>, Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: Re: [PATCH V2 2/6] pwm: sprd: Improve the pwm backlight control
 function
Message-ID: <tbtq2rtixo2dkfeuainsjzhymehkym3zvrjuh6hrpg6znnbyzg@ppl4ztw2t2bh>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
 <20240125025533.10315-3-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3eufueza5633f7n"
Content-Disposition: inline
In-Reply-To: <20240125025533.10315-3-Wenhua.Lin@unisoc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--d3eufueza5633f7n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 25, 2024 at 10:55:29AM +0800, Wenhua Lin wrote:
> The pwm-sprd driver support only 8-bit linear control of backlight. Now,
> new requests of supporting 9-bit, 10-bit, 11-bit and 12-bit linear
> control of backlight are proposed.

I would expect that you can determine a sensible value for mod at
runtime. Also adding this to the device tree isn't hardware description,
is it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d3eufueza5633f7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWyzv0ACgkQj4D7WH0S
/k7Azgf/dUHAPnyIf/XXxctd065kx6rEUD/YFEWzCK3lpm00SgG6+Ed/IGxfJp9x
y3xeE2QT+vmt1LR2ZppdkUgtiSX3NcSmRTY7cK9zX45KJetARln7vBIuK0kLZE4k
nK6cr+09OoQNXpWXRygk+DeLzpds5yK8o2uviAin4R2OLfzpalzofVg2zHXKeTfN
hkNWCftPeSpBuK4/AO4SpBzbI40ZB689Ge13KxTnWsfNVvJvprWD4mQMrnYYz9S0
pDTYwcyfKH/e7yv7u4taoEmH0DK6qkNHaPvYC4T1TaJ1ifPSsw1MtlGBEndm6arT
ASx7tzFbkJQyb/CC9p9lcYa8KO0YYA==
=uuTL
-----END PGP SIGNATURE-----

--d3eufueza5633f7n--

