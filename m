Return-Path: <linux-pwm+bounces-7626-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6C1C5C698
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 11:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54CDF347343
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573D308F16;
	Fri, 14 Nov 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOIHdJMQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9D21CC60;
	Fri, 14 Nov 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113890; cv=none; b=HbuNQAr9/B25l+QxPr2D9SM3bOr3N4lDipeFtruIwIoOyQxGnALspbZ451vfHq2aVssu5vJVX4hgaDtWcSovvRkDgp7IBFEYnpBeFDxDRNK7Q/+lQWunTntL1yYDC29L2pjZicYT3X2HQn0ISCaSl3Hute0O5uS2auDqA8/+KY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113890; c=relaxed/simple;
	bh=O6LXDluXDEafQVVWq0RnhAB+p7afdg+5W2HmBgq2z8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh3wZeVnvkiZqp47e6kqlSu2PZSqPa92yvguRzjsg+cONf9zJCv1/Bal9YYT7Mui/x4TD4IKT3HaGMjvzhBbXr8rPIJ7p+Qy8Bj1y3Z/i8pAIfoiKbz9SvvqCJDlZTzt/5WBXuBav7cZ/yHGZO6r0clD0okAxCVFBUmuGM4GEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOIHdJMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6F3C116D0;
	Fri, 14 Nov 2025 09:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763113889;
	bh=O6LXDluXDEafQVVWq0RnhAB+p7afdg+5W2HmBgq2z8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOIHdJMQE0TDkiX7ARkxw5G2WdNrnktz7C93zfpLOjSLn1DGMqxCGRL2+H11VXA5t
	 TAOlaPLd7XmgJ+NrCWHohiq4sDtyeWuovmYsxLE6NpZDcPacrgvR/xN/N5QBnZp7E0
	 RllAb1nSls9OhiBIou1vVRW7VHcLKxVoN+cobTMUB8JTFrxeD8T3wLJ0OcXmalQAsP
	 SGvrZFfnjccYHeBUeR7Fo73jBd6Y+o468gsooIAT788zEP9Zp52R8ccTrqslkPpBcF
	 gIebxjHCKli7Z65Z1mWRmDJcA4xPW8Cr/Ra2MqmxiQGtOI/WdLa9Xo5nqkPOfDLcT3
	 nZXpAlzBI8F8A==
Date: Fri, 14 Nov 2025 10:51:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
	Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/5] pwm: Add rockchip PWMv4 driver
Message-ID: <fgu42esufq2x4fcccncqs3hlotih2gqmws5atotlaznuahoslw@34vblr6vboze>
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <20251027-rk3576-pwm-v3-3-654a5cb1e3f8@collabora.com>
 <8a6e920b-9565-4161-9d71-63f924593c23@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xfykpml5ewgt3ra3"
Content-Disposition: inline
In-Reply-To: <8a6e920b-9565-4161-9d71-63f924593c23@rock-chips.com>


--xfykpml5ewgt3ra3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/5] pwm: Add rockchip PWMv4 driver
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 04:16:26PM +0800, Damon Ding wrote:
> Hi Nicolas,
>=20
> On 10/28/2025 1:11 AM, Nicolas Frattaroli wrote:
> > The Rockchip RK3576 brings with it a new PWM IP, in downstream code
> > referred to as "v4". This new IP is different enough from the previous
> > Rockchip IP that I felt it necessary to add a new driver for it, instead
> > of shoehorning it in the old one.
> >=20
> > Add this new driver, based on the PWM core's waveform APIs. Its platform
> > device is registered by the parent mfpwm driver, from which it also
> > receives a little platform data struct, so that mfpwm can guarantee that
> > all the platform device drivers spread across different subsystems for
> > this specific hardware IP do not interfere with each other.
> >=20
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   MAINTAINERS                   |   1 +
> >   drivers/pwm/Kconfig           |  13 ++
> >   drivers/pwm/Makefile          |   1 +
> >   drivers/pwm/pwm-rockchip-v4.c | 353 +++++++++++++++++++++++++++++++++=
+++++++++
> >   4 files changed, 368 insertions(+)
> >=20
>=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8f3235ba825e..2079c2d51d5c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22372,6 +22372,7 @@ L:	linux-rockchip@lists.infradead.org
> >   L:	linux-pwm@vger.kernel.org
> >   S:	Maintained
> >   F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
> > +F:	drivers/pwm/pwm-rockchip-v4.c
> >   F:	drivers/soc/rockchip/mfpwm.c
> >   F:	include/soc/rockchip/mfpwm.h
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index c2fd3f4b62d9..b852a7b2a29d 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -615,6 +615,19 @@ config PWM_ROCKCHIP
> >   	  Generic PWM framework driver for the PWM controller found on
> >   	  Rockchip SoCs.
> > +config PWM_ROCKCHIP_V4
> > +	tristate "Rockchip PWM v4 support"
> > +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	depends on MFD_ROCKCHIP_MFPWM
> > +	help
> > +	  Generic PWM framework driver for the PWM controller found on
> > +	  later Rockchip SoCs such as the RK3576.
> > +
> > +	  Uses the Rockchip Multi-function PWM controller driver infrastructu=
re
> > +	  to guarantee fearlessly concurrent operation with other functions of
> > +	  the same device implemented by drivers in other subsystems.
> > +
> >   config PWM_SAMSUNG
> >   	tristate "Samsung PWM support"
> >   	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TE=
ST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index dfa8b4966ee1..fe0d16558d99 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -55,6 +55,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+=3D pwm-rzg2l-gp=
t.o
> >   obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> >   obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >   obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > +obj-$(CONFIG_PWM_ROCKCHIP_V4)	+=3D pwm-rockchip-v4.o
> >   obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >   obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >   obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v=
4.c
> > new file mode 100644
> > index 000000000000..7afa83f12b6a
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rockchip-v4.c
> > @@ -0,0 +1,353 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025 Collabora Ltd.
> > + *
> > + * A Pulse-Width-Modulation (PWM) generator driver for the generators =
found in
> > + * Rockchip SoCs such as the RK3576, internally referred to as "PWM v4=
". Uses
> > + * the MFPWM infrastructure to guarantee exclusive use over the device=
 without
> > + * other functions of the device from different drivers interfering wi=
th its
> > + * operation while it's active.
> > + *
> > + * Technical Reference Manual: Chapter 31 of the RK3506 TRM Part 1, a =
SoC which
> > + * uses the same PWM hardware and has a publicly available TRM.
> > + * https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_P=
art_1_V1.2-20250811.pdf
> > + *
> > + * Authors:
> > + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > + *
> > + * Limitations:
> > + * - When the output is disabled, it will end abruptly without letting=
 the
> > + *   current period complete.
> > + *   TODO: This can be fixed in the driver in the future by having the=
 enable-
> > + *         to-disable transition switch to oneshot mode with one repet=
ition,
> > + *         and then disable the pwmclk and release mfpwm when the ones=
hot
> > + *         complete interrupt fires.
> > + * - When the output is disabled, the pin will remain driven to whatev=
er state
> > + *   it last had.
> > + * - Adjustments to the duty cycle will only take effect during the ne=
xt period.
> > + * - Adjustments to the period length will only take effect during the=
 next
> > + *   period.
> > + * - offset should be between 0 and (period - duty)
> > + */
> > +
> > +#include <linux/math64.h>
> > +#include <linux/mfd/rockchip-mfpwm.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +
> > +struct rockchip_pwm_v4 {
> > +	struct rockchip_mfpwm_func *pwmf;
> > +	struct pwm_chip chip;
> > +};
> > +
> > +struct rockchip_pwm_v4_wf {
> > +	u32 period;
> > +	u32 duty;
> > +	u32 offset;
> > +	u8 enable;
> > +};
> > +
>=20
> ...
>=20
> > +
> > +static int rockchip_pwm_v4_read_wf(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> > +				   void *_wfhw)
> > +{
> > +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> > +	struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> > +	int ret =3D 0;
> > +
>=20
> Redundant blank lin. ;-)
>=20
> > +
> > +	ret =3D mfpwm_acquire(pc->pwmf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	wfhw->period =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_PERIOD);
> > +	wfhw->duty =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_DUTY);
> > +	wfhw->offset =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_OFFSET);
> > +	wfhw->enable =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_ENABLE) & P=
WMV4_EN_BOTH_MASK;
> > +
> > +	mfpwm_release(pc->pwmf);
> > +
> > +	return 0;
> > +}
> > +
>=20
> ...
>=20
> > +MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
> > +MODULE_DESCRIPTION("Rockchip PWMv4 Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS("ROCKCHIP_MFPWM");
> > +MODULE_ALIAS("platform:pwm-rockchip-v4");
> >=20
>=20
> Tested-by: Damon Ding <damon.ding@rock-chips.com>
>=20
> I have tested all the PWM channels in continuous mode on my RK3576-IOTEST
> board.
>=20
> Test commands are like:
>=20
> cd /sys/class/pwm/pwmchip0/
> echo 0 > export
> cd pwm0
> echo 10000 > period
> echo 5000 > duty_cycle
> echo normal > polarity
> echo 1 > enable

Thanks for the test, very appreciated.

I wonder what made you test using sysfs instead of
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/.
Is it unknown? Too complicated? Other problems?

Best regards
Uwe

--xfykpml5ewgt3ra3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkW+5wACgkQj4D7WH0S
/k53tgf/ZFRrKZ3wCBT3fPYwc0esDlhE8SB04CeKkBuW/VIrFjkskcsGK2iJKR2r
2bauJvrF4JaMaXzQb6gVZSdvirjIoNyObsUw1GcjndwxA18k+/7c2XPywT5JLtZ7
c+OelHzh2dmXjDARoRMrHeUHIMMdTJIZZGtWl5mVNhoF/dwsbnw6ClUScmjrK/rs
tcR6Mp6S9pWnYscxTq05ftyRClMflmU+FF7Svjq0ssoaZllI0W5KSUwAv9xOh1aO
3LbRu0QVA9I0O5QKgJcIPjPbF14lBC2FFDSKJSAxTWVZLpzQtD3//phd42ktFrHr
3kEGqi3j/uy7FRv8XWmKVGE2TfESaw==
=aZBT
-----END PGP SIGNATURE-----

--xfykpml5ewgt3ra3--

