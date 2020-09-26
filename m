Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844402799BA
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Sep 2020 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIZNmG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Sat, 26 Sep 2020 09:42:06 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:33065 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZNmG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Sep 2020 09:42:06 -0400
Received: by mail-ej1-f66.google.com with SMTP id j11so2410399ejk.0;
        Sat, 26 Sep 2020 06:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zZiC4GFLiCyxWh5u5vGAPSFiD3LqckqVR10/0vflwwg=;
        b=pmE6FomZalVD8bPNjs20hMVtM9tKotvYkEsVO8i/aIPTM/HjNpSdzyRTs011mLq2W6
         htrpJzJeqgILNV9M+w/M9teLtUwzka9sx4EkAsae7hXCZs9kuJDnvAjwVzXlrzWj+AKD
         4Zd5Tj3QGQCCrxrDsztSSUSwHGWkSfdjw+qX+geDCg8pQ2Wj2GDwAutWQSjjXswoSwIc
         DBGP3toCtf5FkUEptqsiQQ15ZVzYfQIOmc2Yx95/WWK67vQCtYwJ8DVXvJHkP721QvEy
         ImBCNSYM0xbL4B3vv+uUDXzytm1gBRJ88GL3hDngJxRHhbK4aDcwwU9A8Y4paWiMH8Qi
         t5OQ==
X-Gm-Message-State: AOAM532wu1UT7jx+wjSiX1EiEmZ2VLuZHKfFW//TMDvLqIOm0VRkvTFO
        FZkoLzajkWPIRq2slJk6u/o=
X-Google-Smtp-Source: ABdhPJz9GR5blkBoMY58veAVwcmSMDo29BUcNV1QcEUQxNVIvkB6gy7KKlrjrtCiqAKvzgYXZdNSLQ==
X-Received: by 2002:a17:907:2115:: with SMTP id qn21mr7366844ejb.278.1601127723572;
        Sat, 26 Sep 2020 06:42:03 -0700 (PDT)
Received: from kozik-lap ([194.230.155.132])
        by smtp.googlemail.com with ESMTPSA id jo26sm4156240ejb.120.2020.09.26.06.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 06:42:02 -0700 (PDT)
Date:   Sat, 26 Sep 2020 15:41:57 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: imx: document i.MX compatibles
Message-ID: <20200926134157.GA4730@kozik-lap>
References: <20200925212609.23093-1-krzk@kernel.org>
 <20200926132217.xr3rhv7o2o2yc2l7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200926132217.xr3rhv7o2o2yc2l7@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Sep 26, 2020 at 03:22:17PM +0200, Uwe Kleine-König wrote:
> On Fri, Sep 25, 2020 at 11:26:09PM +0200, Krzysztof Kozlowski wrote:
> > Document all ARMv5, ARMv6 and ARMv7 i.MX compatibles to fix dtbs_check
> > warnings like:
> > 
> >   arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml: pwm@2080000: compatible:0:
> >     'fsl,imx6q-pwm' is not one of ['fsl,imx8mm-pwm', 'fsl,imx8mn-pwm', 'fsl,imx8mp-pwm', 'fsl,imx8mq-pwm']
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > index 473863eb67e5..379d693889f6 100644
> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > @@ -25,6 +25,17 @@ properties:
> >            - fsl,imx27-pwm
> >        - items:
> >            - enum:
> > +              - fsl,imx25-pwm
> 
> The driver actually used fsl,imx27-pwm to bind ...

Yes, most of i.MX drivers use only few compatibles but DTSes and
bindings use multiple of them.  I was convinced during various talks
that the specific compatibles (so "fsl,imx6q-pwm, fsl,imx27-pwm") are
preferred than generic ones (so only "fsl,imx27-pwm"). NXP took it
to the another level creating compatibles for absolutely every flavor of
their CPU. And they mainlined it in DTSes...

The PWM is this crazy examples where, as you say, only two compatibles
are actually used for binding but DTSes uses more.

> 
> Also since v5.1-rc1~38^2~17 the driver is split into pwm-imx27 and
> pwm-imx1. So maybe this file should be renamed to fsl,imx27-pwm.yaml?
> (And we need a volunteer to write fsl,imx1-pwm.yaml.)

I think there is no need, because the binding describes the hardware and
could be supported by multiple drivers. I actually recently merged few
bindings (i.MX 8 clocks, NXP PCA953x/max GPIO expanders).

Best regards,
Krzysztof

