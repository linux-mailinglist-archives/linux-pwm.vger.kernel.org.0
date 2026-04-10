Return-Path: <linux-pwm+bounces-8550-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BFQOuwz2WmjnQgAu9opvQ
	(envelope-from <linux-pwm+bounces-8550-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 19:31:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501073DB113
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 19:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3984300F153
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEDC3D3309;
	Fri, 10 Apr 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8rvFum1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29717A305;
	Fri, 10 Apr 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842281; cv=none; b=pfhKOqedUQQqHJLWH1Cfy8mtslGXzyglg5Kc3cEG2vx/rcxQ7mi6Vzb9b+hj8zIyCg9mkm1pVp5wx932AUk/X/yVA6p4uc6lVnPvLgJRxtK9kTFEaRec8LhGDNz+G7u4zvThpNTBTBZndje+v9S0u8JQOTym2kjNAL8VeN7b/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842281; c=relaxed/simple;
	bh=o8dVBEqQuZ5eT0MB2sJSiDn/K4QNVAm7ZQiuW/IByCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKyBOdY1MQvgQtpHy3Afwtv3QmHG9qOC/ZvQ+SkDK2NDm7INeX9VywzDC8yMI/Hfq2rMA2Wf4lv+vRuA9wZdGFSJXp3Sd0w5Yk9+/whyGkLwLQB3Q8pBLgyQD2Cwd5B2ifqQIgxzx4qv8KbtVZtuPzyyjm9KTL7TnTASZfoj9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8rvFum1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EA7C19421;
	Fri, 10 Apr 2026 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775842281;
	bh=o8dVBEqQuZ5eT0MB2sJSiDn/K4QNVAm7ZQiuW/IByCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8rvFum1oDZTa1EpKY0OE7qkWVAY/n8Qpw5qj9z4uJgLc+eR12jfSFthSUu5XjS86
	 ERsWj9IqBTnHYsiGcBdu2CMuY0axjOKhfJTJRp/intXmnNcDQRTnw+NdvRN70DbRPU
	 mFkgL0H2uRk1ksAKVXl68cgWQidmEDNOXrCtFLfICA4p9hcPhNE4dXVfD3D3uKNMbT
	 ntEWtOcQyGUSu5dN97V0ujLp9WMtSf85ilgT5TVJRHU9zqKiHeBFfc+Etn3yfQ9Ciq
	 HzDVZtdd1E09HhUNzZVqkFZrjHPSLjZLVkw18CCp3KBBc9qq+oBeVRzDXpznCQ/iPF
	 AHbHJCSxBsLEg==
Date: Fri, 10 Apr 2026 19:31:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v2 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <adkrHkANCzxO8KUP@monoceros>
References: <cover.1775829499.git.andrea.porta@suse.com>
 <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d5bgry64vqq6zout"
Content-Disposition: inline
In-Reply-To: <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8550-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,raspberrypi.com:email,raspberrypi.com:url,suse.de:email]
X-Rspamd-Queue-Id: 501073DB113
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--d5bgry64vqq6zout
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: rp1: Add RP1 PWM controller driver
MIME-Version: 1.0

Hello Andrea,

nice work for a v2!

On Fri, Apr 10, 2026 at 04:09:58PM +0200, Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
>=20
> The Raspberry Pi RP1 southbridge features an embedded PWM
> controller with 4 output channels, alongside an RPM interface
> to read the fan speed on the Raspberry Pi 5.
>=20
> Add the supporting driver.
>=20
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/pwm/Kconfig   |   9 ++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-rp1.c | 344 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 354 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rp1.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376a..32031f2af75af 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -625,6 +625,15 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
> =20
> +config PWM_RASPBERRYPI_RP1
> +	bool "RP1 PWM support"
> +	depends on MISC_RP1 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select REGMAP_MMIO
> +	select MFD_SYSCON
> +	help
> +	  PWM framework driver for Raspberry Pi RP1 controller.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0dc0d2b69025d..59f29f60f9123 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RASPBERRYPI_RP1)	+=3D pwm-rp1.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
> new file mode 100644
> index 0000000000000..b88c697d9567e
> --- /dev/null
> +++ b/drivers/pwm/pwm-rp1.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pwm-rp1.c
> + *
> + * Raspberry Pi RP1 PWM.
> + *
> + * Copyright =A9 2026 Raspberry Pi Ltd.
> + *
> + * Author: Naushir Patuck (naush@raspberrypi.com)
> + *
> + * Based on the pwm-bcm2835 driver by:
> + * Bart Tanghe <bart.tanghe@thomasmore.be>
> + *
> + * Datasheet: https://pip-assets.raspberrypi.com/categories/892-raspberr=
y-pi-5/documents/RP-008370-DS-1-rp1-peripherals.pdf?disposition=3Dinline
> + *
> + * Limitations:
> + * - Channels can be enabled/disabled and their duty cycle and period can
> + *   be updated glitchlessly. Update are synchronized with the next stro=
be
> + *   at the end of the current period of the respective channel, once the
> + *   update bit is set. The update flag is global, not per-channel.
> + * - Channels are phase-capable, but on RPi5, the firmware can use a cha=
nnel
> + *   phase register to report the RPM of the fan connected to that PWM
> + *   channel. As a result, phase control will be ignored for now.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#define RP1_PWM_GLOBAL_CTRL	0x000
> +#define RP1_PWM_CHANNEL_CTRL(x)	(0x014 + ((x) * 0x10))
> +#define RP1_PWM_RANGE(x)	(0x018 + ((x) * 0x10))
> +#define RP1_PWM_PHASE(x)	(0x01C + ((x) * 0x10))
> +#define RP1_PWM_DUTY(x)		(0x020 + ((x) * 0x10))
> +
> +/* 8:FIFO_POP_MASK + 0:Trailing edge M/S modulation */
> +#define RP1_PWM_CHANNEL_DEFAULT		(BIT(8) + BIT(0))

Please add a #define for BIT(8) and then use that and
FIELD_PREP(RP1_PWM_MODE, RP1_PWM_MODE_SOMENICENAME) to define the
constant. Also I would define it below the register defines.

> +#define RP1_PWM_CHANNEL_ENABLE(x)	BIT(x)
> +#define RP1_PWM_POLARITY		BIT(3)
> +#define RP1_PWM_SET_UPDATE		BIT(31)
> +#define RP1_PWM_MODE_MASK		GENMASK(1, 0)

s/_MASK// please

It would be great if the bitfield's names started with the register
name.

> +
> +#define RP1_PWM_NUM_PWMS	4
> +
> +struct rp1_pwm {
> +	struct regmap	*regmap;
> +	struct clk	*clk;
> +	unsigned long	clk_rate;
> +	bool		clk_enabled;
> +};
> +
> +struct rp1_pwm_waveform {
> +	u32	period_ticks;
> +	u32	duty_ticks;
> +	bool	enabled;
> +	bool	inverted_polarity;
> +};
> +
> +static const struct regmap_config rp1_pwm_regmap_config =3D {
> +	.reg_bits    =3D 32,
> +	.val_bits    =3D 32,
> +	.reg_stride  =3D 4,
> +	.max_register =3D 0x60,

I'm not a fan of aligning the =3D in a struct, still more if it fails like
here. Please consistently align all =3Ds, or even better, use a single
space before each =3D. (Same for the struct definitions above, but I won't
insist.)

> +};
> +
> +static void rp1_pwm_apply_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +	u32 value;
> +
> +	/* update the changed registers on the next strobe to avoid glitches */
> +	regmap_read(rp1->regmap, RP1_PWM_GLOBAL_CTRL, &value);
> +	value |=3D RP1_PWM_SET_UPDATE;
> +	regmap_write(rp1->regmap, RP1_PWM_GLOBAL_CTRL, value);

I assume there is a glitch if I update two channels and the old
configuration of the first channel ends while I'm in the middle of
configuring the second?

> +}
> +
> +static int rp1_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +
> +	/* init channel to reset defaults */
> +	regmap_write(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), RP1_PWM_CHA=
NNEL_DEFAULT);
> +	return 0;
> +}
> +
> +static int rp1_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +				       struct pwm_device *pwm,
> +				       const struct pwm_waveform *wf,
> +				       void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +	struct rp1_pwm_waveform *wfhw =3D _wfhw;
> +	u64 clk_rate =3D rp1->clk_rate;
> +	u64 ticks;

	if (!wf->period_length_ns)
		wfhw->enabled =3D false
		return 0;

> +	ticks =3D mul_u64_u64_div_u64(wf->period_length_ns, clk_rate, NSEC_PER_=
SEC);

To ensure this doesn't overflow please fail to probe the driver if
clk_rate > 1 GHz with an explaining comment. (Or alternatively calculate
the length of period_ticks =3D U32_MAX and skip the calculation if
wf->period_length_ns is bigger.)

> +	if (ticks > U32_MAX)
> +		ticks =3D U32_MAX;
> +	wfhw->period_ticks =3D ticks;

What happens if wf->period_length_ns > 0 but ticks =3D=3D 0?

> +	if (wf->duty_offset_ns + wf->duty_length_ns >=3D wf->period_length_ns) {

The maybe surprising effect here is that in the two cases

	wf->duty_offset_ns =3D=3D wf->period_length_ns and wf->duty_length_ns =3D=
=3D 0

and
=09
	wf->duty_length_ns =3D=3D wf->period_length_ns and wf->duty_offset_ns =3D=
=3D 0

you're configuring inverted polarity. I doesn't matter technically
because the result is the same, but for consumers still using pwm_state
this is irritating. That's why pwm-stm32 uses inverted polarity only if
also wf->duty_length_ns and wf->duty_offset_ns are non-zero.

> +		ticks =3D mul_u64_u64_div_u64(wf->period_length_ns - wf->duty_length_n=
s,
> +					    clk_rate, NSEC_PER_SEC);

The rounding is wrong here. You should pick the biggest duty_length not
bigger than wf->duty_length_ns, so you have to use

	ticks =3D wfhw->period_ticks - mul_u64_u64_div_u64(wf->duty_length_ns, clk=
_rate, NSEC_PER_SEC):

=2E I see this is a hole in the pwmtestperf coverage.

> +		wfhw->inverted_polarity =3D true;
> +	} else {
> +		ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_S=
EC);
> +		wfhw->inverted_polarity =3D false;
> +	}
> +
> +	if (ticks > wfhw->period_ticks)
> +		ticks =3D wfhw->period_ticks;

You can and should assume that wf->duty_length_ns <=3D
wf->period_length_ns. Then the if condition can never become true.

> +	wfhw->duty_ticks =3D ticks;
> +
> +	wfhw->enabled =3D !!wfhw->duty_ticks;
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const void *_wfhw,
> +					 struct pwm_waveform *wf)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +	const struct rp1_pwm_waveform *wfhw =3D _wfhw;
> +	u64 clk_rate =3D rp1->clk_rate;
> +	u32 ticks;
> +
> +	memset(wf, 0, sizeof(*wf));

	wf =3D (struct pwm_waveform){ };

is usually more efficient.

> +	if (!wfhw->enabled)
> +		return 0;
> +
> +	wf->period_length_ns =3D DIV_ROUND_UP_ULL((u64)wfhw->period_ticks * NSE=
C_PER_SEC, clk_rate);
> +
> +	if (wfhw->inverted_polarity) {
> +		wf->duty_length_ns =3D DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_P=
ER_SEC,
> +						      clk_rate);
> +	} else {
> +		wf->duty_offset_ns =3D DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_P=
ER_SEC,
> +						      clk_rate);
> +		ticks =3D wfhw->period_ticks - wfhw->duty_ticks;
> +		wf->duty_length_ns =3D DIV_ROUND_UP_ULL((u64)ticks * NSEC_PER_SEC, clk=
_rate);
> +	}

This needs adaption after the rounding issue in tohw is fixed.

> +	return 0;
> +}
> +
> +static int rp1_pwm_write_waveform(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  const void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +	const struct rp1_pwm_waveform *wfhw =3D _wfhw;
> +	u32 value;
> +
> +	/* set period and duty cycle */
> +	regmap_write(rp1->regmap,
> +		     RP1_PWM_RANGE(pwm->hwpwm), wfhw->period_ticks);
> +	regmap_write(rp1->regmap,
> +		     RP1_PWM_DUTY(pwm->hwpwm), wfhw->duty_ticks);
> +
> +	/* set polarity */
> +	regmap_read(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), &value);
> +	if (!wfhw->inverted_polarity)
> +		value &=3D ~RP1_PWM_POLARITY;
> +	else
> +		value |=3D RP1_PWM_POLARITY;
> +	regmap_write(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), value);
> +
> +	/* enable/disable */
> +	regmap_read(rp1->regmap, RP1_PWM_GLOBAL_CTRL, &value);
> +	if (wfhw->enabled)
> +		value |=3D RP1_PWM_CHANNEL_ENABLE(pwm->hwpwm);
> +	else
> +		value &=3D ~RP1_PWM_CHANNEL_ENABLE(pwm->hwpwm);
> +	regmap_write(rp1->regmap, RP1_PWM_GLOBAL_CTRL, value);

You can exit early if wfhw->enabled is false after clearing the channel
enable bit.

> +	rp1_pwm_apply_config(chip, pwm);
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_read_waveform(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +	struct rp1_pwm_waveform *wfhw =3D _wfhw;
> +	u32 value;
> +
> +	regmap_read(rp1->regmap, RP1_PWM_GLOBAL_CTRL, &value);
> +	wfhw->enabled =3D !!(value & RP1_PWM_CHANNEL_ENABLE(pwm->hwpwm));
> +
> +	regmap_read(rp1->regmap, RP1_PWM_CHANNEL_CTRL(pwm->hwpwm), &value);
> +	wfhw->inverted_polarity =3D !!(value & RP1_PWM_POLARITY);
> +
> +	if (wfhw->enabled) {
> +		regmap_read(rp1->regmap, RP1_PWM_RANGE(pwm->hwpwm), &wfhw->period_tick=
s);
> +		regmap_read(rp1->regmap, RP1_PWM_DUTY(pwm->hwpwm), &wfhw->duty_ticks);
> +	} else {
> +		wfhw->period_ticks =3D 0;
> +		wfhw->duty_ticks =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops rp1_pwm_ops =3D {
> +	.sizeof_wfhw =3D sizeof(struct rp1_pwm_waveform),
> +	.request =3D rp1_pwm_request,
> +	.round_waveform_tohw =3D rp1_pwm_round_waveform_tohw,
> +	.round_waveform_fromhw =3D rp1_pwm_round_waveform_fromhw,
> +	.read_waveform =3D rp1_pwm_read_waveform,
> +	.write_waveform =3D rp1_pwm_write_waveform,
> +};
> +
> +static int rp1_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	unsigned long clk_rate;
> +	struct pwm_chip *chip;
> +	void __iomem	*base;
> +	struct rp1_pwm *rp1;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, RP1_PWM_NUM_PWMS, sizeof(*rp1));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	rp1 =3D pwmchip_get_drvdata(chip);
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rp1->regmap =3D devm_regmap_init_mmio(dev, base, &rp1_pwm_regmap_config=
);
> +	if (IS_ERR(rp1->regmap))
> +		return dev_err_probe(dev, PTR_ERR(rp1->regmap), "Cannot initialize reg=
map\n");
> +
> +	ret =3D of_syscon_register_regmap(np, rp1->regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register syscon\n");
> +
> +	rp1->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(rp1->clk))
> +		return dev_err_probe(dev, PTR_ERR(rp1->clk), "Clock not found\n");
> +
> +	ret =3D clk_prepare_enable(rp1->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable clock\n");
> +	rp1->clk_enabled =3D true;
> +
> +	ret =3D devm_clk_rate_exclusive_get(dev, rp1->clk);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Fail to get exclusive rate\n");

s/Fail/Failed/

> +		goto err_disable_clk;
> +	}
> +
> +	clk_rate =3D clk_get_rate(rp1->clk);
> +	if (!clk_rate) {
> +		ret =3D dev_err_probe(dev, -EINVAL, "Failed to get clock rate\n");
> +		goto err_disable_clk;
> +	}
> +	rp1->clk_rate =3D clk_rate;
> +
> +	chip->ops =3D &rp1_pwm_ops;
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register PWM chip\n");
> +		goto err_disable_clk;
> +	}
> +
> +	return 0;
> +
> +err_disable_clk:
> +	clk_disable_unprepare(rp1->clk);
> +
> +	return ret;
> +}

On remove you miss to balance the call to clk_prepare_enable() (if no
failed call to clk_prepare_enable() in rp1_pwm_resume() happend).

> +
> +static int rp1_pwm_suspend(struct device *dev)
> +{
> +	struct rp1_pwm *rp1 =3D dev_get_drvdata(dev);
> +
> +	if (rp1->clk_enabled) {
> +		clk_disable_unprepare(rp1->clk);
> +		rp1->clk_enabled =3D false;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_resume(struct device *dev)
> +{
> +	struct rp1_pwm *rp1 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(rp1->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clock on resume: %d\n", ret);

Please use %pe for error codes.

> +		return ret;
> +	}
> +
> +	rp1->clk_enabled =3D true;
> +
> +	return 0;
> +}

Best regards
Uwe

--d5bgry64vqq6zout
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnZM+MACgkQj4D7WH0S
/k4q5wf+JyWm60O9EEDBYl5XSWId92/mG09JSGQLpIHeNqI2ysjl8JKvBbk1BEyU
kiIu+mW9xyRs85ZiWtTkO48F6xcr3IEWOAn+SV3C7ADViLaLaa1rcaQmeQizldFW
3NFGi38BahHf6/IuIRR0JeEvDn9nBu/K3vEquGVcl9HqtGiTKVjSfI+/fRppTMnt
3K8K5q+l93A2jDSJweS/wPybX2wV1waSmBZc4sAkttad3muYE5n/7P0VwJ+8B36m
5qHy0wBPfEL4LUEUFMm16Ph9rpeBNKRlMGrgvP9vIujsWllw+/XqKgAzAk8uPJ40
W/d0pmmHxc754DN4LDaAaqgoj9mKLw==
=3xlM
-----END PGP SIGNATURE-----

--d5bgry64vqq6zout--

