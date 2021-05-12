Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5A37B704
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 09:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELHnf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 03:43:35 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44650 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229627AbhELHne (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 03:43:34 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14C7er8Y016608;
        Wed, 12 May 2021 09:42:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=mtmO0eRRDGX4r9MvsJBxMpxoqglzD6KV/FFApB5sBTk=;
 b=1Ppdff9rgy7E3SeQovPpydUQdPP8TacB+WXE7lwAJvQVPHfXrl7/MJl9lnYS5MHRSxY7
 UXIkHC4EXKpRgFmxQmSS48pmP6e9VNa7ZjYIQBRMCev06qZKiLBczma9lQl+qvAapan9
 sMQmplEVnu37oRz5bYsITVZUfu5gMiSs49OKdrBgI7uxdAEjKmlMhXrLon02nCyStLDY
 GMSvKcLsL3NLnut4Iqp5ji9PtXq1vxz6yRYkOt7zIHAuSVjtPNN4lrIwjsdmRVciCGwu
 De+zXQwzWjcYrTLB/feMqsIvwMvT5yhKypLisTETpjpSuOrw64zIx6XUGXcYBcKorZly fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38fggpgec7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 09:42:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B727110002A;
        Wed, 12 May 2021 09:42:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A5337212FCB;
        Wed, 12 May 2021 09:42:18 +0200 (CEST)
Received: from [10.211.1.115] (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 09:41:47 +0200
Subject: Re: [PATCH 1/2] pwm: stm32-lp: Don't modify HW state in .remove
 callback
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kernel@pengutronix.de>
References: <20210505162843.188901-1-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <1bd7cad8-723b-ec43-745c-0be32d105c0b@foss.st.com>
Date:   Wed, 12 May 2021 09:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210505162843.188901-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_03:2021-05-11,2021-05-12 signatures=0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/5/21 6:28 PM, Uwe Kleine-König wrote:
> A consumer is expected to disable a PWM before calling pwm_put(). And if
> they didn't there is hopefully a good reason (or the consumer needs
> fixing).

Hi Uwe,

As you pointed out, (ideally) consumers need to disable the PWM before
undind or remove of the driver. Calling pwm_disable in the remove is a
"fail safe".

> Also if disabling an enabled PWM was the right thing to do,
> this should better be done in the framework instead of in each low level
> driver.

Not doing so, in case the driver gets unbind when the PWM is enabled,
then bind again, it leads to unbalanced clock enable count.
There's no change to recover the balance after it.

Also, I'm also wondering if it's a good idea to let a free running PWM
channel? (That's probably a more general discussion).

> 
> So drop the hardware modification from the .remove() callback.

For now, I'd prefer to keep the current implementation, e.g. not to
simply drop this fail safe.

Is there a reason to address only the STM32 LP Timer pwm driver in your
patch ?
(I see there are other drivers around, doing the same. I agree this
could better be addressed by the framework, for all drivers).

Best Regards,
Fabrice

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index af08f564ef1d..2464f7a24983 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -224,8 +224,6 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>  {
>  	struct stm32_pwm_lp *priv = platform_get_drvdata(pdev);
>  
> -	pwm_disable(&priv->chip.pwms[0]);
> -
>  	return pwmchip_remove(&priv->chip);
>  }
>  
> 
> base-commit: a6efb35019d00f483a0e5f188747723371d659fe
> 
