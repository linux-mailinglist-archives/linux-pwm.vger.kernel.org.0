Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBECE327C1E
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 11:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhCAK31 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 05:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhCAK3X (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 05:29:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E199C06178A
        for <linux-pwm@vger.kernel.org>; Mon,  1 Mar 2021 02:28:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i9so12701560wml.0
        for <linux-pwm@vger.kernel.org>; Mon, 01 Mar 2021 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fEoK6sj6Vx64waeuaFZ7WzuyFiOIkvvvkXXAhuHJ6n0=;
        b=CInzuD9yHUVVP/8k0kdY+Ubp/d8ztYs2RdGpZXm/Pov3aldb+lHMFxv+ESoM7LlBKr
         bDf1GmA541rYTR7nYa21exMDiAbImp0KPPpLF5o/W3/faYxlIBTSvU89DPvH8kFsuEj4
         caTrnXyj4Ju4lGk9y4Hzl5dpwR5izYha4XeLmVa0SWBR9RhU+SyMjM1wn6PW31IgIgZY
         yVAoxrbskT/FMRHpyLLmacnTZkmCEUr089CoI9+SwvfI8WF4ssYWPSYzdSjNpsK6KAti
         d2Ku44Ce3yXJ0yXSQQkMzDHLUoHVJZapYN6xgunsSVdHMLL/TaZVw5n2w9fQA72LbJiD
         2vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fEoK6sj6Vx64waeuaFZ7WzuyFiOIkvvvkXXAhuHJ6n0=;
        b=trOLlznp4yQO6oOzZ/A5/Y1b1UCTCatrK128kQST9HUvh4gYeeLxVXmbQLmINoKrOv
         23KZ6HPRufc5YYoFSCyzOXzduwAscpz9L3G2rVhdOMEDSDXGS2xhM7axUYz1pGDbm3md
         FV/Hyi654GgrC3xg0UxbFCnd8jaJ9IAopdcVRxJmS/g4qiyf4x1rvxfzMvqOkCeLoefG
         ebb7J6SA3Q/dMpo6xqnlr/3nyAImdp9mCzzjqyyljKASOgFHjZTcXmJWp/mblGBzhG8Z
         XfQ23cTJyphmghK10ooXq3Ht0vkpZzw8082SIajCv/GHt7O98udJ0Clx1YvMSMcvSI1m
         GeSg==
X-Gm-Message-State: AOAM533h9pYzJvs0pCDfX/LKN30wIpFTUDYMMJOkN4aIV6Egv9zZfIgG
        uv5kuYFOHLqz0Ek3U8h607qPrw==
X-Google-Smtp-Source: ABdhPJzL/2dtfbTMhhuvxXFnJKC6c5bht+hdeQ08HlMI2CLPQiH+mxyTR+jtNBSYV/UdicarWzgLJw==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr15225989wmj.182.1614594509069;
        Mon, 01 Mar 2021 02:28:29 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id o9sm22331888wmc.8.2021.03.01.02.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 02:28:28 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:28:26 +0000
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
Subject: [GIT PULL] Immutable branch between MFD, PWM and RTC due for the
 v5.13 merge window
Message-ID: <20210301102826.GK641347@dell>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Enjoy!

The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pwm-rtc-v5.13

for you to fetch changes up to 80629611215d1c5d52ed3cf723fd6d24a5872504:

  MAINTAINERS: Add entry for Netronix embedded controller (2021-03-01 10:26:17 +0000)

----------------------------------------------------------------
Immutable branch between MFD, PWM and RTC due for the v5.13 merge window

----------------------------------------------------------------
Jonathan Neuschäfer (6):
      dt-bindings: Add vendor prefix for Netronix, Inc.
      dt-bindings: mfd: Add binding for Netronix embedded controller
      mfd: Add base driver for Netronix embedded controller
      pwm: ntxec: Add driver for PWM function in Netronix EC
      rtc: New driver for RTC in Netronix embedded controller
      MAINTAINERS: Add entry for Netronix embedded controller

 .../devicetree/bindings/mfd/netronix,ntxec.yaml    |  76 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   9 +
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/ntxec.c                                | 221 +++++++++++++++++++++
 drivers/pwm/Kconfig                                |   8 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-ntxec.c                            | 184 +++++++++++++++++
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-ntxec.c                            | 145 ++++++++++++++
 include/linux/mfd/ntxec.h                          |  37 ++++
 13 files changed, 704 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
