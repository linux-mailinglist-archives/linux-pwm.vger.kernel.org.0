Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F2E0FE2
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 04:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbfJWCES (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 22:04:18 -0400
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:48535
        "EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387856AbfJWCES (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 22:04:18 -0400
Received: from labundy.com ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id N60UiPP12LAS6N60ViZxDL; Tue, 22 Oct 2019 19:04:17 -0700
Date:   Tue, 22 Oct 2019 21:04:14 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, lee.jones@linaro.org,
        dmitry.torokhov@gmail.com, jdelvare@suse.com,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 4/8] hwmon: Add support for Azoteq IQS620AT temperature
 sensor
Message-ID: <20191023020414.GB3233@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-5-git-send-email-jeff@labundy.com>
 <20191021153825.GA15359@roeck-us.net>
 <20191022022611.GA2091@labundy.com>
 <f9610e3d-d923-1ffe-233f-e94cace41f64@roeck-us.net>
 <20191022123838.5a9e2b26@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022123838.5a9e2b26@archlinux>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfGaGETfLTMh17dV1Qc/8o5lPbU+c3ts7+wuILZP7hJJHxWcJAGIwbHEoBffqgkNUfD3S3Jes76p03DEP5+3aE34jQQlxMkldVbW3Vj0AXGUow2KGNDhc
 5MkrBFGgbEuoJwH/b8zqz8tvdQDaea/JGKh6KKoKbOg/mYuIOCuiS+b38UrIZE8uiYPZc40WgHYSwN/gh9yY8ProuuRfajALhqUxke6ntfaUC5qUV+qUU8+2
 glLiAk46AtKPvMRBHxJ+imbN/1IJX0sen2+PUofp3r69YYIaaa4g2hFSvgX/vfnzXDdm/bVR0PT4A6wUHYepor375WRfrtS6rqf/aFxBhQhJW1Vadv9W9Z+D
 /mNIFIzPGEcX5nE9wmFty7a9TgKdtQGmPl9fVhKsXk6jim+eGWMvjndF+DBQqomLtQHmJLKoLwDg+Rw0yWOSrTF4FM7rMmZOtIchs+TWkL80Ksova/k4P+/w
 c3WMGV2wyCv01HJtJjmFhe2izw7P5knr+FqI//d9c8lSV2dw7quOwmvpDPdAtPnHjyOafvcIHffn3veU82SC9EdM/NGzYf2h6/0puAjzh7df/zFYUvU1fyM3
 7lQKOZ5tcSR/OcDBorE2Uz7Yx0ZHgFS9Kj8x97Ua5Vk4u351spD1yVTe2VbvwoKRk8bBJrmb07Els1CfCB9F9zEjJFDSUBwG0ypdHgXGsrhYC8uMy01y0ctL
 atFqFSS3+5I=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jonathan and Guenter,

On Tue, Oct 22, 2019 at 12:38:38PM +0100, Jonathan Cameron wrote:
> On Mon, 21 Oct 2019 20:22:44 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 10/21/19 7:26 PM, Jeff LaBundy wrote:
> > > Hi Guenter,
> > > 
> > > Thank you for your prompt review.
> > > 
> > > On Mon, Oct 21, 2019 at 08:38:25AM -0700, Guenter Roeck wrote:  
> > >> On Sun, Oct 20, 2019 at 11:11:19PM -0500, Jeff LaBundy wrote:  
> > >>> This patch adds support for the Azoteq IQS620AT temperature sensor,
> > >>> capable of reporting its absolute die temperature.
> > >>>
> > >>> Signed-off-by: Jeff LaBundy <jeff@labundy.com>  
> > >>
> > >> Seems to me this might be more feasible as iio driver.
> > >> Jonathan, what do you think ?
> > >>  
> > > 
> > > Interestingly enough, this actually started as an iio driver; however the
> > > "When to Use" slide of [0] made me suspect that conventional devices with
> > > the temperature sensing element integrated on the die belong in hwmon.
> > > 
> > > I then found the highly similar ad7314, which Jonathan himself appears to
> > > have converted from iio to hwmon. Therefore, I placed this where existing
> > > drivers seemed to match the most, especially since the temperature sensors
> > > in iio generally use IR or a thermocouple.
> > > 
> > > That being said, I would be happy to move this into iio so long as Jonathan
> > > does not mind, as it would limit the blast radius of this patch series.
> > >   
> > 
> > I don't recall why the ad7314 driver was moved. With a conversion time of 40uS
> > it is most definitely not a typical use case for a hwmon sensor.
> 
> I'll be honest, I can't remember either ;)
> > 
> > Anyway, not worth arguing about. Just don't complain later. There is an
> > iio->hwmon bridge, but no hwmon->iio bridge, so the decision does have some
> > impact. Specifically, userspace will have to implement both hwmon and iio
> > access to handle the chip.
> 
> So I had a very quick look at one of the data sheets.  The temperature sensor
> here is described as: 
> 
> "The IQS620(A) provides temperature monitoring capabilities which can be used for temperature
> change detection in order to ensure the integrity of other sensing technology".
> 
> Superficially this sounds like it's probably inappropriate for any sort
> of system temperature monitoring.  It's really just there to allow
> for clever compensation algorithms for the other bits on this chip
> (much like the temperature sensors we almost always get on a decent
> IMU).
> 

Correct on all counts. The "charge transfer" sensing mechanism employed by these
devices is sensitive to temperature, and they employ a compensation algorithm to
account for drift.

Of the five devices in the series, the IQS620A and IQS621 expose the output of
the temperature monitoring network to the outside world. However, the values are
purely relative. The IQS620AT, however, is calibrated at the factory such that
it can apply an internal scaling factor and offset in order to provide absolute
measurements.

The MFD driver checks these calibration values to determine if this driver can
be loaded, or if the device is a plain IQS620A (no 'T') in which case only the
input and PWM drivers are loaded.

> Normally we'd just tack an extra channel for the temperature sensor on
> to the the the sensor it is integrated with.  This is a bit more
> complex though as we have 3 different IIO sensors that are present
> in particular part numbers and for some cases we have no IIO device
> at all, but do have a temperature sensor.
> 
> So if people are going to actually use this to compensate outputs
> (not sure which ones are actually temperature sensitive btw ;)
> then if those are IIO supported devices, then probably makes sense
> for this to be an IIO device.  It may make sense anyway if there
> is any chance of adding temperature compensation to the drivers
> in kernel.  I suspect the only use that would actually be made
> is as a trip point if something has gone horribly wrong, but
> I might be wrong!
> 

Correct again; in my opinion this device is unlikely to be chosen for any sort
of system-level temperature monitoring. It's really meant for contactless key/
button/switch sensing and PWM control; a subset of the devices simply offer the
internal temperature measurement to the outside world as a bonus in case it is
useful. Hence, this patch.

> Conclusion. I also don't feel strongly on this one as it kind of
> sits between IIO and hwmon, but probably ever so slightly on the
> IIO side as monitoring a sensor chip, not some other device.
> 

Agreed on all counts; I'll move this to iio. Thank you both for the discussion.

> Thanks,
> 
> Jonathan
> 
> > 
> > Guenter
> 
> 

Kind regards,
Jeff LaBundy
