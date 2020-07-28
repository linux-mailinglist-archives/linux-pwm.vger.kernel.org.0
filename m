Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8840230534
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 10:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgG1IVZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 04:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgG1IVZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 04:21:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3D9C061794;
        Tue, 28 Jul 2020 01:21:24 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 64C7C22F00;
        Tue, 28 Jul 2020 10:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595924482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvrp+yGmGW+ZNzAnBXqLG8eW0AGgkG7TdBQt7cBEsrc=;
        b=tzGvI8hDZhf5Z0n9rfs5U8/C8qymnrdoiivp7muYDtC+/8fj8ujBIYmVxkVHAOWGS7k4CC
        pWnd3TpXVvMFkS/2P+ja2mg/DusixLrVUxqqVyh3iMQ3cIL04PAlDaOjQEXysN/WFDdtuQ
        7R09CX1617DoC2vpgDEhkN13M/m6yaE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 28 Jul 2020 10:21:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 06/13] pwm: add support for sl28cpld PWM controller
In-Reply-To: <20200728074352.ckyfso5zwsfgupjx@pengutronix.de>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-7-michael@walle.cc>
 <20200728074352.ckyfso5zwsfgupjx@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <58b53cacc5289f17f669159beeeada03@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Am 2020-07-28 09:43, schrieb Uwe Kleine-König:
> Hello,
> 
> just a few minor issues left:

thanks for the review.

> 
> On Sun, Jul 26, 2020 at 01:18:27AM +0200, Michael Walle wrote:
>> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
>> new file mode 100644
>> index 000000000000..956fa09f3aba
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-sl28cpld.c
>> @@ -0,0 +1,223 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * sl28cpld PWM driver
>> + *
>> + * Copyright (c) 2020 Michael Walle <michael@walle.cc>
>> + *
>> + * There is no public datasheet available for this PWM core. But it 
>> is easy
>> + * enough to be briefly explained. It consists of one 8-bit counter. 
>> The PWM
>> + * supports four distinct frequencies by selecting when to reset the 
>> counter.
>> + * With the prescaler setting you can select which bit of the counter 
>> is used
>> + * to reset it. This implies that the higher the frequency the less 
>> remaining
>> + * bits are available for the actual counter.
>> + *
>> + * Let cnt[7:0] be the counter, clocked at 32kHz:
>> + * +-----------+--------+--------------+-----------+
>> + * | prescaler |  reset | counter bits | frequency |
>> + * +-----------+--------+--------------+-----------+
>> + * |         0 | cnt[7] |     cnt[6:0] |     250Hz |
>> + * |         1 | cnt[6] |     cnt[5:0] |     500Hz |
>> + * |         2 | cnt[5] |     cnt[4:0] |      1kHz |
>> + * |         3 | cnt[4] |     cnt[3:0] |      2kHz |
>> + * +-----------+--------+--------------+-----------+
> 
> Very nice. I'd add a "period length" column, as this is what the PWM
> core uses.
> 
> For your convenience (and as I created that table anyhow for further
> checking of the formulas below):
> 
>  * +-----------+--------+--------------+-----------+--------+
>  * | prescaler |  reset | counter bits | frequency | period |
>  * |           |        |              |           | length |
>  * +-----------+--------+--------------+-----------+--------+
>  * |         0 | cnt[7] |     cnt[6:0] |     250Hz | 4000ns |
>  * |         1 | cnt[6] |     cnt[5:0] |     500Hz | 2000ns |
>  * |         2 | cnt[5] |     cnt[4:0] |      1kHz | 1000ns |
>  * |         3 | cnt[4] |     cnt[3:0] |      2kHz |  500ns |
>  * +-----------+--------+--------------+-----------+--------+

sure :)

> 
>> + *
>> + * Limitations:
>> + * - The hardware cannot generate a 100% duty cycle if the prescaler 
>> is 0.
>> + * - The hardware cannot atomically set the prescaler and the counter 
>> value,
>> + *   which might lead to glitches and inconsistent states if a write 
>> fails.
>> + * - The counter is not reset if you switch the prescaler which leads
>> + *   to glitches, too.
>> + * - The duty cycle will switch immediately and not after a complete 
>> cycle.
>> + * - Depending on the actual implementation, disabling the PWM might 
>> have
>> + *   side effects. For example, if the output pin is shared with a 
>> GPIO pin
>> + *   it will automatically switch back to GPIO mode.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +
>> +/*
>> + * PWM timer block registers.
>> + */
>> +#define SL28CPLD_PWM_CTRL			0x00
>> +#define   SL28CPLD_PWM_CTRL_ENABLE		BIT(7)
>> +#define   SL28CPLD_PWM_CTRL_PRESCALER_MASK	GENMASK(1, 0)
>> +#define SL28CPLD_PWM_CYCLE			0x01
>> +#define   SL28CPLD_PWM_CYCLE_MAX		GENMASK(6, 0)
>> +
>> +#define SL28CPLD_PWM_CLK			32000 /* 32 kHz */
>> +#define SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler)	(1 << (7 - 
>> (prescaler)))
>> +#define SL28CPLD_PWM_PERIOD(prescaler) \
>> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * 
>> SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler))
>> +
>> +/*
>> + * We calculate the duty cycle like this:
>> + *   duty_cycle_ns = pwm_cycle_reg * max_period_ns / max_duty_cycle
>> + *
>> + * With
>> + *   max_period_ns = (1 << 7 - prescaler) / pwm_clk * NSEC_PER_SEC
>> + *   max_duty_cycle = 1 << (7 - prescaler)
> 
> If you don't need parenthesis in the max_period_ns around 7 - 
> prescaler,
> you don't need them either in the max_duty_cycle line.

mhh this should be "1 << (7 - prescaler)" in both cases. So
max_period_ns is wrong:
   max_period_ns = 1 << (7 - prescaler) / pwm_clk * NSEC_PER_SEC


>> + * this then simplifies to:
>> + *   duty_cycle_ns = pwm_cycle_reg / pwm_clk * NSEC_PER_SEC
>> + */
>> +#define SL28CPLD_PWM_TO_DUTY_CYCLE(reg) \
>> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * (reg))
> 
> For those who copy from your driver maybe add a comment like:
> 
>  * NSEC_PER_SEC / SL28CPLD_PWM_CLK is integer here, so we're not 
> loosing
>  * precision by doing the division first.

ok.

>> +#define SL28CPLD_PWM_FROM_DUTY_CYCLE(duty_cycle) \
>> +	(DIV_ROUND_DOWN_ULL((duty_cycle), NSEC_PER_SEC / SL28CPLD_PWM_CLK))
>> +
>> +struct sl28cpld_pwm {
>> +	struct pwm_chip pwm_chip;
>> +	struct regmap *regmap;
>> +	u32 offset;
>> +};
>> +
>> +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
>> +				   struct pwm_device *pwm,
>> +				   struct pwm_state *state)
>> +{
>> +	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
>> +	unsigned int reg;
>> +	int prescaler;
>> +
>> +	regmap_read(priv->regmap, priv->offset + SL28CPLD_PWM_CTRL, &reg);
> 
> Would it make sense to hide this using e.g.:
> 
> 	#define sl28cpkd_pwm_read(priv, reg, val)	regmap_read((priv)->regmap,
> (priv)->offset + (reg), val)
> 
> The line would then become:
> 
> 	sl28cpkd_pwm_read(priv, SL28CPLD_PWM_CTRL, &reg);
> 
> which is a bit prettier. Up to you to decide. If you do it, please do
> the same for write


I don't have a strong opinion on that. I can change it. Although there
will be checkpatch warning about multiple uses of the macro argument,
I'd presume.

>> +	state->enabled = reg & SL28CPLD_PWM_CTRL_ENABLE;
>> +
>> +	prescaler = FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
>> +	state->period = SL28CPLD_PWM_PERIOD(prescaler);
>> +
>> +	regmap_read(priv->regmap, priv->offset + SL28CPLD_PWM_CYCLE, &reg);
>> +	state->duty_cycle = SL28CPLD_PWM_TO_DUTY_CYCLE(reg);
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +}
>> +
>> +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct 
>> pwm_device *pwm,
>> +			      const struct pwm_state *state)
>> +{
>> +	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
>> +	unsigned int cycle, prescaler;
>> +	int ret;
>> +	u8 ctrl;
>> +
>> +	/* Polarity inversion is not supported */
>> +	if (state->polarity != PWM_POLARITY_NORMAL)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Calculate the prescaler. Pick the the biggest period that isn't
>> +	 * bigger than the requested period.
>> +	 */
>> +	prescaler = DIV_ROUND_UP_ULL(SL28CPLD_PWM_PERIOD(0), state->period);
>> +	prescaler = order_base_2(prescaler);
>> +
>> +	if (prescaler > field_max(SL28CPLD_PWM_CTRL_PRESCALER_MASK))
>> +		return -ERANGE;
> 
> The calculation looks right.
> Did you check the generated code? Maybe using an if or switch here is
> more effective? (optional task for bonus points :-)

I varied between this and some if/switch. This hard to read IMHO (as
was your your ilog(n+1)+1), but you could easily change the range
of the prescaler without having to change this. Also if/switch
looked ugly too *g*. I'll check again.

> 
>> +	ctrl = FIELD_PREP(SL28CPLD_PWM_CTRL_PRESCALER_MASK, prescaler);
>> +	if (state->enabled)
>> +		ctrl |= SL28CPLD_PWM_CTRL_ENABLE;
>> +
>> +	cycle = SL28CPLD_PWM_FROM_DUTY_CYCLE(state->duty_cycle);
>> +	cycle = min_t(unsigned int, cycle, 
>> SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler));
>> +
>> +	/*
>> +	 * Work around the hardware limitation. See also above. Trap 100% 
>> duty
>> +	 * cycle if the prescaler is 0. Set prescaler to 1 instead. We don't
>> +	 * care about the frequency because its "all-one" in either case.
>> +	 *
>> +	 * We don't need to check the actual prescaler setting, because only
>> +	 * if the prescaler is 0 we can have this particular value.
>> +	 */
>> +	if (cycle == SL28CPLD_PWM_MAX_DUTY_CYCLE(0)) {
>> +		ctrl &= ~SL28CPLD_PWM_CTRL_PRESCALER_MASK;
>> +		ctrl |= FIELD_PREP(SL28CPLD_PWM_CTRL_PRESCALER_MASK, 1);
>> +		cycle = SL28CPLD_PWM_MAX_DUTY_CYCLE(1);
>> +	}
>> +
>> +	ret = regmap_write(priv->regmap, priv->offset + SL28CPLD_PWM_CTRL, 
>> ctrl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_write(priv->regmap, priv->offset + SL28CPLD_PWM_CYCLE, 
>> (u8)cycle);
> 
> This cast isn't needed, is it?

Due to the clamping, it is not, correct. I'll remove it.

>> +}
>> +
>> +static const struct pwm_ops sl28cpld_pwm_ops = {
>> +	.apply = sl28cpld_pwm_apply,
>> +	.get_state = sl28cpld_pwm_get_state,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static int sl28cpld_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct sl28cpld_pwm *priv;
>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	if (!pdev->dev.parent)
>> +		return -ENODEV;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!priv->regmap)
> 
> Error message here?

This shouldn't really happen and I put it into the same category
as the two above and report no error. But I can add it.

Generally, it looked to me that more and more drivers don't
really report errors anymore, but just return with an -EWHATEVER.
So if someone can shed some light here, I'm all ears.

-michael
