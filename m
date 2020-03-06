Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5117B72D
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 08:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgCFHGE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 02:06:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40307 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgCFHGD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2020 02:06:03 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA73L-0005sH-MH; Fri, 06 Mar 2020 08:05:47 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA73I-00038n-BO; Fri, 06 Mar 2020 08:05:44 +0100
Date:   Fri, 6 Mar 2020 08:05:44 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH V10 3/3] Input: new da7280 haptic driver
Message-ID: <20200306070544.7rj5y44e23kiz65e@pengutronix.de>
References: <cover.1583425388.git.Roy.Im@diasemi.com>
 <fd7066d21e994de56b331d9320f9671356fac408.1583425388.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd7066d21e994de56b331d9320f9671356fac408.1583425388.git.Roy.Im@diasemi.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Roy,

On Fri, Mar 06, 2020 at 01:23:08AM +0900, Roy Im wrote:
> +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool enabled)
> +{
> +	struct pwm_state state;
> +	u64 period_mag_multi;
> +	int error;
> +
> +	if (!haptics->gain) {
> +		dev_err(haptics->dev,
> +			"Please set the gain first for the pwm mode\n");
> +		return -EINVAL;
> +	}
> +
> +	pwm_get_state(haptics->pwm_dev, &state);
> +	state.enabled = enabled;
> +	if (enabled) {
> +		period_mag_multi = state.period * haptics->gain;
> +		period_mag_multi >>= MAX_MAGNITUDE_SHIFT;
> +
> +		/* The interpretation of duty cycle depends on the acc_en,
> +		 * it should be form 50% to 100% for acc_en = 0.

At least s/form/from/, but maybe better: it should be between 50% and
100% ...

> +		 * See datasheet 'PWM mode' section.
> +		 */
> +		if (!haptics->acc_en) {
> +			period_mag_multi += state.period;
> +			period_mag_multi /= 2;
> +		}
> +
> +		state.duty_cycle  = (unsigned int)period_mag_multi;

This cast is not needed. (Also it seems struct pwm_state::duty_cycle
becomes u64 soon, after this happens the cast even hurts.)

> [...]
> +	struct device *dev = &client->dev;
> +	struct da7280_haptic *haptics;
> +	struct input_dev *input_dev;
> +	struct ff_device *ff;
> +	struct pwm_state state;
> +	unsigned int period2freq;
> +	int error;
> +
> +	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
> +	if (!haptics)
> +		return -ENOMEM;
> +	haptics->dev = dev;
> +
> +	if (!client->irq) {
> +		dev_err(dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}
> +
> +	da7280_parse_properties(dev, haptics);
> +
> +	if (haptics->const_op_mode == DA7280_PWM_MODE) {
> +		haptics->pwm_dev = devm_pwm_get(dev, NULL);
> +		if (IS_ERR(haptics->pwm_dev)) {
> +			dev_err(dev, "failed to get PWM device\n");

Please use %pE to show the actual error and don't print if it is
EPROBE_DEFER.

> +			return PTR_ERR(haptics->pwm_dev);
> +		}
> +
> +		pwm_init_state(haptics->pwm_dev, &state);
> +		state.enabled = false;

This usuage is strange (which might be because pwm_init_state() is
strange). I assume the goal here is to disable the PWM with the right
polarity set, right? Ah, and initialize .period as this isn't touched
later on. Hmm, no better idea, I guess we have to leave it as is for
now.

Can it be that the PWM is already on at probe time and it might be
usefull to keep it running as is?

> +		error = pwm_apply_state(haptics->pwm_dev, &state);
> +		if (error) {
> +			dev_err(dev,
> +				"failed to apply initial PWM state: %pE\n",
> +				ERR_PTR(error));
> +			return error;
> +		}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
