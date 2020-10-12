Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8342128BEE4
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Oct 2020 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403884AbgJLRQ4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Oct 2020 13:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403845AbgJLRQ4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Oct 2020 13:16:56 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEF72087E;
        Mon, 12 Oct 2020 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602523015;
        bh=OXdGjM2WT5x5sf1uC6sNIswByKxFQUWPV6TwtUK3Y0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A1pqyRMyjwp3U/Olyt7d5jHUEq7IhD2O0GlgJgMOX2xV+8LWTFBa+tb4G8eLBd0t6
         YZR26XEn7l7KGsaObmPBcLwQ6ZnboUdYk420hYA5smqwCiqm4Z4ZNSt29peAXazBur
         EqqNrdoEnXs7Sdc3qL/LGS5n0HGrMid1q31A5LtM=
Received: by mail-ed1-f53.google.com with SMTP id dg9so15461133edb.12;
        Mon, 12 Oct 2020 10:16:54 -0700 (PDT)
X-Gm-Message-State: AOAM5312Rer2LAwtN+YVCSbX+DYj+7C2QEKUh2jh6aWXC4AnkThKZAzv
        ID9mmiSb4JvMkG6CpFbaCfE/sqpOLX9JHFwlTdk=
X-Google-Smtp-Source: ABdhPJzEVNB8x3r9rtZW2qJLQPAd4mUTCuAhNFPv7+8r7HZYouTO819J7+/JyUqoGPgkO6hqTwq262cY2ghyAYoZKYQ=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr13089405edr.104.1602523013267;
 Mon, 12 Oct 2020 10:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212609.23093-1-krzk@kernel.org> <20200926132217.xr3rhv7o2o2yc2l7@pengutronix.de>
 <20200926134157.GA4730@kozik-lap> <20201009120239.GA450876@ulmo>
In-Reply-To: <20201009120239.GA450876@ulmo>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Oct 2020 19:16:40 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe3R4E7sgHGrLumrZ3hYXFMJKc18hotnLGpWvwMcZ8e0Q@mail.gmail.com>
Message-ID: <CAJKOXPe3R4E7sgHGrLumrZ3hYXFMJKc18hotnLGpWvwMcZ8e0Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: imx: document i.MX compatibles
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 9 Oct 2020 at 14:02, Thierry Reding <thierry.reding@gmail.com> wrot=
e:
>
> On Sat, Sep 26, 2020 at 03:41:57PM +0200, Krzysztof Kozlowski wrote:
> > On Sat, Sep 26, 2020 at 03:22:17PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Sep 25, 2020 at 11:26:09PM +0200, Krzysztof Kozlowski wrote:
> > > > Document all ARMv5, ARMv6 and ARMv7 i.MX compatibles to fix dtbs_ch=
eck
> > > > warnings like:
> > > >
> > > >   arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml: pwm@2080000: co=
mpatible:0:
> > > >     'fsl,imx6q-pwm' is not one of ['fsl,imx8mm-pwm', 'fsl,imx8mn-pw=
m', 'fsl,imx8mp-pwm', 'fsl,imx8mq-pwm']
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 11 ++++++++++=
+
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/imx-pwm.yaml
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
> > to the another level creating compatibles for absolutely every flavor o=
f
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
>         https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20=
200925212609.23093-1-krzk@kernel.org/
>
> Although, looking at the devicetree-bindings instance version of that
> patch, I see that it's got a failing check attached (which looks like
> it can be ignored) and it's marked "Changes Requested", but no comments
> saying so.
>
> Not sure if you want anything done here?

Thanks, I guess this will wait for the merge window to finish. It
should then apply to your tree. I can resend in two weeks.

Best regards,
Krzysztof
