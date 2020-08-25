Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37387250F63
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgHYCgs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:36:48 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43841 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCgr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:36:47 -0400
Received: by mail-il1-f195.google.com with SMTP id e11so9147903ils.10;
        Mon, 24 Aug 2020 19:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UlfbS2vnAzZ5sBtAV+WlmNk8b75VkidkfLid2dc/mRw=;
        b=fUpYdE94ml7S2E7YNYN3RHGJTEhxwKJHypQELx4baY0MwV72t3WrnauYsI2/MV/eKV
         bx0P8S0hXjL6mRMdVNaoiDSRRQxQ5BLu6heEGpmBqf5sxs1ZSidIdPLMT+eart2b9DgR
         7FCGqBaCoonEciS9vrwsDBGfQm2KkDG0cPeHX+qfEQJeTuXY91IMZebQpSm6c9lGWoz5
         CO7LTGYdKkKYfuh9aVgRLbOyBec0lvXF/GlGcnd7TpytYQ1e7ah1zo+HYXWcPTmpJFU2
         FQ/m99t85dhUkdXK5Kj5IjQ5WX8u+diGz4xu04W2jcO9gmzOUFjIIZHXadl8tzlNs6/x
         z80g==
X-Gm-Message-State: AOAM530GycUiaEpy4Z1V8QCTDTLHyfsRQTfnYViKRUKlg8wqmk155WLv
        70y1thOGKXQavd9InWhDlg==
X-Google-Smtp-Source: ABdhPJyluUdv6ckXt6NtvqqOIFO4WPBGXDDadSOzeYergi+1EGQ65T2QUKGU26Hbwt7hRt0m7fVACA==
X-Received: by 2002:a92:505:: with SMTP id q5mr6873789ile.15.1598323006078;
        Mon, 24 Aug 2020 19:36:46 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h7sm8337940ilo.51.2020.08.24.19.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:36:45 -0700 (PDT)
Received: (nullmailer pid 3834766 invoked by uid 1000);
        Tue, 25 Aug 2020 02:36:42 -0000
Date:   Mon, 24 Aug 2020 20:36:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-serial@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Li <frank.li@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Han Xu <han.xu@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 11/19] dt-bindings: thermal: imx8mm-thermal: Add i.MX
 8M Nano compatible
Message-ID: <20200825023642.GA3834715@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-11-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-11-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:44 +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
>     compatible:0: 'fsl,imx8mn-tmu' is not one of ['fsl,imx8mm-tmu', 'fsl,imx8mp-tmu']
>     From schema: Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
>     compatible: ['fsl,imx8mn-tmu', 'fsl,imx8mm-tmu'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
>     compatible: Additional items are not allowed ('fsl,imx8mm-tmu' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/thermal/imx8mm-thermal.yaml    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
