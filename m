Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40A1E2111
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgEZLmV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbgEZLmU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 07:42:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9AAC03E97E;
        Tue, 26 May 2020 04:42:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so3290824plb.3;
        Tue, 26 May 2020 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0KbdXDZ60w99BOdUqDW8OeczOgVguCNs3xmodhMqij0=;
        b=YeTf0oyQbfuNobEmaT0G+JfvhdSR59et4jwI+xEzEyEv2mcxorw5TsaSp59e00qdk5
         fY9adbWlnHXxo47r2s2NUlxSf1f6JZPbRyFyLD970Otx+C+OuipskNfTPO9M2sCoohPX
         wF2s0bO/ugME5/RBXAKRyHwmPXbGygmvGLhrtJVbIo9ZdqOF8Tx4vzIK626oyYgLq6+J
         PZQ3XXmZSgwy4yDM4VaTWuM8+p8bOfZBFvPaK9LQp/OF9jju0hso2Hu6sKdGym5nnAha
         LM6oRcXLVWHVQoSfEwUgPQZ6ohyy663WfPrrjdjHIcdaLxwPMXWqulolRcp9aSENRKg4
         4NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0KbdXDZ60w99BOdUqDW8OeczOgVguCNs3xmodhMqij0=;
        b=AuUWmoD+J9Lam5YoWnSvXRb55nlA9djLEhzMo+1fLARlK8zeeSYDLuuJVii/fCrjLQ
         tbIDMRWTkmgcJIdhh6VjjSPwAvlg9ZwOGCG5dMBkOvrwHyNkkgYAR10YZMvFw7T9RyUN
         WgNFn2wIBNWn5eoTzP4FtLPcCbWPhLzdr4tj2ftlDWD0rm9X3HnU5+gHZXDuiELoOqsh
         YE62cjC0oMnY9vKgfA1VxKO0D8uK2TkmZCFDQ1SZvClYUO/QCRVXHpjTxrsKCeqsrgcE
         AFJUz4ADIifhfQLDusgEN90ldxT2IzWGzReBx5iATvPQNceSLNa+dlD4stYday12SN3P
         Y3qQ==
X-Gm-Message-State: AOAM5323BbNZv2Cc/imOMwYMDnx3eA01tHo8duNQoDqSugT1MMNFbqdT
        STwkh1dhRZLF7jrPx2WlcxcstQA2
X-Google-Smtp-Source: ABdhPJwugSGVJtC/Tp/DSeFSxYWv+Rt6utgvtWt9esxUgmz2ihJKza0En6mww8XwJQemz22e4INQfw==
X-Received: by 2002:a17:90a:8a08:: with SMTP id w8mr26604070pjn.53.1590493340274;
        Tue, 26 May 2020 04:42:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2sm15139192pfi.208.2020.05.26.04.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 04:42:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
To:     Sandipan Patra <spatra@nvidia.com>, treding@nvidia.com,
        jonathanh@nvidia.com, u.kleine-koenig@pengutronix.de,
        kamil@wypas.org, jdelvare@suse.com, robh+dt@kernel.org
Cc:     bbasu@nvidia.com, bbiswas@nvidia.com, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <53619c02-8c0f-3eec-cccc-16e779b8c425@roeck-us.net>
Date:   Tue, 26 May 2020 04:42:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/25/20 10:06 PM, Sandipan Patra wrote:
> This change has 2 parts:
> 1. Add support for profiles mode settings.
>     This allows different fan settings for trip point temp/hyst/pwm.
>     T194 has multiple fan-profiles support.
> 
> 2. Add pwm-fan remove support. This is essential since the config is
>     tristate capable.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  drivers/hwmon/pwm-fan.c | 112 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 100 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 30b7b3e..26db589 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c

[ ... ]

>  
> +static int pwm_fan_remove(struct platform_device *pdev)
> +{
> +	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> +	struct pwm_args args;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	if (IS_ENABLED(CONFIG_THERMAL))
> +		thermal_cooling_device_unregister(ctx->cdev);
> +
> +	pwm_get_args(ctx->pwm, &args);
> +	pwm_config(ctx->pwm, 0, args.period);
> +	pwm_disable(ctx->pwm);
> +
> +	return 0;
> +}
> +

I don't think you actually tested this. I would suggest to make
yourself familiar with 'devm' functions and their use, and
then resubmit.

Thanks,
Guenter
