Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E905225631F
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Aug 2020 00:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgH1W0o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 18:26:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37027 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1W0K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 18:26:10 -0400
Received: by mail-io1-f66.google.com with SMTP id b16so622655ioj.4;
        Fri, 28 Aug 2020 15:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4duqBmGrOIE5h/MJFYsH8A08MjLB2XqWQDb7B6Dfs74=;
        b=TmtOIpaHqGCAZgJqPOx28dvGaCvJHfiuT0c014Excs6ark6RVFMYjaF/4z5/jXoILg
         iZWXp3mKR+Z0p7sKr/Kra4ByspMwik+MH7uqL3nqw8DprcKb8SSBmErshqdqk+7JCGsN
         54H+xUqC1muXm0SCJlr3ThKrrGUtck5SBqqZYzkI3qzzYZY54Jn1DLJxdt/b48iMc3XJ
         +reavvzaTvNHSJIK+AmQbteSoQP/XDDgOUBG21eygCVWllnCLYer0ZcEFR5eTJVIC4xU
         hwDQ0Es/3mP0DI02be9tLyxnUssNMocwJ/7kOyAg+FEWCMVGdg94gDKg4Pqv9b8D59/H
         hd4w==
X-Gm-Message-State: AOAM53245nuzsEpP2JP5bbGQugWDBrjsuKHm6iXxfDl4ChBwh/E24EDp
        j3oCGHFmdKO2jcomSqYscQ==
X-Google-Smtp-Source: ABdhPJyWo64sqjslBZ2g1+ACJ1BfQG2GiCxOUhoNMkowfb9iLK/cF8i/5RAnmdqpHsTGdOTEKzSrEA==
X-Received: by 2002:a05:6602:1589:: with SMTP id e9mr699348iow.85.1598653569509;
        Fri, 28 Aug 2020 15:26:09 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id y8sm255986iom.26.2020.08.28.15.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:26:08 -0700 (PDT)
Received: (nullmailer pid 3514602 invoked by uid 1000);
        Fri, 28 Aug 2020 22:26:04 -0000
Date:   Fri, 28 Aug 2020 16:26:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Han Xu <han.xu@nxp.com>,
        linux-kernel@vger.kernel.org, Frank Li <frank.li@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-watchdog@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-gpio@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-serial@vger.kernel.org, linux-pwm@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 13/19] dt-bindings: nvmem: imx-ocotp: Update i.MX 8M
 compatibles
Message-ID: <20200828222604.GA3514520@bogus>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-14-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825193536.7332-14-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Aug 2020 21:35:30 +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs use two compatibles so update the binding to
> fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000: compatible:1: 'syscon' was expected
>     From schema: Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
>     compatible: ['fsl,imx8mn-ocotp', 'fsl,imx8mm-ocotp', 'syscon'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
>     compatible: Additional items are not allowed ('syscon' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Remove moved compatibles.
> ---
>  .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 38 +++++++++++--------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
