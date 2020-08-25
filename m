Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354B4250F95
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 04:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgHYCkk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 22:40:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34642 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCki (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 22:40:38 -0400
Received: by mail-io1-f66.google.com with SMTP id w20so7623743iom.1;
        Mon, 24 Aug 2020 19:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQ2hLW6/XM8wAoxs0O7Nm1znUzzf1rrbvS6JihVkfWQ=;
        b=Plhb/pKlZ58lY+gdXmMC5tM5JF18T8Eszt0drWa+wrdNn7xvL3UMyNv8pVWUTJOYHI
         5vRmG7XNenBkMGLc1gWah74nKT+APQRRJxz/suncsJKqH0otL9MR9w9q6zNlnfK0zkND
         DDVBdXrNdlM7Z29fuOlNlG58ro4gHwV7OIm6kkrYfhxQWsPDHzTz2nih9bqyjcWsZ/XH
         NQHCDqL0Prw++LV7AGEL/8ui7qeL1+PGTy8jv3aTKe2XGy+D+QYyayGFhPOkd4OdCkc0
         UkMING8rfe06aStCIhwn2nOshPtF6/uXKuQlEHxaqzwyptdrBIQjsIj8NLdpMPebJzsW
         20Kw==
X-Gm-Message-State: AOAM532Xf4VZL+oZCgrD8hGKTnflCFHw9ozThatRYClr/Q9MF5Vq3w9r
        3lKq/dLS6uCEwLl6MTOvLQ==
X-Google-Smtp-Source: ABdhPJxcHhPUemDUv3L0K4zuzSRRqDBK2CcHIo0/ucbYHbJd48+24WJeszkwdFAw2ND+cRYclyTSJQ==
X-Received: by 2002:a5d:91d4:: with SMTP id k20mr7667901ior.9.1598323237476;
        Mon, 24 Aug 2020 19:40:37 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id i11sm8194712ilr.47.2020.08.24.19.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:40:36 -0700 (PDT)
Received: (nullmailer pid 3841340 invoked by uid 1000);
        Tue, 25 Aug 2020 02:40:35 -0000
Date:   Mon, 24 Aug 2020 20:40:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pwm@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mtd@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-watchdog@vger.kernel.org, Will Deacon <will@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        devicetree@vger.kernel.org, Frank Li <frank.li@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 16/19] dt-bindings: interrupt-controller: fsl,
 irqsteer: Fix compatible matching
Message-ID: <20200825024035.GA3841215@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-16-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-16-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 24 Aug 2020 18:26:49 +0200, Krzysztof Kozlowski wrote:
> The i.MX 8M DTSes use two compatibles so update the binding to fix
> dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-thor96.dt.yaml: interrupt-controller@32e2d000:
>     compatible: ['fsl,imx8m-irqsteer', 'fsl,imx-irqsteer'] is too long
>     From schema: Domentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mq-thor96.dt.yaml: interrupt-controller@32e2d000:
>     compatible: Additional items are not allowed ('fsl,imx-irqsteer' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/interrupt-controller/fsl,irqsteer.yaml       | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
