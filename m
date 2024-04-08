Return-Path: <linux-pwm+bounces-1875-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA2089B97E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Apr 2024 09:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9A21F2127E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Apr 2024 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2A625777;
	Mon,  8 Apr 2024 07:56:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987328E0F
	for <linux-pwm@vger.kernel.org>; Mon,  8 Apr 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563001; cv=none; b=EOSUpOdOBL3vFg9RhA/18IPpxm7QoSvfOwwvna5mMMjmAaJwNAQDanngG3sTkdhDsN/zTu2ayozsptt5fv+GrMwexq7Dtg+yJ9GYciWzCqbXJ7BqPyCf4CSjIpVXZOtn9Id3sqRes6Ra0TpwIjfNCMWcEUYyIGUtdtcW47hi7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563001; c=relaxed/simple;
	bh=+y5rhIweDvmUsHQagm3QKbt+Fmptb7hS/WCUb1EAJ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyfSPc33xkifQ1VX5CMYAKmy4OEyAfpP4uAPwy9TSNgopQ/NgNgFABr+bbM8CVwq1qCd8IhdDoh0OLbJj6ydeZ4WdcFe6erdqW/gUoVPOQsBO1MKGnXU2wHfrc/RT40rxLUxr3FDHLXnIjtvkEIqDRAoLrfEpCY5Bx1YZjMD2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rtjre-00084h-Af; Mon, 08 Apr 2024 09:56:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rtjrc-00B4MM-ED; Mon, 08 Apr 2024 09:56:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rtjrc-00G4LH-15;
	Mon, 08 Apr 2024 09:56:24 +0200
Date: Mon, 8 Apr 2024 09:56:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com, 
	thierry.reding@gmail.com, miles.chen@mediatek.com, xinlei.lee@mediatek.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, wenst@chromium.org, 
	kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: pwm: mediatek,pwm-disp: Document
 power-domains property
Message-ID: <govw33edknpv5oif4txex7b47nfqbpmc7qlytqqx6oetpm34db@vilvv2s4zzsy>
References: <20240404081808.92199-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ge6rl4smjg7jdvlz"
Content-Disposition: inline
In-Reply-To: <20240404081808.92199-1-angelogioacchino.delregno@collabora.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ge6rl4smjg7jdvlz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 04, 2024 at 10:18:08AM +0200, AngeloGioacchino Del Regno wrote:
> Allow the power-domains property to the PWM_DISP block as on some SoCs
> this does need at most one power domain.
>=20
> Fixes: b09b179bac0a ("dt-bindings: pwm: Convert pwm-mtk-disp.txt to media=
tek,pwm-disp.yaml format")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

While that is a fix I wouldn't consider this urgent enough to send it to
Linus before v6.9. However if another urgent fix comes in, I'll send it
along.

Best regards and thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ge6rl4smjg7jdvlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYToycACgkQj4D7WH0S
/k5ohwf5ASXu/S93rwTQinzP8fl/R7X0RAysJa4ItkB52IZclVPQ/keaeXAs7cWO
Tx8HlVM0euKtmVIobPXh7ZoyPqe/vhqedQYbMYCSrikuWsVCyErmhnW2Kn+89bKo
YIESDSv0O6EJEVWdcapR4sOzEblnIZJyqB3TYqrT7+eK3nHMHI7E+r318pKLeFoJ
5K/UWMZkTFYIqAJXk4fKG4j3ieuH+cDPCAMhOQRtqxQ6paMXpJgt71aJD4Y+Z4sw
BGHNPKiZTWDeaK7LH1LXFimMwAiZmMDMsf6CGQ6vY/pI6jKzqyUg1R96WTV07nf1
HMKKif/gTgd+D02BlOlrwbj9hUANmw==
=iE3d
-----END PGP SIGNATURE-----

--ge6rl4smjg7jdvlz--

