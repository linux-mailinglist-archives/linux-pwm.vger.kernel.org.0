Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583E726157A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Sep 2020 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgIHQvi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Sep 2020 12:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731909AbgIHQvJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 8 Sep 2020 12:51:09 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B576E2137B;
        Tue,  8 Sep 2020 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599583868;
        bh=pW1S8wYQ7shAS4VTkFPTvct/ClWzUHOw3xWhbsYQUNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FgS6w9TKkNIumIokoiwznLHegSZ8da9H6/tyCUONyA8D6mS4MC5L9U2z22U5vpbaJ
         F9LBw9H3U/ZQfNzWt6ceq2QpbMCME12qMJBPAnufXbEXaMdXUN5OQTdjSiBIy0r3bk
         7U2jnKRg1UiTm9IReOgbeVZRQG6XO2kMrq5x8Ajs=
Received: by mail-oo1-f51.google.com with SMTP id 4so4091291ooh.11;
        Tue, 08 Sep 2020 09:51:08 -0700 (PDT)
X-Gm-Message-State: AOAM5336w4FaUrgkkaZQMHIC9XcoaoO79MmlghHpn2rTwscnyo8U5huj
        MQjZH4r+nvWe9apsBepBEXfpRVfNTTha4s0nQQ==
X-Google-Smtp-Source: ABdhPJyVFdSAOgZ7160kEJoAezjYnztio3h9Ino2moi2r5NNuCCiGtHqBpSUtvivi5rsYhCBevOSckk/m/8RpCmF5Go=
X-Received: by 2002:a4a:d306:: with SMTP id g6mr19090952oos.25.1599583867914;
 Tue, 08 Sep 2020 09:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200904152404.20636-1-krzk@kernel.org> <20200904152404.20636-13-krzk@kernel.org>
 <CAL_Jsq+tGQhkqtQszOx7nvr1PR=YFz2p1=OnWQ8JxmSg4qNkHA@mail.gmail.com> <20200907060958.GA4525@kozik-lap>
In-Reply-To: <20200907060958.GA4525@kozik-lap>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Sep 2020 10:50:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJZ=PxDxH-=GUUg7WadZrAKjYbtE0sQ8h9YDGOGx6Ykwg@mail.gmail.com>
Message-ID: <CAL_JsqJZ=PxDxH-=GUUg7WadZrAKjYbtE0sQ8h9YDGOGx6Ykwg@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] dt-bindings: mtd: gpmi-nand: Fix matching of
 clocks on different SoCs
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

On Mon, Sep 7, 2020 at 12:10 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, Sep 04, 2020 at 04:36:39PM -0600, Rob Herring wrote:
> > On Fri, Sep 4, 2020 at 9:25 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Driver requires different amount of clocks for different SoCs.  Describe
> > > these requirements properly to fix dtbs_check warnings like:
> > >
> > >     arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: clock-names:1: 'gpmi_apb' was expected
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > ---
> > >
> > > Changes since v1:
> > > 1. Do not require order of clocks (use pattern).
> >
> > To the extent that you can, you should fix the order in dts files
> > first. If we just adjust the schemas to match the dts files, then
> > what's the point?
>
> The DTSes do not have mixed order of clocks between each other, as fair
> as I remember. It was fix after Sasha Hauer comment that order is not
> necessarily good.
>
> We have the clock-names property, why enforcing the order?

Because DT/OpenFirmware has always had a defined order for property
values. '*-names' is just extra information.

Rob
