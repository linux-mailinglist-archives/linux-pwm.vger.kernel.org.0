Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC40425AAE2
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 14:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBMMH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 08:12:07 -0400
Received: from smtp1.axis.com ([195.60.68.17]:60944 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBML6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Sep 2020 08:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1557; q=dns/txt; s=axis-central1;
  t=1599048716; x=1630584716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u6QS3JQEdnLbaY7gvazvmZqmKguQ72iSvGbf00nO/C0=;
  b=qF++WjytMBe/zCYcPncawAGHRsZleh0dCM0zKFJJbWSm7y8M3eaMKoKc
   nBLpHd+jKu8EQVPZxpmICU/2zxucqjVu2vj9fJxUcBRC7W28Le+LQi0FG
   5bBdPQuF9bbWI97VJ/Ga6IYPd6BeDX97DiPbrAXSpSvQ8x3TZKkTa74LQ
   iJI3vi++11HiagjezZgXFbW0D/2NAq1PO23zNj6s2KI9LufaKu3CX4HVf
   kivs/Uy44xYNMBaZtbavI14bPg1+DztWzwmsGQaX8pDF6w3DyKGXXLgOG
   ihlIAnaNMVohNi0a6VnxJWALT6yznnwCpi++LmCB2MJ7C2IyzkaTb03yt
   A==;
IronPort-SDR: E8yxxK6dGzeudcndqsHFgU/eEOfDfNX8BWMeMwdAJAGxCl0gNmalYztVPdnwcqBIkMroum8VFk
 TisfLSexOOXuGHwA8UYfYCLs5aEBJHcDD7SDFRfFjkC1IT5peBEyr9K9x3KzssynVseu7yVFIp
 laDdpCZ9nJSq6r3GeMNNmo/LF/vs6POuF8G9BFr1UTeMbkn5uFtaL/D793Dhw09GD3kHFp0Is8
 8AgJBpH+PmQtG8Tug0k7luwK07M9UJ8jaFYUufpPJ/qUOtY9qQgO6S5lBfOrAAoIL6FHu5qxq0
 FBU=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="12474715"
Date:   Wed, 2 Sep 2020 14:11:54 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <kernel@axis.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <oliver@schinagl.nl>
Subject: Re: [PATCH 2/2] pwm: Add GPIO PWM driver
Message-ID: <20200902121154.6bb5d5sqxwf2tmgt@axis.com>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
 <20200814155513.31936-2-vincent.whitchurch@axis.com>
 <20200815075032.k2xyw75l56sbl7nx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200815075032.k2xyw75l56sbl7nx@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 15, 2020 at 09:50:32AM +0200, Uwe Kleine-König wrote:
> On Fri, Aug 14, 2020 at 05:55:13PM +0200, Vincent Whitchurch wrote:
> > Add a software PWM which toggles a GPIO from a high-resolution timer.
> > 
> > This will naturally not be as accurate or as efficient as a hardware
> > PWM, but it is useful in some cases.  I have for example used it for
> > evaluating LED brightness handling (via leds-pwm) on a board where the
> > LED was just hooked up to a GPIO, and for a simple verification of the
> > timer frequency on another platform.
> > 
> > Since high-resolution timers are used, sleeping gpio chips are not
> > supported and are rejected in the probe function.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Nice idea. IMHO this can serve as example about what we expect from pwm
> drivers. There is some improvement necessary however to reach that
> state.

Thank you for the comments.  I think I've fixed all of them in v2.  Just
one point about this one:

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops pwm_gpio_ops = {
> > +	.owner = THIS_MODULE,
> > +	.apply = pwm_gpio_apply,
> 
> Usually a .get_state callback is nice. Does it make sense to do
> something like:
> 
> 	if (driver is up)
> 		report current setting
> 	else
> 		val = gpio_get_value()
> 		report(period=1, duty_cycle=val, enabled=val, polarity=NORMAL)
> 
> ?

I implemented get_state() but I didn't do the gpio_get_value() thing
since the driver sets the gpio to a known value in probe().
