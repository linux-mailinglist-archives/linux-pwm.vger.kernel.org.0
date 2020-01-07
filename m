Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7131324B2
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2020 12:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgAGLTt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jan 2020 06:19:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52259 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgAGLTt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2020 06:19:49 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iomti-0001FG-Ne; Tue, 07 Jan 2020 12:19:42 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iomtg-0007Ek-DM; Tue, 07 Jan 2020 12:19:40 +0100
Date:   Tue, 7 Jan 2020 12:19:40 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20200107111940.ymiey7npx6rrppqz@pengutronix.de>
References: <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
 <20191220031924.GA2658@labundy.com>
 <20191220085948.iagsdpjqd6ixdo7j@pengutronix.de>
 <20191221032755.GA3051@labundy.com>
 <20191222214851.kapsro6b6qylke43@pengutronix.de>
 <20200101223933.GB14339@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200101223933.GB14339@labundy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jeff,

On Wed, Jan 01, 2020 at 10:39:36PM +0000, Jeff LaBundy wrote:
> On Sun, Dec 22, 2019 at 10:48:51PM +0100, Uwe Kleine-König wrote:
> > On Sat, Dec 21, 2019 at 03:28:01AM +0000, Jeff LaBundy wrote:
> > > Based on your other feedback, I'm moving forward under the impression that
> > > you'll still accept option (2); please let me know if I have misunderstood
> > > (thank you for being flexible).
> > 
> > Yeah, that's fine. If in the end it shows that this is a bad idea we can
> > still change to (3).
> 
> Sounds great. As soon as 5.5-rc5 lands this weekend, I'll rebase v3 and
> send it out.
> 
> I failed to catch this in my previous reply, but the comment I've added
> to iqs620_pwm_get_state actually reads as follows:
> 
> /*
>  * Since the device cannot generate a 0% duty cycle, requests to do so
>  * force subsequent calls to iqs620_pwm_get_state to report the output
>  * as disabled with duty cycle equal to that which was in use prior to
>  * the request. This is not ideal, but is the best compromise based on
>  * the capabilities of the device.
>  */
> 
> This matches the present implementation, not your proposed comment that
> claims duty cycle is clamped to 1 / 256 ms following a request for a 0%
> duty cycle.

Yeah, if that's the mechanism that is actually implemented, that's fine
of course.

> This seems OK since the concept of a duty cycle or period aren't really
> relevant if the output is disabled in my opinion. However if you prefer
> I update iqs620_pwm_apply to clamp duty cycle to 1 / 256 ms (instead of
> leaving it untouched) in this case, please let me know.

For a disabled PWM the duty_cycle and period are not relevant, for an
enabled PWM running with 0% the period matters (at least in theory)
however.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
