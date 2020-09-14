Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79741269940
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Sep 2020 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgINWxk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Sep 2020 18:53:40 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38038 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINWxi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2020 18:53:38 -0400
Received: by mail-il1-f193.google.com with SMTP id t18so1199112ilp.5;
        Mon, 14 Sep 2020 15:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qADdGXdYZqT13TlNq77A8iEBF6/xm6VQ88F8vF+6Mt0=;
        b=ZbwWEunnv1fLjUlZfWALBywgqa/JrdFYFsEZ5uOdqAaVON/iJ2+C7cMU3jLZ+K61xg
         +urO/m3JnJxAngXvKxmzGwcdooHPiNPi37q1SaOeylT3oHPZMYQQJy4pAUj8L1UrCinA
         jo1O69pZd8+uC5DhlTP1dGg2/8a5onvHHFUoo96RDnKVmwDwle08G19fAytPtbRDewBn
         SR9yFVHftFVXNBbSjX6LgxcInc4pUR6rmFSApRBoIrh0G/xzXVZ8Z/mZBVak9f1HTmgH
         kDDGiylv0aRE0pq4AwgQ+dZKQthaej7c4IOTnLYkvonCdhB7VypvjOOKIVOumX+EYDlA
         CfrQ==
X-Gm-Message-State: AOAM532gritv5PYZ6UaVf9rRnMHbKTueSse2Gh4HtgNALnJk3yJAic98
        tRlz9Ar6FMPYtzI1uhfANZ9RONpe9j8f
X-Google-Smtp-Source: ABdhPJxQ6XmFgSPgsFsEuxc9KsSWx/uXdnk7BWY/+ZvrQLIouNhajOLGL/a9iRpmAURP/dKuGjOVsg==
X-Received: by 2002:a92:b109:: with SMTP id t9mr13133758ilh.191.1600124017132;
        Mon, 14 Sep 2020 15:53:37 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v20sm7670949ile.42.2020.09.14.15.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:53:36 -0700 (PDT)
Received: (nullmailer pid 419687 invoked by uid 1000);
        Mon, 14 Sep 2020 22:53:32 -0000
Date:   Mon, 14 Sep 2020 16:53:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 00/14] dt-bindings: Cleanup of i.MX 8
Message-ID: <20200914225332.GA418101@bogus>
References: <20200904152404.20636-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 04, 2020 at 05:23:50PM +0200, Krzysztof Kozlowski wrote:
> Hi Rob,
> 
> I am resending the series (v3) without actual changes.  You already
> reviewed many of them.  I think that subsystem maintainers are hesitant
> to pick them up, so maybe this could go via your tree (all of them)?
> 
> Changes against previous revisions are in individual patches.
> 
> Best regards,
> Krzysztof
> 
> 
> Krzysztof Kozlowski (14):
>   dt-bindings: perf: fsl-imx-ddr: Add i.MX 8M compatibles
>   dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles
>   dt-bindings: serial: fsl-imx-uart: Add i.MX 8M compatibles
>   dt-bindings: serial: fsl-lpuart: Fix compatible matching
>   dt-bindings: watchdog: fsl-imx-wdt: Add i.MX 8M compatibles
>   dt-bindings: reset: fsl,imx7-src: Add i.MX 8M compatibles
>   dt-bindings: thermal: imx8mm-thermal: Add i.MX 8M Nano compatible
>   dt-bindings: nvmem: imx-ocotp: Update i.MX 8M compatibles
>   dt-bindings: mfd: rohm,bd71847-pmic: Correct clock properties
>     requirements
>   dt-bindings: interrupt-controller: fsl,irqsteer: Fix compatible
>     matching
>   dt-bindings: mtd: gpmi-nand: Add i.MX 8M compatibles
>   dt-bindings: mtd: gpmi-nand: Fix matching of clocks on different SoCs
>   dt-bindings: mtd: nand-controller: Fix matching with size-cells==1
>   dt-bindings: clock: imx8m: Integrate duplicated i.MX 8M schemas

I've applied patches 1-11 and 14.

Rob
