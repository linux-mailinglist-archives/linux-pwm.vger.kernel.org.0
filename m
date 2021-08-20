Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51F3F2C91
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Aug 2021 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbhHTM6q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Aug 2021 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhHTM6q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Aug 2021 08:58:46 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434D8C061756
        for <linux-pwm@vger.kernel.org>; Fri, 20 Aug 2021 05:58:08 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id a201so6115693vsd.3
        for <linux-pwm@vger.kernel.org>; Fri, 20 Aug 2021 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSaFeBdX4kWGJjrK0LDIdAG7HMHyEVXfRCzRhlCm2Vc=;
        b=DnhQLGM/mJBYM14dOuxq+G21zQDLVubpP7oZsUxJRpqY3uVOSAs9B5niS+x3uyTre7
         OY65Ox4XCQkPwIIGObNgixcuUbaA0/pd1FB1Qo2ODsYfIBziSCun36IE9isJ3506pXpF
         1ecf2r9wVgXbr/9QFjwW0VOiK0pGJUOmyNQXonlOuHCAOSpdd8cj85h6sjjS6N0HUfRU
         JG2biriboTkHUtYnQwws5fcglapOqHqn2aq4ItDnRLAMkRsQbfB5v6w1xfxzn4Mat3vo
         rreigmWF3PCK6SScj/XbW99E8SMa2IrssaqGiq9CflV2XUtvkisBvF3/Z2VuEfCmGOrP
         jh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSaFeBdX4kWGJjrK0LDIdAG7HMHyEVXfRCzRhlCm2Vc=;
        b=TNhekD6rPs8kDRDQOF09hcJcqzZeg/cwZXsyB2azQq2V+4N0j8fxao9iPWnof+ATmV
         xifqyVueZqKITfPCAd09sk/f9epZLDdYjav0vUeQxEzcB/cD2anWkPjumHnlcIwUAjyg
         hlIS45YW6FcWusROyE/Y1vid8m/GSoquZfgEndygjLN/P7Pw2vs9DSxZwjtEIG9ELka8
         s2lrbgN/cfy0lLiOR3T4xyKeR1uXyu9V3DLrZhqbJphhIJFEQY4o+fuFDB+owJqq8l/n
         cbqtBRsBJRZRWarQmwkqNmW00TxhDtdeBNOgjcYxkJMvilJXQsbGFiOig63mU8CBZyGd
         pgiA==
X-Gm-Message-State: AOAM531O1WfMxZR6OpoHNkKzdNtXqW7bFJqRqzxymuZPSWm7rNvyCOxm
        y7q47G0uHRnO0RSuY1TlLv4Ll1TlT4fKJ+Wmg7ifhA==
X-Google-Smtp-Source: ABdhPJyCu5OoKXB/ZnU0BhDnI9FQ/nriFA8C9gxuFpc66zGzEUSQ7NZWEdQGpN5i65y/ydiL4YG1C5HABdRFQK6zhTY=
X-Received: by 2002:a67:3212:: with SMTP id y18mr16683598vsy.19.1629464287428;
 Fri, 20 Aug 2021 05:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <080469b3-612b-3a34-86e5-7037a64de2fe@gmail.com>
 <20210818055849.ybfajzu75ecpdrbn@vireshk-i7> <f1c76f23-086d-ef36-54ea-0511b0ebe0e1@gmail.com>
 <20210818062723.dqamssfkf7lf7cf7@vireshk-i7> <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
 <20210818091417.dvlnsxlgybdsn76x@vireshk-i7> <CAPDyKFrVxhrWGr2pKduehshpLFd_db2NTPGuD7fSqvuHeyzT4w@mail.gmail.com>
 <f1314a47-9e8b-58e1-7c3f-0afb1ec8e70a@gmail.com> <20210819061617.r4kuqxafjstrv3kt@vireshk-i7>
 <CAPDyKFpg8ixT4AEjzVLTwQR7Nn9CctjnLCDS5GwkOrAERquyxw@mail.gmail.com> <20210820051843.5mueqpnjbqt3zdzc@vireshk-i7>
In-Reply-To: <20210820051843.5mueqpnjbqt3zdzc@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Aug 2021 14:57:31 +0200
Message-ID: <CAPDyKFo0rzHT4AhueWjyz9k2ZqUy8N6Od5pbr8sL_m0Jf2AwUg@mail.gmail.com>
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 20 Aug 2021 at 07:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-08-21, 16:55, Ulf Hansson wrote:
> > Right, that sounds reasonable.
> >
> > We already have pm_genpd_opp_to_performance_state() which translates
> > an OPP to a performance state. This function invokes the
> > ->opp_to_performance_state() for a genpd. Maybe we need to allow a
> > genpd to not have ->opp_to_performance_state() callback assigned
> > though, but continue up in the hierarchy to see if the parent has the
> > callback assigned, to make this work for Tegra?
> >
> > Perhaps we should add an API dev_pm_genpd_opp_to_performance_state(),
> > allowing us to pass the device instead of the genpd. But that's a
> > minor thing.
>
> I am not concerned a lot about how it gets implemented, and am not
> sure as well, as I haven't looked into these details since sometime.
> Any reasonable thing will be accepted, as simple as that.
>
> > Finally, the precondition to use the above, is to first get a handle
> > to an OPP table. This is where I am struggling to find a generic
> > solution, because I guess that would be platform or even consumer
> > driver specific for how to do this. And at what point should we do
> > this?
>
> Hmm, I am not very clear with the whole picture at this point of time.
>
> Dmitry, can you try to frame a sequence of events/calls/etc that will
> define what kind of devices we are looking at here, and how this can
> be made to work ?
>
> > > > Viresh, please take a look at what I did in [1]. Maybe it could be done
> > > > in another way.
> > >
> > > I looked into this and looked like too much trouble. The
> > > implementation needs to be simple. I am not sure I understand all the
> > > problems you faced while doing that, would be better to start with a
> > > simpler implementation of get_performance_state() kind of API for
> > > genpd, after the domain is attached and its OPP table is initialized.
> > >
> > > Note, that the OPP table isn't required to be fully initialized for
> > > the device at this point, we can parse the DT as well if needed be.
> >
> > Sure, but as I indicated above, you need some kind of input data to
> > figure out what OPP table to pick, before you can translate that into
> > a performance state. Is that always the clock rate, for example?
>
> Eventually it can be clock, bandwidth, or pstate of anther genpd, not
> sure what all we are looking for now. It should be just clock right
> now as far as I can imagine :)
>
> > Perhaps, we should start with adding a dev_pm_opp_get_from_rate() or
> > what do you think? Do you have other suggestions?
>
> We already have similar APIs, so that won't be a problem. We also have
> a mechanism inside the OPP core, frequency based, which is used to
> guess the current OPP. Maybe we can enhance and use that directly
> here.

After reading the last reply from Dmitry, I am starting to think that
the problem he is facing can be described and solved in a much easier
way.

If I am correct, it looks like we don't need to add APIs to get OPPs
for a clock rate or set initial performance state values according to
the HW in genpd.

See my other response to Dmitry, let's see where that leads us.

Kind regards
Uffe
