Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6569AFB4
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Feb 2023 16:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjBQPmD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Feb 2023 10:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjBQPmB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Feb 2023 10:42:01 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE6371C90
        for <linux-pwm@vger.kernel.org>; Fri, 17 Feb 2023 07:41:59 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-171873034c3so1473875fac.12
        for <linux-pwm@vger.kernel.org>; Fri, 17 Feb 2023 07:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnUShv/qsWAUV9F/d3j8b7I/+SKaHHXb+u6O+HEKzls=;
        b=RbtqWzn7xoNQQwtVZXN5NjxBw7XqTvqMjQT7A9Uy85lcZnHZTJJIS0VeNTAYV4PTNF
         1jy4uQI3G5QK7FjP5H+BEpZvmqcYMpgCqO8N5CxMwA84b6Fpj5Aky6BSdMe8P0+d9AHC
         GtVScTJLIGXlHhZn0Fq0bMZD7CW3hORR2UWsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnUShv/qsWAUV9F/d3j8b7I/+SKaHHXb+u6O+HEKzls=;
        b=tLBD0igcNdN7XgIh3SIzu6DBR8okct+8sSOwRYjesr8VCGYhA84YpqhG8lYZXh6tfG
         jbPc880f12oPE5Co7NR3YkK2m6ko11Sk8MKU6UheyeQ5YtZPwFdcWvmIqUgVg59u3Tni
         ItljIkySKmTlwnQAXK8k1rxxdL+31wBXchH6VNTuN8ZFqM34+2q+iN3OA+nFmeRB9HOY
         numCMZrGbvvWZPdQUfulVNiI5CRTAvP7egr/Qqtf/jse7JCB1BBQyYV57SPbixnO3z7T
         yJAsY83iCubPk9Vw3j4kWW5T6QW6BkjSaC4pyrDdD+377EqqAcqKHJ1wGifE5qYB/0BE
         oVbQ==
X-Gm-Message-State: AO0yUKWIdQNj76wD/VDquN5QiCbOtLJVxFBXYoaxID8Ua8LhXjKJ+oxP
        gwnddhUD4n84Zy/pbkfhKUdh1wx+q7k0uE+YsRUlGg==
X-Google-Smtp-Source: AK7set/ymXnMI2GPHlf5yoehFffTnCXPRiGP7VIPZAU9KRFd3YQ5Uvtgo5Ia9dmc4tdJ/hSQt0dxaws/S6xTXGW7xU8=
X-Received: by 2002:a05:6871:b12:b0:16e:5f2d:2e55 with SMTP id
 fq18-20020a0568710b1200b0016e5f2d2e55mr463693oab.9.1676648518379; Fri, 17 Feb
 2023 07:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20230217145731.3018148-1-angelo@amarulasolutions.com> <Y++e6IMusukWJNw2@kroah.com>
In-Reply-To: <Y++e6IMusukWJNw2@kroah.com>
From:   Angelo Compagnucci <angelo@amarulasolutions.com>
Date:   Fri, 17 Feb 2023 16:41:22 +0100
Message-ID: <CA+_SqVaTNuco-7re=FQxNiowtWvNgokkXFD3Kmo5U9AFMdz13g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Feb 17, 2023 at 4:36 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 17, 2023 at 03:57:28PM +0100, Angelo Compagnucci wrote:
> > This patch adds a simple driver to control servo motor position via
> > PWM signal.
> > The driver allows to set the angle from userspace, while min/max
> > positions duty cycle and the motor degrees aperture are defined in
> > the dts.
> >
> > Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> > ---
> >  MAINTAINERS              |   6 ++
> >  drivers/misc/Kconfig     |  11 +++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
>
> You add sysfs files but do not document them in Documentation/ABI/ which
> is required.  Please do so in your next version of this patch.

https://patchwork.ozlabs.org/project/linux-pwm/patch/20230217145731.3018148-2-angelo@amarulasolutions.com/

This patch [2/3] should do what you're asking.

>
> > +static ssize_t degrees_show(struct device *dev, struct device_attribute *attr,
> > +                       char *buf)
> > +{
> > +     struct servo_pwm_data *data = dev_get_drvdata(dev);
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%u\n", data->degrees);
>
> sysfs_emit() please.

Will do.

>
> thanks,
>
> greg k-h



-- 

Angelo Compagnucci

Software Engineer

angelo@amarulasolutions.com
__________________________________
Amarula Solutions SRL

Via le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 (0)42 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

[`as] https://www.amarulasolutions.com|
