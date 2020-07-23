Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1082F22B83A
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 22:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGWUzK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 16:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgGWUzK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 16:55:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD423C0619D3;
        Thu, 23 Jul 2020 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ICBX86+Lkkci6Ue+B7VowL4TPQylTLlU+8rjSgsn/kY=; b=PXTfv7ANvy94gKr5OC2zsWn/nz
        i3vfvhKgL0r99ZON2G7T9JuyG6hp+D7SaO4uHupQV/jZRDdUs3jiKiALhhPXE9kOvbSJOOHRtFRj2
        WA1dy4PcFiEgIpjkKiTwq8X3A4Ob09hCWySRByy+HGaFBHhhzefDJRLOXjMdVulhuFAIhwqRTwA6L
        0oZDBTtSmj0lU2JewPsGFRLexOeKXW7RKsoyiWTGFMmEVkM/vxwYDhL36tMUDXFSHy4A5dy41IcQS
        5EYweiIy2x8N85dmapjSvH7QoSjE/icilxuyiZQhmJDdrlCrs7tzavF85LR4SX7dMqcBBXxQBtojP
        /cVSq9cg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyiF9-00043b-9A; Thu, 23 Jul 2020 20:55:08 +0000
Subject: Re: [PATCH V17 3/3] Input: new da7280 haptic driver
To:     Roy Im <roy.im.opensource@diasemi.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ad4f8a07-9e78-ce97-021f-094210d99a3c@infradead.org>
Date:   Thu, 23 Jul 2020 13:55:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/23/20 8:01 AM, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.
> 
> Reviewed-by: Jes Sorensen <Jes.Sorensen@gmail.com>.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 
> ---
> 
> 
>  drivers/input/misc/Kconfig  |   13 +
>  drivers/input/misc/Makefile |    1 +
>  drivers/input/misc/da7280.c | 1840 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1854 insertions(+)
>  create mode 100644 drivers/input/misc/da7280.c
> 

> diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
> new file mode 100644
> index 0000000..6e3ead5
> --- /dev/null
> +++ b/drivers/input/misc/da7280.c
> @@ -0,0 +1,1840 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DA7280 Haptic device driver
> + *
> + * Copyright (c) 2020 Dialog Semiconductor.
> + * Author: Roy Im <Roy.Im.Opensource@diasemi.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/workqueue.h>
> +#include <linux/uaccess.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +

...


> +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool enabled)
> +{
> +	struct pwm_state state;
> +	u64 period_mag_multi;
> +	int error;
> +
> +	if (!haptics->gain && enabled) {
> +		dev_err(haptics->dev,
> +			"Please set the gain first for the pwm mode\n");
> +		return -EINVAL;
> +	}
> +
> +	pwm_get_state(haptics->pwm_dev, &state);
> +	state.enabled = enabled;
> +	if (enabled) {
> +		period_mag_multi = (u64)state.period * haptics->gain;
> +		period_mag_multi >>= MAX_MAGNITUDE_SHIFT;
> +
> +		/* The interpretation of duty cycle depends on the acc_en,
> +		 * it should be between 50% and 100% for acc_en = 0.
> +		 * See datasheet 'PWM mode' section.
> +		 */

from coding-style.rst:

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

(except for networking code)

Please fix multiple locations.


thanks.
-- 
~Randy

