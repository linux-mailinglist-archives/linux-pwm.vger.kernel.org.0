Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F72557EC
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Aug 2020 11:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgH1Jmx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1Jmo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 05:42:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5053FC061237
        for <linux-pwm@vger.kernel.org>; Fri, 28 Aug 2020 02:42:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so583159ljj.7
        for <linux-pwm@vger.kernel.org>; Fri, 28 Aug 2020 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOHxtM5yk1gvAYHJqAG90Qc4zP0j2G+j6TpnDxaoDIA=;
        b=L98VAkj/cNInmoKUxH8AOMVGrtQB6tuwlU+TtqyN5Ybq0OUUvv1/WwZwP/2Q2BHyKh
         vqUlX41ul/3RpVcXqGfRbkUmVVvq6H1hEWgDQMRDV/7DaH91K3EGhG9soVvrYxzDayLX
         Eqax3EwZJned8+IDqYNTwphOYkkSSaXo2hXUr/bYJbdL0c1Fcq87vv4Q3drcyo/ypkPU
         uHS6o48yHpMIBAWuJqv1j5jmWKbAs7euGm039AzZib3oBy7mF/xCc8cB+9yD3drlKdM8
         Vu8bGjLkz3mCqUOQuR1k2EBXuw7/zEKf7s116YtbCzzU427zzOjEE516m3pOeDUBdRQZ
         vWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOHxtM5yk1gvAYHJqAG90Qc4zP0j2G+j6TpnDxaoDIA=;
        b=oZSlp8AfIp2xE7uIlEN26C+nzGRsT0cvIehIHZbxBqzpxixgV4f5Qm9LRHLLFwu9db
         pmUtqFp5uV3pamFrr/GZd8H/X759sWFcy71vyplJK0OgqnAl7YkSX4cVTw4WpZJQIqEl
         tBaA7Pmre8/XiKNaSwcMbPfYWak7BPxTDUqxXsPDGphHyt+Pah8+tgqR4846u0PXPsyl
         AJC4ZOLSXjy7YFJWdl79/m4Kk+LDFl7axHNb+yv5aiOeLcEo2MUEYEVB40E0UNz6mkuw
         5cmiYDRDc3NJKGF8JC/MxcJKuq6SHaFwCy5QCmvzn9e1Ia+BFLpWnatE5XMDFVpp6ozF
         dJXw==
X-Gm-Message-State: AOAM532WLb4qI8o5UvEl3zglJCKOj4EH8mGEe9HM52KYTPxyPL/w1FUz
        NimW20gMpnqJz9vR/kRdZhmSTS7+RrBzHB1z7AnKjg==
X-Google-Smtp-Source: ABdhPJyoS2eg46/tyZ0yOApwD8OZKfUAZkgcEVLTK+EqD3GisGxH98dOWf4tudhOdF9/ATIaddWgil7TZpkYIeZMjNY=
X-Received: by 2002:a2e:558:: with SMTP id 85mr495792ljf.293.1598607758211;
 Fri, 28 Aug 2020 02:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200823161550.3981-1-krzk@kernel.org>
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 11:42:27 +0200
Message-ID: <CACRpkdYRk=1m0+FoE2YKYtwh+Vt6sFbh6w-m1t04YMV0WJR5VA@mail.gmail.com>
Subject: Re: [PATCH 01/22] dt-bindings: gpio: fsl-imx-gpio: Add i.MX 8 compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Aug 23, 2020 at 6:16 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> DTSes with new i.MX 8 SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
>
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible:0: 'fsl,imx8mm-gpio' is not one of ['fsl,imx1-gpio', 'fsl,imx21-gpio', 'fsl,imx31-gpio', 'fsl,imx35-gpio', 'fsl,imx7d-gpio']
>     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
>
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible: ['fsl,imx8mm-gpio', 'fsl,imx35-gpio'] is too long
>
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible: Additional items are not allowed ('fsl,imx35-gpio' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I'm just waiting for some review from the i.MX people on these FSL things,
then I can apply it.

Yours,
Linus Walleij
