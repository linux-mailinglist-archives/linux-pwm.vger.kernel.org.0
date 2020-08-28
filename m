Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE93256314
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Aug 2020 00:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgH1W0v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 18:26:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33397 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgH1W0q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 18:26:46 -0400
Received: by mail-io1-f67.google.com with SMTP id g14so641578iom.0;
        Fri, 28 Aug 2020 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=beCKEWR+2oQoP1iLca7XLO6xgI6N1F/W6UJQBTH3DqY=;
        b=Ko9KQpvKIsxNwtB/dhkjCgjWerfusOFduegC4KGLQVqH+uZgQepUt93NwpIm7UsC/G
         Dgu8/fS0NWgFuZ1YcCYBve6GqovtONMwWxSabhj+oN5T6S0Abn2u4rs6ypSQjnaWB2OG
         ZNyeyd5YKxq0hKXF1OmPXzKBxgvfjEkgvc90NkEB4BCFcW1Xyr4gVCI8E0bvsiEtck5p
         36K3gVl6lCg/cnC/PHzz/KK1TY4e9kbd3GuFm09bZUp43tT3ryobADb9wc11yAn8iJun
         q+TxRJcVo7mteMidGQvSkjp5chcb0SVASB3aKn2pDdty49bNSlW7xJliNN/eaNGGm0B5
         I8bw==
X-Gm-Message-State: AOAM532aXkoBA8WI8pBsEq8iDVYqpfMDvg/jMrBHkia2gTMhd3oLtrzi
        VBrDCaMSMB7oMZMZcthFDg==
X-Google-Smtp-Source: ABdhPJyDswgrN+BluIgdLCgk2oMwkfO3ihCsb+7kbjBf1nAUVnPwHEtq+pfxrTZ7lhQpsLVbL5AMYw==
X-Received: by 2002:a05:6602:1589:: with SMTP id e9mr701184iow.85.1598653604968;
        Fri, 28 Aug 2020 15:26:44 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id b5sm317699ilr.58.2020.08.28.15.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:26:43 -0700 (PDT)
Received: (nullmailer pid 3515429 invoked by uid 1000);
        Fri, 28 Aug 2020 22:26:39 -0000
Date:   Fri, 28 Aug 2020 16:26:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Li <frank.li@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>, linux-pwm@vger.kernel.org,
        Han Xu <han.xu@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 17/19] dt-bindings: serial: fsl-lpuart: Fix compatible
 matching
Message-ID: <20200828222639.GA3515379@bogus>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-18-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825193536.7332-18-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Aug 2020 21:35:34 +0200, Krzysztof Kozlowski wrote:
> The i.MX 8QXP DTSes use two compatibles so update the binding to fix
> dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
>     compatible: ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
>     From schema: Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: serial@5a060000:
>     compatible: Additional items are not allowed ('fsl,imx7ulp-lpuart' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Remove moved compatibles.
> 
> Changes since v1:
> 1. New patch.
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.yaml  | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
