Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B689628BF7C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Oct 2020 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404102AbgJLSOM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Oct 2020 14:14:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44432 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404152AbgJLSOL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Oct 2020 14:14:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id x62so19596162oix.11;
        Mon, 12 Oct 2020 11:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J3q7xHuH0aR/mKQTWSzv+4bd6O+Z10supV2gdoPo7Lo=;
        b=Ew2499x4LmgZqJg7/faouURyB3dhB6irypikPNyKFXbVvBkw9JE1xfqX4++thzwMJ1
         zGRvy5xydJ7d/BxyMAD6hbbGgL/OfNgIEKJQFKtfXU8e6YZpkwL5QgiMlEiIpYiqml1K
         iBhkE3a2VLNGw08y/yUOuJeXKfsNlav/tkBwquK30/C5+362t0bARMa8dq5OIEkRwh8q
         tERkjkKP2LmyXVUhPSN2kT3RbIDA6pX1YcrOmxebkFdBpy0cn/D9XEG9sw6GuS18zbxl
         o3fkJEW58QRy9xwXr0JA1d5rq2Mh5zJnca5hpY2PXZjAl/InfWW+sZ2qi+wcKYQjUAci
         bymw==
X-Gm-Message-State: AOAM533HIb8JPdVjOfnwc9L6il2kpNnQyaSA9tHMCjdnrKBrg/gJ/foy
        UtMS38LNew5sAuArOPnNHA==
X-Google-Smtp-Source: ABdhPJxEUqKxSDYUb/dWoUKkqguMsBXKOfsJi4XsgrQSu5P3tIoepRAQCg4Kb7WGp2CkRnNpo8Kn8Q==
X-Received: by 2002:aca:4e05:: with SMTP id c5mr12111904oib.99.1602526448601;
        Mon, 12 Oct 2020 11:14:08 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm9779176oid.40.2020.10.12.11.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:14:06 -0700 (PDT)
Received: (nullmailer pid 1850043 invoked by uid 1000);
        Mon, 12 Oct 2020 18:14:04 -0000
Date:   Mon, 12 Oct 2020 13:14:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-pwm@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pwm: imx: document i.MX compatibles
Message-ID: <20201012181404.GA1846397@bogus>
References: <20200925212609.23093-1-krzk@kernel.org>
 <20200926132217.xr3rhv7o2o2yc2l7@pengutronix.de>
 <20200926134157.GA4730@kozik-lap>
 <20201009120239.GA450876@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009120239.GA450876@ulmo>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 09, 2020 at 02:02:39PM +0200, Thierry Reding wrote:
> On Sat, Sep 26, 2020 at 03:41:57PM +0200, Krzysztof Kozlowski wrote:
> > On Sat, Sep 26, 2020 at 03:22:17PM +0200, Uwe Kleine-König wrote:
> > > On Fri, Sep 25, 2020 at 11:26:09PM +0200, Krzysztof Kozlowski wrote:
> > > > Document all ARMv5, ARMv6 and ARMv7 i.MX compatibles to fix dtbs_check
> > > > warnings like:
> > > > 
> > > >   arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml: pwm@2080000: compatible:0:
> > > >     'fsl,imx6q-pwm' is not one of ['fsl,imx8mm-pwm', 'fsl,imx8mn-pwm', 'fsl,imx8mp-pwm', 'fsl,imx8mq-pwm']
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > > > index 473863eb67e5..379d693889f6 100644
> > > > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > > > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > > > @@ -25,6 +25,17 @@ properties:
> > > >            - fsl,imx27-pwm
> > > >        - items:
> > > >            - enum:
> > > > +              - fsl,imx25-pwm
> > > 
> > > The driver actually used fsl,imx27-pwm to bind ...
> > 
> > Yes, most of i.MX drivers use only few compatibles but DTSes and
> > bindings use multiple of them.  I was convinced during various talks
> > that the specific compatibles (so "fsl,imx6q-pwm, fsl,imx27-pwm") are
> > preferred than generic ones (so only "fsl,imx27-pwm"). NXP took it
> > to the another level creating compatibles for absolutely every flavor of
> > their CPU. And they mainlined it in DTSes...
> > 
> > The PWM is this crazy examples where, as you say, only two compatibles
> > are actually used for binding but DTSes uses more.
> 
> Yeah, these new compatible strings all seem to be used in the kernel, so
> we might as well document them.
> 
> That said, I did want to apply this patch, but that fails. Am I missing
> some other patch that you have sent out that touches this file? Actually
> it looks like this is because you've based this patch on linux-next, or
> perhaps the devicetree tree, because that contains commit d058717bdff4
> ("dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles") from you that
> adds a couple more compatible strings. Probably best for Rob to pick
> this up, then:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> Rob, here's a patchwork link for you if you need one:
> 
> 	https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20200925212609.23093-1-krzk@kernel.org/
> 
> Although, looking at the devicetree-bindings instance version of that
> patch, I see that it's got a failing check attached (which looks like
> it can be ignored) and it's marked "Changes Requested", but no comments
> saying so.

I was assuming a rename at least.

> Not sure if you want anything done here?

I guess not, so I've applied it.

Rob
