Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1502AE173
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 22:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgKJVRM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 16:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVRM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 16:17:12 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8960C0613D1;
        Tue, 10 Nov 2020 13:17:10 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v144so88828lfa.13;
        Tue, 10 Nov 2020 13:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EGw/lJ2fFtGQXxuehfGhLjJtLJBME8AehCZBZ0GpWKM=;
        b=NAjhIP+3pP7247wVyMNIoqS0eBQ6Ub6VXzYDVkDW5hh7OeVhZnrCfqxE2LxWyJsKMV
         90KLTj2Sz4TgROVkbS2FdYgKiKElggblFjPltnMdRMP+LsofRfySn0ZAVRiZ/rJhCxi6
         Ihb4k6looEtRmT1ELEZ0lM7wPWjSKyFQbZqNuGGZWJnLFo6POVOBCZ35lDBdx6WUlyZo
         hFkkJUxBTXfhYM1L6nmK/Cdx6WzQfwcvnzNWLiRd/LuWn+G/zTP5qT4snC3j+huX+nYr
         tA9dCLNuMRHfewvKYy4Ua/ksZbn9fdwQO2uPYg+XI2muKxWHeQxfYp9b34Tx6cpXjg8z
         oyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EGw/lJ2fFtGQXxuehfGhLjJtLJBME8AehCZBZ0GpWKM=;
        b=YZRECcJ7PAUTjtP9s4dxXu0vwXJ/TdAvaawxP8WYuIH35iAxGEkfgMhKtPeollmBlq
         D0Qaih+nf+WySiB7fzwV4vbdpVo7CgtuMXDuqD5CaOA9pKgiBMnw434KzQ5ohbAzJzJW
         7xgONDva+SlzjQcT/NZPUlnhzdC1Y2iIVtGTBNAohYMX4G4AoX0BTHUd7CWQ8LZAnt1m
         gPiv9H8Kt9OKrJ46bW6paHblxjXWSurUJXrDTe7nIlvGp3o8QcHAp2Sj8FWlGpMtJEmb
         QEUoyraWHs9KfeB8iZkiiHusWiIsraLDqtiyixaMkfmwcXuGJtwTGSS3fN+NNqxlFcM8
         6SzQ==
X-Gm-Message-State: AOAM531Ih9D4P6xzza1CqNOLFm42BFxdGp2niDJ2OPFi26saNnNkZaka
        L6NBIndpt1aCVG3h4aOr84fWlsM3ldE=
X-Google-Smtp-Source: ABdhPJy9MxQ9JDqgbUxs5iJjOZhvvAhbIb4SB90wBtvxj6i+Z1NqL4Sgmd5xFUlSjTl9BiZi3p2X+g==
X-Received: by 2002:a19:6a07:: with SMTP id u7mr4706867lfu.252.1605043028710;
        Tue, 10 Nov 2020 13:17:08 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id m7sm1658405ljb.37.2020.11.10.13.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:17:07 -0800 (PST)
Subject: Re: [PATCH v1 18/30] pwm: tegra: Support OPP and core voltage scaling
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
 <20201104234427.26477-19-digetx@gmail.com> <20201110205057.GH2375022@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a3bf156d-17b8-0edd-9981-a17991266e1d@gmail.com>
Date:   Wed, 11 Nov 2020 00:17:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110205057.GH2375022@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

10.11.2020 23:50, Thierry Reding пишет:
> On Thu, Nov 05, 2020 at 02:44:15AM +0300, Dmitry Osipenko wrote:
> [...]
>> +static void tegra_pwm_deinit_opp_table(void *data)
>> +{
>> +	struct device *dev = data;
>> +	struct opp_table *opp_table;
>> +
>> +	opp_table = dev_pm_opp_get_opp_table(dev);
>> +	dev_pm_opp_of_remove_table(dev);
>> +	dev_pm_opp_put_regulators(opp_table);
>> +	dev_pm_opp_put_opp_table(opp_table);
>> +}
>> +
>> +static int devm_tegra_pwm_init_opp_table(struct device *dev)
>> +{
>> +	struct opp_table *opp_table;
>> +	const char *rname = "core";
>> +	int err;
>> +
>> +	/* voltage scaling is optional */
>> +	if (device_property_present(dev, "core-supply"))
>> +		opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
>> +	else
>> +		opp_table = dev_pm_opp_get_opp_table(dev);
>> +
>> +	if (IS_ERR(opp_table))
>> +		return dev_err_probe(dev, PTR_ERR(opp_table),
>> +				     "failed to prepare OPP table\n");
>> +
>> +	/*
>> +	 * OPP table presence is optional and we want the set_rate() of OPP
>> +	 * API to work similarly to clk_set_rate() if table is missing in a
>> +	 * device-tree.  The add_table() errors out if OPP is missing in DT.
>> +	 */
>> +	if (device_property_present(dev, "operating-points-v2")) {
>> +		err = dev_pm_opp_of_add_table(dev);
>> +		if (err) {
>> +			dev_err(dev, "failed to add OPP table: %d\n", err);
>> +			goto put_table;
>> +		}
>> +	}
>> +
>> +	err = devm_add_action(dev, tegra_pwm_deinit_opp_table, dev);
>> +	if (err)
>> +		goto remove_table;
>> +
>> +	return 0;
>> +
>> +remove_table:
>> +	dev_pm_opp_of_remove_table(dev);
>> +put_table:
>> +	dev_pm_opp_put_regulators(opp_table);
>> +
>> +	return err;
>> +}
> 
> These two functions seem to be heavily boilerplate across all these
> drivers. Have you considered splitting these out into separate helpers?

The helper is already prepared for v2.
