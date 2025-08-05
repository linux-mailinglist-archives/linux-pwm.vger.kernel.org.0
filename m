Return-Path: <linux-pwm+bounces-6958-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA8B1B4D2
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578FE182B2E
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080F2749DA;
	Tue,  5 Aug 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MppPOKAE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35C2749C4;
	Tue,  5 Aug 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400196; cv=none; b=FGJDQhQ3w3F+X0GWRQ1SpD1nkScQJU/3lW4EH04QmpVmuzo34geMNM8xphjnJ7GgAVsyz2vVMHbhhGXo+Cdxj5m0BzDx1ur7Cy/7fo+ROSiHXNPvTYwJLIuk2nGXaMHIMtYXHI7j3+AcGXG1wUOUT5PID8Pinw8gkk3xUPUXeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400196; c=relaxed/simple;
	bh=4XpKY+hrV//JqY5IB0jEGLiEF04z3a1ypjzN/Ip/ON0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKONJF7B+hWiPVqNU9ZiF6K4yprxvP05kQUs4OleJbRXE9RPPUS52WdiP3Hd0JVvsf/OvtMtQMvTwUg5LM13VLPvP1n2lZOEnQ3X9og5f6NYToCQwgOtMSUNkUAVqjvTkqVbOVTBtl6z1ERVFD+G8csC1LjwNN1vUpXK/iPJTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MppPOKAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF7C4CEF0;
	Tue,  5 Aug 2025 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754400195;
	bh=4XpKY+hrV//JqY5IB0jEGLiEF04z3a1ypjzN/Ip/ON0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MppPOKAETMD/BqZRdpVGHGh0jhnuJMh9KObQqr9IRR1G0wYcPe5YUe9bHfzOlG4po
	 0SC44ly+aXPz/iMhRAM5yj4RkanAgvRO5IZ7sgNigcRJPM4OQ/ESdBLOs4DAbhmL4g
	 nUVo8lRu4XRj+P19miwzQjWyepxUCuvk3y8h80yJz65ZWG8Mm7sZ+X1+hJV6gOgLWC
	 XNLxrSVOcVAPGnQvDiAOOcB9UoLHf32eYEwBwriug0ierfD3VZolCZi3bwghbnfj6d
	 fNdpad2Brd5jze6/lOtyc/y/7NyN+WXKvz1UzmkWGSOGIbB/Ay1LC9Krj1GH20Nq6d
	 8udjMyFgWLOCw==
Date: Tue, 5 Aug 2025 15:23:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, kernel@axis.com, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: meson: Remove error print for
 devm_add_action_or_reset()
Message-ID: <sveurgnigarzdjreweoibcxkkl7rekcpufuwqr7bxcrdx7zdrd@kz4ohstmfyjh>
References: <pndwm7ikt8v.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qpe4lsz3c3n5r2b5"
Content-Disposition: inline
In-Reply-To: <pndwm7ikt8v.a.out@axis.com>


--qpe4lsz3c3n5r2b5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: meson: Remove error print for
 devm_add_action_or_reset()
MIME-Version: 1.0

Hello Waqar,

On Tue, Aug 05, 2025 at 11:33:36AM +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
>=20
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Changes in v2:
>=20
> * Split the patch to one seperate patch for each sub-system.
>=20
> Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/
>=20
>  drivers/pwm/pwm-meson.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 8c6bf3d49753..e90d37d4f956 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -520,8 +520,7 @@ static int meson_pwm_init_channels_s4(struct pwm_chip=
 *chip)
>  		ret =3D devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
>  					       meson->channels[i].clk);
>  		if (ret)
> -			return dev_err_probe(dev, ret,
> -					     "Failed to add clk_put action\n");
> +			return ret;

On the other hand the call to dev_err_probe() also doesn't hurt, right?
And when we keep it, it is clear that this error path is correctly
handled without having to know that devm_add_action_or_reset() can only
return success or -ENOMEM and we don't have to watch
devm_add_action_or_reset() to not grow something like

diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index ae696d10faff..0876cce68776 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -156,6 +156,9 @@ static inline int __devm_add_action_or_reset(struct dev=
ice *dev, void (*action)(
 {
 	int ret;
=20
+	if (IS_ERR_OR_NULL(dev))
+		return -EINVAL;
+
 	ret =3D __devm_add_action(dev, action, data, name);
 	if (ret)
 		action(data);

=46rom a subsystem maintainer's POV it would be great if it was easy to
notice if a given function needs an error message or not. One excellent
way to cover functions that can only return -ENOMEM on failure is to
optimize out the small overhead of the devm_add_action_or_reset() call.

See
https://lore.kernel.org/all/ylr7cuxldwb24ccenen4khtyddzq3owgzzfblbohkdxb7p7=
eeo@qpuddn6wrz3x/
for a prototype of what I imagine. Oh, you were the addressee of that
mail, so you already know.

To make my position here explicit: This is a nack.

Best regards
Uwe

--qpe4lsz3c3n5r2b5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiSBb0ACgkQj4D7WH0S
/k7uTAf+IV4xlBSvJged2+TaatRIHPURN3SCK5I88TP02Cl5uM6b7hApBTqA8Ypd
g3faAO9lFQSRxGgQ7s8VAOsXAMJbmYzc0yFsAANBo1Nx587Q9QA/sVHFNhWPF/hs
v0wUECR915RNR3BgakctzGvtF4aS99tCgkVS8DszU4ngP9ZYtqqHi6vztBHrZgA4
61kveQRsL2xsBv//xmoN5cDtmcns2Gr7nAC3G+8lgq/kkSWiJ6BKMhpi1Tvz/2T0
XagBlQK6u66Aa6letKYpYuDGCAoBxre4ecvDcTHTOCiwLBaCO7/cQKBWDPMUpnYl
lgExQoYJuwfH3aw6jq1LbSFplv2QYQ==
=NaYJ
-----END PGP SIGNATURE-----

--qpe4lsz3c3n5r2b5--

