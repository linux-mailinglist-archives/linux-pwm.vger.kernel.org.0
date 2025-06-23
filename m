Return-Path: <linux-pwm+bounces-6473-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B736BAE398E
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3D7A6E9F
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA71A23183C;
	Mon, 23 Jun 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr+osGXC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA24230BFB;
	Mon, 23 Jun 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669877; cv=none; b=GBCQbE1LRyblrVcG9f0JDS+7wpktEEkEJYkBzoKwiiuLZE4nWXGdaVyqDf0dTDl0siS62eDhYWqLq2UiSrCql0rZqyvFx20W+AG+73vKvGHqmsk3fMTguqGbLzqXAc97KpDngqI0m5ug4EWCI5vEY3ACNWf2i/K+9uaf8gsAxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669877; c=relaxed/simple;
	bh=Mw5fokAaXa5VnqKAPXjpTNXw3aceShhfmvpffF5X+c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1CzjDq8a9NXB4vgIlFmvLpdej7h7ZjXViJhR+BZjoAESgq9S5MKrmnffOp0aiq34OYK3qEoKItKGfnUUzjXsM97lK7JXaH13//WEtia8PnBX9juEMTYWvKaHdRwZDGFnXsgcIZZvLmK0GiSlr1MgdraATIQD3EEsde62lyB9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr+osGXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2B9C4CEEA;
	Mon, 23 Jun 2025 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669877;
	bh=Mw5fokAaXa5VnqKAPXjpTNXw3aceShhfmvpffF5X+c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vr+osGXCZe0arFmXaCOqFkYR+xXtkPoQ7Oyspzjqug3AWmv/x7N7ptGMGyy46zmQr
	 lwkNmrN1F4VaJ0NqpVaKx/wKYxRW/dGRaAkHBnYTpam2c62rjf2CsF0OF5qsYBGOA8
	 Xb1/blwsDU4BaVgPkTZuFfMn/Bn6eqJiF5S+UUQZU05KLyji8aUCRZZx5n2+QARzn0
	 mw+TbAeFZAh2YboRlJN5OEmg3X6YHeOldcRgEGx87tY6lh/XId1VHJAmwc4CqWt2Vv
	 qRuAZ8iy9lkdGtksaXUWgt6cpeopawapSFBssLabudnu+3zWr3LHkd6Lj/I2ssSv+e
	 cjm3AAxitbJSw==
Date: Mon, 23 Jun 2025 11:11:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Message-ID: <purpjdp72jw2rok5ihyua635izyih54ufom2knsbaiwdd3jzgk@6wjf364fao2g>
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
 <20250621172056.160855-3-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27jb2x7vw2zpfygb"
Content-Disposition: inline
In-Reply-To: <20250621172056.160855-3-marek.vasut+renesas@mailbox.org>


--27jb2x7vw2zpfygb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
MIME-Version: 1.0

Hello,

when I replied to v3 this v4 was already on the list which I missed. My
concern applies here, too, though.

On Sat, Jun 21, 2025 at 07:19:56PM +0200, Marek Vasut wrote:
> +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
> +{
> +	argon_fan_hat_write(i2c, 100);
> +}

If you drop this, I'm willing to apply.

Best regards
Uwe

--27jb2x7vw2zpfygb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhZGi0ACgkQj4D7WH0S
/k5k/ggAt3eSn90MsI3AnID0IfNPqYi2yeR+uaHhvclBWzFqhWM9B9/FIfhaOgco
4Fec+9Qt/zBI2nz+K8orCTkaRBapY2C4QdwV8SMpd/x+mHOsCsznJUAClJjEOfXy
DNcDNP4BXlPd2mwaC7kZbVdoaMNLjsyQhhwyEoRfzheMD5ulVdi6BN8BErXR3Sqi
0GQLXuc9UtH1y9vouPwit5Ip9e9j+WVnQKvH2Sa0h82vQLuGJ3eW/ffM+iE04GNo
9efidteGpgSs8pSIK2ZrVRTFdoMOuCDn2xiaqtfCfs0oCFfPpPiMUIQ9U/HfRRk/
GXha36MsWb5mL4WXlVsxo8BtsDafZw==
=HIUC
-----END PGP SIGNATURE-----

--27jb2x7vw2zpfygb--

