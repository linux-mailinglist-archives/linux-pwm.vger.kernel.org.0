Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560BF2A855C
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 18:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgKERyy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 12:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKERyx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 12:54:53 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3EC0613CF;
        Thu,  5 Nov 2020 09:54:53 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so3540928lfd.9;
        Thu, 05 Nov 2020 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gA6OLdD6ilrl1MlK7OiJsrdds83PpowmxPmjVFzKPLU=;
        b=XXHF9HTK2ugJChM+FIFMCW2E53QGEH1yguNWVVsZT4/1tb/wA72NsMDzQdgSY44iRC
         mV3oLf1MLXH5haz2YuP1CDRT8aUuzPTl7F2/RMHftpwIeYEBCAs3NG+BR4dNeGs187mI
         XbuGXQroBJTTOWAvgupbT5YRyuuxAIsIhg4fLFlZAAdVH++d1JBlqRiVgDhJ8kvrw9/J
         CoeoXoFGkh8y4iwGjCRTehbz/gI/F1PorRz0eVlctXoG9S08Uk7T6RBaUSdPCHSWuFmU
         /CTWZV/yrLcMfC8ZqzKcUNZKBSSDhWAWRgAsWN1XiInqnWC0QIShxySn34YF6hnFOplx
         3LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gA6OLdD6ilrl1MlK7OiJsrdds83PpowmxPmjVFzKPLU=;
        b=LpDc8mD5HHiK/05L6j9SILjUW7kl9ImPU9DSX3knUp05nIak7YsZwvidw7C966nsEK
         cF4Qy+7FdJIxKoTJhgwJ9D+6TQFmgJYlS3xa3+yA+4JL0hy2i34V4iXKj94W2oUt8mbj
         rh+l4iY3ZEhvKP5hwzfenDxIRuc5CFcnstLIFAjv+mJmC8P+hLON9jIOPng+KzO32LtB
         3CbRN2FONZ+luJ42achnO+4YMRTY1dsl0CZIuZpvdYmbAN4pk6D7G+qGzdNMO7cAVzMO
         mBYSC/TfUrsELzEauD2eB5bcbs0DHu7GLSQhxv6El7ep4Rpy3fE4Py5x1CprltFrmSEC
         Xqdg==
X-Gm-Message-State: AOAM531ZyCewGlIdzS6sTCisd6Xp2UHLMSR55AKBKnHEG9tPyrKYdonF
        gGAwbsai3pqckEqlLshyKCvBnFQ7tEs=
X-Google-Smtp-Source: ABdhPJyehz6KeITPmKFKw6lYd3zXe4BcIJiDjnQqHKJZPRp9Z41GNG8/Y3X7JzcgSQn251Z5j8SlyQ==
X-Received: by 2002:a19:4206:: with SMTP id p6mr1372241lfa.151.1604598890223;
        Thu, 05 Nov 2020 09:54:50 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id v20sm248899lfd.178.2020.11.05.09.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 09:54:49 -0800 (PST)
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
Message-ID: <cbc6bf1f-eccb-dee5-d2aa-2c60f1d365e2@gmail.com>
Date:   Thu, 5 Nov 2020 20:54:48 +0300
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
> Do you really want to use the same error unwinding for opp_table values 
> obtained from dev_pm_opp_set_regulators() as from 
> dev_pm_opp_get_opp_table()?

They both are pointing at the same opp_table, which is refcounted.

The dev_pm_opp_set_regulators() is dev_pm_opp_get_opp_table() + it sets
regulator for the table.

https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/opp/core.c#L1756
