Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8A49B4F0
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 14:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385644AbiAYNZL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 08:25:11 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:35163 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1576320AbiAYNUh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Jan 2022 08:20:37 -0500
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 2D3E3440537;
        Tue, 25 Jan 2022 15:20:11 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1643116812;
        bh=kbhMyTqv/ZM+4D/fI4w1cdFP/9uJp0sy4leqXD9Th+I=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=rB6lGdAmxSt3P6BGaBq+7XQjNgQn4d+4jDaaAdbhwtNlPyunu+HZDtY8wkxs4saSC
         rG1QixOfO4ZLQ+XB6vPxfD9c43EPFAkJ4v20FgjkK+qqOGFkO0yuUr8l0a4gkGwHBT
         mx78X6HRGWvmH6rWqXFHPn9621i1L4ntfQSgdTVgJgoJjOlEcTaXCilzSql0YTKrB6
         c7gz/sVUC1ttEB9OeArcJIQs7B3N/vYstCdNW9B3xsuCVShzA6b8dziCIH4B8Qf/C9
         hc15tLtHCm+UxvTUqz4LrhebZkfqu6fpZBeh24/v5wn0sapY7jpPbkPK9IotpCw4gu
         G1JjTLw7blF0A==
References: <ab2a4c345844f66aa22a847e522b2f4ee0786d8b.1639499239.git.baruch@tkos.co.il>
 <20220119172439.be4xpaqgwzdy26oh@pengutronix.de>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 1/3] pwm: driver for qualcomm ipq6018 pwm block
Date:   Tue, 25 Jan 2022 15:03:08 +0200
In-reply-to: <20220119172439.be4xpaqgwzdy26oh@pengutronix.de>
Message-ID: <87tuds7y09.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your detailed review and comments. Please find my comments
below.

On Wed, Jan 19 2022, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Dec 14, 2021 at 06:27:17PM +0200, Baruch Siach wrote:
>> From: Baruch Siach <baruch.siach@siklu.com>
>>=20
>> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
>> driver from downstream Codeaurora kernel tree. Removed support for older
>> (V1) variants because I have no access to that hardware.
>>=20
>> Tested on IPQ6010 based hardware.
>>=20
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> ---
>> v10:
>>=20
>>   Restore round up in pwm_div calculation; otherwise diff is always <=3D
>>   0, so only bingo match works
>>=20
>>   Don't overwrite min_diff on every loop iteration
>>=20
>> v9:
>>=20
>> Address comment from Uwe Kleine-K=C3=B6nig:
>>=20
>>   Use period_ns*rate in dividers calculation for better accuracy
>>=20
>>   Round down pre_div and pwm_div
>>=20
>>   Add a comment explaining why pwm_div can't underflow
>>=20
>>   Add a comment explaining why pre_div > pwm_div end the search loop
>>=20
>>   Drop 'CFG_' from register macros
>>=20
>>   Rename to_ipq_pwm_chip() to ipq_pwm_from_chip()
>>=20
>>   Change bare 'unsigned' to 'unsigned int'
>>=20
>>   Clarify the comment on separate REG1 write for enable/disable
>>=20
>>   Round up the period value in .get_state
>>=20
>>   Use direct readl/writel so no need to check for regmap errors
>>=20
>> v7:
>>=20
>>   Change 'offset' to 'reg' for the tcsr offset (Rob)
>>=20
>>   Drop clock name; there is only one clock (Bjorn)
>>=20
>>   Simplify probe failure code path (Bjorn)
>>=20
>> v6:
>>=20
>> Address Uwe Kleine-K=C3=B6nig review comments:
>>=20
>>   Drop IPQ_PWM_MAX_DEVICES
>>=20
>>   Rely on assigned-clock-rates; drop IPQ_PWM_CLK_SRC_FREQ
>>=20
>>   Simplify register offset calculation
>>=20
>>   Calculate duty cycle more precisely
>>=20
>>   Refuse to set inverted polarity
>>=20
>>   Drop redundant IPQ_PWM_REG1_ENABLE bit clear
>>=20
>>   Remove x1000 factor in pwm_div calculation, use rate directly, and rou=
nd up
>>=20
>>   Choose initial pre_div such that pwm_div < IPQ_PWM_MAX_DIV
>>=20
>>   Ensure pre_div <=3D pwm_div
>>=20
>>   Rename close_ to best_
>>=20
>>   Explain in comment why effective_div doesn't overflow
>>=20
>>   Limit pwm_div to IPQ_PWM_MAX_DIV - 1 to allow 100% duty cycle
>>=20
>>   Disable clock only after pwmchip_remove()
>>=20
>>   const pwm_ops
>>=20
>> Other changes:
>>=20
>>   Add missing linux/bitfield.h header include (kernel test robot)
>>=20
>>   Adjust code for PWM device node under TCSR (Rob Herring)
>>=20
>> v5:
>>=20
>> Use &tcsr_q6 syscon to access registers (Bjorn Andersson)
>>=20
>> Address Uwe Kleine-K=C3=B6nig review comments:
>>=20
>>   Implement .get_state()
>>=20
>>   Add IPQ_PWM_ prefix to local macros
>>=20
>>   Use GENMASK/BIT/FIELD_PREP for register fields access
>>=20
>>   Make type of config_div_and_duty() parameters consistent
>>=20
>>   Derive IPQ_PWM_MIN_PERIOD_NS from IPQ_PWM_CLK_SRC_FREQ
>>=20
>>   Integrate enable/disable into config_div_and_duty() to save register r=
ead,
>>   and reduce frequency glitch on update
>>=20
>>   Use min() instead of min_t()
>>=20
>>   Fix comment format
>>=20
>>   Use dev_err_probe() to indicate probe step failure
>>=20
>>   Add missing clk_disable_unprepare() in .remove
>>=20
>>   Don't set .owner
>>=20
>> v4:
>>=20
>>   Use div64_u64() to fix link for 32-bit targets ((kernel test robot
>>   <lkp@intel.com>, Uwe Kleine-K=C3=B6nig)
>>=20
>> v3:
>>=20
>>   s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>>=20
>>   Fix integer overflow on 32-bit targets (kernel test robot <lkp@intel.c=
om>)
>>=20
>> v2:
>>=20
>> Address Uwe Kleine-K=C3=B6nig review comments:
>>=20
>>   Fix period calculation when out of range
>>=20
>>   Don't set period larger than requested
>>=20
>>   Remove PWM disable on configuration change
>>=20
>>   Implement .apply instead of non-atomic .config/.enable/.disable
>>=20
>>   Don't modify PWM on .request/.free
>>=20
>>   Check pwm_div underflow
>>=20
>>   Fix various code and comment formatting issues
>>=20
>> Other changes:
>>=20
>>   Use u64 divisor safe division
>>=20
>>   Remove now empty .request/.free
>> ---
>>  drivers/pwm/Kconfig   |  12 ++
>>  drivers/pwm/Makefile  |   1 +
>>  drivers/pwm/pwm-ipq.c | 275 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 288 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-ipq.c
>>=20
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 21e3b05a5153..e39718137ecd 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -260,6 +260,18 @@ config PWM_INTEL_LGM
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-intel-lgm.
>>=20=20
>> +config PWM_IPQ
>> +	tristate "IPQ PWM support"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on HAVE_CLK && HAS_IOMEM
>> +	help
>> +	  Generic PWM framework driver for IPQ PWM block which supports
>> +	  4 pwm channels. Each of the these channels can be configured
>> +	  independent of each other.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-ipq.
>> +
>>  config PWM_IQS620A
>>  	tristate "Azoteq IQS620A PWM support"
>>  	depends on MFD_IQS62X || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 708840b7fba8..7402feae4b36 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
>>  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>>  obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
>> +obj-$(CONFIG_PWM_IPQ)		+=3D pwm-ipq.o
>>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>>  obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
>> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
>> new file mode 100644
>> index 000000000000..3764010808f0
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ipq.c
>> @@ -0,0 +1,275 @@
>> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
>> +/*
>> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reser=
ved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/math64.h>
>> +#include <linux/of_device.h>
>> +#include <linux/bitfield.h>
>> +
>> +/* The frequency range supported is 1 Hz to clock rate */
>> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
>> +
>> +/*
>> + * The max value specified for each field is based on the number of bits
>> + * in the pwm control register for that field
>> + */
>> +#define IPQ_PWM_MAX_DIV		0xFFFF
>> +
>> +/*
>> + * Two 32-bit registers for each PWM: REG0, and REG1.
>> + * Base offset for PWM #i is at 8 * #i.
>> + */
>> +#define IPQ_PWM_REG0			0 /*PWM_DIV PWM_HI*/
>> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
>> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
>
> PWM_HI in the comment of IPQ_PWM_REG0 vs. HI_DURATION? Should this
> match? I'd say the comment is redundant.
>
>> +#define IPQ_PWM_REG1			4 /*ENABLE UPDATE PWM_PRE_DIV*/
>> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
>> +/*
>> + * Enable bit is set to enable output toggling in pwm device.
>> + * Update bit is set to reflect the changed divider and high duration
>> + * values in register.
>> + */
>> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
>> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
>> +
>> +
>> +struct ipq_pwm_chip {
>> +	struct pwm_chip chip;
>> +	struct clk *clk;
>> +	void __iomem *mem;
>> +};
>> +
>> +static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
>> +{
>> +	return container_of(chip, struct ipq_pwm_chip, chip);
>> +}
>> +
>> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned i=
nt reg)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(pwm->chip);
>> +	unsigned int off =3D 8 * pwm->hwpwm + reg;
>> +
>> +	return readl(ipq_chip->mem + off);
>> +}
>> +
>> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned int reg,
>> +			      unsigned int val)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(pwm->chip);
>> +	unsigned int off =3D 8 * pwm->hwpwm + reg;
>> +
>> +	writel(val, ipq_chip->mem + off);
>> +}
>> +
>> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pr=
e_div,
>> +			unsigned int pwm_div, unsigned long rate, u64 duty_ns,
>> +			bool enable)
>> +{
>> +	unsigned long hi_dur;
>> +	unsigned long val =3D 0;
>> +
>> +	/*
>> +	 * high duration =3D pwm duty * (pwm div + 1)
>> +	 * pwm duty =3D duty_ns / period_ns
>> +	 */
>> +	hi_dur =3D div64_u64(duty_ns * rate, (pre_div + 1) * NSEC_PER_SEC);
>> +
>> +	val =3D FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
>> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
>> +
>> +	val =3D FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
>> +
>> +	/* PWM enable toggle needs a separate write to REG1 */
>> +	val |=3D IPQ_PWM_REG1_UPDATE;
>> +	if (enable)
>> +		val |=3D IPQ_PWM_REG1_ENABLE;
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
>> +}
>> +
>> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(chip);
>> +	unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
>> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
>> +	u64 period_ns, duty_ns, period_rate;
>> +	u64 min_diff;
>> +
>> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
>> +		return -EINVAL;
>> +
>> +	if (state->period < div64_u64(NSEC_PER_SEC, rate))
>> +		return -ERANGE;
>
> NSEC_PER_SEC / rate is the smallest period you can achieve, right?
> Consider rate =3D 33333 (Hz), then the minimal period is
> 30000.30000300003 ns. So you should refuse a request to configure
> state->period =3D 30000, but as div64_u64(1000000000, 33333) is 30000 you
> don't.
>
>> +	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
>> +	duty_ns =3D min(state->duty_cycle, period_ns);
>> +
>> +	/*
>> +	 * period_ns is 1G or less. As long as rate is less than 16 GHz this
>> +	 * does not overflow.
>
> Well, rate cannot be bigger than 4294967295 because an unsigned long
> cannot hold a bigger value.

On 64-bit systems __SIZEOF_LONG__ is 8, which can hold more than 2^32.

>> +	 */
>> +	period_rate =3D period_ns * rate;
>> +	best_pre_div =3D IPQ_PWM_MAX_DIV;
>> +	best_pwm_div =3D IPQ_PWM_MAX_DIV;
>> +	/* Initial pre_div value such that pwm_div < IPQ_PWM_MAX_DIV */

Note this comment.

>> +	pre_div =3D div64_u64(period_rate,
>> +			(u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
>
> Hmmm, we want=20
>
> 	(pre_div + 1) * (pwm_div + 1) * NSEC_PER_SEC
> 	-------------------------------------------- <=3D period_ns
> 	                  rate
>
> , right? Resolving that for pre_div this gives:
>
> 	                period_ns * rate
> 	pre_div <=3D ----------------------------
> 	           NSEC_PER_SEC * (pwm_div + 1)
>
> The term on the right hand side is maximal for pwm_div =3D=3D 0 so the
> possible values for pre_div are
>
> 	0 ... min(div64_u64(period_rate / NSEC_PER_SEC), IPQ_PWM_MAX_DIV)
>
> isn't it?

I don't think so. pre_div =3D=3D 0 will produce pwm_div larger than
IPQ_PWM_MAX_DIV for a large period_rate value. The initial pre_div here is =
the
smallest value that produces pwm_div within it limit.

> If so, your algorithm is wrong as you're iterating over
>
> 	div64_u64(period_rate, NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1)) ... IPQ_PWM=
_MAX_DIV

The loop stops when pre_div > pwm_div. That should be before pre_div =3D=3D
IPQ_PWM_MAX_DIV because pwm_div <=3D IPQ_PWM_MAX_DIV. Should I put the pre_=
div >
pwm_div condition directly in the for statement?

>> +	min_diff =3D period_rate;
>> +
>> +	for (; pre_div <=3D IPQ_PWM_MAX_DIV; pre_div++) {
>> +		long long diff;
>> +
>> +		pwm_div =3D DIV64_U64_ROUND_UP(period_rate,
>> +				(u64)NSEC_PER_SEC * (pre_div + 1));
>> +		/* pwm_div is unsigned; the check below catches underflow */
>> +		pwm_div--;
>
> What underflow? DIV64_U64_ROUND_UP returns > 0 assuming period_rate > 0.
> So pwm_div - 1 doesn't underflow?!

I'll update the comment.

> The task here is to calculate the biggest pwm_div for a given pre_div
> such that
>
>
> 	(pre_div + 1) * (pwm_div + 1) * NSEC_PER_SEC
> 	-------------------------------------------- <=3D period_ns
> 	                   rate
>
> right?
>
> This is equivalent to:
>
> 	                  period_ns * rate
> 	pre_div <=3D ---------------------------- - 1
> 	           (pre_div + 1) * NSEC_PER_SEC
>
> As pre_div is integer, rounding down should be fine?!

I can't follow. With round down (as in v8) the result is always:

  NSEC_PER_SEC * (pre_div + 1) * (pwm_div + 1) <=3D period_rate

As a result, 'diff' calculation below will always produce diff <=3D 0. When
there is no diff =3D=3D 0 result (bingo) we get IPQ_PWM_MAX_DIV in both bes=
t_
values at the end of the loop.

Do we actually need diff > 0 in the condition below?

>> +		/*
>> +		 * pre_div and pwm_div values swap produces the same
>> +		 * result. This loop goes over all pre_div <=3D pwm_div
>> +		 * combinations. The rest are equivalent.
>> +		 */
>
> I'd write:
>
> 	/*
> 	 * Swapping values for pre_div and pwm_div produces the same
> 	 * period length. So we can skip all settings with pre_div <
> 	 * pwm_div which results in bigger constraints for selecting the
> 	 * duty_cycle than with the two values swapped.
> 	 */

I'll take your wording with inverted inequality sign.

Thanks,
baruch

>> +		if (pre_div > pwm_div)
>> +			break;
>> +
>> +		/*
>> +		 * Make sure we can do 100% duty cycle where
>> +		 * hi_dur =3D=3D pwm_div + 1
>> +		 */
>> +		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
>> +			continue;
>> +
>> +		diff =3D ((uint64_t)NSEC_PER_SEC * (pre_div + 1) * (pwm_div + 1))
>> +			- period_rate;
>> +
>> +		if (diff < 0) /* period larger than requested */
>> +			continue;
>
> This shouldn't happen if the above calculation is correct.
>
>> +		if (diff =3D=3D 0) { /* bingo */
>> +			best_pre_div =3D pre_div;
>> +			best_pwm_div =3D pwm_div;
>> +			break;
>> +		}
>> +		if (diff < min_diff) {
>> +			min_diff =3D diff;
>> +			best_pre_div =3D pre_div;
>> +			best_pwm_div =3D pwm_div;
>> +		}
>
> This can be simplified as:
>
> 		if (diff < min_diff) {
> 			best_pre_div =3D pre_div;
> 			best_pwm_div =3D pwm_div;
> 			min_diff =3D diff;
>
> 			if (min_diff =3D=3D 0)
> 				/* bingo! */
> 				break;
> 		}
>
>> +	}
>> +
>> +	/* config divider values for the closest possible frequency */
>> +	config_div_and_duty(pwm, best_pre_div, best_pwm_div,
>> +			    rate, duty_ns, state->enabled);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
>> +			      struct pwm_state *state)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(chip);
>> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
>> +	unsigned int pre_div, pwm_div, hi_dur;
>> +	u64 effective_div, hi_div;
>> +	u32 reg0, reg1;
>> +
>> +	reg0 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
>> +	reg1 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
>> +
>> +	state->polarity =3D PWM_POLARITY_NORMAL;
>> +	state->enabled =3D reg1 & IPQ_PWM_REG1_ENABLE;
>> +
>> +	pwm_div =3D FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
>> +	hi_dur =3D FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
>> +	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
>> +
>> +	/* No overflow here, both pre_div and pwm_div <=3D 0xffff */
>> +	effective_div =3D (u64)(pre_div + 1) * (pwm_div + 1);
>> +	state->period =3D DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC, rat=
e);
>> +
>> +	hi_div =3D hi_dur * (pre_div + 1);
>> +	state->duty_cycle =3D div64_u64(hi_div * NSEC_PER_SEC, rate);
>
> This must be round up for the same reasons as for period.
>
>> +}
>
> Best regards
> Uwe


--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
