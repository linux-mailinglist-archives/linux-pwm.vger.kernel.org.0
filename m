Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B243333B15
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Mar 2021 12:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhCJLJP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Mar 2021 06:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhCJLIv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Mar 2021 06:08:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9CBC061762
        for <linux-pwm@vger.kernel.org>; Wed, 10 Mar 2021 03:08:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d15so22845708wrv.5
        for <linux-pwm@vger.kernel.org>; Wed, 10 Mar 2021 03:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZRL7VpICIHdNLQCDIEw5U87ZqICmDJ3F4jDS2Mxkavk=;
        b=iAVdIFoX2sYOz9Oz0LAWiZIJ42usPLOZU2Cv53gTTtvAC6abthP+11eKGG9NwlEQ2Q
         GXsTWO5ET1RmmG6rftOgt2vtuWjfCkAbgA6TEdt8v21bNeiCMT+GgjGuaizMiYrf4NgE
         rCznMWTzJCTYDDB/ZIw6ScyNXy7+3SUNaYaDJ3rhWN71tmtUksW7u6u8KjQ5iN+4DQqr
         h0Xh67xcuiSP4lSJcLoiKU3VZHMh0onVL0o+TGcnckSRa4+xJWHGJi5yky9jTErzY4U7
         eYVE/hkomACyPuTz37nsPalIB9fhlxhO2l2hHs8HHGI7lS2i7dd2ZPpEGJkO4euzJicC
         Jyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZRL7VpICIHdNLQCDIEw5U87ZqICmDJ3F4jDS2Mxkavk=;
        b=b1XlEF5nbLbQddApb5lVzGHnLQ4FYHp3Xw8z4TwC6i5w6bb3IuOLeR5EOjFPzLJlF4
         9H4Bp76tyVZhXGtRRGmF8wGmdbsbHzlNTc5z3N4QczuptOA5N4h4AvqPB/V3pDTE2IW3
         dSOYZyBZxvD7pSCZ1eemZS6MM4+3bWiTqZYL+NKdSna9fsLSIw2sxo4AnWce9fgTyyaj
         J4OyMwSi/3Josb+qJxHVgoEBMJO+7DNM7Sa/uzweYrhhYzZaknsdqzE+VnB9yOQDEQoR
         y9cCjOiQlhZQ1ADIfUu9p8vFI+Ud/ViQE2KDpJU9lKrBr6UaJCCeGTXgpZJuW91npasT
         TMkA==
X-Gm-Message-State: AOAM532rFhIxTDQo1guFQ+5lYt9dfLloJgicY4R1WIBRhAdjCC+WTdI8
        PoRdql4T7S0Ro4KuyRzf7bdyFA==
X-Google-Smtp-Source: ABdhPJzC+XqMc01WfFzTn7uqK7JGCaqqOoS9um+sF6WwFpSlL8vRl76t9ktjXIMW0q99U5mHRNrQvQ==
X-Received: by 2002:adf:f851:: with SMTP id d17mr2893397wrq.267.1615374529542;
        Wed, 10 Mar 2021 03:08:49 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id z2sm34244531wrm.0.2021.03.10.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 03:08:49 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:08:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD, PWM and RTC due for the
 v5.13 merge window
Message-ID: <20210310110846.GL701493@dell>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
 <20210301102826.GK641347@dell>
 <20210309200520.GA4931@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309200520.GA4931@dell>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 09 Mar 2021, Lee Jones wrote:

> On Mon, 01 Mar 2021, Lee Jones wrote:
> 
> > Enjoy!
> > 
> > The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> > 
> >   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pwm-rtc-v5.13
> > 
> > for you to fetch changes up to 80629611215d1c5d52ed3cf723fd6d24a5872504:
> > 
> >   MAINTAINERS: Add entry for Netronix embedded controller (2021-03-01 10:26:17 +0000)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD, PWM and RTC due for the v5.13 merge window
> > 
> > ----------------------------------------------------------------
> > Jonathan Neuschäfer (6):
> >       dt-bindings: Add vendor prefix for Netronix, Inc.
> >       dt-bindings: mfd: Add binding for Netronix embedded controller
> >       mfd: Add base driver for Netronix embedded controller
> >       pwm: ntxec: Add driver for PWM function in Netronix EC
> >       rtc: New driver for RTC in Netronix embedded controller
> >       MAINTAINERS: Add entry for Netronix embedded controller
> > 
> >  .../devicetree/bindings/mfd/netronix,ntxec.yaml    |  76 +++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
> >  MAINTAINERS                                        |   9 +
> >  drivers/mfd/Kconfig                                |  11 +
> >  drivers/mfd/Makefile                               |   1 +
> >  drivers/mfd/ntxec.c                                | 221 +++++++++++++++++++++
> >  drivers/pwm/Kconfig                                |   8 +
> >  drivers/pwm/Makefile                               |   1 +
> >  drivers/pwm/pwm-ntxec.c                            | 184 +++++++++++++++++
> >  drivers/rtc/Kconfig                                |   8 +
> >  drivers/rtc/Makefile                               |   1 +
> >  drivers/rtc/rtc-ntxec.c                            | 145 ++++++++++++++
> >  include/linux/mfd/ntxec.h                          |  37 ++++
> >  13 files changed, 704 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> >  create mode 100644 drivers/mfd/ntxec.c
> >  create mode 100644 drivers/pwm/pwm-ntxec.c
> >  create mode 100644 drivers/rtc/rtc-ntxec.c
> >  create mode 100644 include/linux/mfd/ntxec.h
> 
> FYI, if anyone has pulled this, they should probably rebase it onto
> v5.12-rc2 and delete the v5.12-rc1 tag from their tree:
> 
>   https://lwn.net/Articles/848431/

In case you haven't pulled this in yet, I have created a new tag:

  ib-mfd-pwm-rtc-v5.13-1

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
