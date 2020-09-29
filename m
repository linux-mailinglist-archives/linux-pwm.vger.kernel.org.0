Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7378127D62B
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgI2Swg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Sep 2020 14:52:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38576 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2Swg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Sep 2020 14:52:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id 26so6626392ois.5;
        Tue, 29 Sep 2020 11:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=de1WNQyCl17XyZzshE+x6Zb0PznuOMDS3LUbbcC+7Ok=;
        b=DPuHNhkQ7NFdqMJZqqIhj2LggVWLe6lzP/W+wVuuARD7+PE5VkI7mnI5V5TiTXmao5
         xZRroFTabZ/eojREZplVYFwcIffcgnvwiXQT6tCvt++CuCqNczwnOcq0668E6VMoRNZf
         XDwfGpL1TszPpY7g0MtU1+S+b1tBUQgqU2rWZ/bR8eMM/b0MX56mRFY/TSW8sXLkS93v
         tTmp7+Y5a9+IT6rGFInq5PADAgfwAia6x3I//VFW+AepJErjGaQgj3VZR2jU4M/ikNID
         jSxp4/0Zc34bS+AqqclfEGSKUvrDEThCZbCYB34+GcdITPjqwkdPqQRHAgvh/EBS8TrT
         V/zA==
X-Gm-Message-State: AOAM531ekTSx9wMxST5olZ/WkKj8Sb+yr5tFbtFDoY9JnCUyFzL+yFQN
        CAxjSNgEEh8KU6GVd7pQNQ==
X-Google-Smtp-Source: ABdhPJz65s/a+7zuhHF4YXSHQEw6A+onPxGlBGfWNeac2wigD9ZxclA3WtCnFnaZXHKWWF/obQo9yA==
X-Received: by 2002:aca:1806:: with SMTP id h6mr3581496oih.88.1601405554017;
        Tue, 29 Sep 2020 11:52:34 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r21sm1186493oie.15.2020.09.29.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:52:33 -0700 (PDT)
Received: (nullmailer pid 954801 invoked by uid 1000);
        Tue, 29 Sep 2020 18:52:31 -0000
Date:   Tue, 29 Sep 2020 13:52:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Stephan Gerhold <stephan@gerhold.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        allen <allen.chen@ite.com.tw>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-rtc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pwm@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/7] dt-bindings: mfd: Add binding for Netronix
 embedded controller
Message-ID: <20200929185231.GA954745@bogus>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924192455.2484005-3-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 24 Sep 2020 21:24:50 +0200, Jonathan Neuschäfer wrote:
> This EC is found in e-book readers of multiple brands (e.g. Kobo,
> Tolino), and is typically implemented as a TI MSP430 microcontroller.
> 
> It controls different functions of the system, such as power on/off,
> RTC, PWM for the backlight. The exact functionality provided can vary
> between boards.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v3:
> - Remove binding in text form patch description again
> - Add additionalProperties: false
> - Remove interrupt-controller property from example
> - Merge pwm/rtc nodes into main node
> 
> v2:
> - https://lore.kernel.org/lkml/20200905133230.1014581-3-j.neuschaefer@gmx.net/
> - Add the plaintext DT binding for comparison
> ---
>  .../bindings/mfd/netronix,ntxec.yaml          | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
