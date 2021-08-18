Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC93EF967
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 06:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhHREcJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Aug 2021 00:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbhHREcI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Aug 2021 00:32:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D640C0613C1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Aug 2021 21:31:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 17so937654pgp.4
        for <linux-pwm@vger.kernel.org>; Tue, 17 Aug 2021 21:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1HMKBtZVmoU7Rc9QD3kyFw8BSxbQ1XXUucrR+Z4oVdk=;
        b=WNnzDrjKSuo57M5U/vvksnesnE3XSYhvmOFwkkjYoF4N6XG+ta8N8NZzIFWeIE0OGt
         m4GJMPaxMYVC2//z4Hj1hbmM69h0o2zIOCkq7g914IVwVDrfUCYp2Fyx5EFg3zpe7op6
         sBuMx6G4//Vj5k5oQ3p1EjIx0FNqKDs8PZoGLd5zLM/K21YuDJix7HN32JKNpXc9lV5b
         /CqWxJPWJu6lybUtbqgsRNAUEAdjQXqyLlNMosG1SgkdTrL/H77eBngh5FCPI3mbp5WM
         Y5XCL3BSH33gOEYrWigS1sIOtvjBIhuytq+nTcM3RY+gm1vUp6Ia4lgmwIFSUDCDGDVu
         UE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1HMKBtZVmoU7Rc9QD3kyFw8BSxbQ1XXUucrR+Z4oVdk=;
        b=OSma5GRDEI4Uo6Dse5s02DA123mccvrhW/nzEXclI2iHzOqrBPjsSW36bTsxH9aF8H
         ig3m7oXUcQvo/rb53bg2txkDahUdlE5tafzO2RDfGcOlWlX2TAYGlxd7qvPdCDGwwuNr
         q/uGl95X+N/hIdbqyFYpz/gJDgwnjkI/zSw1tzfzv3NE7gmYrqysTrx/qvXG7AKyldU3
         8IGgVWAEtUafjZJIm5Hp9XNoMq44oIcvjM2uEsCQtU50T91pRnpm2Tf+AveYoCDfCRL8
         tJwXyCxU6mZFohyas5LGWnLBJC3YXeV/H5+enrunKlvF5h0e/+IT2C3J/yxrlVmIqCgW
         iGBQ==
X-Gm-Message-State: AOAM533S89dODbU+GasHybZxgsXrlv+YPiy9j2wsNioxr4lCLeu5HzD8
        oUZVxlVHeBwYQMtfK7/TDBNsMw==
X-Google-Smtp-Source: ABdhPJxMvaeYlR6ulOVs6g7ClDkUxVRC1d9pxaerEppmknwXG/wEM2I8f172Oe2lWr6x04vVo8i8LA==
X-Received: by 2002:a62:a117:0:b029:394:dddf:6b00 with SMTP id b23-20020a62a1170000b0290394dddf6b00mr7062959pff.50.1629261093845;
        Tue, 17 Aug 2021 21:31:33 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id a17sm4156560pff.30.2021.08.17.21.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:31:33 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:01:31 +0530
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
Message-ID: <20210818043131.7klajx6drvvkftoc@vireshk-i7>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-2-digetx@gmail.com>
 <20210817075515.vyyv7z37e6jcrhsl@vireshk-i7>
 <710261d9-7ae3-5155-c0a2-f8aed2408d0b@gmail.com>
 <20210818035533.ieqkexltfvvf2p4n@vireshk-i7>
 <5b2a80c1-9743-e633-6257-ede94c8a274c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b2a80c1-9743-e633-6257-ede94c8a274c@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 18-08-21, 07:12, Dmitry Osipenko wrote:
> 18.08.2021 06:55, Viresh Kumar пишет:
> > On 17-08-21, 18:49, Dmitry Osipenko wrote:
> >> 17.08.2021 10:55, Viresh Kumar пишет:
> >> ...
> >>>> +int dev_pm_opp_sync(struct device *dev)
> >>>> +{
> >>>> +	struct opp_table *opp_table;
> >>>> +	struct dev_pm_opp *opp;
> >>>> +	int ret = 0;
> >>>> +
> >>>> +	/* Device may not have OPP table */
> >>>> +	opp_table = _find_opp_table(dev);
> >>>> +	if (IS_ERR(opp_table))
> >>>> +		return 0;
> >>>> +
> >>>> +	if (!_get_opp_count(opp_table))
> >>>> +		goto put_table;
> >>>> +
> >>>> +	opp = _find_current_opp(dev, opp_table);
> >>>> +	ret = _set_opp(dev, opp_table, opp, opp->rate);
> >>>
> >>> And I am not sure how this will end up working, since new OPP will be
> >>> equal to old one. Since I see you call this from resume() at many
> >>> places.
> >>
> >> Initially OPP table is "uninitialized" and opp_table->enabled=false,
> >> hence the first sync always works even if OPP is equal to old one. Once
> >> OPP has been synced, all further syncs are NO-OPs, hence it doesn't
> >> matter how many times syncing is called.
> >>
> >> https://elixir.bootlin.com/linux/v5.14-rc6/source/drivers/opp/core.c#L1012
> > 
> > Right, but how will this work from Resume ? Won't that be a no-op ?
> 
> The first resume initializes the OPP state on sync, all further syncs on
> resume are no-ops.

But the OPPs should already be initialized as someone must have called
opp-set-rate earlier ? Why do this from resume and not probe ?

-- 
viresh
