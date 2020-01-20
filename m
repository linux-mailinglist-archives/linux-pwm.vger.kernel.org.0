Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6D1142435
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 08:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgATH1v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 02:27:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41629 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATH1v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 02:27:51 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1itRTJ-0000sd-HT; Mon, 20 Jan 2020 08:27:41 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1itRTH-0000jo-GG; Mon, 20 Jan 2020 08:27:39 +0100
Date:   Mon, 20 Jan 2020 08:27:39 +0100
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
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20200120072739.sixr5e76uckrugvu@pengutronix.de>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-5-git-send-email-jeff@labundy.com>
 <20200117073427.ufrduwagvppeasgr@pengutronix.de>
 <20200119233234.GB28865@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200119233234.GB28865@labundy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Jeff,

On Sun, Jan 19, 2020 at 11:32:39PM +0000, Jeff LaBundy wrote:
> On Fri, Jan 17, 2020 at 08:34:27AM +0100, Uwe Kleine-König wrote:
> > On Fri, Jan 17, 2020 at 02:35:57AM +0000, Jeff LaBundy wrote:
> > > +static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +				 struct pwm_state *state)
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +
> > > +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> > > +
> > > +	mutex_lock(&iqs620_pwm->lock);
> > > +
> > > +	/*
> > > +	 * Since the device cannot generate a 0% duty cycle, requests to do so
> > > +	 * cause subsequent calls to iqs620_pwm_get_state to report the output
> > > +	 * as disabled with duty cycle equal to that which was in use prior to
> > > +	 * the request. This is not ideal, but is the best compromise based on
> > > +	 * the capabilities of the device.
> > > +	 */
> > > +	state->enabled = iqs620_pwm->out_en;
> > 
> > Hmm, when .get_state is called first (before the first invokation of
> > .apply) .out_en doesn't represent the hardware's state but is false
> > unconditionally. This makes it hard to take over a running PWM setup by
> > the bootloader.
> 
> This was intentional, albeit poorly documented on my part. When the parent
> MFD driver probes the device, it issues a soft reset (which returns all of
> its registers to their default state). It then loads firmware (essentially
> tuning/calibration register settings) and then triggers the device's self-
> calibration sequence.
> 
> Both IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE default to zero,
> and the firmware does not modify these. Therefore out_en and duty_val match
> the hardware even before iqs620_pwm_apply is called, as they're initialized
> to zero as well.
> 
> I would be happy to add a comment in iqs620_pwm_get_state describing this
> behavior; I should have described it there rather than the review history
> (sorry about that).

I didn't saw that mentioned in the review history, just skimmed through
the driver.

> However, you bring up a really interesting point about preserving what may
> have been done by the bootloader. The device holds itself in POR until its
> supply reaches a sufficient level, so there isn't necessarily a functional
> reason to manually issue a soft reset from the parent MFD driver.
> 
> I could get rid of the manual soft reset, and then simply sync both out_en
> and duty_val in iqs620_pwm_probe which would allow iqs620_pwm_get_state to
> pick up any changes made by the bootloader prior to the kernel coming up.

That sounds good. This way the PWM driver is independent of the MFD
driver and does the right thing no matter if parent resets the chip or
not.
 
> The only problem is that leds-pwm disables the pwm at start-up, so the end
> result is the same anyway. Regardless of the behavior of any one consumer,
> however, I'm slightly inclined to go with the second option as it seems to
> be less restrictive and more maintainable. Let me know if you disagree.

With

	default-state = "keep";

in your dt the LED shouldn't get disabled.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
