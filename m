Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA435A2AD
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhDIQI1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhDIQI0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 12:08:26 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B9C061761;
        Fri,  9 Apr 2021 09:08:13 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 35805C725C8;
        Fri,  9 Apr 2021 18:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617984492;
        bh=Np0R8jz8X4f7v3vdRWj+57iPcgTXHXb9XIYeOfW1UjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVZ9FKGYwtfh+ksPg4LV9T5cfz/S7UWpckmigqBJUkQ++69eYSiEdVfd6NDGrQC1G
         LKm+7ywk4nXYWJH2ncU5dth8JOXifkKfFBNZ8FnlqCjrRm5hrCdJpaZk6JL1kA3KI1
         bKVi50TYuyy6nI4j+lkYZ15TzPyAi80Rum4Y651I=
Date:   Fri, 9 Apr 2021 18:08:10 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/8] pwm: pca9685: Improve runtime PM behavior
Message-ID: <YHB76i7IcVAqvTQm@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-3-clemens.gruber@pqgruber.com>
 <YHBQmGJIsa6sNRIg@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHBQmGJIsa6sNRIg@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 09, 2021 at 03:03:20PM +0200, Thierry Reding wrote:
> On Tue, Apr 06, 2021 at 06:41:35PM +0200, Clemens Gruber wrote:
> > The chip does not come out of POR in active state but in sleep state.
> > To be sure (in case the bootloader woke it up) we force it to sleep in
> > probe.
> > 
> > On kernels without CONFIG_PM, we wake the chip in .probe and put it to
> > sleep in .remove.
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> > Changes since v6:
> > - Improved !CONFIG_PM handling (wake it up without putting it to sleep
> >   first)
> > 
> >  drivers/pwm/pwm-pca9685.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index d4474c5ff96f..0bcec04b138a 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -474,13 +474,18 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  		return ret;
> >  	}
> >  
> > -	/* The chip comes out of power-up in the active state */
> > -	pm_runtime_set_active(&client->dev);
> > -	/*
> > -	 * Enable will put the chip into suspend, which is what we
> > -	 * want as all outputs are disabled at this point
> > -	 */
> > -	pm_runtime_enable(&client->dev);
> > +	if (IS_ENABLED(CONFIG_PM)) {
> 
> This looks odd to me. I've seen similar constructs, but they usually go
> something like this (I think):
> 
> 	pm_runtime_enable(&client->dev);
> 
> 	if (!pm_runtime_enabled(&client->dev)) {
> 		/* resume device */
> 	}
> 
> Which I guess in your would be somewhat the opposite and it wouldn't
> actually resume the device but rather put it to sleep.

Yes, I wanted to keep it in sleep mode if runtime PM is supported (to be
woken up later) and otherwise just wake it up in probe.

> 
> Perhaps something like this:
> 
> 	pm_runtime_enable(&client->dev);
> 
> 	if (pm_runtime_enabled(&client->dev)) {
> 		pca9685_set_sleep_mode(pca, true);
> 		pm_runtime_set_suspended(&client->dev);
> 	} else {
> 		/* wake the chip up on non-PM environments */
> 		pca9685_set_sleep_mode(pca, false);
> 	}
> 
> ? I think that's slightly more correct than your original because it
> takes into account things like sysfs power control and such. It also
> doesn't rely on the config option alone but instead uses the runtime
> PM API to achieve this more transparently.

Ah, yes, I missed the fact that runtime could be disabled 'at runtime'
via sysfs as well, so yes, that's more correct and pm_runtime_enabled
will just return false if !CONFIG_PM, so that should work as well.

Thanks,
Clemens
