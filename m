Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5B344D7A
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVRgU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 13:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231365AbhCVRgP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 22 Mar 2021 13:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0770361994;
        Mon, 22 Mar 2021 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616434575;
        bh=VdW4om2AyPCfqy4wAovCR7HUVEe2frovxQ0Cc8nEk7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mh9yoSTNMWrpBFxp7mRAqgfTfZOlph3dYZnhso+XBF99dtzEHkgBu1YOy2DccLzzn
         fUylSmXKjiXNkdvZx/WKnjEV+5GnHZAVRPf8FAuQ+FX2zNlEFwMnVuBx3/7QcHBGRR
         VmCt4+L4cInUjBNq78zxXp4FBDQOleC4/KxA9aQVsnHM3Zt5q+sPQ+9++fOCLAChGA
         ZrbBCoyVviPqoFFBHsivxNrK5fArDQmqAhFcrkwkX3XZuyzri6iX5TjfgUyKO2BGWn
         +jNA3cIftCwjS8BGd8BxZpoBiA5+h4IHlX0hKg0akAFueiGgUW8oqUusCrgeyLdw+R
         NAjf6bEHS7S5w==
Received: by mail-ed1-f45.google.com with SMTP id z1so20406691edb.8;
        Mon, 22 Mar 2021 10:36:14 -0700 (PDT)
X-Gm-Message-State: AOAM531IT0C8EmZXdUdl2/O0RfqM2n+Belt7+onRvizq6QDIQphW2JSP
        Rz4HTlybecblpmqZzlLW4FYCCmlGZgWGlIDeSg==
X-Google-Smtp-Source: ABdhPJx2NmuQG0Y5DzdS5+450riDgemRYrFCSvVWhwcs0YPSA/NP54tZmFoCyKBJEdQ1WhL/o13t1FITdk/T511dQts=
X-Received: by 2002:aa7:c403:: with SMTP id j3mr718221edq.137.1616434573540;
 Mon, 22 Mar 2021 10:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
 <1599734644-4791-3-git-send-email-sagar.kadam@sifive.com> <20200922203429.GA3188204@bogus>
 <CAMuHMdXPG-+EOCrQZi1deKv1yYMBtohprUVYW_-Shdp_gfQs5Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXPG-+EOCrQZi1deKv1yYMBtohprUVYW_-Shdp_gfQs5Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 22 Mar 2021 11:36:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJSF=p657tdvm4CW_LYi93t6vG0aOmQxUmYYW3_5h5UHQ@mail.gmail.com>
Message-ID: <CAL_JsqJSF=p657tdvm4CW_LYi93t6vG0aOmQxUmYYW3_5h5UHQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: riscv: convert plic bindings to json-schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sagar Kadam <sagar.kadam@sifive.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 22, 2021 at 9:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Sagar, Rob,
>
> (replying to an old email, as this one seems to be the most appropriate)
>
> On Tue, Sep 22, 2020 at 10:34 PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Sep 10, 2020 at 04:14:03PM +0530, Sagar Kadam wrote:
> > > Convert device tree bindings for SiFive's PLIC to YAML format
> > >
> > > Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
>
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
>
> > > +
> > > +  '#address-cells':
> > > +    const: 0
> > > +    description: Should be <0> or more.
> >
> > Drop. 'or more' is wrong. If there's a case with more, it will need to
> > be documented.
>
> Why do we have the "'#address-cells': const: 0" at all...
>
> > > +required:
> > > +  - compatible
> > > +  - '#address-cells'
>
> ... and why is it required?

It is only required if an 'interrupt-map' points to this node.
Currently dtc is warning if it is missing always, but there are plans
to relax dtc to only warn when 'interrupt-map' is present. Of course,
if you had 'interrupt-map' in an overlay, you'd want #address-cells in
the base dt and there's no other way to check that than making it
required.

Rob
