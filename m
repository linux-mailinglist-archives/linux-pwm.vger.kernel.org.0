Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024A92034E2
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2020 12:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFVKcs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jun 2020 06:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgFVKcs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jun 2020 06:32:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8C7C061796
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jun 2020 03:32:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so8408777wrv.9
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jun 2020 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fa4dCMlEWKxhwtDN8DZa0EBzcvxNGKcUrvu6R1FLLEY=;
        b=avt6c0ad9r5XtZvoCZsUT9m85JMd/pwM+nH7ld0naOBpha7Jkf6u2MGebUC3u2YD7V
         BDMYT+W6hKu/qxgMRTn8CHo4T/t/p+Q2j01eq0Y9+DFvdvgJESLEr2x8xDLexqabk2ir
         +nJJ3xS2rK0L4H/btmt7xfl/v8d/xT/Ehyl6qt6PI75AxA5zoQuH4BxNZi9cajCv9N8Q
         IZNJM4mQnHI3shXQNuuv2UAuIO0mocUXa1lpdH3nQh4ZlwjVC6/JjrDHP455EuaAAx5I
         A4/2mDw8nJMH3QcaFeNdsNrZIuyFYh+mUzdkNEDU05xhWWV3wTzZvIyFtvOXZx1igV3j
         Ow5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fa4dCMlEWKxhwtDN8DZa0EBzcvxNGKcUrvu6R1FLLEY=;
        b=MAc+9i7/LTkSz6Wz5W2gOFVufAAdzlDlw3jjO8z8VlebR0BM3rhoQ6c7i/KbksS+cl
         I4RzoER6Hm4h/UDVsMwlPanvBh8d6OJGHXTRrfum4dS1iCOsa0IAeliwqMCFtY1H9ITV
         Zlghj2G5NA4FloR0dRvluSm4ZqzZ0s9sF6EbCSteuNWXYBxH4Tq5hSFW7qhSLJlEaTAq
         XHhc6DxzWpTviMEdHdtQUuGA87mCYxR//ZpTtjAlDV34kgdiryMa+Zb+TQWCX/7lQqB9
         Es6UfpZUPqgH2b1fAswuCF2OYQKFas9nFkkOX+qVpU2etiNvBn+5NqRjT+rqeNWDWuqg
         PVZQ==
X-Gm-Message-State: AOAM533HG5OrDtMSEEIhsguRU9Yt0qfLg5g9NDZ/iem6s7hIFRVshlq7
        9bVljFwJSiE9VOiZrlzhD3KvaQ==
X-Google-Smtp-Source: ABdhPJwX0G/3q4eO7PMMGrf3/EarwYht0K/sahtWaIUqU5krFYZCMH4KP6m8xJqZ1qD6hZbalCZVPQ==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr5666137wrm.193.1592821966276;
        Mon, 22 Jun 2020 03:32:46 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id j6sm15810066wmb.3.2020.06.22.03.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:32:45 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:32:43 +0100
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 01/10] DT bindings in plain text format
Message-ID: <20200622103243.GT954398@dell>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
 <20200620223915.1311485-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200620223915.1311485-2-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 21 Jun 2020, Jonathan Neuschäfer wrote:

> For reference, here are the devicetree bindings in plaintext format.
> (Not for merge.)

This would be better placed inside the relevant patch(es), rather than
in a separate non-mergeable extra/superfluous patch.

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../bindings/mfd/netronix,ntxec.txt           | 58 +++++++++++++++++++
>  .../bindings/pwm/netronix,ntxec-pwm.txt       | 27 +++++++++
>  .../bindings/rtc/netronix,ntxec-rtc.txt       | 17 ++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
