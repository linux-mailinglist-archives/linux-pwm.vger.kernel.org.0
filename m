Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690712A8598
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgKESCK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 13:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKESCJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 13:02:09 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59854C0613CF;
        Thu,  5 Nov 2020 10:02:07 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id v18so691639ljc.3;
        Thu, 05 Nov 2020 10:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Al4h4rmGhqwiEGe133XHwebc8D8nOD3olrp8Vml5Ma4=;
        b=ns839VcoCfQlmSawliO3BW+/1vwbWsC0SuMDgd2rWP8iV711Mqqtf4m0MCEmnLvl6U
         3vb8CBUhCZHuLBbT/vy/0iMtjPX+V3C6uUIb2OPOXdjLYjIP6UI/e87eGPrrzJ+xbk0U
         lPuFmuT1kZYJ9xA2IDMRS58fh3QHtxbqkhAxXI9q2n4iD1UkN9wCV6XZxUKCW+jG4fl1
         bhur1vx8ueIhfdY8E1LoNLWhfnSqc8Cz4pG2mSMrLt8qiqsSVAo166ZZkzVsvdwhvofK
         JB2HZrGV3JeU2U3FG6Z6xcUm8hK1QDD32JbxQ1HpcmJHxS8qabOilxvrGXG1/u5lCDmu
         kXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Al4h4rmGhqwiEGe133XHwebc8D8nOD3olrp8Vml5Ma4=;
        b=kogleMfcIzCNRGSmtj2Mp4vuVz9hj/KZxXiPi3KwKdtUMTJ9cBrEPYkhZaOqsVlB+f
         Iqus4nDIr7p0LeKRAwa0TJgf8lRaxP4Ya2c9LifYDYfFGCE6TEbnmjZ2f1YAlAveVNIP
         H9I/IxuZ7Hg19SLdTK8O1FpAVe2t27aolQ6k5aOhsyO4x7CQxAYbSLOKM7E2nkb3ao08
         FGWqd2VtGS6Ntqwbgzmu+rmjdZ0OGtOvurTiPTwTQ7WFUAIxDBZVun4OH4aFtl6oAarT
         Gzy77dz0ksLbCsc5XtHcEb7Z12lG4Xd1pPX5DVDjt9QCa4yrbBoOxMkeAKDmiCOCRalw
         sJkQ==
X-Gm-Message-State: AOAM532CPsJwyMLw6SUhYB57bqVpvrs/rICa2rAQkJNaNWSl8s0Q3rex
        vdzPEl8013fAOXJnbXDwAFnS5A/lpJk=
X-Google-Smtp-Source: ABdhPJyGo1QPlqd8Bg9dlBjbnD5b7q3iSRiSvONPHwwdeYcMEjv8aISie0TROJMehCbGPKS7ntWyVA==
X-Received: by 2002:a2e:5007:: with SMTP id e7mr1293766ljb.196.1604599324582;
        Thu, 05 Nov 2020 10:02:04 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id q28sm251319lfn.7.2020.11.05.10.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 10:02:03 -0800 (PST)
Subject: Re: [PATCH v1 21/30] usb: host: ehci-tegra: Support OPP and SoC core
 voltage scaling
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-22-digetx@gmail.com>
 <20201105160743.GA1613614@rowland.harvard.edu>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a6030abc-3727-01ca-91b6-faf02d8083fd@gmail.com>
Date:   Thu, 5 Nov 2020 21:02:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105160743.GA1613614@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

05.11.2020 19:07, Alan Stern пишет:
>> +	err = devm_tegra_ehci_init_opp_table(&pdev->dev);
>> +	if (err)
>> +		return dev_err_probe(&pdev->dev, err,
>> +				     "Failed to initialize OPP\n");
> Why log a second error message?  Just return err.

Indeed, thanks.
