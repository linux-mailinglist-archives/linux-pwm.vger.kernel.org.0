Return-Path: <linux-pwm+bounces-9382-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f3V+G0gIPWqLwAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9382-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:51:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F36C4DB6
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:51:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=andestech.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9382-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9382-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EB83300516E
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F338D3F1;
	Thu, 25 Jun 2026 10:51:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AC2EDD6C;
	Thu, 25 Jun 2026 10:51:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384703; cv=none; b=GKC1xbNXTgkcS0coOy0Kl56bJcOErH9csMFYVAWnmzS+fYT2PMM4LPdX0iBUjuIazF0rPxhGiC9/d9KB36sz/5DrEWUxufL7bnX7Zc04rh/J0IOlMNvnuD+giGCcki4KXtQ3+7AJM7eXRQsRnj+JlJ6DzRiP384A+y/eJE8ah+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384703; c=relaxed/simple;
	bh=gja+bjPTC1Tv5rCcH0I5e2jM5Emse/rNrEIlkkbJlsA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqsl6+hUEPmH5pxQ66QVaAmFqSttpsbU/hlnGpHdVD0aYE7ZxDp24/gLn5yJ3aDH7kWTCuiAnbEoXICoGj8oi4N4crR3viD/TVLEAAszeM/sK6EWjt2oXHtU+qFpvsa6w8XZbsfC9XVwdNg5ZoautfL7Ot+OJHPdhnPeJM/4iJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.184
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 65PAWRb9093564;
	Thu, 25 Jun 2026 18:32:27 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 65PAW4ca093522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 18:32:04 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 25 Jun 2026 18:32:03
 +0800
Date: Thu, 25 Jun 2026 18:32:02 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] pwm: add Andes PWM driver support
Message-ID: <aj0DotaZID63A5_A@swlinux02>
References: <20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com>
 <20260330-andes-pwm-v5-2-01c59a659d2c@andestech.com>
 <ahajkcejv71TwV5f@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahajkcejv71TwV5f@monoceros>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 65PAWRb9093564
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[andestech.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[ben717@andestech.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9382-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FROM_NEQ_ENVFROM(0.00)[ben717@andestech.com,linux-pwm@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[andestech.com:from_mime,andestech.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 024F36C4DB6

Hi Uwe,

On Wed, May 27, 2026 at 10:55:32AM +0200, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <ukleinek@kernel.org>
>
> Hello Ben,
>
> On Mon, Mar 30, 2026 at 03:45:44PM +0800, Ben Zong-You Xie via B4 Relay wrote:
> > From: Ben Zong-You Xie <ben717@andestech.com>
> >
> > Add a driver for the PWM controller found in Andes AE350 platforms and
> > QiLai SoCs.
> >
> > The Andes PWM controller features:
> > - 4 independent channels.
> > - Dual clock source support (APB clock and external clock) to provide
> >   a flexible range of frequencies.
> > - Support for normal and inversed polarity.
> >
> > The driver implements the .apply() and .get_state() callbacks. Since the
> > clock source of each channel can be selected by programming the
> > register, clock selection logic is implemented to prioritize the
> > external clock to maximize the supported period range, falling back to
> > the APB clock for higher frequency requirements.
> >
> > Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> > ---
> >  drivers/pwm/Kconfig     |  10 ++
> >  drivers/pwm/Makefile    |   1 +
> >  drivers/pwm/pwm-andes.c | 306 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 317 insertions(+)
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 6f3147518376..b82f2c857ada 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -73,6 +73,16 @@ config PWM_AIROHA
> >        To compile this driver as a module, choose M here: the module
> >        will be called pwm-airoha.
> >
> > +config PWM_ANDES
> > +   tristate "Andes PWM support"
> > +   depends on ARCH_ANDES || COMPILE_TEST
> > +   help
> > +     Generic PWM framework driver for Andes platform, such as QiLai SoC
> > +     and AE350 platform.
> > +
> > +     To compile this driver as a module, choose M here: the module
> > +     will be called pwm-andes.
> > +
> >  config PWM_APPLE
> >      tristate "Apple SoC PWM support"
> >      depends on ARCH_APPLE || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 0dc0d2b69025..858f225289cc 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -3,6 +3,7 @@ obj-$(CONFIG_PWM)           += core.o
> >  obj-$(CONFIG_PWM_AB8500)   += pwm-ab8500.o
> >  obj-$(CONFIG_PWM_ADP5585)  += pwm-adp5585.o
> >  obj-$(CONFIG_PWM_AIROHA)   += pwm-airoha.o
> > +obj-$(CONFIG_PWM_ANDES)            += pwm-andes.o
> >  obj-$(CONFIG_PWM_APPLE)            += pwm-apple.o
> >  obj-$(CONFIG_PWM_ARGON_FAN_HAT)    += pwm-argon-fan-hat.o
> >  obj-$(CONFIG_PWM_ATMEL)            += pwm-atmel.o
> > diff --git a/drivers/pwm/pwm-andes.c b/drivers/pwm/pwm-andes.c
> > new file mode 100644
> > index 000000000000..835c8db55987
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-andes.c
> > @@ -0,0 +1,306 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Andes PWM, used in Andes AE350 platform and QiLai SoC
> > + *
> > + * Copyright (C) 2026 Andes Technology Corporation.
> > + *
> > + * Limitations:
> > + * - When disabling a channel, the current period will not be completed, and the
> > + *   output will be constant zero.
>
> You could use that to simulate a 0% relative duty cycle instead of
> erroring out.
>
> Just to be sure: A disabled channel emits zero independant of
> ANDES_PWM_CH_CTRL_PARK being set or not?!
>

No, a disabled channel does not always emit zero. Its output is held at
the "park level" selected by the ANDES_PWM_CH_CTRL_PARK field: the
output is driven LOW when the bit is 0 and HIGH when it is 1. So the
"constant zero" wording was wrong; I have corrected the limitation
comment in v6. And yes, as you suggested, v6 uses exactly this to
emulate the duty-cycle extremes instead of erroring out: a 0% relative
duty cycle parks the channel low (PARK=0) and a 100% relative duty cycle
parks it high (PARK=1).

> > + * - The current period will be completed first if reconfiguring.
> > + * - Further, if the reconfiguration changes the clock source, the output will
> > + *   not be the old one nor the new one. And the output will be the new one
> > + *   until writing to the reload register.
> > + * - The hardware can neither do a 0% nor a 100% relative duty cycle.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/math64.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/time.h>
> > +#include <linux/types.h>
> > +
> > +#define ANDES_PWM_CH_ENABLE                0x1C
> > +#define ANDES_PWM_CH_ENABLE_PWM(ch)        BIT(3 + (4 * (ch)))
> > +
> > +#define ANDES_PWM_CH_CTRL(ch)              (0x20 + (0x10 * (ch)))
> > +#define ANDES_PWM_CH_CTRL_MODE_PWM BIT(2)
> > +#define ANDES_PWM_CH_CTRL_CLK              BIT(3)
> > +#define ANDES_PWM_CH_CTRL_PARK             BIT(4)
> > +#define ANDES_PWM_CH_CTRL_MASK             GENMASK(4, 0)
> > +
> > +#define ANDES_PWM_CH_RELOAD(ch)            (0x24 + (0x10 * (ch)))
> > +#define ANDES_PWM_CH_RELOAD_HIGH   GENMASK(31, 16)
> > +#define ANDES_PWM_CH_RELOAD_LOW            GENMASK(15, 0)
> > +
> > +#define ANDES_PWM_CH_COUNTER(ch)   (0x28 + (0x10 * (ch)))
> > +
> > +#define ANDES_PWM_CH_MAX           4
> > +#define ANDES_PWM_CYCLE_MIN                1
> > +#define ANDES_PWM_CYCLE_MAX                0x10000
> > +
> > +struct andes_pwm {
> > +   struct regmap *regmap;
> > +   struct clk *pclk;
> > +   struct clk *extclk;
> > +   unsigned int pclk_rate;
> > +   unsigned int extclk_rate;
> > +};
> > +
> > +static const struct regmap_config andes_pwm_regmap_config = {
> > +   .name = "andes_pwm",
> > +   .reg_bits = 32,
> > +   .reg_stride = 4,
> > +   .val_bits = 32,
> > +   .pad_bits = 0,
> > +   .max_register = ANDES_PWM_CH_COUNTER(ANDES_PWM_CH_MAX - 1),
> > +   .cache_type = REGCACHE_NONE,
> > +};
> > +
> > +static inline struct andes_pwm *to_andes_pwm(struct pwm_chip *chip)
>
> If you rename this to andes_pwm_from_chip this function has the driver's
> function name prefix, too.
>

Renamed in v6.

> > +{
> > +   return pwmchip_get_drvdata(chip);
> > +}
> > +
> > +static int andes_pwm_enable(struct pwm_chip *chip, unsigned int channel,
> > +                       bool enable)
> > +{
> > +   struct andes_pwm *ap = to_andes_pwm(chip);
> > +
> > +   return regmap_assign_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
> > +                             ANDES_PWM_CH_ENABLE_PWM(channel), enable);
> > +}
> > +
> > +static int andes_pwm_config(struct pwm_chip *chip, unsigned int channel,
> > +                       const struct pwm_state *state)
> > +{
> > +   struct andes_pwm *ap = to_andes_pwm(chip);
> > +   unsigned int clk_rate = ap->extclk_rate;
> > +   unsigned int try = 2;
> > +   u64 high_ns = state->duty_cycle;
> > +   u64 low_ns = state->period - high_ns;
>
> This results in rounding errors. Consider:
>
>        clk_rate = 500000000
>        state->duty_cycle = 17
>        state->period = 32
>
> then you configure
>
>        high_cycles = 8
>        low_cycles = 7
>
> which corresponds to a period = 30 ns, while you can do 32 ns. So you
> have to convert state->period to ticks and do the subtraction in the
> tick domain.
>

Fixed in v6.

> > +   unsigned int ctrl = ANDES_PWM_CH_CTRL_MODE_PWM;
> > +   u64 high_cycles;
> > +   u64 low_cycles;
> > +   u32 reload;
> > +
> > +   /*
> > +    * Reload register for PWM mode:
> > +    *
> > +    *               31 : 16    15 : 0
> > +    *               PWM16_Hi | PWM16_Lo
> > +    *
> > +    * The high duration is (PWM16_Hi + 1) cycles and the low duration is
> > +    * (PWM16_Lo + 1) cycles. For a duty cycle of 10 cycles and a total
> > +    * period of 30 cycles in normal polarity, PWM16_Hi is set to
> > +    * 9 (10 - 1) and PWM16_Lo to 19 (30 - 10 - 1). Also, PWM16_Hi is set to
> > +    * 19 and PWM16_Lo is set to 9 in inversed polarity.
> > +    *
> > +    * Because the register stores "cycles - 1", the valid range for
> > +    * each phase is 1 to 65536 (0x10000) cycles. This implies the hardware
> > +    * cannot achieve a true 0% or 100% duty cycle.
> > +    *
> > +    * The controller supports two clock sources: the APB clock and an
> > +    * external clock. The driver first attempts to use the external clock
> > +    * to widest possible range of supported periods. If the requests
> > +    * exceeds the valid range of the register, it falls back to the APB
> > +    * clock. The request is rejected if the timing cannot be met by either
> > +    * source.
> > +    */
> > +   if (state->polarity == PWM_POLARITY_INVERSED)
> > +           swap(high_ns, low_ns);
> > +
> > +   while (try) {
> > +           high_cycles = mul_u64_u64_div_u64(clk_rate, high_ns,
> > +                                             NSEC_PER_SEC);
> > +           low_cycles = mul_u64_u64_div_u64(clk_rate, low_ns,
> > +                                            NSEC_PER_SEC);
> > +           if (high_cycles > ANDES_PWM_CYCLE_MAX)
> > +                   high_cycles = ANDES_PWM_CYCLE_MAX;
> > +
> > +           if (low_cycles > ANDES_PWM_CYCLE_MAX)
> > +                   low_cycles = ANDES_PWM_CYCLE_MAX;
> > +
> > +           if (high_cycles >= ANDES_PWM_CYCLE_MIN &&
> > +               low_cycles >= ANDES_PWM_CYCLE_MIN)
> > +                   break;
> > +
> > +           try--;
> > +           clk_rate = ap->pclk_rate;
> > +   }
>
> This loop implements:
>
>        if extclk_rate is too high:
>                if pclk is too high:
>                        error out
>                else:
>                        use pclk
>        else:
>                use extclk
>
> This might be surprising for a user because the emitted period depends
> on the requested duty_cycle.
>

Agreed, that was wrong. In v6 both the clock source and the period are
derived from the requested period alone:

- The driver computes the period in external-clock ticks and uses the
  external clock unless that resolves fewer than two ticks (i.e. the period
  is too short for it), in which case it uses the APB clock. So the clock
  choice depends only on state->period.

- The period is then rounded down to the largest value that stays
  representable for every duty split -- at most
  ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN ticks, so both phases always fit
  the 16-bit reload fields. The requested duty cycle is split within that
  fixed period afterwards.

So changing only the duty cycle no longer moves the emitted period, and an
out-of-range period or duty is now rounded down instead of rejected.

> > +
> > +   /*
> > +    * try == 0 : no clock is valid
> > +    * try == 1 : use APB clock
> > +    * try == 2 : use external clock
> > +    */
> > +   if (!try)
> > +           return -EINVAL;
> > +
> > +   /*
> > +    * If changing the clock source here, the output will not be the old one
> > +    * nor the new one. And the output will be the new one until writing to
> > +    * the reload register.
>
> And the output will be the new one *after* writing to the reload register?
>

Correct, "until" was a typo for "after". When the clock source changes,
it settles to the new waveform only "after"" the reload register is
written. Fixed in v6.

> > +    */
> > +   ctrl |= (try == 1) ? ANDES_PWM_CH_CTRL_CLK : 0;
> > +   ctrl |= (state->polarity == PWM_POLARITY_INVERSED) ?
> > +           ANDES_PWM_CH_CTRL_PARK : 0;
> > +   regmap_update_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
> > +                      ANDES_PWM_CH_CTRL_MASK, ctrl);
> > +   reload = FIELD_PREP(ANDES_PWM_CH_RELOAD_HIGH, high_cycles - 1) |
> > +            FIELD_PREP(ANDES_PWM_CH_RELOAD_LOW, low_cycles - 1);
> > +
> > +   return regmap_write(ap->regmap, ANDES_PWM_CH_RELOAD(channel), reload);
> > +}
> > +
> > +static int andes_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                      const struct pwm_state *state)
> > +{
> > +   unsigned int channel = pwm->hwpwm;
> > +   int ret;
> > +
> > +   if (!state->enabled) {
> > +           if (pwm->state.enabled)
> > +                   andes_pwm_enable(chip, channel, false);
> > +
> > +           return 0;
> > +   }
> > +
> > +   ret = andes_pwm_config(chip, channel, state);
> > +   if (ret)
> > +           return ret;
> > +
> > +   return andes_pwm_enable(chip, channel, true);
> > +}
> > +
> > +static int andes_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                          struct pwm_state *state)
> > +{
> > +   struct andes_pwm *ap = to_andes_pwm(chip);
> > +   unsigned int channel = pwm->hwpwm;
> > +   unsigned int ctrl;
> > +   unsigned int clk_rate;
> > +   unsigned int reload;
> > +   u64 high_cycles;
> > +   u64 low_cycles;
> > +
> > +   regmap_read(ap->regmap, ANDES_PWM_CH_CTRL(channel), &ctrl);
> > +   clk_rate = FIELD_GET(ANDES_PWM_CH_CTRL_CLK, ctrl) ? ap->pclk_rate
> > +                                                     : ap->extclk_rate;
> > +   state->enabled = regmap_test_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
> > +                                     ANDES_PWM_CH_ENABLE_PWM(channel));
> > +   state->polarity = regmap_test_bits(ap->regmap,
> > +                                      ANDES_PWM_CH_CTRL(channel),
> > +                                      ANDES_PWM_CH_CTRL_PARK);
>
> This can be simplified to use FIELD_GET(..., ctrl);
>

Done in v6.

> > +   regmap_read(ap->regmap, ANDES_PWM_CH_RELOAD(channel), &reload);
> > +   high_cycles = FIELD_GET(ANDES_PWM_CH_RELOAD_HIGH, reload) + 1;
> > +   low_cycles = FIELD_GET(ANDES_PWM_CH_RELOAD_LOW, reload) + 1;
> > +
> > +   /*
> > +    * high_cycles and low_cycles are both 16 bits, and NSEC_PER_SEC is 30
> > +    * bits. Thus, the multiplication is safe from overflow
>
> Missing . at the end.
>

Fixed in v6.

> > +    */
> > +   if (state->polarity == PWM_POLARITY_NORMAL) {
> > +           state->duty_cycle = DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
> > +                                                clk_rate);
> > +           state->period = state->duty_cycle +
> > +                           DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
> > +                                            clk_rate);
> > +   } else {
> > +           state->duty_cycle = DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
> > +                                                clk_rate);
> > +           state->period = state->duty_cycle +
> > +                           DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
> > +                                            clk_rate);
>
> Here is a rounding error. You need
>
>        state->period = DIV_ROUND_UP_ULL((low_cycles + high_cycles) * NSEC_PER_SEC, clk_rate);
>
> (for both polarities, so it can be moved out of the if).
>
> To see the difference, consider clk_rate = 2 * NSEC_PER_SEC,
> high_cycles = 15 and low_cycles = 15.
>

Fixed in v6.

> > +   }
> > +
> > +   return 0;
> > +}
> > +
> > +static const struct pwm_ops andes_pwm_ops = {
> > +   .apply = andes_pwm_apply,
> > +   .get_state = andes_pwm_get_state,
> > +};
> > +
> > +static int andes_pwm_probe(struct platform_device *pdev)
> > +{
> > +   struct device *dev = &pdev->dev;
> > +   struct pwm_chip *chip;
> > +   struct andes_pwm *ap;
> > +   void __iomem *reg_base;
> > +   int ret;
> > +
> > +   chip = devm_pwmchip_alloc(dev, ANDES_PWM_CH_MAX, sizeof(*ap));
> > +   if (IS_ERR(chip))
> > +           return PTR_ERR(chip);
> > +
> > +   ap = to_andes_pwm(chip);
> > +   reg_base = devm_platform_ioremap_resource(pdev, 0);
> > +   if (IS_ERR(reg_base))
> > +           return dev_err_probe(dev, PTR_ERR(reg_base),
> > +                                "failed to map I/O space\n");
> > +
> > +   ap->pclk = devm_clk_get_enabled(dev, "pclk");
> > +   if (IS_ERR(ap->pclk))
> > +           return dev_err_probe(dev, PTR_ERR(ap->pclk),
> > +                                "failed to get APB clock\n");
> > +
> > +   ap->extclk = devm_clk_get_optional_enabled(dev, "extclk");
> > +   if (IS_ERR(ap->extclk))
> > +           return dev_err_probe(dev, PTR_ERR(ap->extclk),
> > +                                "failed to get external clock\n");
> > +
> > +   /*
> > +    * If the clock rate is greater than 10^9, there may be an overflow when
> > +    * calculating the cycles in andes_pwm_config()
> > +    */
> > +   ap->pclk_rate = clk_get_rate(ap->pclk);
> > +   if (ap->pclk_rate > NSEC_PER_SEC)
> > +           ap->pclk = NULL;
>
> This is not enough to prevent that pclk is used.
>

Right -- the clock selection keys off the rate, not the pointer, so nulling
ap->pclk left the out-of-range pclk_rate in place and the clock could still
be picked. v6 caps the rate itself to 0 instead:

  ap->pclk_rate = pclk_rate > NSEC_PER_SEC ? 0 : pclk_rate;
  ap->extclk_rate = extclk_rate > NSEC_PER_SEC ? 0 : extclk_rate;

A 0 rate resolves to zero ticks in .apply(), so that source is never selected.

> > +   ap->extclk_rate = ap->extclk ? clk_get_rate(ap->extclk) : 0;
> > +   if (ap->extclk_rate > NSEC_PER_SEC)
> > +           ap->extclk = NULL;
> > +
> > +   if (!ap->pclk && !ap->extclk)
> > +           return dev_err_probe(dev, -EINVAL, "clocks are out of range\n");
>
> If you mention the clk rates in the error message, the problem to fix
> becomes easier to identify.
>

Done in v6.

> > +   ap->regmap = devm_regmap_init_mmio(dev, reg_base,
> > +                                      &andes_pwm_regmap_config);
> > +   if (IS_ERR(ap->regmap)) {
> > +           return dev_err_probe(dev, PTR_ERR(ap->regmap),
> > +                                "failed to initialize regmap\n");
> > +   }
>
> Don't use { ... } for single statements. Please start error messages
> with a capital letter.
>

Done in v6.

> > +
> > +   chip->ops = &andes_pwm_ops;
> > +   ret = devm_pwmchip_add(dev, chip);
> > +   if (ret)
> > +           return dev_err_probe(dev, ret, "failed to add pwm chip\n");
> > +
> > +   return 0;
> > +}
> > +
> > +static const struct of_device_id andes_pwm_of_match[] = {
> > +   { .compatible = "andestech,ae350-pwm" },
> > +   { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, andes_pwm_of_match);
> > +
> > +static struct platform_driver andes_pwm_driver = {
> > +   .driver = {
> > +           .name = "andes_pwm",
> > +           .of_match_table = andes_pwm_of_match,
> > +   },
> > +   .probe = andes_pwm_probe,
> > +};
> > +module_platform_driver(andes_pwm_driver);
> > +
> > +MODULE_AUTHOR("Ben Zong-You Xie <ben717@andestech.com>");
> > +MODULE_DESCRIPTION("Andes PWM driver");
> > +MODULE_LICENSE("GPL");
>
> Best regards
> Uwe

Thanks,
Ben

