Return-Path: <linux-pwm+bounces-3214-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1880975CA2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5ED1C21DE3
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F561547EE;
	Wed, 11 Sep 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9WHzgHD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CB14D6E9;
	Wed, 11 Sep 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091283; cv=none; b=jIFfyegGXS/6Q7ZhDmtogdzp9HuYjYkyAF7PP26E7AqsooTLJ69MHuNO3KhE+P5gJefDHAAsawicixftuJFBXSz0ECwlv8v2unPb36uAnK/ecFwNXIrjaOQPhUT1wupkhKO/7LA1b2ae5wNDPnbvh2eQ4JMdQKL5fVE5LYnU4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091283; c=relaxed/simple;
	bh=8yn0zrNcPvuxbkhbLHONB+8lF/ldniej9mqHx/Rr7kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGzpUfLN82i72cHP9AdKNZftU/KeQX0FfEOXnRSozSMMW1f84tPPMKzDXL+ykOePWtiEjeBz6tDblMsfw6ujR04xwn4HRv5SvOTaakTvYNN7qFv98IiTro7oZTZzwFwJyS22vXuXvpuGYRKeiImHE93g6mfJngW9As/UwO6WSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9WHzgHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA7FC4CEC0;
	Wed, 11 Sep 2024 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726091283;
	bh=8yn0zrNcPvuxbkhbLHONB+8lF/ldniej9mqHx/Rr7kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9WHzgHDyZntuHqmlInqUB3G2T8eDx64/wSgiVp7LR88Ee5pVJW0c8QeXkmG3/CxP
	 ilVo0bc0xwXdnPmu/0piLAc9Lw9TMstUZb8mIGU4Z1rVbkTA6Xk7kGvgQsmL0xfD9B
	 69LtNeJ5JzpWjOndI+K2o5t9yq/c4Wxu/ijlYeXYxHqGgFSNy3z8Bjf/5B6fN1IoF8
	 Ple+NUBkDzeGY56vBQte2YJBeZViWM2pUBYankXrA6NV3NNPxETd70hY/TsaYIljfd
	 9axJOU92G0ozi5BRlMDESaWR/5uHRd2h48OJwB8JtJyDeK6OzypOkkvlZFZMBzG/64
	 zxlI9yvJiHnmg==
Date: Wed, 11 Sep 2024 23:48:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-mediatek@lists.infradead.org, benjamin.larsson@genexis.eu,
	upstream@airoha.com, ansuelsmth@gmail.com,
	Sean Wang <sean.wang@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-gpio@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
Message-ID: <ZuIQEC4T6a69LmIM@lore-desk>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <20240911-en7581-pinctrl-v4-2-60ac93d760bb@kernel.org>
 <172608915288.1388772.4934918553914498433.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hy2aa9DFi4yP9wrh"
Content-Disposition: inline
In-Reply-To: <172608915288.1388772.4934918553914498433.robh@kernel.org>


--hy2aa9DFi4yP9wrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On Wed, 11 Sep 2024 21:50:02 +0200, Lorenzo Bianconi wrote:
> > From: Christian Marangi <ansuelsmth@gmail.com>
> >=20
> > Add support for Airoha EN7581 GPIO System Controller which provide a
> > register map for controlling the GPIO, pinctrl and PWM of the SoC.
> >=20
> > Schema define cells for both gpio/interrupt controller and PWM.
> > Moreover it provides a dedicated pinctrl node for pins and config
> > definitions.
> >=20
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 433 +++++++++++++=
++++++++
> >  1 file changed, 433 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
>=20
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202409=
11-en7581-pinctrl-v4-2-60ac93d760bb@kernel.org
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20

Similar to the previous patch, I run the following command before posting t=
he
series:

$make dt_binding_check DT_SCHEMA_FILES=3Dairoha
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.e=
xample.dts
  DTC_CHK Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.e=
xample.dtb
  DTC_CHK Documentation/devicetree/bindings/arm/airoha.example.dtb
  DTC_CHK Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.exam=
ple.dtb
  DTC_CHK Documentation/devicetree/bindings/clock/airoha,en7523-scu.example=
=2Edtb
  DTC_CHK Documentation/devicetree/bindings/net/airoha,en7581-eth.example.d=
tb
  DTC_CHK Documentation/devicetree/bindings/net/airoha,en8811h.example.dtb
  DTC_CHK Documentation/devicetree/bindings/gpio/airoha,en7523-gpio.example=
=2Edtb
  DTC_CHK Documentation/devicetree/bindings/spi/airoha,en7581-snand.example=
=2Edtb
  DTC_CHK Documentation/devicetree/bindings/phy/airoha,en7581-pcie-phy.exam=
ple.dtb

Regards,
Lorenzo

--hy2aa9DFi4yP9wrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZuIQEAAKCRA6cBh0uS2t
rC5zAP90DD/iK+dtOght4EIvssIUPWzp3Qjz6h3JqET9NgGjSAD/T5Gy0q7vNM6T
OomZ2p89ybGeg2KELBPqQKsSmbzIfgg=
=MyFS
-----END PGP SIGNATURE-----

--hy2aa9DFi4yP9wrh--

