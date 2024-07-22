Return-Path: <linux-pwm+bounces-2889-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6478E938A19
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 09:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D51B207E5
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8545023;
	Mon, 22 Jul 2024 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzTNQOP0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF92E40E;
	Mon, 22 Jul 2024 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633630; cv=none; b=KfM1j4Nawe06y4UMB5bllB7/5TieE0TTTYiTcs2f6gbC40L7QPGq4C2S+r7otOE0q+ff+IyO6ysuRnXtHM/oqSCKbaUB0C3xAYLm4j9JgNm086Lg/uEVe5YD0dyqdH1F8gnwwrjpkVp9FMWTardovCojuUV8Ag9TIfPjTm7OJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633630; c=relaxed/simple;
	bh=ixkQraF2mPTq1wzuLdcv4TA4A7FAN91Cxbk4sOqj6uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLj79uBeWYJkCuUysaQiR67/Ozuv0avIOvbVVcYkU00m2uhZaYQ9O/GYwF7806fh+hjGbJ0K1Ib7iI7obONCxIRxSLUlIeH75wfpSxW6p0JFxVdhH8CUcaQdbO9++jPp0r4dHypXhMiLgXsHwpVXQnWXJ5llK8yrbDtlHBtKhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzTNQOP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D0DC116B1;
	Mon, 22 Jul 2024 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721633629;
	bh=ixkQraF2mPTq1wzuLdcv4TA4A7FAN91Cxbk4sOqj6uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzTNQOP0d+wWIRDtNAaYB0J3PYtjNowxpXcwef0g4Im9ePDmObPYLkZAyhQb+0xsj
	 8lilNsuLVRj689iSqKSSVkY17a8cYtUkqYQXLoRv5HT5IgqWFMsKXlk6vaB2U/u257
	 VoGPGHEmeWMM6BsXx0POlCCCdeuzE+RP4d0TBnALuDIG5x4V/H57NBK34jRAQi39uv
	 owMqsuN7r1oVw5VzDOzT6H+3zTIoc172G9TcG+3wwfigPcClqBL4EOHWcbnWudMJOz
	 rfnpJTbu6sg6LvCSuCKdSqyWdsQgmh2G+JZPdYrv0CYrB2hK0lulj6TVQ40btjpscY
	 ZmBJ7EskYoGRQ==
Date: Mon, 22 Jul 2024 09:33:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Haibo Chen <haibo.chen@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v6 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <i3rk2h4hzwzlx5fkizhdvz7xz6sboy3jrygpgaj6qv443yvjny@mpbl5g5agxav>
References: <20240721160049.20470-1-laurent.pinchart@ideasonboard.com>
 <20240721160049.20470-5-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wihpt7aqsjmxs47f"
Content-Disposition: inline
In-Reply-To: <20240721160049.20470-5-laurent.pinchart@ideasonboard.com>


--wihpt7aqsjmxs47f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 07:00:49PM +0300, Laurent Pinchart wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the PWM function using the platform device
> registered by the core MFD driver.
>=20
> The driver is derived from an initial implementation from NXP, available
> in commit 113113742208 ("MLK-25922-1 pwm: adp5585: add adp5585 PWM
> support") in their BSP kernel tree. It has been extensively rewritten.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Co-developed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

As expected I'm happy with this patch now. If you respin, consider
adding a comment to .request() describing the effect of the register
access there. I guess it's about pinmux, so something like:

	/* Configure the XYZ pin as PWM output */

(with XYZ replaced by something sensible of course).

It's fine for me if this patch gets in via MFD as suggested in the cover
letter.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--wihpt7aqsjmxs47f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaeC1gACgkQj4D7WH0S
/k6coggAiaD4WyJ0MkiXLdxT5Zi1Zg0kkastWxpPQJWxqVSwLEQeYqIAexsB67lQ
d3/pETqIuLxq7/fts+y8bXRlKXWmzEZQSz+6QrHzJE4vapWsoqoVD4W4gOUwNKpX
ls05T892rH4rIRpxrdeOiqwt8SjgHECpANkhDnea4U9TsnI+kBQzcrJ0v+GLejBN
P/fFbLXaBpNB/R2EUImjt7xsohcnfvDpWUACje6H1gnEVRhWTgQTf5blMjKpHUMn
fFDhbBBANiieQyx1/TDWjMf38+yWfIli+wKX/LPy4KmPhb5kwhW9tHB6a1zykE4y
NGD5LtWTyneLN/JncQV0POSkbEBcPg==
=j0D7
-----END PGP SIGNATURE-----

--wihpt7aqsjmxs47f--

