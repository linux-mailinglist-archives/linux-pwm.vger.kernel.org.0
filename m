Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33151A29C
	for <lists+linux-pwm@lfdr.de>; Wed,  4 May 2022 16:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351499AbiEDOzo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 May 2022 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351522AbiEDOxk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 May 2022 10:53:40 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C3A24F18
        for <linux-pwm@vger.kernel.org>; Wed,  4 May 2022 07:50:04 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so1012582fac.9
        for <linux-pwm@vger.kernel.org>; Wed, 04 May 2022 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QeFiQ9rABQ+jsnlWFATMHbzDLVEHfjrJ5lroY7LHjX4=;
        b=H5IJ/aqZWpfdIMrj7CgLAqG/SdKN5STaYbw0mAiMe3knsYohgMViLX+4UVUoKCbjYy
         KKl4gSQqN+y8a/5bgi2RL4jv+amby146NGM7XBx8dbVn4RsofMgka5QZYxjpufREvBgx
         on8qRLmmmZDTNBS3mIpw49Zfq+rPlMGaYLZ12oBZLGWqrTnMda+uze00F4XB8lCnZ5nm
         8Tl5G8rLBtDEYPTBoB6Iw3xTervmR0L8O+zASziNoND35e/wLu2xlyoXStOr8sXjon1D
         bzVRi1ICf4OkXuJZNPr4iA9KfJYxKeZKraeRlic8bM30iN0elqk80fTjZY50t3Okqw6Y
         ZeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QeFiQ9rABQ+jsnlWFATMHbzDLVEHfjrJ5lroY7LHjX4=;
        b=52fBC3HHKjb77kntYVj9roa67fFQxnlqGOIV2OZgBHFLE2CpkRAImN85jhRIVutk1h
         4SkbSwjSO5MREx+CDSJEqx4Pmn8C3DvV3eTmyEh2w26oMi6h85SiQxyuWXOd23ggtxom
         9SQMRe2h5OBAechkp9I4TJ/d7knF9RyOhYMvlLovN5AbMDsmv9kXVuyIrx5QITEzIL6I
         bL+FwIt+2uV1/e8Terxq/nmExeMscXVLVTP7LxbfR6gPRUdl1mg3dxvvPMGkpzScAm8o
         NYd/GgkawLEktPpHuv2rrKkeNa5VtuCzsocWLEOe8KnaoDJ4VHsSAY1HL8hbeSPiWSQp
         yarQ==
X-Gm-Message-State: AOAM5309dt+dmFcEM8iobzazBAXauHZDWkYd4REY5I0rpt4D7Shjw8Hp
        cmNlNDg8jts5wQQK/4yTOhLXbQ==
X-Google-Smtp-Source: ABdhPJwNJvAJDal6JEEM3A076oA8yC/XXroNGViJX0ZDvZfYyeiTcwTHDhaQwkREcnPpG+p4quwFKw==
X-Received: by 2002:a05:6870:d254:b0:e9:5d17:9e35 with SMTP id h20-20020a056870d25400b000e95d179e35mr3712035oac.154.1651675803423;
        Wed, 04 May 2022 07:50:03 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v15-20020a05683018cf00b0060603221251sm5158169ote.33.2022.05.04.07.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 07:50:02 -0700 (PDT)
Date:   Wed, 4 May 2022 07:51:46 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <YnKTAvQc6eDxTl14@ripper>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
 <20220303214300.59468-2-bjorn.andersson@linaro.org>
 <20220504073009.GC8204@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504073009.GC8204@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed 04 May 00:30 PDT 2022, Pavel Machek wrote:

> Hi!
> 
> > +/sys/class/leds/<led>/hw_pattern
> > +--------------------------------
> > +
> > +Specify a hardware pattern for a Qualcomm LPG LED.
> > +
> > +The pattern is a series of brightness and hold-time pairs, with the hold-time
> > +expressed in milliseconds. The hold time is a property of the pattern and must
> > +therefor be identical for each element in the pattern (except for the pauses
> > +described below).
> 
> therefore?
> 

Yes

> > +Simple pattern::
> > +
> > +    "255 500 0 500"
> > +
> > +        ^
> > +        |
> > +    255 +----+    +----+
> > +        |    |    |    |      ...
> > +      0 |    +----+    +----
> > +        +---------------------->
> > +        0    5   10   15     time (100ms)
> > +
> > +The LPG supports specifying a longer hold-time for the first and last element
> > +in the pattern, the so called "low pause" and "high pause".
> 
> Please see
> Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt . This
> should really be compatible.
> 

Unfortunately the LPG hardware only supports fixed duration (except for
the ability to hold/extend the first and last duration in the pattern)
and it also does not support gradual transition between the brightness
levels.

As such the pattern sequence provided to hw_pattern looks to be the
smae, but I don't see that it can be made compatible.

> Can I get either patch to disable pattern infrastructure for now or to
> get it compatible?
> 

I'd be happy to get this updated to your liking, but this was one of the
drivers we discussed when we introduced the pattern trigger and led to
the conclusion that we need the ability to do hw-specific patterns.

As such this document provides the hardware specific documentation, as
we describe under "hw_pattern" in
Documentation/ABI/testing/sysfs-class-led-trigger-pattern.

Please advice on what you would like me to do.

Regards,
Bjorn
