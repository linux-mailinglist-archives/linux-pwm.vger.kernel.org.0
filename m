Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BF243A953
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 02:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhJZAk1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 20:40:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60634 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233957AbhJZAk1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 25 Oct 2021 20:40:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635208684; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=8mByl3gAGfKf4AoJcCSTiFOyD0EhGvwG2hEw0n8Woe8=; b=ShOHMazzG6zWMmN7tjzpA+or3ydxPng2QOimkIWAN3X5jMm5gA2tACKSoq5ejAnHMiNGTYW8
 NHBZWUzZ4m8RLXp1Yara7ZF27ILB4TOiwhpX0mkeOZICt6XFteKBbD5/BTIo0t1kHJGBH4R2
 MbsVDcHNl8JyQdo45l9e34ntDEI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZWM1ZCIsICJsaW51eC1wd21Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61774de9fd91319f0f256d18 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 00:38:01
 GMT
Sender: subbaram=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AE8B2C4361A; Tue, 26 Oct 2021 00:38:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.47.233.232] (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: subbaram)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CA92C4338F;
        Tue, 26 Oct 2021 00:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2CA92C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v10 2/2] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
References: <20211010043912.136640-1-bjorn.andersson@linaro.org>
 <20211010043912.136640-2-bjorn.andersson@linaro.org>
From:   Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Message-ID: <1ad508af-f7cb-a88f-07d8-5731c5a45403@codeaurora.org>
Date:   Mon, 25 Oct 2021 17:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211010043912.136640-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bjorn,

> +#define LPG_RESOLUTION		512

Just a thought. Having this fixed to 9-bit resolution would require a lot of code churn if this driver ends up supporting higher resolution PWM later. Would it be possible to have this as a parameter in "struct lpg_channel" ?

> +static const unsigned int lpg_clk_rates[] = {1024, 32768, 19200000};
> +static const unsigned int lpg_pre_divs[] = {1, 3, 5, 6};
> +
> +static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> +{
> +	unsigned int clk, best_clk = 0;
> +	unsigned int div, best_div = 0;
> +	unsigned int m, best_m = 0;
> +	unsigned int error;
> +	unsigned int best_err = UINT_MAX;
> +	u64 best_period = 0;
> +
> +	/*
> +	 * The PWM period is determined by:
> +	 *
> +	 *          resolution * pre_div * 2^M
> +	 * period = --------------------------
> +	 *                   refclk
> +	 *
> +	 * With resolution fixed at 2^9 bits, pre_div = {1, 3, 5, 6} and
> +	 * M = [0..7].
> +	 *
> +	 * This allows for periods between 27uS and 384s, as the PWM framework
> +	 * wants a period of equal or lower length than requested, reject
> +	 * anything below 27uS.
> +	 */
> +	if (period <= (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
> +		return -EINVAL;
> +
> +	/* Limit period to largest possible value, to avoid overflows */
> +	if (period > (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 1024)
> +		period = (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 2014;

s/2014/1024 ?

Thanks,
Subbaraman


