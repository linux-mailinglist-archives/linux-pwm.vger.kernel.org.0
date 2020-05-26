Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04F1E2333
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgEZNmG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 09:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgEZNmF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 09:42:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB64DC03E96D;
        Tue, 26 May 2020 06:42:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id i17so198510pli.13;
        Tue, 26 May 2020 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZK3/SNQt3TrHZpjfApxGGKEtvPPIQXrgwzz3895qfM=;
        b=j+G5UZ3zNq0MLdgpa6fl0zMrztS8RamkTd/G12R4uGo9gO6gikSiBBWBrHNaPtE1I/
         xGNyZetYoCrjujqyiXHejdzHY+6R90MnZFlH59TDTGwqLDLT4qPULL8B/zdTo00jmGEm
         y671dNLbk+AREWEs1i5kin5FgdXEO08XXASMuPppnMkR4kmEe3sn4q5q4zC7dyJIUKTc
         699QP81+jHswHq+xvb/meVB4wCKzc1xKV/nNQGho8NEtjwCGisPGKJbr4F3lE634Dxoo
         mAt1XgPXuRlGS5xFrq//gQbs5i+oQOHjxPwY/oxEngwSmgKuSt4iwHYESNHxPYw2o55V
         wsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZK3/SNQt3TrHZpjfApxGGKEtvPPIQXrgwzz3895qfM=;
        b=r3tVuY0M9ppUlt73pe+dOk61uWaLSWkRwiZ8Jnt86LPunkBSy6LP9cbhVxXJQqU1bk
         T9PKQZGsqUV1dWWf2jh9J2BRDNzo9wBidrQNH5LuVTs+8A/eoUwmG7HZWdZ/iXdHzLu4
         ZrEZ96aviyywSAkvLA0jxh6C9usOFKicpW/3LzjroVmidZOGtKncvs7JemriUT5T/p+d
         UXKqzZB1Gm8RIZppWzdA5cHxu1q+ENLEDzHaK56riz036e+JkjzVxzaD1oM4farlw5Pw
         BkTrsq3h0M8HfMZ8xeQsed86OVATByF9laAcNTcZ9Xm6ux8bbmjJLM1yukJpPcad1OyU
         F+Bw==
X-Gm-Message-State: AOAM531C9ZGlgpII334BLBI4cgcYKyPSX8IJj1eOsRUnG3sxYZprT54H
        hS1F8zvDxQTa3ETVSNJVXYI=
X-Google-Smtp-Source: ABdhPJxLTNIM6FAl2B+KrsXvY6EQWED8Nx4JzuJrtGmGp51UH2Du4f798QaJ/xzSY/CJMBWnvV0WEg==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1mr1111991plb.314.1590500525352;
        Tue, 26 May 2020 06:42:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s206sm15423492pfc.31.2020.05.26.06.42.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 06:42:04 -0700 (PDT)
Date:   Tue, 26 May 2020 06:42:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "kamil@wypas.org" <kamil@wypas.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Bibek Basu <bbasu@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Message-ID: <20200526134203.GA51584@roeck-us.net>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
 <53619c02-8c0f-3eec-cccc-16e779b8c425@roeck-us.net>
 <BYAPR12MB30145EC4578F64EAD1233357ADB00@BYAPR12MB3014.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB30145EC4578F64EAD1233357ADB00@BYAPR12MB3014.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, May 26, 2020 at 12:08:14PM +0000, Sandipan Patra wrote:
> Hi,
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Tuesday, May 26, 2020 5:12 PM
> > To: Sandipan Patra <spatra@nvidia.com>; Thierry Reding
> > <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; u.kleine-
> > koenig@pengutronix.de; kamil@wypas.org; jdelvare@suse.com;
> > robh+dt@kernel.org
> > Cc: Bibek Basu <bbasu@nvidia.com>; Bitan Biswas <bbiswas@nvidia.com>;
> > linux-pwm@vger.kernel.org; linux-hwmon@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
> > module support
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 5/25/20 10:06 PM, Sandipan Patra wrote:
> > > This change has 2 parts:
> > > 1. Add support for profiles mode settings.
> > >     This allows different fan settings for trip point temp/hyst/pwm.
> > >     T194 has multiple fan-profiles support.
> > >
> > > 2. Add pwm-fan remove support. This is essential since the config is
> > >     tristate capable.
> > >
> > > Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> > > ---
> > >  drivers/hwmon/pwm-fan.c | 112
> > > ++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 100 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
> > > 30b7b3e..26db589 100644
> > > --- a/drivers/hwmon/pwm-fan.c
> > > +++ b/drivers/hwmon/pwm-fan.c
> > 
> > [ ... ]
> > 
> > >
> > > +static int pwm_fan_remove(struct platform_device *pdev) {
> > > +     struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> > > +     struct pwm_args args;
> > > +
> > > +     if (!ctx)
> > > +             return -EINVAL;
> > > +
> > > +     if (IS_ENABLED(CONFIG_THERMAL))
> > > +             thermal_cooling_device_unregister(ctx->cdev);
> > > +
> > > +     pwm_get_args(ctx->pwm, &args);
> > > +     pwm_config(ctx->pwm, 0, args.period);
> > > +     pwm_disable(ctx->pwm);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > 
> > I don't think you actually tested this. I would suggest to make yourself familiar
> > with 'devm' functions and their use, and then resubmit.
> > 
> 
> Thanks Guenter.
> I missed to mention about devm while unregistering the cooling device.
> That would definitely cause a mistake in code. I am noting it for further patch.
> 
For that part, I am extremely surprised that it is not handled by the
thermal subsystem. Does each thermal driver need this kind of code ?

> For a better clarity, I will push next version of this patch to handle only multiple profiles support.
> "remove fan module" will be supported by a separate patch altogether.
> 

I asked you to look into "devm" functionality. I ask you again.
If you still think that a remove function is needed, I will require
detailed reasoning. Please be prepared to explain why devm functions
do not work for this driver.

Guenter
