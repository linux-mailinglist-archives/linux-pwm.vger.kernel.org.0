Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C962A7F0A
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 13:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgKEMxR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 07:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbgKEMxQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 07:53:16 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2BC0613D4
        for <linux-pwm@vger.kernel.org>; Thu,  5 Nov 2020 04:53:16 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id y1so466721uac.13
        for <linux-pwm@vger.kernel.org>; Thu, 05 Nov 2020 04:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6TCLuc1aSDhvBsEh/oyOKoJFVXSTFCOXAYW2AUTtHo=;
        b=y6DX4cMUVCgpxUKuGqoEligLjI7mP0FgyJ97c7sIUUHZxJlTwtRRakXekgH7YsuigB
         Na2QU2xZN4x2PfpN6omerSdhzPwwGn9bDYKeR2k6MuBaUl4m5dH4WWWTdnhpeJeXb0wO
         XSZFej4dNy5nb1iC9xr8tfwJeCBjFjlTzg4qI2DAs6FEDqJOv7dGIgx54zxdVZ6kpJNY
         qEEM8136+KYXcHo4ba8akOcRfEEQa2WPh8DybrHFK+sabZgBhMR36tCVRG83K7vH1cW2
         +tAvD7+11Tiw9WmdBdchM838Ksuv8W7UHq8LoeYHHVZz9EZWz0CY4hFIKH9bgfZDnoHM
         MkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6TCLuc1aSDhvBsEh/oyOKoJFVXSTFCOXAYW2AUTtHo=;
        b=WS10zMlFWS4zB3R5ipIn2cUfPyt+e+anP+zGc3GhGohPjnXUHDdEviHOc5/gZ4J6GJ
         pnhOyCZqHvgR+bf6I77neQv7UbuV/ZQpcZrKtIsdGcVNlpmokPJcrzUATlvO8jOMyHpy
         l07GWR/cmw3pfm/Z/FhprF6K22u+BNacDMkoiJZgONZ2wbYJKmaJacGq3VWh3JoGUeq2
         WfVujdypf0EqE0mA05RDP+e9Qz0rfaT6q3Y9vdL9B0kqQy0p2OIoam+XT47vCwbtOCso
         /CBi8SMAtiEmPYWAWe7DTNLwHvg3RB5eJjraOACiyRHU5APT0murbjAr/cY8KUojwxIo
         BvXg==
X-Gm-Message-State: AOAM533b7wTNQ+PZyYFWBrKCmTcTp98dNtm370mlhO3Q1R2I+YWgoWpQ
        +oWeWsq++156BZIT0DcY0fba2o1YR5RXD5lPsrLFHg==
X-Google-Smtp-Source: ABdhPJycxdGkrda5dU9htxc/OSwm7s+GQAoBTPW1YXOO/bE03Yfcq+QBohkR+LMOwjYHynIUz7nEwPk/k/ZMFVtVBnc=
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr833961uaj.104.1604580795669;
 Thu, 05 Nov 2020 04:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20201104234427.26477-1-digetx@gmail.com> <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <20201105100603.skrirm7uke4s2xyl@vireshk-i7> <CAPDyKFoCJt5MBSKBJ8n1OAMdVsWHdwXTx0zFEcZw_F_gQ6Ug0w@mail.gmail.com>
 <20201105104009.oo4dc6a2gdcwduhk@vireshk-i7> <CAPDyKFpQG98d6foc1U6fp3YEBdZ1vLqY9cmWxpUwXoKgDn+ojQ@mail.gmail.com>
 <20201105111301.2hxfx2tnmf2saakp@vireshk-i7>
In-Reply-To: <20201105111301.2hxfx2tnmf2saakp@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:52:39 +0100
Message-ID: <CAPDyKFr3LhrnK9mm=RzhZvcnfeAKez3Yzm6HU_oP1bnPokh9vg@mail.gmail.com>
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 5 Nov 2020 at 12:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-11-20, 11:56, Ulf Hansson wrote:
> > On Thu, 5 Nov 2020 at 11:40, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > Btw, how do we identify if it is a power domain or a regulator ?
>
> To be honest, I was a bit afraid and embarrassed to ask this question,
> and was hoping people to make fun of me in return :)
>
> > Good question. It's not a crystal clear line in between them, I think.
>
> And I was relieved after reading this :)
>
> > A power domain to me, means that some part of a silicon (a group of
> > controllers or just a single piece, for example) needs some kind of
> > resource (typically a power rail) to be enabled to be functional, to
> > start with.
>
> Isn't this what a part of regulator does as well ? i.e.
> enabling/disabling of the regulator or power to a group of
> controllers.

It could, but it shouldn't.

>
> Over that the regulator does voltage/current scaling as well, which
> normally the power domains don't do (though we did that in
> performance-state case).
>
> > If there are operating points involved, that's also a
> > clear indication to me, that it's not a regular regulator.
>
> Is there any example of that? I hope by OPP you meant both freq and
> voltage here. I am not sure if I know of a case where a power domain
> handles both of them.

It may be both voltage and frequency - but in some cases only voltage.
From HW point of view, many ARM legacy platforms have power domains
that work like this.

As you know, the DVFS case has in many years not been solved in a
generic way, but mostly via platform specific hacks.

The worst ones are probably those hacking clock drivers (which myself
also have contributed to). Have a look at clk_prcmu_opp_prepare(), for
example, which is used by the UX500 platform. Another option has been
to use the devfreq framework, but it has limitations in regards to
this too.

That said, I am hoping that people start moving towards the
deploying/implementing DVFS through the power-domain approach,
together with the OPPs. Maybe there are still some pieces missing from
an infrastructure point of view, but that should become more evident
as more starts using it.

>
> > Maybe we should try to specify this more exactly in some
> > documentation, somewhere.
>
> I think yes, it is very much required. And in absence of that I think,
> many (or most) of the platforms that also need to scale the voltage
> would have modeled their hardware as a regulator and not a PM domain.
>
> What I always thought was:
>
> - Module that can just enable/disable power to a block of SoC is a
>   power domain.
>
> - Module that can enable/disable as well as scale voltage is a
>   regulator.
>
> And so I thought that this patchset has done the right thing. This
> changed a bit with the qcom stuff where the IP to be configured was in
> control of RPM and not Linux and so we couldn't add it as a regulator.
> If it was controlled by Linux, it would have been a regulator in
> kernel for sure :)

In my view, DT bindings have consistently been pushed back during the
year, if they have tried to model power domains as regulator supplies
from consumer device nodes. Hence, people have tried other things, as
I mentioned above.

I definitely agree that we need to update some documentations,
explaining things more exactly. Additionally, it seems like a talk at
some conferences should make sense, as a way to spread the word.

Kind regards
Uffe
