Return-Path: <linux-pwm+bounces-6126-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA84BAC3CED
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584333A20EA
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972C1EFFB2;
	Mon, 26 May 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Wg7XJSmr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABE158DD4;
	Mon, 26 May 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251874; cv=pass; b=p8rSoNSCy/2YyplQhDGIHqdhgA8E2OuynKTlqqfcv0b67KEUnXDq4L6Bi9qFu31haJVE1RX/S/tGRiLyFe6QmAuZ+QpDDTMsWyOQVdtcM/QzkswzY7g121fkjbzyWuT5DwGE50GpGkElz0pat/P1f6sMr+3gEIGqk1zxGBM7tEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251874; c=relaxed/simple;
	bh=BqQ5tYNL3Ro4idvCnU/3OSzfmDwsDgjFYL9oBJ2NR9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx+JFjGivS/y1JFchCl74H+F3LyqVpWrckYMMcNDljuO+mXyojABQRX9s+HtvntSFdRDsAi7efuOEyq3IY3qrVev2hOd9ZqCqqLren0CsaMPB720S/yGXo3IqmCZi4ugttLO2+Mjb+gnGJVsIONwhHEF2N6dHF8h/XwA4Jvf8Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Wg7XJSmr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748251834; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SBEsJcZHWSkaR/fROh7J9MBU8lIVoJhe/jejF9Fmga+ZTXxvyjrPzhu6rHxiv1vCK11NegL2g6dqlS6gnl4WnRCRGDDG+y9rxMj6TyngCdv8zJqGPYh0xaXWtg0TGoscHFXafDDcG4iS5QjSr7St017bDhuBrfMyFgbjd3IfOUI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748251834; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z6te812vgyS+SyE7SWT04/qWDSaGg86QzX952wROxNE=; 
	b=hY5XCU5tJIb2v7vLhdFphnAMf1VaCYsVNJ22OV70w65U5iSJff+f2vgmGp4sdtGpO6tIo47RbtO7leAgcPis4RnLZpo+sucy+kDAdER7BCk345pTH53/d/YBjjags9NA23VsX+viIfdH/AD8xcwTFOValbM/4o8vWeYbNXV5haM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748251834;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Z6te812vgyS+SyE7SWT04/qWDSaGg86QzX952wROxNE=;
	b=Wg7XJSmrHb2OeyYw0MSH1bN4dcN1cXuBbrfJdY/qn3fyDkYZ7LdooXNVLExuQvu6
	a/MqqbSNJlfNNT0AmmMhsh2wj3GB2drEP7po1/EWw9J7Fc+8QAXXQJs0J5AhAyfKNYq
	O7ANIVOUFI7Y4sstGl+ZdmkgTiEf+caRFoU/HHOs=
Received: by mx.zohomail.com with SMTPS id 1748251831359884.8119171996467;
	Mon, 26 May 2025 02:30:31 -0700 (PDT)
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
Date: Mon, 26 May 2025 11:30:25 +0200
Message-ID: <10663552.nUPlyArG6x@workhorse>
In-Reply-To: <gcirox4uq33lbfthusrphuabvxc2jnnjfazuhuyhohwlnv2gnu@5trpjknqaivm>
References:
 <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <4313739.kQq0lBPeGt@workhorse>
 <gcirox4uq33lbfthusrphuabvxc2jnnjfazuhuyhohwlnv2gnu@5trpjknqaivm>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Uwe,

On Friday, 23 May 2025 17:02:34 Central European Summer Time Uwe Kleine-K=
=C3=B6nig wrote:
> [Dropped Jonas Karlman from Cc as his email address doesn't work.]

Strange, I don't think I got any bounces, and your reply still has him in
the Cc ;) Just letting you know so that it doesn't look like I re-added him.

> Hello Nicolas,
>=20
> On Thu, May 22, 2025 at 03:02:29PM +0200, Nicolas Frattaroli wrote:
> > On Tuesday, 13 May 2025 19:26:31 Central European Summer Time Uwe Klein=
e-K=C3=B6nig wrote:
> > > On Tue, Apr 08, 2025 at 02:32:17PM +0200, Nicolas Frattaroli wrote:
> > > > The Rockchip RK3576 brings with it a new PWM IP, in downstream code
> > > > referred to as "v4". This new IP is different enough from the previ=
ous
> > > > Rockchip IP that I felt it necessary to add a new driver for it, in=
stead
> > > > of shoehorning it in the old one.
> > > >=20
> > > > Add this new driver, based on the PWM core's waveform APIs. Its pla=
tform
> > > > device is registered by the parent mfpwm driver, from which it also
> > > > receives a little platform data struct, so that mfpwm can guarantee=
 that
> > > > all the platform device drivers spread across different subsystems =
for
> > > > this specific hardware IP do not interfere with each other.
> > > >=20
> > > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > > ---
> > > >  MAINTAINERS                   |   1 +
> > > >  drivers/pwm/Kconfig           |  13 ++
> > > >  drivers/pwm/Makefile          |   1 +
> > > >  drivers/pwm/pwm-rockchip-v4.c | 336 ++++++++++++++++++++++++++++++=
++++++++++++
> > > >  4 files changed, 351 insertions(+)
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index e6a9347be1e7889089e1d9e655cb23c2d8399b40..3ddd245fd4ad8d9ed2e=
762910a7a1f6436f93e34 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -20891,6 +20891,7 @@ L:	linux-rockchip@lists.infradead.org
> > > >  L:	linux-pwm@vger.kernel.org
> > > >  S:	Maintained
> > > >  F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
> > > > +F:	drivers/pwm/pwm-rockchip-v4.c
> > > >  F:	drivers/soc/rockchip/mfpwm.c
> > > >  F:	include/soc/rockchip/mfpwm.h
> > > > =20
> > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > index 4731d5b90d7edcc61138e4a5bf7e98906953ece4..242039f62ab091cea33=
7bf27ef310bcf696b6ed0 100644
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -540,6 +540,19 @@ config PWM_ROCKCHIP
> > > >  	  Generic PWM framework driver for the PWM controller found on
> > > >  	  Rockchip SoCs.
> > > > =20
> > > > +config PWM_ROCKCHIP_V4
> > > > +	tristate "Rockchip PWM v4 support"
> > > > +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> > > > +	depends on ROCKCHIP_MFPWM
> > > > +	depends on HAS_IOMEM
> > > > +	help
> > > > +	  Generic PWM framework driver for the PWM controller found on
> > > > +	  later Rockchip SoCs such as the RK3576.
> > > > +
> > > > +	  Uses the Rockchip Multi-function PWM controller driver infrastr=
ucture
> > > > +	  to guarantee fearlessly concurrent operation with other functio=
ns of
> > > > +	  the same device implemented by drivers in other subsystems.
> > > > +
> > > >  config PWM_RZ_MTU3
> > > >  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > > >  	depends on RZ_MTU3
> > > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > > index 539e0def3f82fcb866ab83a0346a15f7efdd7127..b5aca7ff58ac83f8445=
81df526624617025291de 100644
> > > > --- a/drivers/pwm/Makefile
> > > > +++ b/drivers/pwm/Makefile
> > > > @@ -49,6 +49,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspbe=
rrypi-poe.o
> > > >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> > > >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> > > >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > > > +obj-$(CONFIG_PWM_ROCKCHIP_V4)	+=3D pwm-rockchip-v4.o
> > > >  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> > > >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > > >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > > > diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockch=
ip-v4.c
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..980b27454ef9b930bef=
0496ca528533cf419fa0e
> > > > --- /dev/null
> > > > +++ b/drivers/pwm/pwm-rockchip-v4.c
> > > > @@ -0,0 +1,336 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * Copyright (c) 2025 Collabora Ltd.
> > > > + *
> > > > + * A Pulse-Width-Modulation (PWM) generator driver for the generat=
ors found in
> > > > + * Rockchip SoCs such as the RK3576, internally referred to as "PW=
M v4". Uses
> > > > + * the MFPWM infrastructure to guarantee exclusive use over the de=
vice without
> > > > + * other functions of the device from different drivers interferin=
g with its
> > > > + * operation while it's active.
> > >=20
> > > Can you please add a "Limitations" paragraph here similar to the other
> > > newer drivers that explains how the hardware behave on disable
> > > (inactive? High-Z? freeze?), if there are glitches possible when
> > > settings are changed or if the currently running period is completed =
on
> > > reconfiguration.
> >=20
> > Will do. Might need a few long hours with the logic analyzer and poking=
 at
> > the common clock framework to cover all bases.
>=20
> Usually it's simpler. e.g. if you set period=3D1s,duty=3D0 and then
> period=3D2s,duty=3D2 an LED is enough to determine if the current period =
is
> completed before a change.
>=20
> You don't find High-Z with an LED but can distinguish between "inactive
> when off" and "freeze when off". The datasheet might know about High-Z.

I've used a logic analyzer to quickly determine this, it went fairly
smoothly and didn't take long at all. The PWM output stops immediately
and freezes in whatever state it was in at that point in time, i.e.
stays either low or high. Changes to period/duty/offset params only
seem to take effect at the start of the next period, so changing them
should be glitch-free.

I will add a full limitations paragraph, including a TODO for the future
with an idea for how to change the driver so that it lets the current
period complete when turning the PWM off. I'm not implementing it right
away in this series because that'd involve adding some IRQ handlers to
this driver as well and the series is big enough as it is already :)

> Apropos datasheet: If that is publically available, a reference to it in
> the driver's header would be awesome.

I've noted that down as a thing to ask Rockchip. Currently, the technical
reference manual of this SoC unfortunately is not publicly available, at
least not in an official capacity. I'll mention it'd also be sufficient
if we had just the PWM section of that TRM so that I can link to it.

> > > > +static int rockchip_pwm_v4_round_wf_tohw(struct pwm_chip *chip,
> > > > +					 struct pwm_device *pwm,
> > > > +					 const struct pwm_waveform *wf,
> > > > +					 void *_wfhw)
> > > > +{
> > > > +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> > > > +	struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> > > > +	unsigned long rate;
> > > > +	int ret =3D 0;
> > > > +
> > > > +	/* We do not want chosen_clk to change out from under us here */
> > > > +	ret =3D mfpwm_acquire(pc->pwmf);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	rate =3D mfpwm_clk_get_rate(pc->pwmf->parent);
> > > > +
> > > > +	ret =3D rockchip_pwm_v4_round_params(rate, wf->duty_length_ns,
> > > > +					   wf->period_length_ns,
> > > > +					   wf->duty_offset_ns, &wfhw->duty,
> > > > +					   &wfhw->period, &wfhw->offset);
> > > > +
> > > > +	if (wf->period_length_ns > 0)
> > > > +		wfhw->enable =3D PWMV4_EN_BOTH_MASK;
> > > > +	else
> > > > +		wfhw->enable =3D 0;
> > > > +
> > > > +	dev_dbg(&chip->dev, "tohw: duty =3D %u, period =3D %u, offset =3D=
 %u, rate %lu\n",
> > > > +		wfhw->duty, wfhw->period, wfhw->offset, rate);
> > > > +
> > > > +	mfpwm_release(pc->pwmf);
> > > > +	return ret;
> > >=20
> > > This is wrong. If a too high value for (say) period_length_ns is
> > > requested, you're supposed to configure the maximal possible
> > > period_length and not return a failure.
> >=20
> > Ack. What if offset > period - duty is requested? Should I just saturat=
e it
> > to period - duty in that case?
>=20
> If you configure period =3D 10, duty =3D offset =3D 6 the period restart =
is
> supposed to happen during the active phase, that is it looks as follows:
>=20
>     __     _____     _____     _____     ____
>       \___/     \___/     \___/     \___/   =20
>     ^         ^         ^         ^         ^
>     01234567890
>=20
> ('^' marks the period start.)

Okay, this might make this a bit more complicated then. The hardware in the
TRM at least states for the offset register

  The value ranges from 0 to (period-duty)

which I think means that I have to actually make use of the hardware's
polarity setting, set it to inverse polarity, and then set the offset
to duty and the duty to period - duty if I understand this right.

Offset right now is just used by the pwm core to do inversion, right? As
in there's no handy sysfs knob I can shove values into to set it to an
arbitrary number?

I may also just shove a value above (period - duty) into the offset reg
to see if the hardware already behaves in the expected way and doing the
math manually would be overcomplicating things.

> > > > +	ret =3D mfpwm_acquire(pc->pwmf);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	rate =3D mfpwm_clk_get_rate(pc->pwmf->parent);
> > >=20
> > > Why isn't that a proper clock that you can call clk_get_rate() (and
> > > clk_rate_exclusive_get()) for?
> >=20
> > Because I didn't know clk-mux.c existed :( But even with it, I'm not su=
re
> > if letting mfpwm function drivers touch the clk directly is a good idea,
> > as this either means storing it in their pwmf struct or making the memb=
ers
> > of the mfpwm struct part of the shared header.
>=20
> The different drivers shouldn't need to touch the clk directly, the clk
> API functions should be enough?!

It's not just enough, it's too much. I don't want to give every pwmf
instance a pointer to the clock mux and then let the function drivers call
every common clock framework function on it that they wish to call.

I'll think about it more. clk_rate_exclusive_get/_put should protect
against the kinds of cross-function-driver interference hijinks I'm
worried about, so maybe the indirection isn't needed.

> > > > +	wfhw->period =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_PERIOD);
> > > > +	wfhw->duty =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_DUTY);
> > > > +	wfhw->offset =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_OFFSET);
> > > > +	wfhw->enable =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_ENABLE)=
 & PWMV4_EN_BOTH_MASK;
> > > > +
> > > > +	mfpwm_release(pc->pwmf);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int rockchip_pwm_v4_write_wf(struct pwm_chip *chip, struct =
pwm_device *pwm,
> > > > +				    const void *_wfhw)
> > > > +{
> > > > +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> > > > +	const struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> > > > +	bool was_enabled =3D false;
> > > > +	int ret =3D 0;
> > > > +
> > > > +	ret =3D mfpwm_acquire(pc->pwmf);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	was_enabled =3D pwmv4_is_enabled(mfpwm_reg_read(pc->pwmf->base,
> > > > +						      PWMV4_REG_ENABLE));
>=20
> Just noticed: pwmv4_is_enabled has the wrong prefix. Please use
> "rockchip_pwm_v4" consistently.

Will do.

> [...]
>
> > > > +static int rockchip_pwm_v4_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct rockchip_mfpwm_func *pwmf =3D dev_get_platdata(&pdev->dev);
> > > > +	struct rockchip_pwm_v4 *pc;
> > > > +	struct pwm_chip *chip;
> > > > +	int ret;
> > > > +
> > > > +	chip =3D devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
> > > > +	if (IS_ERR(chip))
> > > > +		return PTR_ERR(chip);
> > > > +
> > > > +	pc =3D to_rockchip_pwm_v4(chip);
> > > > +	pc->pwmf =3D pwmf;
> > > > +
> > > > +	platform_set_drvdata(pdev, pc);
> > > > +
> > > > +	chip->ops =3D &rockchip_pwm_v4_ops;
> > > > +	chip->atomic =3D true;
> > > > +
> > >=20
> > > If the PWM is already enabled you better call mfpwm_acquire() here?
> >=20
> > As in, if the hardware set the PWM on before the driver probed? I hadn't
> > considered this case, and will need to think about it. Could very well =
be
> > a possibility as u-boot does things before us.
>=20
> The typical application is that the bootloader already shows a splash
> screen and then you don't want Linux booting result in a flashing
> display.

Gotcha, that does sound fairly important and I've implemented it for v2
now. Managed to successfully test it with some manual register writes
from u-boot.

Haven't really decided yet whether I'll send v2 out soon or wait for -rc1
to release to base it against. I'm currently leaning towards sending it
out before -rc1 just because I don't want to rob reviewers of up to two
additional weeks of potential review time, especially since v2 is already
substantially different based on the changes I've staged for it so far.

>=20
> Best regards
> Uwe

Kind regards,
Nicolas Frattaroli




