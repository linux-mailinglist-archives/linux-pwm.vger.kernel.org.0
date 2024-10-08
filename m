Return-Path: <linux-pwm+bounces-3546-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2A9959C6
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 00:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0077B1C20506
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D7C21503B;
	Tue,  8 Oct 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clxtKb6u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CD179954;
	Tue,  8 Oct 2024 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425076; cv=none; b=eUkO79LxKoQQGoJtOmqXLrWF3vJjN/SKLJV3tE/0hfROJHsoZNGHBkV0jcKvEcOt7jvm8Are2g/NAsBSqVUi9wMM9yT9psySOuHXPP/5Q1F5ViuVEMu01C0hCsu2yztEpWde5VxC/T+GUjqy2eWzpjgxE340sXeRRr2rDb8zQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425076; c=relaxed/simple;
	bh=ms7y13SKSl3l6x54yKv0dqYa0hkXrQlTObop68w2TTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA3cqzXlealvKlzKqjNRo7vbLO9Sw3SMXcBOqDIbF4rUBhB0eaVC8RSntei/4VlcPxTLdpEZ8YrfCLNAwfYUSZm0P0f4c+LSywEtP1VvBpq/PsmyXZmmvooMmU8lxfVVz6tvAqFdVARHLlxUIbQS0gbjvFM9juyJa3mqQDStdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clxtKb6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394CDC4CECF;
	Tue,  8 Oct 2024 22:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728425075;
	bh=ms7y13SKSl3l6x54yKv0dqYa0hkXrQlTObop68w2TTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clxtKb6uPWfUDdD1z+NjKt4020Xf1psaH3OQVC3cD4jDYPJWXAHFmHyJcBvcZ5DYw
	 r2yUu15NRPsHpKLM48JiRf8G4jN5hXP15K03DUppXPtn7rAH9bKT75MIdg3VFVzhb0
	 hYT2IL21c5XIRJECdGWnNfUegiUMWKvu6zAut6bGuIV0RydpOqOjcVz8VGwDKlIP1H
	 IDI2Cwc8Qa/N/BvMSM1vp0g2Jy1cyaiPdoU3CJ0Bx/zNXrkN0mrSieEoX+m9OXo3R9
	 Arcqd9hwGNKGfX9Nst20wL/IJ2giwlTEwU6ooSENHogKWxiWXcO0nyuweXFRBznC9o
	 NdMgHmAoRYFYw==
Date: Wed, 9 Oct 2024 00:04:33 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
Message-ID: <ZwWscWk5axQI9H1t@lore-desk>
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
 <20241002132518.GD7504@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ck0ElvyZLVpyJemd"
Content-Disposition: inline
In-Reply-To: <20241002132518.GD7504@google.com>


--Ck0ElvyZLVpyJemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 02, Lee Jones wrote:
> On Tue, 01 Oct 2024, Lorenzo Bianconi wrote:
>=20
> > From: Christian Marangi <ansuelsmth@gmail.com>
> >=20
> > Support for Airoha EN7581 Multi Function Device that
> > expose PINCTRL functionality and PWM functionality.
>=20
> The device is a jumble of pinctrl registers, some of which can oscillate.
>=20
> This is *still* not an MFD.
>=20
> If you wish to spread this functionality over 2 drivers, use syscon to
> obtain the registers and simple-mfd to automatically probe the drivers.

Hi Lee,

IIUC you are suggesting two possible approaches here:

1- have a single driver implementing both pinctrl and pwm functionalities.
   This approach will not let us reuse the code for future devices that
   have just one of them in common, like pwm (but we can live with that).

2- use a device node like the one below (something similar to [0])

system-controller@1fbf0200 {
	compatible =3D "syscon", "simple-mfd";
	reg =3D <0x0 0x1fbf0200 0x0 0xc0>;

	interrupt-parent =3D <&gic>;
	interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;

	gpio-controller;
	#gpio-cells =3D <2>;

	interrupt-controller;
	#interrupt-cells =3D <2>;

	pio: pinctrl {
		compatible =3D "airoha,en7581-pinctrl";

		[ some pinctrl properties here ]
	};

	#pwm-cells =3D <3>;

	pwm {
		compatible =3D "airoha,en7581-pwm";
	};
};

Please correct me if I am wrong, but using syscon/simple-mfd as compatible
string for the 'parent' device, will require to introduce the compatible st=
rings
even for the child devices in order to probe them, correct?=20
If so, as pointed out by Christian, this is something nacked by Rob/Krzyszt=
of/Conor
(this is the main reason why we introduced a full mfd driver here).

@Rob, Krzysztof, Conor: am I right?

I guess we need to find a middle ground here between mfd and dts to support=
 this
uncommon hw device.

Regards,
Lorenzo

[0] https://elixir.bootlin.com/linux/v6.11.2/source/arch/arm64/boot/dts/mar=
vell/armada-ap80x.dtsi#L269

>=20
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/mfd/Kconfig                   |  8 ++++
> >  drivers/mfd/Makefile                  |  2 +
> >  drivers/mfd/airoha-en7581-gpio-mfd.c  | 72 +++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/airoha-en7581-mfd.h |  9 +++++
> >  4 files changed, 91 insertions(+)
> >=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index f9325bcce1b9..eca221351ab7 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -32,6 +32,14 @@ config MFD_ADP5585
> >  	  the core APIs _only_, you have to select individual components like
> >  	  the GPIO and PWM functions under the corresponding menus.
> > =20
> > +config MFD_AIROHA_EN7581
> > +	bool "Airoha EN7581 Multi Function Device"
> > +	depends on (ARCH_AIROHA || COMPILE_TEST) && OF
> > +	select MFD_CORE
> > +	help
> > +	  Support for Airoha EN7581 Multi Function Device that
> > +	  expose PINCTRL functionality and PWM functionality.
> > +
> >  config MFD_ALTERA_A10SR
> >  	bool "Altera Arria10 DevKit System Resource chip"
> >  	depends on ARCH_INTEL_SOCFPGA && SPI_MASTER=3Dy && OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 2a9f91e81af8..be8448e81a5b 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -257,6 +257,8 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+=3D intel_soc_p=
mic_chtwc.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+=3D intel_soc_pmic_chtdc_ti.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+=3D intel_soc_pmic_mrfld.o
> > =20
> > +obj-$(CONFIG_MFD_AIROHA_EN7581)	+=3D airoha-en7581-gpio-mfd.o
> > +
> >  obj-$(CONFIG_MFD_ALTERA_A10SR)	+=3D altera-a10sr.o
> >  obj-$(CONFIG_MFD_ALTERA_SYSMGR) +=3D altera-sysmgr.o
> >  obj-$(CONFIG_MFD_STPMIC1)	+=3D stpmic1.o
> > diff --git a/drivers/mfd/airoha-en7581-gpio-mfd.c b/drivers/mfd/airoha-=
en7581-gpio-mfd.c
> > new file mode 100644
> > index 000000000000..88407ce5747e
> > --- /dev/null
> > +++ b/drivers/mfd/airoha-en7581-gpio-mfd.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * MFD driver for Airoha EN7581
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/mfd/airoha-en7581-mfd.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +
> > +static struct resource airoha_mfd_pinctrl_intr[] =3D {
> > +	{
> > +		.flags =3D IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static const struct mfd_cell airoha_mfd_devs[] =3D {
> > +	{
> > +		.name =3D "pinctrl-airoha",
> > +		.resources =3D airoha_mfd_pinctrl_intr,
> > +		.num_resources =3D ARRAY_SIZE(airoha_mfd_pinctrl_intr),
> > +	}, {
> > +		.name =3D "pwm-airoha",
> > +	},
> > +};
> > +
> > +static int airoha_mfd_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct airoha_mfd *mfd;
> > +	int irq;
> > +
> > +	mfd =3D devm_kzalloc(dev, sizeof(*mfd), GFP_KERNEL);
> > +	if (!mfd)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, mfd);
> > +
> > +	mfd->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(mfd->base))
> > +		return PTR_ERR(mfd->base);
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	airoha_mfd_pinctrl_intr[0].start =3D irq;
> > +	airoha_mfd_pinctrl_intr[0].end =3D irq;
> > +
> > +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, airoha_mfd_devs,
> > +				    ARRAY_SIZE(airoha_mfd_devs), NULL, 0,
> > +				    NULL);
> > +}
> > +
> > +static const struct of_device_id airoha_mfd_of_match[] =3D {
> > +	{ .compatible =3D "airoha,en7581-gpio-sysctl" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, airoha_mfd_of_match);
> > +
> > +static struct platform_driver airoha_mfd_driver =3D {
> > +	.probe =3D airoha_mfd_probe,
> > +	.driver =3D {
> > +		.name =3D KBUILD_MODNAME,
> > +		.of_match_table =3D airoha_mfd_of_match,
> > +	},
> > +};
> > +module_platform_driver(airoha_mfd_driver);
> > +
> > +MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
> > +MODULE_DESCRIPTION("Driver for Airoha EN7581 MFD");
> > diff --git a/include/linux/mfd/airoha-en7581-mfd.h b/include/linux/mfd/=
airoha-en7581-mfd.h
> > new file mode 100644
> > index 000000000000..25e73952a777
> > --- /dev/null
> > +++ b/include/linux/mfd/airoha-en7581-mfd.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_INCLUDE_MFD_AIROHA_EN7581_MFD_H_
> > +#define _LINUX_INCLUDE_MFD_AIROHA_EN7581_MFD_H_
> > +
> > +struct airoha_mfd {
> > +	void __iomem *base;
> > +};
> > +
> > +#endif  /* _LINUX_INCLUDE_MFD_AIROHA_EN7581_MFD_H_ */
> >=20
> > --=20
> > 2.46.2
> >=20
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--Ck0ElvyZLVpyJemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZwWscAAKCRA6cBh0uS2t
rEz/AQCFBJOOtzJqJ2Zgfn+hqeD0mG44RsxTxw/hCr8oWqE2TAD8CvJfaYJ/spUO
GPey9tflRamTmCSiSKdx1wZE17e4Gwc=
=OMHu
-----END PGP SIGNATURE-----

--Ck0ElvyZLVpyJemd--

