Return-Path: <linux-pwm+bounces-9285-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c1szN+YXLGoPLQQAu9opvQ
	(envelope-from <linux-pwm+bounces-9285-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 16:29:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7995867A2E8
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 16:29:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mess.org header.s=2020 header.b=pyRCbr7L;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9285-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9285-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=mess.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC5CF3003602
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A8A35E1DB;
	Fri, 12 Jun 2026 14:29:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3A388885;
	Fri, 12 Jun 2026 14:29:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274595; cv=none; b=lJ/mQVUQzYk/mQPr0lVx/9LUOmVyuEgdsUTH2Ib4gJ7U8mEj01Z447zwzv1ndVI5ay/qdYUO6tv/He+eBLOgtlk7i3nzrRrpX0++ptUF85SyWGD8j7vikhJpm3rvbYVpCJvKrALIYGc106Gv2ZkJzaMaASjvPA7tVkx8zDsQKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274595; c=relaxed/simple;
	bh=ln8wvrKKN3MdXkM30Nocz21j1m8LmQLll/H966ohjnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrCxA3kBDM3HaY7h8AAPjxrgmlpekVeTTXYjuGFKijOCt47G9exR89cUx7lS+9Kf6c5zEGa6TYk2OPGNyL2OdoJEQmBhBAQv2xd2MSEWXDzVcRvJNt1pzDuEmDEey94aN6Zwshc9bA2kreGPRllQFOksswBwtgFEc6TqciW6wqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=pyRCbr7L; arc=none smtp.client-ip=92.243.27.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1781274585; bh=ln8wvrKKN3MdXkM30Nocz21j1m8LmQLll/H966ohjnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyRCbr7L7A82LtwcuGaRklmz4pzweHfVs1gVdSKUJ/jrgnS/1fezobf9AChH5jR6d
	 h7vZMlQYhrmF5CyUDzWL3O009YXlndZYv2wUh07BcRY4FVEhhvJ8rbyqQZ27AFpnwL
	 z8VpsoXv6C5cfnn5fLXLPhlMEHJJJv8oU6WQFl2W3i9EQH4Ye/lsH/ViW7j4l19asu
	 L8tyuMSgRA51WKCs5zrlOMnFtiWuSkawR5QK8MQUteEBB8kS8Ia4TeSe+F+VHAxj7N
	 l2c3Uv5wpYYGYLAUQcrSPQvl99noo2Q+Sqr8OKjfgNcfHykzspbFk0HyLk1RWZGoCm
	 cxRvLVbBKfZUQ==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id D404941D1A; Fri, 12 Jun 2026 15:29:45 +0100 (BST)
Date: Fri, 12 Jun 2026 15:29:45 +0100
From: Sean Young <sean@mess.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <aiwX2YWVJnDNTNiu@extorris.mess.org>
References: <cover.1780670224.git.andrea.porta@suse.com>
 <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mess.org,none];
	R_DKIM_ALLOW(-0.20)[mess.org:s=2020];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9285-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrea.porta@suse.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sean@mess.org,linux-pwm@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean@mess.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[mess.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,vger.kernel.org:from_smtp,raspberrypi.com:url,raspberrypi.com:email,mess.org:dkim,mess.org:from_mime,suse.com:email,extorris.mess.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7995867A2E8

On Fri, Jun 12, 2026 at 04:01:27PM +0200, Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> The Raspberry Pi RP1 southbridge features an embedded PWM
> controller with 4 output channels, alongside an RPM interface
> to read the fan speed on the Raspberry Pi 5.
> 
> Add the supporting driver.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/pwm/Kconfig   |   9 +
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-rp1.c | 424 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 434 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rp1.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376a..c3ddc0eb4774f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -625,6 +625,15 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>  
> +config PWM_RASPBERRYPI_RP1
> +	tristate "RP1 PWM support"
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
> @@ -56,6 +56,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
> +obj-$(CONFIG_PWM_RASPBERRYPI_RP1)	+= pwm-rp1.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
> new file mode 100644
> index 0000000000000..6382a81a5ea0f
> --- /dev/null
> +++ b/drivers/pwm/pwm-rp1.c
> @@ -0,0 +1,424 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pwm-rp1.c
> + *
> + * Raspberry Pi RP1 PWM.
> + *
> + * Copyright © 2026 Raspberry Pi Ltd.
> + *
> + * Author: Naushir Patuck (naush@raspberrypi.com)
> + *
> + * Based on the pwm-bcm2835 driver by:
> + * Bart Tanghe <bart.tanghe@thomasmore.be>
> + *
> + * Datasheet: https://pip-assets.raspberrypi.com/categories/892-raspberry-pi-5/documents/RP-008370-DS-1-rp1-peripherals.pdf?disposition=inline
> + *
> + * Limitations:
> + * - Channels can be enabled/disabled through a global update flag, while the
> + *   period and duty per-channel registers are independently updatable, and
> + *   they are latched on the end of (specific channel) period strobe.
> + *   This means that period and duty changes might result in glitches if the
> + *   period/duty is changed exactly during an end of period strobe.
> + * - Since the duty/period registers are freely updatable (do not depend on
> + *   the global update flag), setting one of them close to the period end and
> + *   the other right afterwards results in a mixed output for that cycle because
> + *   the write ops are not atomic.
> + * - The global update flag prevents mis-sampling of multi-bit bus signals in
> + *   the PWM clock domain. This ensures that all PWM channel settings update
> + *   on the same PWM clock cycle. Channels start in sync only if they share the
> + *   same period.
> + * - If both duty and period are set to 0, the output is a constant low signal
> + *   if polarity is normal or a constant high signal if polarity is inversed.
> + * - When disabled the output is driven to 0 if polarity is normal, or to 1
> + *   if polarity is inversed.
> + * - Disabling the PWM stops the output immediately, without waiting for current
> + *   period to complete first.
> + * - Channels are phase-capable, but on RPi5, the firmware can use a channel
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
> +#include <linux/units.h>
> +
> +#define RP1_PWM_GLB_CTRL			0x000
> +#define RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(chan)	BIT(chan)
> +#define RP1_PWM_GLB_CTRL_SET_UPDATE		BIT(31)
> +
> +#define RP1_PWM_CHAN_CTRL(chan)			(0x014 + ((chan) * 0x10))
> +#define RP1_PWM_CHAN_CTRL_POLARITY		BIT(3)
> +#define RP1_PWM_CHAN_CTRL_FIFO_POP_MASK		BIT(8)
> +#define RP1_PWM_CHAN_CTRL_MODE			GENMASK(2, 0)
> +enum rp1_pwm_ctrl_mode {
> +	RP1_PWM_CHAN_CTRL_MODE_ZERO,
> +	RP1_PWM_CHAN_CTRL_MODE_TE_MS,
> +	RP1_PWM_CHAN_CTRL_MODE_PC_MS,
> +	RP1_PWM_CHAN_CTRL_MODE_PD_ENC,
> +	RP1_PWM_CHAN_CTRL_MODE_MSB_SER,
> +	RP1_PWM_CHAN_CTRL_MODE_PPM,
> +	RP1_PWM_CHAN_CTRL_MODE_LE_MS,
> +	RP1_PWM_CHAN_CTRL_MODE_LSB_SER,
> +};
> +
> +#define RP1_PWM_CHAN_CTRL_DEFAULT		(RP1_PWM_CHAN_CTRL_FIFO_POP_MASK +  \
> +						FIELD_PREP(RP1_PWM_CHAN_CTRL_MODE, \
> +						RP1_PWM_CHAN_CTRL_MODE_TE_MS))
> +
> +#define RP1_PWM_RANGE(chan)			(0x018 + ((chan) * 0x10))
> +#define RP1_PWM_PHASE(chan)			(0x01C + ((chan) * 0x10))
> +#define RP1_PWM_DUTY(chan)			(0x020 + ((chan) * 0x10))
> +
> +#define RP1_PWM_NUM_PWMS			4
> +
> +struct rp1_pwm {
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	unsigned long clk_rate;
> +	bool clk_enabled;

I don't understand the point of the clk_enabled field. If the probe
function succeeds, then clk_enabled = true. It is set to false during
suspend, but after suspend the only thing which can follow is resume,
I think. In resume, we set it in to true again unconditionally. So
it is always true, no?

> +};
> +
> +struct rp1_pwm_waveform {
> +	u32 period_ticks;
> +	u32 duty_ticks;
> +	bool enabled;
> +	bool inverted_polarity;
> +};
> +
> +static const struct regmap_config rp1_pwm_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x60,
> +};
> +
> +static void rp1_pwm_apply_config(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	u32 value;
> +
> +	/* update the changed registers on the next strobe to avoid glitches */
> +	regmap_read(rp1->regmap, RP1_PWM_GLB_CTRL, &value);
> +	value |= RP1_PWM_GLB_CTRL_SET_UPDATE;
> +	regmap_write(rp1->regmap, RP1_PWM_GLB_CTRL, value);
> +}
> +
> +static int rp1_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +
> +	/* init channel to reset defaults, preserving the polarity bit */
> +	regmap_update_bits(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm),
> +			   ~(u32)RP1_PWM_CHAN_CTRL_POLARITY, RP1_PWM_CHAN_CTRL_DEFAULT);
> +	return 0;
> +}
> +
> +static int rp1_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +				       struct pwm_device *pwm,
> +				       const struct pwm_waveform *wf,
> +				       void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	u64 period_ticks, duty_ticks, offset_ticks;
> +	struct rp1_pwm_waveform *wfhw = _wfhw;
> +	u64 clk_rate = rp1->clk_rate;
> +	int ret = 0;
> +
> +	if (!wf->period_length_ns) {
> +		wfhw->enabled = false;
> +		return 0;
> +	}
> +
> +	period_ticks = mul_u64_u64_div_u64(wf->period_length_ns, clk_rate, NSEC_PER_SEC);
> +
> +	/*
> +	 * The period is limited to U32_MAX, and it will be decremented by one later
> +	 * to allow 100% duty cycle.
> +	 */
> +	if (period_ticks > U32_MAX) {
> +		period_ticks = U32_MAX;
> +	} else if (period_ticks < 2) {
> +		period_ticks = 2;
> +		ret = 1;
> +	}

period_ticks = clamp(period_ticks, 2, U32_MAX);

Although that misses out the `ret = 1;` which I am not sure about anyway.

> +
> +	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC);
> +	duty_ticks = min(duty_ticks, period_ticks);
> +	offset_ticks = mul_u64_u64_div_u64(wf->duty_offset_ns, clk_rate, NSEC_PER_SEC);
> +	if (offset_ticks >= period_ticks)
> +		offset_ticks %= period_ticks;
> +	if (duty_ticks && offset_ticks &&
> +	    duty_ticks + offset_ticks >= period_ticks) {
> +		wfhw->duty_ticks = period_ticks - duty_ticks;
> +		wfhw->inverted_polarity = true;
> +	} else {
> +		wfhw->duty_ticks = duty_ticks;
> +		wfhw->inverted_polarity = false;
> +	}
> +	/* Account for the extra tick at the end of the period */
> +	wfhw->period_ticks = period_ticks - 1;
> +
> +	wfhw->enabled = true;
> +
> +	return ret;
> +}
> +
> +static int rp1_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const void *_wfhw,
> +					 struct pwm_waveform *wf)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	const struct rp1_pwm_waveform *wfhw = _wfhw;
> +	u64 clk_rate = rp1->clk_rate;
> +	u64 ticks;
> +
> +	*wf = (struct pwm_waveform){ };
> +
> +	if (!wfhw->enabled)
> +		return 0;
> +
> +	wf->period_length_ns = DIV_ROUND_UP_ULL(((u64)wfhw->period_ticks + 1) * NSEC_PER_SEC,
> +						clk_rate);
> +
> +	if (!wfhw->inverted_polarity) {
> +		wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_PER_SEC,
> +						      clk_rate);
> +	} else {
> +		ticks = (u64)wfhw->period_ticks + 1 - wfhw->duty_ticks;
> +		wf->duty_length_ns = DIV_ROUND_UP_ULL(ticks * NSEC_PER_SEC, clk_rate);
> +		wf->duty_offset_ns = wf->period_length_ns - wf->duty_length_ns;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_write_waveform(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  const void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	const struct rp1_pwm_waveform *wfhw = _wfhw;
> +	u32 value, ctrl;
> +
> +	/* set polarity */
> +	regmap_read(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), &value);
> +	if (!wfhw->inverted_polarity)
> +		value &= ~RP1_PWM_CHAN_CTRL_POLARITY;
> +	else
> +		value |= RP1_PWM_CHAN_CTRL_POLARITY;
> +	regmap_write(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), value);
> +
> +	/* early exit if disabled */
> +	regmap_read(rp1->regmap, RP1_PWM_GLB_CTRL, &ctrl);
> +	if (!wfhw->enabled) {
> +		ctrl &= ~RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm);
> +		goto exit_disable;
> +	}
> +
> +	/* set period and duty cycle */
> +	regmap_write(rp1->regmap,
> +		     RP1_PWM_RANGE(pwm->hwpwm), wfhw->period_ticks);
> +	regmap_write(rp1->regmap,
> +		     RP1_PWM_DUTY(pwm->hwpwm), wfhw->duty_ticks);
> +
> +	/* enable the channel */
> +	ctrl |= RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm);
> +exit_disable:
> +	regmap_write(rp1->regmap, RP1_PWM_GLB_CTRL, ctrl);
> +
> +	rp1_pwm_apply_config(chip, pwm);
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_read_waveform(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	struct rp1_pwm_waveform *wfhw = _wfhw;
> +	u32 value;
> +
> +	regmap_read(rp1->regmap, RP1_PWM_GLB_CTRL, &value);
> +	wfhw->enabled = !!(value & RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm));
> +
> +	regmap_read(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), &value);
> +	wfhw->inverted_polarity = !!(value & RP1_PWM_CHAN_CTRL_POLARITY);
> +
> +	if (wfhw->enabled) {
> +		regmap_read(rp1->regmap, RP1_PWM_RANGE(pwm->hwpwm), &wfhw->period_ticks);
> +		regmap_read(rp1->regmap, RP1_PWM_DUTY(pwm->hwpwm), &wfhw->duty_ticks);
> +	} else {
> +		wfhw->period_ticks = 0;
> +		wfhw->duty_ticks = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops rp1_pwm_ops = {
> +	.sizeof_wfhw = sizeof(struct rp1_pwm_waveform),
> +	.request = rp1_pwm_request,
> +	.round_waveform_tohw = rp1_pwm_round_waveform_tohw,
> +	.round_waveform_fromhw = rp1_pwm_round_waveform_fromhw,
> +	.read_waveform = rp1_pwm_read_waveform,
> +	.write_waveform = rp1_pwm_write_waveform,
> +};
> +
> +static int rp1_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	unsigned long clk_rate;
> +	struct pwm_chip *chip;
> +	void __iomem	*base;
> +	struct rp1_pwm *rp1;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, RP1_PWM_NUM_PWMS, sizeof(*rp1));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	rp1 = pwmchip_get_drvdata(chip);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rp1->regmap = devm_regmap_init_mmio(dev, base, &rp1_pwm_regmap_config);
> +	if (IS_ERR(rp1->regmap))
> +		return dev_err_probe(dev, PTR_ERR(rp1->regmap), "Cannot initialize regmap\n");
> +
> +	rp1->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(rp1->clk))
> +		return dev_err_probe(dev, PTR_ERR(rp1->clk), "Clock not found\n");
> +
> +	ret = clk_prepare_enable(rp1->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable clock\n");
> +	rp1->clk_enabled = true;
> +
> +	ret = devm_clk_rate_exclusive_get(dev, rp1->clk);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to get exclusive rate\n");
> +		goto err_disable_clk;
> +	}
> +
> +	clk_rate = clk_get_rate(rp1->clk);
> +	if (!clk_rate) {
> +		ret = dev_err_probe(dev, -EINVAL, "Failed to get clock rate\n");
> +		goto err_disable_clk;
> +	}
> +	/*
> +	 * To prevent u64 overflow in period calculations:
> +	 * mul_u64_u64_div_u64(period_ns, clk_rate, NSEC_PER_SEC)
> +	 * If clk_rate > 1 GHz, the result can overflow.
> +	 */
> +	if (clk_rate > HZ_PER_GHZ) {
> +		ret = dev_err_probe(dev, -EINVAL, "Clock rate > 1 GHz is not supported\n");
> +		goto err_disable_clk;
> +	}
> +	rp1->clk_rate = clk_rate;
> +
> +	chip->ops = &rp1_pwm_ops;

Can we add the following please:

	 chip->atomic = true; 

This means that the pwm can be controlled from atomic context (not process
context) using pwm_apply_atomic(). This is very helpful for the pwm-ir-tx
driver, which produces a much more faithful IR signal in atomic context.

Using pwm for infrared tx is much nicer than using gpio which bit bangs
the IR signal and holds the CPU with interrupts disabled for upto one second.

As far as I can see there is no sleeping code in these code paths, so we
should be fine.

Thanks,

Sean

> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	ret = pwmchip_add(chip);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register PWM chip\n");
> +		goto err_disable_clk;
> +	}
> +
> +	ret = of_syscon_register_regmap(np, rp1->regmap);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register syscon\n");
> +		goto err_remove_chip;
> +	}
> +
> +	return 0;
> +
> +err_remove_chip:
> +	pwmchip_remove(chip);
> +err_disable_clk:
> +	clk_disable_unprepare(rp1->clk);
> +
> +	return ret;
> +}
> +
> +static void rp1_pwm_remove(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip = platform_get_drvdata(pdev);
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +
> +	pwmchip_remove(chip);
> +
> +	if (rp1->clk_enabled) {
> +		clk_disable_unprepare(rp1->clk);
> +		rp1->clk_enabled = false;
> +	}
> +}
> +
> +static int rp1_pwm_suspend(struct device *dev)
> +{
> +	struct pwm_chip *chip = dev_get_drvdata(dev);
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +
> +	if (rp1->clk_enabled) {
> +		clk_disable_unprepare(rp1->clk);
> +		rp1->clk_enabled = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_resume(struct device *dev)
> +{
> +	struct pwm_chip *chip = dev_get_drvdata(dev);
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	int ret;
> +
> +	ret = clk_prepare_enable(rp1->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clock on resume: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	rp1->clk_enabled = true;
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(rp1_pwm_pm_ops, rp1_pwm_suspend, rp1_pwm_resume);
> +
> +static const struct of_device_id rp1_pwm_of_match[] = {
> +	{ .compatible = "raspberrypi,rp1-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rp1_pwm_of_match);
> +
> +static struct platform_driver rp1_pwm_driver = {
> +	.probe = rp1_pwm_probe,
> +	.remove = rp1_pwm_remove,
> +	.driver = {
> +		.name = "rp1-pwm",
> +		.of_match_table = rp1_pwm_of_match,
> +		.pm = pm_ptr(&rp1_pwm_pm_ops),
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(rp1_pwm_driver);
> +
> +MODULE_DESCRIPTION("RP1 PWM driver");
> +MODULE_AUTHOR("Naushir Patuck <naush@raspberrypi.com>");
> +MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.35.3
> 

