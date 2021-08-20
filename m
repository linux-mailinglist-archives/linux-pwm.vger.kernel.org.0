Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFFB3F2649
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Aug 2021 07:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhHTFIO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Aug 2021 01:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhHTFIN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Aug 2021 01:08:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBB6C0613CF
        for <linux-pwm@vger.kernel.org>; Thu, 19 Aug 2021 22:07:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o2so8023802pgr.9
        for <linux-pwm@vger.kernel.org>; Thu, 19 Aug 2021 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I11c1cKgPr/Sp26Jfws1CaBTqYhcyWk53u2DaXhbwr4=;
        b=UpF+nH2OkwIlPICwJCGnmyjIr4B9zvEagcPYbt+FJYBnDajj0m1nO6tNVE8qbt0+Fb
         dvuJgN/eTqaJJteqhCVn/rpcLUbjjgUdxm7UyfiENQfoJm1xoF4RsPXSRRmHR5JJ+BPY
         PyeM7sN+r+QeMIx3F/9qJdfTHD7pTlzTgVcV3EQwfDc98f2L+ENvpCEJkt6OSiVH99HJ
         DBrXa6YTNx2fJk97BqJPlKXpgux1dBNrNVjVGSJvKx8onkggk5QqicWc5AuujjenjwE8
         18Ew9Inp2nlX4py5sLi42iaANQsw78fFTvRX/HOAZ1Q/cYx042ZZ2sxqM8pjRICPn4KS
         FXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I11c1cKgPr/Sp26Jfws1CaBTqYhcyWk53u2DaXhbwr4=;
        b=MPEN8XbRcptrhCDGlVsVOpdyWHsEVUmpa6CQoDgKv1rAhNjWNon7l/UMNVCkq67iWR
         EwTSMnPv7oK96GJVzO/z9yOh2gQnnyPu+A9kPCjyJ3OJYNzspwLp2cFVUiCdD+R9lfj4
         vJfewjhhH3RkA3KzIDca8vEBBRVSNPd/uaRtJ6vG8FHifTedcKpL8ngTbESEo/bdmBx3
         Jm6pyBpJouKXQ/4zJ9ouHJRfgBF0oCQp9p8MidyDJcZapcij1Nb0Ebp5IGfT0O1en0nf
         bsgT6QpDPshTfgVMD7Pnl9Mjk68j5doOZizRoxmnr9LLft2pMXC0Zcxy6IssMP9f38aW
         uNSQ==
X-Gm-Message-State: AOAM533TwWT3O+0YVEEx2EO2wzKvf/lWfXVUZIydgASIYY1mY5rOpyZJ
        QFZxtRW1/WU6lr0Hqn8ejrBexA==
X-Google-Smtp-Source: ABdhPJy16/E+lvO8MOOTzYuxWhro60JOgxJRFDA2oDgCU53rDXdaeG2jdAFewa07ZsImLDOdZ74p+w==
X-Received: by 2002:a05:6a00:791:b0:3e1:3316:2e8 with SMTP id g17-20020a056a00079100b003e1331602e8mr18151438pfu.10.1629436055638;
        Thu, 19 Aug 2021 22:07:35 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id m5sm6747464pgn.70.2021.08.19.22.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 22:07:35 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:37:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
Message-ID: <20210820050732.oy2qdtwha5zioasq@vireshk-i7>
References: <f1c76f23-086d-ef36-54ea-0511b0ebe0e1@gmail.com>
 <20210818062723.dqamssfkf7lf7cf7@vireshk-i7>
 <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
 <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
 <CAPDyKFrVxhrWGr2pKduehshpLFd_db2NTPGuD7fSqvuHeyzT4w@mail.gmail.com>
 <20210818095044.e2ntsm45h5cddk7s@vireshk-i7>
 <CAPDyKFrFF00xGDWPCQnPwF0_QkG4TB2UqggpuBpp8LY_CMKP-A@mail.gmail.com>
 <0354acbe-d856-4040-f453-8e8164102045@gmail.com>
 <CAPDyKFoQdn1rm91iFNJwZwpSYcKJBjDLqtJB4KZAkhgY1Grm-Q@mail.gmail.com>
 <87073fc2-d7b3-98f4-0067-29430ea2adef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87073fc2-d7b3-98f4-0067-29430ea2adef@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 19-08-21, 22:35, Dmitry Osipenko wrote:
> 19.08.2021 16:07, Ulf Hansson пишет:
> > In the other scenario where a consumer driver prefers to *not* call
> > pm_runtime_resume_and_get() in its ->probe(), because it doesn't need
> > to power on the device to complete probing, then we don't want to vote
> > for an OPP at all - and we also want the performance state for the
> > device in genpd to be set to zero. Correct?
> 
> Yes
> 
> > Is this the main problem you are trying to solve, because I think this
> > doesn't work out of the box as of today?
> 
> The main problem is that the restored performance state is zero for the
> first genpd_runtime_resume(), while it's not zero from the h/w perspective.

This is exactly why I have been advocating that the genpd needs to
sync up with the hardware before any calls are made to it from the
consumer driver. Just what clock framework does to get the clock rate.

> > There is another concern though, but perhaps it's not a problem after
> > all. Viresh told us that dev_pm_opp_set_rate() may turn on resources
> > like clock/regulators. That could certainly be problematic, in
> > particular if the device and its genpd have OPP tables associated with
> > it and the consumer driver wants to follow the above sequence in
> > probe.
> 
> dev_pm_opp_set_rate() won't enable clocks and regulators, but it may

It does enable regulators right now, it may choose to enable clocks
later on, no guarantees.

> change the clock rate and voltage. This is also platform/driver specific
> because it's up to OPP user how to configure OPP table. On Tegra we only
> assign clock to OPP table, regulators are unused.

Right, over that platforms can set their own version of set-opp
callback, where all this is done from a platform specific callback.

> > Viresh, can you please chime in here and elaborate on some of the
> > magic happening behind dev_pm_opp_set_rate() API - is there a problem
> > here or not?

It configures clock, regulators, genpds, any required OPPs, + it
enables regulators right now.

-- 
viresh
