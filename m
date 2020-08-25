Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7507325129E
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgHYHI5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 03:08:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34705 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgHYHI4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Aug 2020 03:08:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so11614882wrw.1;
        Tue, 25 Aug 2020 00:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l54b9M6lsfNgFjV5LriaXZxkCjRvfaXuheWXTmhA8H0=;
        b=IhJpiKm5Vp3VzhjSJT571kVboqOooMmXwHKQfrJe0v5jcYoZJz7rmdoIugP8nLVVY4
         vg9RUGaJYw2SrljnPJEtWjZRYziyBEPhRJOC4XXnxx4Vk7HTOFB6DZWPhhXekF9un+2B
         VwXIrn6Pn3M/g7x1U7ktjlhhtnjkMsgQv8cU2dgwK8GNN62uco1YPUNIr0I9JUYVkvwf
         IjXc6yx0F817c+m/n+bRScmigY9RCumpvnbwtz1Qhtoo9hMU7zX34WLt9PDMo+V/ZACn
         jyYOghhxSYRIILxzX2UuJUT/h75RhjChvRLVoICg7zISWdeLAMvNOEY4yERqO/zp7DAL
         1Gbg==
X-Gm-Message-State: AOAM533YmdK5ORUcDXJ2Bh2wSimS/8BDJLipqZzbFpn/GeEaB/JkbGOA
        t7459voHH9YXg04qQ5Ec0KE=
X-Google-Smtp-Source: ABdhPJx6Y8Pp2Xu+VQIJdGvRDGKdAFvlXR7vDcNPN4yTT16XHARtlil/gzCAiQcAzCm0WH80KJ2xHQ==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr9680913wrs.419.1598339333020;
        Tue, 25 Aug 2020 00:08:53 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id h11sm29004318wrb.68.2020.08.25.00.08.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 00:08:52 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:08:49 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 12/19] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8
 compatible matching
Message-ID: <20200825070849.GC3458@kozik-lap>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-12-krzk@kernel.org>
 <20200825023801.GA3835035@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825023801.GA3835035@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 08:38:01PM -0600, Rob Herring wrote:
> On Mon, Aug 24, 2020 at 06:26:45PM +0200, Krzysztof Kozlowski wrote:
> > The i.MX 8 DTSes use two compatibles so update the binding to fix
> > dtbs_check warnings like:
> > 
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
> >     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
> >     From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > 
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
> >     compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
> > 
> >   arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: mmc@30b40000:
> >     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
> > ---
> >  .../bindings/mmc/fsl-imx-esdhc.yaml           | 40 +++++++++++--------
> >  1 file changed, 23 insertions(+), 17 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index 10b45966f1b8..54f05e2a4246 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -21,23 +21,29 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - fsl,imx25-esdhc
> > -      - fsl,imx35-esdhc
> > -      - fsl,imx51-esdhc
> > -      - fsl,imx53-esdhc
> > -      - fsl,imx6q-usdhc
> > -      - fsl,imx6sl-usdhc
> > -      - fsl,imx6sx-usdhc
> > -      - fsl,imx6ull-usdhc
> > -      - fsl,imx7d-usdhc
> > -      - fsl,imx7ulp-usdhc
> > -      - fsl,imx8mq-usdhc
> > -      - fsl,imx8mm-usdhc
> > -      - fsl,imx8mn-usdhc
> > -      - fsl,imx8mp-usdhc
> > -      - fsl,imx8qm-usdhc
> > -      - fsl,imx8qxp-usdhc
> > +    oneOf:
> > +      - enum:
> > +          - fsl,imx25-esdhc
> > +          - fsl,imx35-esdhc
> > +          - fsl,imx51-esdhc
> > +          - fsl,imx53-esdhc
> > +          - fsl,imx6q-usdhc
> > +          - fsl,imx6sl-usdhc
> > +          - fsl,imx6sx-usdhc
> > +          - fsl,imx6ull-usdhc
> > +          - fsl,imx7d-usdhc
> > +          - fsl,imx7ulp-usdhc
> 
> > +          - fsl,imx8mq-usdhc
> > +          - fsl,imx8mm-usdhc
> > +          - fsl,imx8qxp-usdhc
> 
> These should be dropped.

You're right, thanks.

Best regards,
Krzysztof

