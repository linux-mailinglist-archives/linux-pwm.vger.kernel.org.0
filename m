Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6782AB104
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 06:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgKIFxZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 00:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgKIFxY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 00:53:24 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AAAC0617A7
        for <linux-pwm@vger.kernel.org>; Sun,  8 Nov 2020 21:53:24 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x13so7064158pfa.9
        for <linux-pwm@vger.kernel.org>; Sun, 08 Nov 2020 21:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I4CHDtUGbNIJQpM023wPiaWJqW6VgcrXTJggEv8wwSw=;
        b=qCNPstD8wk3f6WVndWAivRv5cGLOIzilHxs0sV7MkBI8GDXwzWkbmt+V1Ae9lrpsMJ
         B4t28mlabIok8WTUpK4tOZJhv14XX6QPx9rUN/5/7PjDOEIOF07vmO2pAN+fOFSCVQFs
         N9tTa3VjUXqiHFZpYHNhvX9c+lshFtkGG4kTSo9LVtvbWKYZTAF10/IyRus+uU55LRBE
         4k68uNqq+fkS72Id3gBgsPo8GFhIcdXrrqMldXmeqgNgvMOl+qXZJXb1YbEiT/aa1Etq
         o30FSX7jLjx5MVrVA99VofHiE5IMFfg3o0pRw5sTKSTM5XBTSZbKnADSmkIOStFM24ld
         zguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I4CHDtUGbNIJQpM023wPiaWJqW6VgcrXTJggEv8wwSw=;
        b=YV6xMGhWlCHQzmv8+aVYJBDugB5ZkUDTHo2bJ4lbOTVARPqwd2Q4gz6Fawh+TBsm8g
         Jpfu1Wb/47uk3g5wkyOjtks0mk9PxaIdnTYGF8FClamDsgxwy85vMZM3s71isxnIa/ec
         t+x1aCxMK7fQnWYkmAZjcdFuBOYJB9vnqMHDG0ykJL9keDa/zz90j4nyH9jGwXy2VVRf
         ysbx6cU/p5j8of4DO8ahBDERywteeQrJrGfnKkBnlhc3PqeFQcdZEFczUzOK/Q0YU3C3
         x28pzdkHZnAEoEl3VSWU1vnrMBBVVoraNzFZj2HgWXlmZ0DZCb+bMV6paYM7UKY6XxA/
         Ph0Q==
X-Gm-Message-State: AOAM532qnXjf3gXSRSGWCg768rn8q7z/STGdAyVAEvkHpbbm0EVbnpwR
        4341f8vbWNmsntsdyC8kl3jn9A==
X-Google-Smtp-Source: ABdhPJwcV7Uyws0t/xTffHxasXM2N+eWSdO5J/LaZj2Wqdrek/AXYoDsM1gv08im58tWUSJ8zIbVUg==
X-Received: by 2002:a17:90a:e110:: with SMTP id c16mr11572525pjz.84.1604901203964;
        Sun, 08 Nov 2020 21:53:23 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 12sm3592369pjn.19.2020.11.08.21.53.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 21:53:22 -0800 (PST)
Date:   Mon, 9 Nov 2020 11:23:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
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
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        driver-dev <devel@driverdev.osuosl.org>,
        linux-pwm@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage
 scaling
Message-ID: <20201109055320.5y5gf2whwast2mi4@vireshk-i7>
References: <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
 <20201106061513.uyys7njcqcdlah67@vireshk-i7>
 <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
 <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
 <20201109050010.g47zojh6wafvwqva@vireshk-i7>
 <c584b301-e052-7f01-335d-8f9160865198@gmail.com>
 <20201109051014.oa6bt4g3ctm2hnuy@vireshk-i7>
 <4476fed9-a356-b7f1-32ee-935343e23038@gmail.com>
 <20201109053546.xupmmsx5qccn46tr@vireshk-i7>
 <33a7ad95-a8cf-7b88-0f78-09086c1a4adf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33a7ad95-a8cf-7b88-0f78-09086c1a4adf@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 09-11-20, 08:44, Dmitry Osipenko wrote:
> 09.11.2020 08:35, Viresh Kumar пишет:
> > On 09-11-20, 08:19, Dmitry Osipenko wrote:
> >> Thanks, I made it in a different way by simply adding helpers to the
> >> pm_opp.h which use devm_add_action_or_reset(). This doesn't require to
> >> add new kernel symbols.
> > 
> > I will prefer to add it in core.c itself, and yes
> > devm_add_action_or_reset() looks better. But I am still not sure for
> > which helpers do we need the devm_*() variants, as this is only useful
> > for non-CPU devices. But if we have users that we can add right now,
> > why not.
> 
> All current non-CPU drivers (devfreq, mmc, memory, etc) can benefit from it.
> 
> For Tegra drivers we need these variants:
> 
> devm_pm_opp_set_supported_hw()
> devm_pm_opp_set_regulators() [if we won't use GENPD]
> devm_pm_opp_set_clkname()
> devm_pm_opp_of_add_table()

I tried to look earlier for the stuff already merged in and didn't
find a lot of stuff where the devm_* could be used, maybe I missed
some of it.

Frank, would you like to refresh your series based on suggestions from
Dmitry and make other drivers adapt to the new APIs ?

-- 
viresh
