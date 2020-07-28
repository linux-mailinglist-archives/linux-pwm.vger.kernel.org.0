Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4323081F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgG1Kv1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgG1Kv0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 06:51:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6458BC061794
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 03:51:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so17812252wrh.3
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LzOc135fINoaOyyxwY4N4SP5+/4WZUgI3XQn3ZBQrDA=;
        b=vDkkyU+5XaTOEmRQYW0CYyR4mlMX1mtnZDopRBrR16WWZAymHLppooL3WbRsemUOlF
         7JAG9CCFFBkNo1ck8oAFsHnGGCFpddbJZI4FvPPe/5vgXZIxS7pdXreW0pAmXl4fefVk
         uemgsa2HPMS2pgMJSiY5gsoUuJ22Uc9FFMkDS50upr4Y5t/bruJsOn96uJd/Xej/4+wJ
         r3z4kV7L9g728y5x+aNOBIj6JRK/2vA+lFuGJCCKMNnmmCY7vsMSYcIdJpOO1Lj/2Nk6
         unQbNqxObw8nTIlx8MnFNeMtUIVxddRTqJvHuyaU1npKp/UQnousCC6p6CUsu9YCp0JA
         N8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LzOc135fINoaOyyxwY4N4SP5+/4WZUgI3XQn3ZBQrDA=;
        b=m8OkW92XYjK6Lt65UstIjmFzxmLnY+4vVoem53xlRWFKPHay+5ujrtThaUAnDsJGEL
         3llx24FATuYn5WEJidfLboLUr5vbT2eVOAWYMoQiHLBngMOwCUrbAO9kHFAtll31+PQa
         zFsU1i2kN0O44uUIRW/G5akTyyKJpp0QM7j2dNonlERVW3leJewQ65OAlQsVcwGgcyaB
         491lDGdNNyefWhY/ou6h7mX1SzqN9w3QQgXhKvWHZNC5omm5TTilSdph11mmiJLqBONg
         3ogXkOjiwQqOH9XaLLciZvAF6m5KyGaL/QHQR9E0uIBxh6Pwjd9aIZORMkX1OMaTqdMd
         xXXw==
X-Gm-Message-State: AOAM530hwqYoU9bQ6src2GbFzL8WzH18FhtBx6VZR6W/X5i7akWccRHd
        zYB47155jHXxeOMvErLgLdHuFA==
X-Google-Smtp-Source: ABdhPJyXBEeI4zvLVf/tRWpqopuL2jSNCu4L9LZnKQaZP1mCTaWKou6fjAB0L+zVU5NonfUp5NxoSw==
X-Received: by 2002:a5d:4a90:: with SMTP id o16mr23540803wrq.87.1595933483925;
        Tue, 28 Jul 2020 03:51:23 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id y189sm4194196wmd.27.2020.07.28.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:51:23 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:51:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200728105121.GG2419169@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-7-michael@walle.cc>
 <20200728074352.ckyfso5zwsfgupjx@pengutronix.de>
 <58b53cacc5289f17f669159beeeada03@walle.cc>
 <20200728094720.x6pucwxsfwvz6nvv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200728094720.x6pucwxsfwvz6nvv@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 28 Jul 2020, Uwe Kleine-König wrote:
> On Tue, Jul 28, 2020 at 10:21:22AM +0200, Michael Walle wrote:
> > Am 2020-07-28 09:43, schrieb Uwe Kleine-König:
> > > On Sun, Jul 26, 2020 at 01:18:27AM +0200, Michael Walle wrote:
> > > > +static int sl28cpld_pwm_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct sl28cpld_pwm *priv;
> > > > +	struct pwm_chip *chip;
> > > > +	int ret;
> > > > +
> > > > +	if (!pdev->dev.parent)
> > > > +		return -ENODEV;
> > > > +
> > > > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > > > +	if (!priv)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > > +	if (!priv->regmap)
> > > 
> > > Error message here?
> > 
> > This shouldn't really happen and I put it into the same category
> > as the two above and report no error. But I can add it.
> 
> For kzalloc it is right to not emit an error because a failing kzalloc
> is already loud on its own. I missed the first error path, that should
> get a message, too.
> 
> > Generally, it looked to me that more and more drivers don't
> > really report errors anymore, but just return with an -EWHATEVER.
> > So if someone can shed some light here, I'm all ears.
> 
> IMHO it's wrong not to add error messages. At one point in time it will
> fail and then you're happy if you don't have to add printks all over the
> place first to debug that.

Error messages should only be omitted for -ENOMEM and if something is
already being printed out, ideally by the sub-system API.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
