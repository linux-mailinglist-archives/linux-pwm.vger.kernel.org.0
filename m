Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF813EFA6B
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 07:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhHRF71 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Aug 2021 01:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbhHRF70 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Aug 2021 01:59:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD4C0617AD
        for <linux-pwm@vger.kernel.org>; Tue, 17 Aug 2021 22:58:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso1632588pjb.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Aug 2021 22:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/oqvyX1+fZTz+wtMw2AZVqGvrykbTQj8oIvIXJk4fnQ=;
        b=BiNyX/6IYojCpnpyPGFzrgnh8ilV1S48JvAdE+mM4BuP7CRu2FKtWLmHb+6pMAnjSh
         /wfP9QCG/Q2Ukj1ZByvNzYSCb76F2+QCOquffMB7/VgJzMfI6biDam1D93oJFOcKLxY5
         r0ui6XTLNwvZZ2QgeJ+nHG0xrCIvTYYP76CrkUOXqGHCkZrCx8j9IwfpGrJOMhMeq8y0
         k2mkEWBfMzJhbTlNZAz6IL2S8V/0dB0U3qYFm8ylkevVbHpEgfdJ2weIyvMA0dAHIkMr
         BJ+3m2Wz3q/+kbkLCXBH7Ci4zKCVmfsRmjz+f2zh3gygpbMTckDnXDsC8v0GIrUYRu/5
         PVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/oqvyX1+fZTz+wtMw2AZVqGvrykbTQj8oIvIXJk4fnQ=;
        b=BIiKcdRmdqwlEjO2kTWduu2zRItmXt9qQ4v5Oh18/p+j/+cT5YU7dKMDwzLda/O5jU
         rXDp8G9++znEN4AhwGsFdurwTiPkPz7p+OYxiDsBppeSJWSmG/ZTkGcdm0any3PFX772
         TGB1OPbk8xuxU2ckh2ri3nw6EtT46SPXJe/99PJTUeEkxsf2mbj555uwquNOB654z/2y
         p2y+Ffx1YoAjAGV72fhsd6/LDsLfFo9DMAggAqYOByPCWE5nVCZkV6506dEq0A28l1TN
         N6knKHpWrNIqTCW7nGo/Fyaeq/xIEcn//GE/kH0u+qy+sleYmNtVRBQxSbDPnwzwFp1Z
         Tp1Q==
X-Gm-Message-State: AOAM531jR194gRtcIdMXm/SZtVoAhGxwGimGdGe5XlD5ots+P57OpZb6
        QXur22bTtu8A+3PNAmtd15sNVg==
X-Google-Smtp-Source: ABdhPJxmfawJmjScyveR+qRjue44WOBbTuswMGRMZAcW5NbsgTVLKIK8N3zHMPdQxwr8K+gezRoAzQ==
X-Received: by 2002:a17:90a:db89:: with SMTP id h9mr7820049pjv.214.1629266331439;
        Tue, 17 Aug 2021 22:58:51 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id g14sm4668532pfr.31.2021.08.17.22.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:58:51 -0700 (PDT)
Date:   Wed, 18 Aug 2021 11:28:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
Message-ID: <20210818055849.ybfajzu75ecpdrbn@vireshk-i7>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-2-digetx@gmail.com>
 <20210817075515.vyyv7z37e6jcrhsl@vireshk-i7>
 <710261d9-7ae3-5155-c0a2-f8aed2408d0b@gmail.com>
 <20210818035533.ieqkexltfvvf2p4n@vireshk-i7>
 <5b2a80c1-9743-e633-6257-ede94c8a274c@gmail.com>
 <20210818043131.7klajx6drvvkftoc@vireshk-i7>
 <a2a3c41f-c5e4-ee7e-7d48-03af8bac8863@gmail.com>
 <20210818045307.4brb6cafkh3adjth@vireshk-i7>
 <080469b3-612b-3a34-86e5-7037a64de2fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080469b3-612b-3a34-86e5-7037a64de2fe@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 18-08-21, 08:21, Dmitry Osipenko wrote:
> Yes, GENPD will cache the perf state across suspend/resume and initially
> cached value is out of sync with h/w.
> 
> Nothing else. But let me clarify it all again.

Thanks for your explanation.

> Initially the performance state of all GENPDs is 0 for all devices.
> 
> The clock rate is preinitialized for all devices to a some default rate
> by clk driver, or by bootloader or by assigned-clocks in DT.
> 
> When device is rpm-resumed, the resume callback of a device driver
> enables the clock.
> 
> Before clock is enabled, the voltage needs to be configured in
> accordance to the clk rate.
> 
> So now we have a GENPD with pstate=0 on a first rpm-resume, which
> doesn't match the h/w configuration. Calling dev_pm_opp_sync() sets the
> pstate in accordance to the h/w config.

What about calling dev_pm_opp_set_rate(dev, clk_get_rate(dev)) here
instead ? That will work, right ? The advantage is it works without
any special routine to do so.

I also wonder looking at your gr3d.c changes, you set a set-opp
helper, but the driver doesn't call set_opp_rate at all. Who calls it
?

And if it is all about just syncing the genpd core, then can the genpd
core do something like what clk framework does? i.e. allow a new
optional genpd callback, get_performance_state() (just like
set_performance_state()), which can be called initially by the core to
get the performance to something other than zero. opp-set-rate is
there to set the performance state and enable the stuff as well.
That's why it looks incorrect in your case, where the function was
only required to be called once, and you are ending up calling it on
each resume. Limiting that with another local variable is bad as well.

> In a previous v7 I proposed to preset the rpm_pstate of GENPD (perf
> level that is restored before device is rpm-resumed) from PD's
> attach_dev callback, but Ulf didn't like that because it requires to use
> and modify GENPD 'private' variables from a PD driver. We decided that
> will be better to make device drivers to explicitly sync the perf state,
> which I implemented in this v8.

-- 
viresh
