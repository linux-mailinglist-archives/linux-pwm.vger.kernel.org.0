Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E6896271
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfHTO3N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 10:29:13 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:32808 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfHTO3M (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 20 Aug 2019 10:29:12 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 4D9EDA26B4;
        Tue, 20 Aug 2019 16:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1566311350;
        bh=OZgPlsjEML0oTrJQxK/BDWYIQZ5/kZrrpsA3Y4+redM=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=REFMYz4DhGgV47omLiJcwHNSMQiDdDOPBlf0aisKVsa65Sr7uUk5BH40MlxjOR1kK
         x/OaFGEXwXNu6hdMHRkGORY7OpYadLtt+KGtRqmthxsFOz1DJZGqDg1GXoSl/EPn6J
         dtSHju4EPbxwNGTY7aY930xE3vCJc1W6zu59fwRs=
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [PATCH RFC] pwm: add debug knob to help driver authors
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Baolin Wang <baolin.wang@linaro.org>
References: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
Message-ID: <c9a4e48b-92e9-90a0-a0c4-a571f6afa7b3@ysoft.com>
Date:   Tue, 20 Aug 2019 16:29:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 15. 08. 19 11:38, Uwe Kleine-König wrote:
> This patch adds some additional checks to the pwm core that help getting
> the details right. The check about rounding isn't approved yet, but I
> consider that sensible as it helps consistency when all drivers round in
> the same direction. The other checks are in line with what I understood
> are the intended requirements.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this patch is only compile tested up to now but still I think it adds
> useful diagnostics for driver authors that helps even more than an exact
> documentation. Feedback welcome.

Hello Uwe,

First of all, thank you for your continuous effort to improve the situation!
I just tried your patch on our imx6 platform. Here are my few cents.

> 
>   drivers/pwm/Kconfig |  8 +++++++
>   drivers/pwm/core.c  | 56 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a7e57516959e..76105cfd581d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -33,6 +33,14 @@ config PWM_SYSFS
>   	bool
>   	default y if SYSFS
>   
> +config PWM_DEBUG
> +	bool "Additional checks for correctness of lowlevel drivers"

I am not native speaker too but this sounds weird to me. And as
a driver author I would maybe like to see the word "debug" somewhere
in the prompt for this option so its purpose is more obvious?

What about something like "PWM lowlevel drivers debugging" or
"PWM lowlevel drivers additional checks and debug messages" ?

> +	help
> +	  This option enables some additional checks to help lowlevel driver
> +	  authors to get their callbacks implemented correctly.
> +	  It is expected to introduce some runtime overhead and diagnostic
> +	  output to the kernel log, so only enable while working on a driver.
> +
>   config PWM_AB8500
>   	tristate "AB8500 PWM support"
>   	depends on AB8500_CORE && ARCH_U8500
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 8edfac17364e..6ce341a4574d 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -467,12 +467,68 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>   		return 0;
>   
>   	if (pwm->chip->ops->apply) {
> +		struct pwm_state state_pre = *state;
> +
>   		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
>   		if (err)
>   			return err;
>   
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
> +			if (pwm->chip->ops->get_state) {
> +				struct pwm_state state_post = { 0, };
> +
> +				pwm->chip->ops->get_state(pwm->chip, pwm, &state_post);
> +
> +				if (state_post.period != state->period ||
> +				    state_post.duty_cycle != state->duty_cycle ||
> +				    state_post.polarity != state->polarity ||
> +				    state_post.enabled != state->enabled) {
> +
> +					dev_warn(pwm->chip->dev,
> +						 ".apply is supposed to modify the pwm_state parameter to match the actual output.\n");

I tend to turn the warning messages around to more emphasize there
is something wrong in the driver. Maybe something like:
						"pwm_state parameter does not match actual output! Update .apply to modify the state please.\n"

> +				}
> +
> +				if (state_pre.polarity == state_post.polarity &&
> +				    state_pre.enabled &&
> +				    (state_pre.period > state_post.period ||
> +				     state_pre.duty_cycle > state_post.period)) {
> +
> +					dev_warn(pwm->chip->dev,
> +						 ".apply is supposed to round down both period and duty_cycle.\n");

And here something like:
						 "period or duty_cycle is not rounded down. Update .apply to do so please.\n"
> +
> +				}
> +
> +				*state = state_post;
> +
> +				/* reapply state_post and check it is unmodified */
> +				err = pwm->chip->ops->apply(pwm->chip, pwm, state);

Here you reapply even if the pre and post states match.
On imx6 that means you just wrote to the PWM_PWMPR register.
Such write "results in the counter being reset to zero and the start of
a new count period." viz 51.7.5 in the RM.

That means the current period most probably was not completed when you
applied the new configuration. Which is one of the requirements we are
finally trying to met.

Hmm, now while I just finished the above paragraph I think the answer
to this is that it is responsibility of the PWM driver to ensure such
requirement is met. So that is just another opportunity how to improve
the pwm-imx27 driver .)

> +				if (err) {
> +					dev_err(pwm->chip->dev,
> +						 "failed to reapply the current setting\n");

Another nitpicking. Consistency in first capital letter and period at
the end of message?

> +					return err;
> +				}
> +
> +				if (state_post.period != state->period ||
> +				    state_post.duty_cycle != state->duty_cycle ||
> +				    state_post.polarity != state->polarity ||
> +				    state_post.enabled != state->enabled) {
> +					dev_warn(pwm->chip->dev,
> +						 "applying the settings that .get_state returned yields changes\n");

Same here.

> +				}
> +
> +			} else {
> +				dev_warn(pwm->chip->dev,
> +					 "Please update the driver to provide .get_state()\n");

This could be rephrased to:
					 "Update the driver to provide .get_state() please.\n"

to be consistent with the other messages I proposed.

> +			}
> +		}
> +
>   		pwm->state = *state;
>   	} else {
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
> +			dev_warn(pwm->chip->dev,
> +				 "Please update the driver to provide .apply() instead of .config()\n");

Same here.

> +		}
> +
>   		/*
>   		 * FIXME: restore the initial state in case of error.
>   		 */
> 

While testing the patch I tried to configure some extreme values
and got quite strange results.

The best resolution of the i.MX6 PWM is ~15ns.

root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 1000 > period
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 45 > duty_cycle
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [352446.858141] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
30
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 30 > duty_cycle
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
30
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 15 > duty_cycle
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [352511.598175] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
0
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 30 > duty_cycle
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [352538.138203] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
15
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 45 > duty_cycle
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [352559.248184] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
30
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 60 > duty_cycle
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [353811.638114] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
45
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 75 > duty_cycle
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [353819.718146] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
61
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 76 > duty_cycle
root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
76

So the driver refuses to configure a certain duty_cycle value, e.g. 30,
but it happily configures it when you try the next higher one, e.g. 45.
I suppose it is related to rounding in the pwm-imx27 driver but I did
spent much time thinking about the root cause yet, sorry.

Anyway, your patch already prove to be useful ;)

Thank you,
Michal
