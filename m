Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90C53BE244
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 06:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhGGFAp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 7 Jul 2021 01:00:45 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:33273 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhGGFAp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Jul 2021 01:00:45 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id D7B5344029B;
        Wed,  7 Jul 2021 07:58:01 +0300 (IDT)
References: <305eacc9c57c2404795b6be76a08915808e23108.1624771446.git.baruch@tkos.co.il>
 <20210705072055.5mvux5h6zdewzabz@pengutronix.de>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] pwm: driver for qualcomm ipq6018 pwm block
In-reply-to: <20210705072055.5mvux5h6zdewzabz@pengutronix.de>
Date:   Wed, 07 Jul 2021 07:58:01 +0300
Message-ID: <875yxmg1pi.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for taking the time to review this patch. I have a few comment
below.

On Mon, Jul 05 2021, Uwe Kleine-König wrote:
> On Sun, Jun 27, 2021 at 08:24:04AM +0300, Baruch Siach wrote:
>> +/*
>> + * Enable bit is set to enable output toggling in pwm device.
>> + * Update bit is set to reflect the changed divider and high duration
>> + * values in register.
>> + */
>> +#define PWM_ENABLE		0x80000000
>> +#define PWM_UPDATE		0x40000000
>> +
>> +/* The frequency range supported is 1Hz to 100MHz */
>> +#define MIN_PERIOD_NS	10
>> +#define MAX_PERIOD_NS	1000000000
>
> Please use a driver prefix for these defines.

I take this to refer also to the defines below, right?

>> +
>> +/*
>> + * The max value specified for each field is based on the number of bits
>> + * in the pwm control register for that field
>> + */
>> +#define MAX_PWM_CFG		0xFFFF
>> +
>> +#define PWM_CTRL_HI_SHIFT	16
>> +
>> +#define PWM_CFG_REG0 0 /*PWM_DIV PWM_HI*/
>> +#define PWM_CFG_REG1 1 /*ENABLE UPDATE PWM_PRE_DIV*/

...

>> +static void config_div_and_duty(struct pwm_device *pwm, int pre_div,
>> +			unsigned long long pwm_div, unsigned long period_ns,
>> +			unsigned long long duty_ns)
>
> Please also use a consistent prefix for function names.
>
> I suggest to use u64 for some of the parameters. While this doesn't
> change anything, it is cleaner as the caller passes variables of this
> type.

Actually for pre_div and pwm_div the caller passes int values. I agree
this is inconsistent.

...

>> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(chip);
>> +	unsigned long freq;
>> +	int pre_div, close_pre_div, close_pwm_div;
>> +	int pwm_div;
>> +	long long diff;
>> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
>> +	unsigned long min_diff = rate;
>> +	uint64_t fin_ps;
>> +	u64 period_ns, duty_ns;
>> +
>> +	if (state->period < MIN_PERIOD_NS)
>> +		return -ERANGE;
>
> MIN_PERIOD_NS depends on clk_get_rate(ipq_chip->clk), doesn't it?

probe sets this clock to the fixed 100MHz rate (CLK_SRC_FREQ). Would you
prefer to derive MIN_PERIOD_NS from CLK_SRC_FREQ?

>> +	period_ns = min_t(u64, state->period, MAX_PERIOD_NS);
>> +	duty_ns = min_t(u64, state->duty_cycle, period_ns);
>
> If you define MAX_PERIOD_NS as (u64)1000000000 you can just use min().
>
>> +
>> +	/* freq in Hz for period in nano second*/
>
> Space before the closing */ please
>
>> +	freq = div64_u64(NSEC_PER_SEC, period_ns);
>> +	fin_ps = div64_u64(NSEC_PER_SEC * 1000ULL, rate);
>> +	close_pre_div = MAX_PWM_CFG;
>> +	close_pwm_div = MAX_PWM_CFG;
>> +
>> +	for (pre_div = 0; pre_div <= MAX_PWM_CFG; pre_div++) {
>> +		pwm_div = DIV64_U64_ROUND_CLOSEST(period_ns * 1000,
>> +						  fin_ps * (pre_div + 1));
>> +		pwm_div--;
>> +		if (pwm_div < 0 || pwm_div > MAX_PWM_CFG)
>> +			continue;
>> +
>> +		diff = ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
>> +			- (uint64_t)rate;
>> +
>> +		if (diff < 0) /* period larger than requested */
>> +			continue;
>> +		if (diff == 0) { /* bingo */
>> +			close_pre_div = pre_div;
>> +			close_pwm_div = pwm_div;
>> +			break;
>> +		}
>> +		if (diff < min_diff) {
>> +			min_diff = diff;
>> +			close_pre_div = pre_div;
>> +			close_pwm_div = pwm_div;
>> +		}
>
> I didn't check deeply, but I assume this calculation can be done more
> efficiently.

The thing is that we have two dividers to play with. I can't think of a
cleaner way to find the best match for a given target frequency.

> Also I wonder if DIV64_U64_ROUND_CLOSEST is right. When you implement
> a .get_state() callback (which usually helps me to understand how the
> hardware works) I'm willing to take a closer look.

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
