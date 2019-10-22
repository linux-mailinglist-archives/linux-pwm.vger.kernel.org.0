Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13520E0319
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbfJVLiq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 07:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387871AbfJVLip (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Oct 2019 07:38:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB038207FC;
        Tue, 22 Oct 2019 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571744324;
        bh=aVhV8SXUfakeMnO83FUK3yRAfke9knQB8SLYn7IKA1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L4xojqsZuVDh1hRZGbe1mITUqgcXeXKcLI2WCBSLS8RRcaE8dOkg2hBJNsETLBAo+
         Y/QJ70gfq8LuS6UDNffzwAsdH4Z8hZz5niDqM/oV60Y9qgBT906m9hug/lUKXNlYdg
         tLjRWD0oONt9ZR/DLr5Dx+EsHdkO2bi8Rn2i8bZg=
Date:   Tue, 22 Oct 2019 12:38:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jeff LaBundy <jeff@labundy.com>, lee.jones@linaro.org,
        dmitry.torokhov@gmail.com, jdelvare@suse.com,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 4/8] hwmon: Add support for Azoteq IQS620AT temperature
 sensor
Message-ID: <20191022123838.5a9e2b26@archlinux>
In-Reply-To: <f9610e3d-d923-1ffe-233f-e94cace41f64@roeck-us.net>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
        <1571631083-4962-5-git-send-email-jeff@labundy.com>
        <20191021153825.GA15359@roeck-us.net>
        <20191022022611.GA2091@labundy.com>
        <f9610e3d-d923-1ffe-233f-e94cace41f64@roeck-us.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 21 Oct 2019 20:22:44 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 10/21/19 7:26 PM, Jeff LaBundy wrote:
> > Hi Guenter,
> > 
> > Thank you for your prompt review.
> > 
> > On Mon, Oct 21, 2019 at 08:38:25AM -0700, Guenter Roeck wrote:  
> >> On Sun, Oct 20, 2019 at 11:11:19PM -0500, Jeff LaBundy wrote:  
> >>> This patch adds support for the Azoteq IQS620AT temperature sensor,
> >>> capable of reporting its absolute die temperature.
> >>>
> >>> Signed-off-by: Jeff LaBundy <jeff@labundy.com>  
> >>
> >> Seems to me this might be more feasible as iio driver.
> >> Jonathan, what do you think ?
> >>  
> > 
> > Interestingly enough, this actually started as an iio driver; however the
> > "When to Use" slide of [0] made me suspect that conventional devices with
> > the temperature sensing element integrated on the die belong in hwmon.
> > 
> > I then found the highly similar ad7314, which Jonathan himself appears to
> > have converted from iio to hwmon. Therefore, I placed this where existing
> > drivers seemed to match the most, especially since the temperature sensors
> > in iio generally use IR or a thermocouple.
> > 
> > That being said, I would be happy to move this into iio so long as Jonathan
> > does not mind, as it would limit the blast radius of this patch series.
> >   
> 
> I don't recall why the ad7314 driver was moved. With a conversion time of 40uS
> it is most definitely not a typical use case for a hwmon sensor.

I'll be honest, I can't remember either ;)
> 
> Anyway, not worth arguing about. Just don't complain later. There is an
> iio->hwmon bridge, but no hwmon->iio bridge, so the decision does have some
> impact. Specifically, userspace will have to implement both hwmon and iio
> access to handle the chip.

So I had a very quick look at one of the data sheets.  The temperature sensor
here is described as: 

"The IQS620(A) provides temperature monitoring capabilities which can be used for temperature
change detection in order to ensure the integrity of other sensing technology".

Superficially this sounds like it's probably inappropriate for any sort
of system temperature monitoring.  It's really just there to allow
for clever compensation algorithms for the other bits on this chip
(much like the temperature sensors we almost always get on a decent
IMU).

Normally we'd just tack an extra channel for the temperature sensor on
to the the the sensor it is integrated with.  This is a bit more
complex though as we have 3 different IIO sensors that are present
in particular part numbers and for some cases we have no IIO device
at all, but do have a temperature sensor.

So if people are going to actually use this to compensate outputs
(not sure which ones are actually temperature sensitive btw ;)
then if those are IIO supported devices, then probably makes sense
for this to be an IIO device.  It may make sense anyway if there
is any chance of adding temperature compensation to the drivers
in kernel.  I suspect the only use that would actually be made
is as a trip point if something has gone horribly wrong, but
I might be wrong!

Conclusion. I also don't feel strongly on this one as it kind of
sits between IIO and hwmon, but probably ever so slightly on the
IIO side as monitoring a sensor chip, not some other device.

Thanks,

Jonathan

> 
> Guenter

