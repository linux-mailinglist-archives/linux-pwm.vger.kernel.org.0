Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26301264D23
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIJSff (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 14:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgIJSeb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 14:34:31 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1BC2087C;
        Thu, 10 Sep 2020 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599762869;
        bh=SRgE3e+cWOee6V2K0Aw2EKLPOh+GtgrkQeeqC/WhKkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iRRR8DCEphKxCESUIOWKSYOGUMgScZXbeOeEcg0yOyRFJbnqmaYlOsiksuwiLjobQ
         M4uyBus+mshUVHZZ3JgPrAGSIFrgxOqZoEzzZ37YKf8U3tBk8av9U+Y8144ibkRREk
         PXnrMHTG6GY6MWdGQ00DeKQVPH9cYf3H7WrJDCZw=
Received: by mail-ej1-f51.google.com with SMTP id z23so10139662ejr.13;
        Thu, 10 Sep 2020 11:34:29 -0700 (PDT)
X-Gm-Message-State: AOAM5309MZH2hu7qkldGTU7mIu6vR+EodTzY1BZTBk5+Pn51YJBCdv8c
        7Oe/ExFWFSLC8z+1Ugwp+aJ3u3mdF3wKah6FmvI=
X-Google-Smtp-Source: ABdhPJyqKY0eU5W2IUZveRSdHihYXkn66844ltcGWOZGAN2rPhOWdGk7NLfovjoBdKlH8jBLp9/fUyrxxJec5WeF4cE=
X-Received: by 2002:a17:906:af53:: with SMTP id ly19mr9924685ejb.503.1599762867837;
 Thu, 10 Sep 2020 11:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200904152404.20636-1-krzk@kernel.org> <20200904152404.20636-13-krzk@kernel.org>
 <CAL_Jsq+tGQhkqtQszOx7nvr1PR=YFz2p1=OnWQ8JxmSg4qNkHA@mail.gmail.com>
 <20200907060958.GA4525@kozik-lap> <CAL_JsqJZ=PxDxH-=GUUg7WadZrAKjYbtE0sQ8h9YDGOGx6Ykwg@mail.gmail.com>
In-Reply-To: <CAL_JsqJZ=PxDxH-=GUUg7WadZrAKjYbtE0sQ8h9YDGOGx6Ykwg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 10 Sep 2020 20:34:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdVDGhdD5hMuXBDBa6XiaYRAK86E2G1gpGZSqnMLiY+Lg@mail.gmail.com>
Message-ID: <CAJKOXPdVDGhdD5hMuXBDBa6XiaYRAK86E2G1gpGZSqnMLiY+Lg@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] dt-bindings: mtd: gpmi-nand: Fix matching of
 clocks on different SoCs
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 8 Sep 2020 at 18:51, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Sep 7, 2020 at 12:10 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Fri, Sep 04, 2020 at 04:36:39PM -0600, Rob Herring wrote:
> > > On Fri, Sep 4, 2020 at 9:25 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > Driver requires different amount of clocks for different SoCs.  Describe
> > > > these requirements properly to fix dtbs_check warnings like:
> > > >
> > > >     arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: clock-names:1: 'gpmi_apb' was expected
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > >
> > > > ---
> > > >
> > > > Changes since v1:
> > > > 1. Do not require order of clocks (use pattern).
> > >
> > > To the extent that you can, you should fix the order in dts files
> > > first. If we just adjust the schemas to match the dts files, then
> > > what's the point?
> >
> > The DTSes do not have mixed order of clocks between each other, as fair
> > as I remember. It was fix after Sasha Hauer comment that order is not
> > necessarily good.
> >
> > We have the clock-names property, why enforcing the order?
>
> Because DT/OpenFirmware has always had a defined order for property
> values. '*-names' is just extra information.

Thanks for the explanation. There are few nonobvious requirements
about writing schema which seems many (including me) miss. It might be
a good topic for some conference. Too bad ELCE CFP ended some time
ago. :)

Best regards,
Krzysztof
