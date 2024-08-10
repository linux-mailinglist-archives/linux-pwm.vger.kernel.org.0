Return-Path: <linux-pwm+bounces-2997-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5650C94DDB4
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 19:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5560D1C20A59
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709D139D04;
	Sat, 10 Aug 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYCks6sj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320421366;
	Sat, 10 Aug 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723309364; cv=none; b=tlSIOcHzsYrBXx/qUgfkjLPfp8El74WNt01FQAn/mJ3plR7aLElPc+NdS7UfCUhE+SGXqWZIh8qlhlT556ACBD6qPCFPtcLjoZBDV1wUe+S7+CIQsKVDoI3S9WODkBZOpLd/qRDeT/PJuG8Qvhn3sVRiLuAJEzwazdcTKo1EGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723309364; c=relaxed/simple;
	bh=mDQTTL0Iiqf0Z+l4V0xWPwMG4F9xVJeUOoTlBU4qFRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuFaSoWfPdUbFlF+JUaIkOW67Tcu6ZrYLdxdyOrXRvNemgWu94lOhSm5kH8aeqo6lW0GPzzHxXzPPCsM7DMbigu1FcEg7aHomnpmgv/9HU0UjdFU33seYKQbIePkL+BOMbaedq0ANCJFxlt97Oq9hFpYMQvUKdT8IS7z2AersB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYCks6sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAF5C32781;
	Sat, 10 Aug 2024 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723309363;
	bh=mDQTTL0Iiqf0Z+l4V0xWPwMG4F9xVJeUOoTlBU4qFRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYCks6sjezumYBjC7nIuWJecjTLP/6vtR67eh0gvr6ruVA9yUpEebCqchEmhodIBi
	 GaOSa2TGMDp5nNq6kHgc1viy3tdktgPmrI3VVZrXGAxAnvabvpJTXUXFT5nbtItCRz
	 sl7sFF5cBKzc7NwlHmt1Nm1XH06YwkjdBSCtdSuTmszypF6U8Psd2ZvxBG/LR275fU
	 jV+Iq23fbNk7MEk540iRuZw52db04WctX1qHcdorIrjOXKrlUDOGBMLZe39P/OUJYb
	 DSrG0HCgI2/66QqpqziW3nFSstDX3ekdZ+dLGdnZGR9Uog/Itv5PWi+jIDf0TsOLWY
	 47dCa5BnCHrvg==
Date: Sat, 10 Aug 2024 19:02:38 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pwm@vger.kernel.org, ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com, krzk+dt@kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: Re: [PATCH 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <ZredLsQ1Y2FSBMkM@lore-rh-laptop>
References: <cover.1723264979.git.lorenzo@kernel.org>
 <a03f5ea9291e39eab303696eb03fdd44cf04e8d9.1723264979.git.lorenzo@kernel.org>
 <1f8905b0-aff6-4932-b936-191aa5529f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VXtAOg5aaeAuFy7/"
Content-Disposition: inline
In-Reply-To: <1f8905b0-aff6-4932-b936-191aa5529f0e@kernel.org>


--VXtAOg5aaeAuFy7/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/08/2024 06:48, Lorenzo Bianconi wrote:
> > From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> >=20
> > Introduce driver for PWM module available on EN7581 SoC.
> >=20
> > Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
>=20
>=20
> ...
>=20
> > +
> > +static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
> > +					unsigned int hwpwm, int index)
> > +{
> > +	u32 addr, mask, val;
> > +
> > +	if (hwpwm < PWM_NUM_GPIO) {
> > +		addr =3D REG_GPIO_FLASH_MAP(hwpwm / 8);
> > +	} else {
> > +		addr =3D REG_SIPO_FLASH_MAP(hwpwm / 8);
> > +		hwpwm -=3D PWM_NUM_GPIO;
> > +	}
> > +
> > +	if (index < 0) {
> > +		/* Change of waveform takes effect immediately but
>=20
> This and other comments should be not netdev-style but general Linux styl=
e.

ack, I will fix them in v2.

>=20
> > +		 * disabling has some delay so to prevent glitching
> > +		 * only the enable bit is touched when disabling
> > +		 */
> > +		airoha_pwm_flash_clear(pc, addr, GPIO_FLASH_EN(hwpwm % 8));
> > +		return;
>=20
> ...
>=20
>=20
> > +
> > +static const struct of_device_id airoha_pwm_of_match[] =3D {
> > +	{ .compatible =3D "airoha,en7581-pwm" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, airoha_pwm_of_match);
> > +
> > +static struct platform_driver airoha_pwm_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "airoha-pwm",
> > +		.of_match_table =3D airoha_pwm_of_match,
> > +	},
> > +	.probe =3D airoha_pwm_probe,
> > +};
> > +module_platform_driver(airoha_pwm_driver);
> > +
> > +MODULE_ALIAS("platform:airoha-pwm");
>=20
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.
>=20
> Especially that it does not match compatible, so you cannot use excuse
> module autoloading does not work for given OF node...

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
>=20
> Best regards,
> Krzysztof
>=20

--VXtAOg5aaeAuFy7/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZredLAAKCRA6cBh0uS2t
rEk4AP0eoyOjcR6w8+t/ov1LaRJlnHPLFWKynjHtxGsq/0aqQwD/UNpYf+i4orFa
3f0e2DGg17yh6Fd8YtjEHMmPc7QPbQ4=
=M7tX
-----END PGP SIGNATURE-----

--VXtAOg5aaeAuFy7/--

