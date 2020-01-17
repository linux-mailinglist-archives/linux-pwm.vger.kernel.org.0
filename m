Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0514047E
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2020 08:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAQHei (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jan 2020 02:34:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39207 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgAQHeh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jan 2020 02:34:37 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1isM9F-0005gR-I7; Fri, 17 Jan 2020 08:34:29 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1isM9D-00028c-L9; Fri, 17 Jan 2020 08:34:27 +0100
Date:   Fri, 17 Jan 2020 08:34:27 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20200117073427.ufrduwagvppeasgr@pengutronix.de>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-5-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579228475-6681-5-git-send-email-jeff@labundy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jan 17, 2020 at 02:35:57AM +0000, Jeff LaBundy wrote:
> +static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct iqs620_pwm_private *iqs620_pwm;
> +
> +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> +
> +	mutex_lock(&iqs620_pwm->lock);
> +
> +	/*
> +	 * Since the device cannot generate a 0% duty cycle, requests to do so
> +	 * cause subsequent calls to iqs620_pwm_get_state to report the output
> +	 * as disabled with duty cycle equal to that which was in use prior to
> +	 * the request. This is not ideal, but is the best compromise based on
> +	 * the capabilities of the device.
> +	 */
> +	state->enabled = iqs620_pwm->out_en;

Hmm, when .get_state is called first (before the first invokation of
.apply) .out_en doesn't represent the hardware's state but is false
unconditionally. This makes it hard to take over a running PWM setup by
the bootloader.

Best regards
Uwe

> +	state->duty_cycle = DIV_ROUND_UP((iqs620_pwm->duty_val + 1) *
> +					 IQS620_PWM_PERIOD_NS, 256);
> +
> +	mutex_unlock(&iqs620_pwm->lock);
> +
> +	state->period = IQS620_PWM_PERIOD_NS;
> +}

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
