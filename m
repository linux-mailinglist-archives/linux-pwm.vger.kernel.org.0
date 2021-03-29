Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59DC34D527
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhC2Qb2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhC2QbU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 12:31:20 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4FEC061574;
        Mon, 29 Mar 2021 09:31:20 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id CACBDC72850;
        Mon, 29 Mar 2021 18:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617035479;
        bh=Y4P1l6qGT0FozQveYBvpyYlZHzj8F1XucMPVUYIroBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meNHS3C5343RDj5b6FfGXyJRjxwws2ZnIOCObwv9h3qs//WKb2VxUUvgX8TB4YD4w
         mwVySCAMmi9uYqoCyHYb0SBIxQtdBxDbUnhfkRXl6atFBKp6UpvOFL0K08W6TwWUB3
         Fa5+lCiEx00bHigSE0MaZxJVSiTQktwCt7Y2Gbak=
Date:   Mon, 29 Mar 2021 18:31:17 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] pwm: pca9685: Improve runtime PM behavior
Message-ID: <YGIA1ZX9PrPlRvkb@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-3-clemens.gruber@pqgruber.com>
 <20210329155527.q3o25ubh33pmszsi@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329155527.q3o25ubh33pmszsi@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Mar 29, 2021 at 05:55:27PM +0200, Uwe Kleine-König wrote:
> On Mon, Mar 29, 2021 at 02:57:03PM +0200, Clemens Gruber wrote:
> > The chip does not come out of POR in active state but in sleep state.
> > To be sure (in case the bootloader woke it up) we force it to sleep in
> > probe.
> > 
> > On kernels without CONFIG_PM, we wake the chip in .probe and put it to
> > sleep in .remove.
> 
> What is the effect of sleep state? Does it continue to oscilate it the
> bootloader set up some configuration?

The datasheet says: "When the oscillator is off (Sleep mode) the LEDn
outputs cannot be turned on, off or dimmed/blinked."

At the moment, we reset the output registers anyway, so everything is
turned off at probe time, even if the bootloader did set something up.

When removing the resets in the future, I would read out the state of
the SLEEP bit at probe time and set the pm runtime state accordingly.

> 
> 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index fb026a25fb61..4d6684b90819 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -469,14 +469,19 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  		return ret;
> >  	}
> >  
> > -	/* The chip comes out of power-up in the active state */
> > -	pm_runtime_set_active(&client->dev);
> >  	/*
> > -	 * Enable will put the chip into suspend, which is what we
> > -	 * want as all outputs are disabled at this point
> > +	 * The chip comes out of power-up in the sleep state,
> > +	 * but force it to sleep in case it was woken up before
> >  	 */
> > +	pca9685_set_sleep_mode(pca, true);
> > +	pm_runtime_set_suspended(&client->dev);
> >  	pm_runtime_enable(&client->dev);
> >  
> > +	if (!IS_ENABLED(CONFIG_PM)) {
> > +		/* Wake the chip up on non-PM environments */
> > +		pca9685_set_sleep_mode(pca, false);
> 
> I admit I didn't grasp all the PM framework details, but I wonder if
> it's right to first call set_sleep_mode(true) and then in some cases to
> false again.

That was done for readability reasons, however, I admit that after we no
longer reset the period (deemed not necessary by me due to the planned
removal of the resets) it would probably be as readable to have:

if (IS_ENABLED(CONFIG_PM)) {
	pca9685_set_sleep_mode(pca, true);
	pm_runtime_set_suspended..
	pm_runtime_enable..
} else
	pca9685_set_sleep_mode(pca, false);

Thanks,
Clemens
