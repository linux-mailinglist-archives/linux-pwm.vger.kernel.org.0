Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E339643F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHTPYb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 11:24:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTPYb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 11:24:31 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i05zq-0007vJ-7f; Tue, 20 Aug 2019 17:24:30 +0200
Message-ID: <1566314668.3030.16.camel@pengutronix.de>
Subject: Re: [PATCH RFC] pwm: add debug knob to help driver authors
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Michal =?UTF-8?Q?Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        kernel@pengutronix.de, Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 20 Aug 2019 17:24:28 +0200
In-Reply-To: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
References: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

I have two suggestions below:

On Thu, 2019-08-15 at 11:38 +0200, Uwe Kleine-König wrote:
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
> 
> Best regards
> Uwe
> 
>  drivers/pwm/Kconfig |  8 +++++++
>  drivers/pwm/core.c  | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a7e57516959e..76105cfd581d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -33,6 +33,14 @@ config PWM_SYSFS
>  	bool
>  	default y if SYSFS
>  
> +config PWM_DEBUG
> +	bool "Additional checks for correctness of lowlevel drivers"
> +	help
> +	  This option enables some additional checks to help lowlevel driver
> +	  authors to get their callbacks implemented correctly.
> +	  It is expected to introduce some runtime overhead and diagnostic
> +	  output to the kernel log, so only enable while working on a driver.
> +
>  config PWM_AB8500
>  	tristate "AB8500 PWM support"
>  	depends on AB8500_CORE && ARCH_U8500
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 8edfac17364e..6ce341a4574d 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -467,12 +467,68 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  		return 0;
>  
>  	if (pwm->chip->ops->apply) {
> +		struct pwm_state state_pre = *state;
> +
>  		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
>  		if (err)
>  			return err;
>  
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {

How about moving this whole block into a separate function, say
'pwm_validate_state', to reduce the level of indentation and to separate
the debug/validation code from the common business logic a bit?

> +			if (pwm->chip->ops->get_state) {
> +				struct pwm_state state_post = { 0, };
> +
> +				pwm->chip->ops->get_state(pwm->chip, pwm, &state_post);
> +
> +				if (state_post.period != state->period ||
> +				    state_post.duty_cycle != state->duty_cycle ||
> +				    state_post.polarity != state->polarity ||
> +				    state_post.enabled != state->enabled) {

This is only used twice here, but there is an inverted version of this
check in the beginning of pwm_apply_state already. You could introduce a
'pwm_state_equal' helper function to simplify this.

> +
> +					dev_warn(pwm->chip->dev,
> +						 ".apply is supposed to modify the pwm_state parameter to match the actual output.\n");
> +				}
> +
> +				if (state_pre.polarity == state_post.polarity &&
> +				    state_pre.enabled &&
> +				    (state_pre.period > state_post.period ||
> +				     state_pre.duty_cycle > state_post.period)) {
> +
> +					dev_warn(pwm->chip->dev,
> +						 ".apply is supposed to round down both period and duty_cycle.\n");
> +
> +				}
> +
> +				*state = state_post;
> +
> +				/* reapply state_post and check it is unmodified */
> +				err = pwm->chip->ops->apply(pwm->chip, pwm, state);
> +				if (err) {
> +					dev_err(pwm->chip->dev,
> +						 "failed to reapply the current setting\n");
> +					return err;
> +				}
> +
> +				if (state_post.period != state->period ||
> +				    state_post.duty_cycle != state->duty_cycle ||
> +				    state_post.polarity != state->polarity ||
> +				    state_post.enabled != state->enabled) {
> +					dev_warn(pwm->chip->dev,
> +						 "applying the settings that .get_state returned yields changes\n");
> +				}
> +
> +			} else {
> +				dev_warn(pwm->chip->dev,
> +					 "Please update the driver to provide .get_state()\n");
> +			}
> +		}
> +
>  		pwm->state = *state;
>  	} else {
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
> +			dev_warn(pwm->chip->dev,
> +				 "Please update the driver to provide .apply() instead of .config()\n");
> +		}
> +
>  		/*
>  		 * FIXME: restore the initial state in case of error.
>  		 */

regards
Philipp
