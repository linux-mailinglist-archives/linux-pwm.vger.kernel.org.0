Return-Path: <linux-pwm+bounces-6089-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E1AC0C26
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 15:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7261B500D33
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579C28BA90;
	Thu, 22 May 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="e+ThdrWj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C128B3F9;
	Thu, 22 May 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918999; cv=pass; b=EirV1JHXIT/jCdGR3nlo5RaRRV+EZSXrbMU3G47Kzh6W2BF8nqTHaGtNBHNHXvZedAJpIMAxHL6DHgEhGlp0vEA3ZaakRE4PPhfzUfXWA/L48X8+MfERy/c0iGEIFBXub78tQuCDagXseYlj6IjYR9SNXXvWIPaitXL3zdjrP4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918999; c=relaxed/simple;
	bh=YhZpbTIm2QHCN4FJfPNYrYsWBW2ZXyI+BXTnalc8Hhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3h90CwavJ+MJ6RKOXye8jrfxckMrfU5p9x0p2wH9Sanw7MiodwwV8eBxHW+Ey2Wop9dO/ByrKPd39fZd26MS2IT5D68rEzXgZuLsBWRuqtNpZl32qb8Aiyl6ZU5Djl4MFKU0CgaHBItzJJWOv2+7IropU9ZnY8wMviqO/fN/1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=e+ThdrWj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747918959; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M/xFiBagEKR2Ya2kcXXxy6kLBV3zzmtEhWu9yB1vpCuDHugM3XN3xh9fyKMy7DEI37fdD6Essd55B+Muy9wyEMbqXN4ZFHybbMbG7GoX024Q9H4mYVra5Z/A4ZA02nVkmxl8MZFl5hXsbaTgEu2X4aztI948dnR1m3LKFLFIhxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747918959; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yAzVUYHblSoPTB0olb5aawXBsuLsX+i/Vja0SSAs4yM=; 
	b=Iy1MI7rk6DydTqZt+PsgWIcPQojnJmeNjx9Gjr/1FLPSUS37Ma/gQUClvo3EtfltDEHgoDPyt9iytkpMf+hMBHEZMQQia2Z/ct7oC+7g9aoPJo/aUxoa30JSXVq9AOXtLNi/M8/ZgjUqCjEdDueyWrz0YiWJF0GFGamPavwgisA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747918959;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=yAzVUYHblSoPTB0olb5aawXBsuLsX+i/Vja0SSAs4yM=;
	b=e+ThdrWj/dCeYWjXT7Sn2wa3UbL1rJgVHxXHJDk9Cka0ViwZKX6DutfJbRLcFfr1
	oITFGrcjbesSdKS33jfnRZjh3BxeoCkTAwrv2+1rH+CrKdZgI6012kkmvTQ0ksyq2ML
	WSG3YjJx6iZ93fVUhbMO+a8z/c5yS1I9dgVviLpw=
Received: by mx.zohomail.com with SMTPS id 1747918955405526.6068930201867;
	Thu, 22 May 2025 06:02:35 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 5/7] pwm: Add rockchip PWMv4 driver
Date: Thu, 22 May 2025 15:02:29 +0200
Message-ID: <4313739.kQq0lBPeGt@workhorse>
In-Reply-To: <zg47we7oopvuayi7wyosq6j7uuzz4numystbmluezsim2pxg4g@zvtm3pwzkice>
References:
 <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-5-a49286c2ca8e@collabora.com>
 <zg47we7oopvuayi7wyosq6j7uuzz4numystbmluezsim2pxg4g@zvtm3pwzkice>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Uwe,

thanks for the review. Just got started on v2, I'll respond or ack comments
inline.

On Tuesday, 13 May 2025 19:26:31 Central European Summer Time Uwe Kleine-K=
=C3=B6nig wrote:
> Hello Nicolas,
>=20
> On Tue, Apr 08, 2025 at 02:32:17PM +0200, Nicolas Frattaroli wrote:
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
> >  MAINTAINERS                   |   1 +
> >  drivers/pwm/Kconfig           |  13 ++
> >  drivers/pwm/Makefile          |   1 +
> >  drivers/pwm/pwm-rockchip-v4.c | 336 ++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 351 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e6a9347be1e7889089e1d9e655cb23c2d8399b40..3ddd245fd4ad8d9ed2e7629=
10a7a1f6436f93e34 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20891,6 +20891,7 @@ L:	linux-rockchip@lists.infradead.org
> >  L:	linux-pwm@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
> > +F:	drivers/pwm/pwm-rockchip-v4.c
> >  F:	drivers/soc/rockchip/mfpwm.c
> >  F:	include/soc/rockchip/mfpwm.h
> > =20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 4731d5b90d7edcc61138e4a5bf7e98906953ece4..242039f62ab091cea337bf2=
7ef310bcf696b6ed0 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -540,6 +540,19 @@ config PWM_ROCKCHIP
> >  	  Generic PWM framework driver for the PWM controller found on
> >  	  Rockchip SoCs.
> > =20
> > +config PWM_ROCKCHIP_V4
> > +	tristate "Rockchip PWM v4 support"
> > +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> > +	depends on ROCKCHIP_MFPWM
> > +	depends on HAS_IOMEM
> > +	help
> > +	  Generic PWM framework driver for the PWM controller found on
> > +	  later Rockchip SoCs such as the RK3576.
> > +
> > +	  Uses the Rockchip Multi-function PWM controller driver infrastructu=
re
> > +	  to guarantee fearlessly concurrent operation with other functions of
> > +	  the same device implemented by drivers in other subsystems.
> > +
> >  config PWM_RZ_MTU3
> >  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> >  	depends on RZ_MTU3
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 539e0def3f82fcb866ab83a0346a15f7efdd7127..b5aca7ff58ac83f844581df=
526624617025291de 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -49,6 +49,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberryp=
i-poe.o
> >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > +obj-$(CONFIG_PWM_ROCKCHIP_V4)	+=3D pwm-rockchip-v4.o
> >  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v=
4.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..980b27454ef9b930bef0496=
ca528533cf419fa0e
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rockchip-v4.c
> > @@ -0,0 +1,336 @@
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
>=20
> Can you please add a "Limitations" paragraph here similar to the other
> newer drivers that explains how the hardware behave on disable
> (inactive? High-Z? freeze?), if there are glitches possible when
> settings are changed or if the currently running period is completed on
> reconfiguration.

Will do. Might need a few long hours with the logic analyzer and poking at
the common clock framework to cover all bases.

>=20
> > + *
> > + * Authors:
> > + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <soc/rockchip/mfpwm.h>
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
> > +static inline struct rockchip_pwm_v4 *to_rockchip_pwm_v4(struct pwm_ch=
ip *chip)
> > +{
> > +	return pwmchip_get_drvdata(chip);
> > +}
> > +
> > +/**
> > + * rockchip_pwm_v4_round_single - convert a PWM parameter to hardware
> > + * @rate: clock rate of the PWM clock, as per clk_get_rate
> > + * @in_val: parameter in nanoseconds to convert
> > + * @out_val: pointer to location where converted result should be stor=
ed.
> > + *
> > + * If @out_val is %NULL, no calculation is performed.
> > + *
> > + * Return:
> > + * * %0          - Success
> > + * * %-EOVERFLOW - Result too large for target type
> > + */
> > +static int rockchip_pwm_v4_round_single(unsigned long rate, u64 in_val,
> > +					u32 *out_val)
> > +{
> > +	u64 tmp;
> > +
> > +	if (!out_val)
> > +		return 0;
>=20
> This is never hit, so better drop it.

Will do.

>=20
> > +	tmp =3D mult_frac(rate, in_val, NSEC_PER_SEC);
> > +	if (tmp > U32_MAX)
> > +		return -EOVERFLOW;
>=20
> Is it clear that this cannot overflow the u64?

Good point. mult_frac in this case will expand to
  {
  	unsigned long x_ =3D (rate);
  	u64 n_ =3D (in_val);
  	long d_ =3D (NSEC_PER_SEC);
  =09
  	unsigned long q =3D x_ / d_;
  	unsigned long r =3D x_ % d_;
  	q * n_ + r * n_ / d_;
  }

Whether or not this works out depends on the size of the unsigned long
type that it infers from rate, which will be 64 bits on arm64 and it
should only overflow in extreme cases, or 32 bits on arm32 (where this
driver may get used as well) where it goes horribly wrong way more often
as a result.

I'll replace it with the less suspect

  mul_u64_u64_div_u64(rate, in_val, NSEC_PER_SEC)

to avoid the C footguns.

>=20
> > +	*out_val =3D tmp;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * rockchip_pwm_v4_round_params - convert PWM parameters to hardware
> > + * @rate: PWM clock rate to do the calculations at
> > + * @duty: PWM duty cycle in nanoseconds
> > + * @period: PWM period in nanoseconds
> > + * @offset: PWM offset in nanoseconds
> > + * @out_duty: pointer to where the rounded duty value should be stored
> > + *            if NULL, don't calculate or store it
> > + * @out_period: pointer to where the rounded period value should be st=
ored
> > + *              if NULL, don't calculate or store it
> > + * @out_offset: pointer to where the rounded offset value should be st=
ored
> > + *              if NULL, don't calculate or store it
> > + *
> > + * Convert nanosecond-based duty/period/offset parameters to the PWM h=
ardware's
> > + * native rounded representation in number of cycles at clock rate @ra=
te. If an
> > + * out_ parameter is a NULL pointer, the corresponding parameter will =
not be
> > + * calculated or stored. Should an overflow error occur for any of the
> > + * parameters, assume the data at all the out_ locations is invalid an=
d may not
> > + * even have been touched at all.
> > + *
> > + * Return:
> > + * * %0          - Success
> > + * * %-EOVERFLOW - One of the results is too large for the PWM hardware
> > + */
> > +static int rockchip_pwm_v4_round_params(unsigned long rate, u64 duty,
> > +					u64 period, u64 offset, u32 *out_duty,
> > +					u32 *out_period, u32 *out_offset)
> > +{
> > +	int ret;
> > +
> > +	ret =3D rockchip_pwm_v4_round_single(rate, duty, out_duty);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D rockchip_pwm_v4_round_single(rate, period, out_period);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D rockchip_pwm_v4_round_single(rate, offset, out_offset);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rockchip_pwm_v4_round_wf_tohw(struct pwm_chip *chip,
> > +					 struct pwm_device *pwm,
> > +					 const struct pwm_waveform *wf,
> > +					 void *_wfhw)
> > +{
> > +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> > +	struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> > +	unsigned long rate;
> > +	int ret =3D 0;
> > +
> > +	/* We do not want chosen_clk to change out from under us here */
> > +	ret =3D mfpwm_acquire(pc->pwmf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	rate =3D mfpwm_clk_get_rate(pc->pwmf->parent);
> > +
> > +	ret =3D rockchip_pwm_v4_round_params(rate, wf->duty_length_ns,
> > +					   wf->period_length_ns,
> > +					   wf->duty_offset_ns, &wfhw->duty,
> > +					   &wfhw->period, &wfhw->offset);
> > +
> > +	if (wf->period_length_ns > 0)
> > +		wfhw->enable =3D PWMV4_EN_BOTH_MASK;
> > +	else
> > +		wfhw->enable =3D 0;
> > +
> > +	dev_dbg(&chip->dev, "tohw: duty =3D %u, period =3D %u, offset =3D %u,=
 rate %lu\n",
> > +		wfhw->duty, wfhw->period, wfhw->offset, rate);
> > +
> > +	mfpwm_release(pc->pwmf);
> > +	return ret;
>=20
> This is wrong. If a too high value for (say) period_length_ns is
> requested, you're supposed to configure the maximal possible
> period_length and not return a failure.

Ack. What if offset > period - duty is requested? Should I just saturate it
to period - duty in that case?

>=20
> > +}
> > +
> > +static int rockchip_pwm_v4_round_wf_fromhw(struct pwm_chip *chip,
> > +					   struct pwm_device *pwm,
> > +					   const void *_wfhw,
> > +					   struct pwm_waveform *wf)
> > +{
> > +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> > +	const struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> > +	unsigned long rate;
> > +	int ret =3D 0;
> > +
> > +	/* We do not want chosen_clk to change out from under us here */
>=20
> This is also true while the PWM is enabled.=20
>=20
> > +	ret =3D mfpwm_acquire(pc->pwmf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	rate =3D mfpwm_clk_get_rate(pc->pwmf->parent);
>=20
> Why isn't that a proper clock that you can call clk_get_rate() (and
> clk_rate_exclusive_get()) for?

Because I didn't know clk-mux.c existed :( But even with it, I'm not sure
if letting mfpwm function drivers touch the clk directly is a good idea,
as this either means storing it in their pwmf struct or making the members
of the mfpwm struct part of the shared header.

>=20
> > +	/* Let's avoid a cool division-by-zero if the clock's busted. */
> > +	if (!rate) {
> > +		ret =3D -EINVAL;
> > +		goto out_mfpwm_release;
> > +	}
> > +
> > +	wf->duty_length_ns =3D mult_frac(wfhw->duty, NSEC_PER_SEC, rate);
> > +
> > +	if (pwmv4_is_enabled(wfhw->enable))
> > +		wf->period_length_ns =3D mult_frac(wfhw->period, NSEC_PER_SEC,
> > +						 rate);
> > +	else
> > +		wf->period_length_ns =3D 0;
> > +
> > +	wf->duty_offset_ns =3D mult_frac(wfhw->offset, NSEC_PER_SEC, rate);

Note: I'll also need to replace all the mult_frac's here I think, as the
macro infers u32 as the result type here, which is needlessly restrictive
and probably prone to overflowing.

> > +
> > +	dev_dbg(&chip->dev, "fromhw: duty =3D %llu, period =3D %llu, offset =
=3D %llu\n",
> > +		wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
>=20
> In my experience it't helpful to include rate in the output here.

Will do.

>=20
> > +out_mfpwm_release:
> > +	mfpwm_release(pc->pwmf);
> > +	return ret;
> > +}
> > +
> > +static int rockchip_pwm_v4_read_wf(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> > +				   void *_wfhw)
> > +{
> > +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> > +	struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> > +	int ret =3D 0;
> > +
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
> > +static int rockchip_pwm_v4_write_wf(struct pwm_chip *chip, struct pwm_=
device *pwm,
> > +				    const void *_wfhw)
> > +{
> > +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> > +	const struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> > +	bool was_enabled =3D false;
> > +	int ret =3D 0;
> > +
> > +	ret =3D mfpwm_acquire(pc->pwmf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	was_enabled =3D pwmv4_is_enabled(mfpwm_reg_read(pc->pwmf->base,
> > +						      PWMV4_REG_ENABLE));
> > +
> > +	/*
> > +	 * "But Nicolas", you ask with valid concerns, "why would you enable =
the
> > +	 * PWM before setting all the parameter registers?"
>=20
> Funny, I had this thought alread for mfpwm_acquire() above. Do you also
> need that if wfhw->enable =3D=3D 0?

The only thing mfpwm_acquire does is check that this driver is the only
one using the hardware, and enabling the bus clk so registers can be
accessed. The clock that the PWM signal is derived from, as well as
enabling and disabling PWM, is a separate step. In this case, we need
to have acquired mfpwm beforehand to do the reg read for was_enabled.

>=20
> > +	 * Excellent question, Mr. Reader M. Strawman! The RK3576 TRM Part 1
> > +	 * Section 34.6.3 specifies that this is the intended order of writes.
> > +	 * Doing the PWM_EN and PWM_CLK_EN writes after the params but before
> > +	 * the CTRL_UPDATE_EN, or even after the CTRL_UPDATE_EN, results in
> > +	 * erratic behaviour where repeated turning on and off of the PWM may
> > +	 * not turn it off under all circumstances. This is also why we don't
> > +	 * use relaxed writes; it's not worth the footgun.
> > +	 */
> > +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> > +			REG_UPDATE_WE(wfhw->enable, 0, 1));
> > +
> > +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_PERIOD, wfhw->period);
> > +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_DUTY, wfhw->duty);
> > +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_OFFSET, wfhw->offset);
> > +
> > +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL, PWMV4_CTRL_CONT_FLAGS=
);
> > +
> > +	/* Commit new configuration to hardware output. */
> > +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> > +			PWMV4_CTRL_UPDATE_EN(1));
>=20
> PWMV4_CTRL_UPDATE_EN is always only used with 1 as parameter, so maybe
> simplify the definition to BIT(2)?

Will do.

>=20
> > +	if (pwmv4_is_enabled(wfhw->enable)) {
> > +		if (!was_enabled) {
> > +			dev_dbg(&chip->dev, "enabling PWM output\n");
> > +			ret =3D mfpwm_pwmclk_enable(pc->pwmf);
> > +			if (ret)
> > +				goto err_mfpwm_release;
> > +
> > +			/*
> > +			 * Output should be on now, acquire device to guarantee
> > +			 * exclusion with other device functions while it's on.
> > +			 */
> > +			ret =3D mfpwm_acquire(pc->pwmf);
> > +			if (ret)
> > +				goto err_mfpwm_release;
>=20
> Alternatively to calling mfpwm_acquire once more, you could also skip
> the mfpwm_release() below. That makes the code a bit more complicated,
> but also reduces the number of possible failing points.
>=20

I think I did this at some stage but it'd just necessitate duplicating the
if condition at the release point. The else-if branch just down below still
needs to exist since we need to not just balance this function's acquire,
but the fact that we kept it acquired when we turned it on so we need to
release it an extra time when we turn it off. I don't think changing this
to eliminate the additional acquire call has clear benefits here.

> > +		}
> > +	} else if (was_enabled) {
> > +		dev_dbg(&chip->dev, "disabling PWM output\n");
> > +		mfpwm_pwmclk_disable(pc->pwmf);
> > +		/* Output is off now, extra release to balance extra acquire */
> > +		mfpwm_release(pc->pwmf);
> > +	}
> > +
> > +err_mfpwm_release:
> > +	mfpwm_release(pc->pwmf);
> > +
> > +	return ret;
> > +}
> > +
> > +/* We state the PWM chip is atomic, so none of these functions should =
sleep. */
> > +static const struct pwm_ops rockchip_pwm_v4_ops =3D {
> > +	.sizeof_wfhw =3D sizeof(struct rockchip_pwm_v4_wf),
> > +	.round_waveform_tohw =3D rockchip_pwm_v4_round_wf_tohw,
> > +	.round_waveform_fromhw =3D rockchip_pwm_v4_round_wf_fromhw,
> > +	.read_waveform =3D rockchip_pwm_v4_read_wf,
> > +	.write_waveform =3D rockchip_pwm_v4_write_wf,
> > +};
> > +
> > +static int rockchip_pwm_v4_probe(struct platform_device *pdev)
> > +{
> > +	struct rockchip_mfpwm_func *pwmf =3D dev_get_platdata(&pdev->dev);
> > +	struct rockchip_pwm_v4 *pc;
> > +	struct pwm_chip *chip;
> > +	int ret;
> > +
> > +	chip =3D devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +
> > +	pc =3D to_rockchip_pwm_v4(chip);
> > +	pc->pwmf =3D pwmf;
> > +
> > +	platform_set_drvdata(pdev, pc);
> > +
> > +	chip->ops =3D &rockchip_pwm_v4_ops;
> > +	chip->atomic =3D true;
> > +
>=20
> If the PWM is already enabled you better call mfpwm_acquire() here?

As in, if the hardware set the PWM on before the driver probed? I hadn't
considered this case, and will need to think about it. Could very well be
a possibility as u-boot does things before us.

>=20
> > +	ret =3D pwmchip_add(chip);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void rockchip_pwm_v4_remove(struct platform_device *pdev)
> > +{
> > +	struct rockchip_pwm_v4 *pc =3D platform_get_drvdata(pdev);
>=20
> 	pwmchip_remove()?

Good catch, thanks. Will add.

>=20
> > +	mfpwm_remove_func(pc->pwmf);
>=20
> Maybe make this a devm function?

I vaguely recall trying that and running into issues with it but it's
possible I'm misremembering which remove caused issues.

>=20
> > +}
> > +
> > +static const struct platform_device_id rockchip_pwm_v4_ids[] =3D {
> > +	{ .name =3D "pwm-rockchip-v4", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, rockchip_pwm_v4_ids);
> > +
> > +static struct platform_driver rockchip_pwm_v4_driver =3D {
> > +	.probe =3D rockchip_pwm_v4_probe,
> > +	.remove =3D rockchip_pwm_v4_remove,
> > +	.driver =3D {
> > +		.name =3D "pwm-rockchip-v4",
> > +	},
> > +	.id_table =3D rockchip_pwm_v4_ids,
> > +};
> > +module_platform_driver(rockchip_pwm_v4_driver);
> > +
> > +MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
> > +MODULE_DESCRIPTION("Rockchip PWMv4 Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS("ROCKCHIP_MFPWM");
>=20
> There are different tastes, but if you ask me that MODULE_IMPORT_NS can
> go into the header declaring the functions from that namespace.
>=20
> Best regards
> Uwe
>=20

Kind regards,
Nicolas Frattaroli



