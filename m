Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E826954D7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Feb 2023 00:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBMXho (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Feb 2023 18:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBMXho (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Feb 2023 18:37:44 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 15:37:43 PST
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01693AD3C
        for <linux-pwm@vger.kernel.org>; Mon, 13 Feb 2023 15:37:42 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 42a68002-abf7-11ed-a738-005056bdd08f;
        Tue, 14 Feb 2023 01:36:38 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 14 Feb 2023 01:36:38 +0200
To:     Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
Message-ID: <Y+rJhvpgJkU2uBvF@surfacebook>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
 <20201211170432.6113-2-nicola.dilieto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211170432.6113-2-nicola.dilieto@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fri, Dec 11, 2020 at 06:04:31PM +0100, Nicola Di Lieto kirjoitti:
> This new driver allows pulse width modulating any GPIOs using
> a high resolution timer. It is fully generic and can be useful
> in a variety of situations. As an example I used it to provide
> a pwm to the pwm-beeper driver so that my embedded system can
> produce tones through a piezo buzzer connected to a GPIO which
> unfortunately is not hardware PWM capable.

...

> +#include <linux/atomic.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/hrtimer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

No need (instead use mod_devicetable.h). See below.

> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>

...

> +struct pwm_gpio {
> +	struct pwm_chip chip;
> +	struct gpio_desc *desc;
> +	struct work_struct work;
> +	struct hrtimer timer;
> +	atomic_t enabled;
> +	spinlock_t lock;

> +	struct {
> +		u64 ton_ns;
> +		u64 toff_ns;
> +		bool invert;
> +	} cur, new;

Can we instead have two struct pwm_state members?

> +	bool state;
> +	bool output;
> +};

...

> +enum hrtimer_restart pwm_gpio_do_timer(struct hrtimer *handle)
> +{
> +	struct pwm_gpio *pwm_gpio = container_of(handle, struct pwm_gpio, timer);
> +	u64 ns;
> +
> +	if (!atomic_read(&pwm_gpio->enabled))
> +		return HRTIMER_NORESTART;
> +
> +	if (pwm_gpio->state) {
> +		ns = pwm_gpio->cur.toff_ns;
> +		pwm_gpio->state = false;
> +	} else {

> +		if (spin_trylock(&pwm_gpio->lock)) {

What does this mean? So, if we don't get a lock, it doesn't imply we won't get
it locked below...

> +			pwm_gpio->cur = pwm_gpio->new;
> +			spin_unlock(&pwm_gpio->lock);
> +		}

...i.e. here...

> +		ns = pwm_gpio->cur.ton_ns;

...or here.

> +		pwm_gpio->state = true;

So the trylock needs a good comment explaining why it's not a problem.

> +	}
> +	pwm_gpio->output = pwm_gpio->state ^ pwm_gpio->cur.invert;

...

> +#ifdef CONFIG_OF

Drop this ifdeffery.

> +static const struct of_device_id pwm_gpio_of_match[] = {
> +	{ .compatible = "pwm-gpio", },

Inner comma is not needed.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_gpio_of_match);
> +#endif

...

> +		.of_match_table = of_match_ptr(pwm_gpio_of_match),

No of_match_ptr(), please.

-- 
With Best Regards,
Andy Shevchenko


