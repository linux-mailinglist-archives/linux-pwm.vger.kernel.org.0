Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D351DA3B
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442105AbiEFOQd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442114AbiEFOQb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 10:16:31 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E5B68317;
        Fri,  6 May 2022 07:12:47 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso7317187fac.1;
        Fri, 06 May 2022 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Lo4c+Tb31SG9HLAGVohnQiTM/YzpkiJ7seZfD5EoiYo=;
        b=qDp6gfYcQmgo1gnaVMH/N5tlhNPiDBPHWdGjO/hC1SzU6XUqTIjAHFctihxM1cWFh0
         +otoolosD99PtRKTG14WTlY8xSW1S8NhyrtTVGIfYKrR93hmfCuOOCpoSKI2cTn5arr+
         LAOWtIT1BaFGeUCONgTZZfIfYzf134K2HgsYPBx7IFW2mN0EUc33kIi8GYyy9MPPJTYA
         fTIFQg0gQR9RsrhiRVhoLe3ZA/dLXeKnephBm4gb2QE1bC2R5/BwgYtIrRCqJHZv+AFS
         IGDo6HkCboUvyJE8Zyefhos2HXGI6XHEc3T05MY/0OW2QLhhxOs5AlKlvQLrHu5Oloht
         MCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Lo4c+Tb31SG9HLAGVohnQiTM/YzpkiJ7seZfD5EoiYo=;
        b=0GjRyjOBQtAQnBmnjatpQBiHz9XUyBgzPrPg/1K0IlNb5cB6sY6JOFN0Njm6LNKxbm
         jPd9qmM1mCWCwF3CoSSCZXolb+jec8sNlBkKslAjewkMbrQjopx+3sC84l9zKyooHYwT
         jeFHg37mZII1pJg1tl9yy7wQprDCwP8E/qwYHwO9bwHrSpNBg/oDc6bMf6aVoSlYAaxe
         s9AEb7VqI6/l902qPE3HOMnB7ZNTel/KzN5EbwWBqhbJ/TPjGsJA6MCZIOUOrYhe9YfS
         9Z1XDu4KnulDkYZ3Xj22YWsrO+/5xSsA1LzZK7bn21gLLFnzNRHfe5CDe2s4lfEQ9XYc
         XIRw==
X-Gm-Message-State: AOAM531fjiEY4QltXKXLPwwoQ4SXw/egEcf8ZS61p3Yv3SRa7JzN37Wb
        i73XmNmpQDx6z4ivp6sTs+0=
X-Google-Smtp-Source: ABdhPJw1JiiDEb65D3KwCS+YMS8Wb9EyPdhGOwihHm0JftNyfJebc2BZ1w4OLna0igjk/btuxrDyuA==
X-Received: by 2002:a05:6870:a54b:b0:ec:e21b:111e with SMTP id p11-20020a056870a54b00b000ece21b111emr1362337oal.229.1651846367106;
        Fri, 06 May 2022 07:12:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k2-20020a056870570200b000edae17a8cesm1658778oap.3.2022.05.06.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 07:12:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 6 May 2022 07:12:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan:
 dynamically switch regulator
Message-ID: <20220506141244.GA2990519@roeck-us.net>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
 <2371611.jE0xQCEvom@steina-w>
 <20220506102301.my2tsn7kfldwqtll@pengutronix.de>
 <3417990.V25eIC5XRa@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3417990.V25eIC5XRa@steina-w>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 06, 2022 at 02:23:11PM +0200, Alexander Stein wrote:
> Hello Uwe,
> 
> Am Freitag, 6. Mai 2022, 12:23:01 CEST schrieb Uwe Kleine-König:
> > * PGP Signed by an unknown key
> > 
> > On Fri, May 06, 2022 at 10:35:21AM +0200, Alexander Stein wrote:
> > > Am Freitag, 6. Mai 2022, 10:20:01 CEST schrieb Uwe Kleine-König:
> > > > > Old Signed by an unknown key
> > > > 
> > > > Hello,
> > > > 
> > > > On Fri, May 06, 2022 at 09:15:55AM +0200, Alexander Stein wrote:
> > > > > Am Freitag, 6. Mai 2022, 00:00:37 CEST schrieb Guenter Roeck:
> > > > > > On Wed, May 04, 2022 at 02:45:51PM +0200, Alexander Stein wrote:
> > > > > > > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > > > > > > 
> > > > > > > A pwm value equal to zero is meant to switch off the pwm
> > > > > > > hence also switching off the fan. Currently the optional
> > > > > > > regulator is always on. When using this driver on boards
> > > > > > > with an inverted pwm signal polarity this can cause running
> > > > > > > the fan at maximum speed when setting pwm to zero.
> > > > > > 
> > > > > > The appropriate solution in this case would be to tell the
> > > > > > software that the pwm is inverted. Turning off the regulator
> > > > > > in that situation is a bad idea since setting the pwm value to
> > > > > > 1 would set it to almost full speed. That does not really make
> > > > > > sense.
> > > > > 
> > > > > The pwm-fan driver is already configured for inverted PWM (ommited
> > > > > some
> > > > > properties for shortness):
> > > > > fan0: pwm-fan {
> > > > > 
> > > > > 	compatible = "pwm-fan";
> > > > > 	fan-supply = <&reg_pwm_fan>;
> > > > > 	pwms = <&pwm3 0 40000 PWM_POLARITY_INVERTED>;
> > > > > 	cooling-levels = <0 32 64 128 196 240>;
> > > > > 
> > > > > [...]
> > > > > };
> > > > > 
> > > > > The problem here is that the pwm-fan driver currently enables the
> > > > > regulator
> > > > > unconditionally, but the PWM only when the fan is enabled, refer to
> > > > > __set_pwm(). This results in a fan at full speed when pwm-fan is idle,
> > > > > as
> > > > > pwm state is not enabled.
> > > > 
> > > > Which PWM driver are you using?
> > > 
> > > It's pwm-imx27 on a imx8mp based board.
> > 
> > This is one of the known offenders.
> > 
> > > > There is an implicit assumption in some PWM consumers that a disabled
> > > > PWM emits the inactive level. However not all PWMs do this. Is this such
> > > > a case?
> > > 
> > > Oh, I was not aware of that assumption. As far I can tell, this assumption
> > > might actually be violated in pwm-imx27.
> > 
> > The pwm-imx27 driver is a known offender.
> > 
> > IMHO the problem is that there is no properly documented definition what
> > "disabled" means for a PWM. I had some discussions about that in the
> > past with Thierry, but with no agreement. Either we have do define that
> > the output of a PWM is undefined when it's disabled (then the pwm-fan
> > needs fixing) or the output must be the inactive level (then the
> > pwm-imx27 must be fixed to not unset the EN bit when configured for an
> > inverted polarity). In my eyes the first is the sensible thing to do.
> > 
> > See
> > https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf43@pengutroni
> > x.de/ for one of the previous discussions.
> 
> Thanks for the link. I took a look into it. I'm on your side here, IMHO 
> pwm_disable() implies that the PWM perphery is disabled, including any clocks 
> or powerdomain. This is what pwm-imx27 actually does. This might lead to a, 
> probably platform dependent, (undefined?) state of the PWM output pin.
> This implies it is not possible to disable the PWM periphery for inverted 
> signals, if the disabled state is not the inactive level. You know all about 
> it already.
> Then again from pwm-fan side I want be able to disable the FAN, turning of 
> regulator and PWM, so powersaving is possible. That's what this patch is 
> about. This is similar also what pwm_bl is doing.
> Independent of the exact semantics, it makes sense to disable the regulator in 
> pwm-fan as well when the fan shall be disabled.
> 

There are fans which never stop if pwm==0, such as some CPU fans. I don't
think it is a good idea to force those off by turning off their power. The
problem in the driver is that it treats pwm==0 as "disable pwm", not as
"set pwm output to 0", Part of the probem may be that the ABI doesn't have
a good representation for "disable pwm output", which is what is really
wanted/needed here. I think the best solution would be to implement and
use pwmX_enable, and define in the driver documentation that pwm1_enable=0
reflects "disable pwm" and pwm1_enable=1 reflects "emable manual pwm
control:. At the same time, stop associating "pwm==0" with "disable pwm",
but just set the pwm output value to 0.

Guenter

> > > If state->enabled==false then the EN Bit in PWMCR is not set which most
> > > probably renders the output polarity in POUTC as inactive.
> > 
> > It drives the output to 0 which in the inverted polarity case is a 100%
> > relative duty.
> 
> Thanks for confirmation, this matches my observations.
> 
> Best regards,
> Alexander
> 
> 
> 
