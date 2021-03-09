Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A04E332F92
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Mar 2021 21:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhCIUF4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Mar 2021 15:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhCIUFY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Mar 2021 15:05:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C782C061760
        for <linux-pwm@vger.kernel.org>; Tue,  9 Mar 2021 12:05:24 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso7820119wma.4
        for <linux-pwm@vger.kernel.org>; Tue, 09 Mar 2021 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XGjP1IwYY9V5MTdu5gz2bGCMoHloL2HLzkBo8xqKCcU=;
        b=xffYs7vzhK4DnRSpTaSp+Ec//mT5EfBuoIpR9TBygBXd4AVAxF82/Fgt0GRuFuiCkw
         hCCxPhhv5u6IrdEV/DSl05apgw5Le+1xwYxkVYy7jMINaAo4S7lIKcnWmStllOApmD6n
         IibsYpnUwstk3fEKwphtWzG5H+xHg/R+8cThq6k3biaiGf+/DKKIOLhlaTFsrVzKttzp
         BNDdCaPRxzYad7e37L3WUDA3T12xWfzs61ENy2Xm2jbUP4xSUWMTGBkL98b5Wd8ZCLrH
         tBKOowGx5stqetns4YSjuQ/reyAKDmaVxHe4Lg8qA+JWI3TUpGK5FTiKAfmqbc6rLhqS
         JyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XGjP1IwYY9V5MTdu5gz2bGCMoHloL2HLzkBo8xqKCcU=;
        b=frDYaOw2dnn8I1mvpoHhcFJC+2v7LAiLX8SPeAxPheEKiveoE4862RO12PfD0LKWJB
         d9S/Ke5/2nUP5Pzqdx3mL2OdETI0ruRiMdCdfoaNFyCBm2k80Uv+caRrqC6pMwypqSCW
         Z9+0eamgn59N4XAvox5c+9b0kfb38GTmhggUnXOQ/4CKYyS64ehiE3OV+fYUoLO7tRfQ
         hsR8Q9irUtQiaeG0Y2wA1OaO54gcD/DoabMip7i28X8ktTLNEnKg7bVympPURzqzZBGI
         WtDz34nMTAOLOEMWhoqAMtmGM9mm1LZaW736aw1NdeOPXQhKlA/BML5A9zTaBuV1gGjx
         xk0g==
X-Gm-Message-State: AOAM532lcQKRRERErNcUR2vnHbpzZVxaIzE+X/pmfMHbBwWH02op8EvT
        ijr8+R3SND9f7tgKAg+6BD3GGg==
X-Google-Smtp-Source: ABdhPJxlGaFCDMWbfFV5Pr/WWx8z0K7o5uAIGkLbbZ+Fg98b+aBlnMrftxj9+78TWRIlh0DueAOXyg==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr5821993wmq.140.1615320323081;
        Tue, 09 Mar 2021 12:05:23 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id p10sm26424631wrw.33.2021.03.09.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 12:05:22 -0800 (PST)
Date:   Tue, 9 Mar 2021 20:05:20 +0000
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
Message-ID: <20210309200520.GA4931@dell>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
 <20210301102826.GK641347@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301102826.GK641347@dell>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 01 Mar 2021, Lee Jones wrote:

> Enjoy!
> 
> The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> 
>   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pwm-rtc-v5.13
> 
> for you to fetch changes up to 80629611215d1c5d52ed3cf723fd6d24a5872504:
> 
>   MAINTAINERS: Add entry for Netronix embedded controller (2021-03-01 10:26:17 +0000)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, PWM and RTC due for the v5.13 merge window
> 
> ----------------------------------------------------------------
> Jonathan Neuschäfer (6):
>       dt-bindings: Add vendor prefix for Netronix, Inc.
>       dt-bindings: mfd: Add binding for Netronix embedded controller
>       mfd: Add base driver for Netronix embedded controller
>       pwm: ntxec: Add driver for PWM function in Netronix EC
>       rtc: New driver for RTC in Netronix embedded controller
>       MAINTAINERS: Add entry for Netronix embedded controller
> 
>  .../devicetree/bindings/mfd/netronix,ntxec.yaml    |  76 +++++++
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  MAINTAINERS                                        |   9 +
>  drivers/mfd/Kconfig                                |  11 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/ntxec.c                                | 221 +++++++++++++++++++++
>  drivers/pwm/Kconfig                                |   8 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-ntxec.c                            | 184 +++++++++++++++++
>  drivers/rtc/Kconfig                                |   8 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-ntxec.c                            | 145 ++++++++++++++
>  include/linux/mfd/ntxec.h                          |  37 ++++
>  13 files changed, 704 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
>  create mode 100644 drivers/mfd/ntxec.c
>  create mode 100644 drivers/pwm/pwm-ntxec.c
>  create mode 100644 drivers/rtc/rtc-ntxec.c
>  create mode 100644 include/linux/mfd/ntxec.h

FYI, if anyone has pulled this, they should probably rebase it onto
v5.12-rc2 and delete the v5.12-rc1 tag from their tree:

  https://lwn.net/Articles/848431/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
