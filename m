Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A37EB0D0
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 14:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjKNN0s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 08:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjKNN0r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 08:26:47 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B231C1A1
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 05:26:44 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AE8PX1N024036;
        Tue, 14 Nov 2023 14:26:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=EInGY1O7eeTJWEq3JL+TXEHTdFwdqTmcYlfV0KHYYDs=; b=75
        530B6v09vu9VhPmUMZ846tUxhiORtsLngdOQu6aqxMWQpnmHlmhy0X9pb8S6Debk
        GTlkMDIdOohxz16BXrEaNnSYgQL0WdIqf0S9YDcW9S1yw7A/zvzWEPn/sChWUQNs
        pWAMFjma0OMianEKwucHmnlVJ3/DToJcaZ0+FQsJ9iZXVN3Fz6AxOVDJ2ZfJMrV7
        nbYFwDrrPZEA1GREwgW9ZzsVGnTE/CqJhoqpgIl6KTlhuEKSNVj8eho/OPlK283x
        3NyQuzMqHnR6XvxgxGDBst+SPVUAW9zuZAUiwX+H9Qo5wo55WyLIyJMRzmLP1lyQ
        Hlrt26Sv/8zmMfVu6tvw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uam249hvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:26:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 69A3E100038;
        Tue, 14 Nov 2023 14:26:37 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 619C02122E8;
        Tue, 14 Nov 2023 14:26:37 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 14 Nov
 2023 14:26:36 +0100
Message-ID: <3e880744-ec9f-4c22-9913-81ec356f8073@foss.st.com>
Date:   Tue, 14 Nov 2023 14:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pwm: stm32: Make ch parameter unsigned
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
 <20231019200658.1754190-9-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231019200658.1754190-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_13,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/19/23 22:07, Uwe Kleine-König wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> The channel parameter is only ever set to pwm->hwpwm.
> Make it unsigned int as well.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Hi Uwe,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 5e48584e3bd4..009f9c1a5eca 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -308,7 +308,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return ret;
>  }
>  
> -static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
> +static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
>  			    int duty_ns, int period_ns)
>  {
>  	unsigned long long prd, div, dty;
> @@ -371,7 +371,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
>  	return 0;
>  }
>  
> -static int stm32_pwm_set_polarity(struct stm32_pwm *priv, int ch,
> +static int stm32_pwm_set_polarity(struct stm32_pwm *priv, unsigned int ch,
>  				  enum pwm_polarity polarity)
>  {
>  	u32 mask;
> @@ -386,7 +386,7 @@ static int stm32_pwm_set_polarity(struct stm32_pwm *priv, int ch,
>  	return 0;
>  }
>  
> -static int stm32_pwm_enable(struct stm32_pwm *priv, int ch)
> +static int stm32_pwm_enable(struct stm32_pwm *priv, unsigned int ch)
>  {
>  	u32 mask;
>  	int ret;
> @@ -411,7 +411,7 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, int ch)
>  	return 0;
>  }
>  
> -static void stm32_pwm_disable(struct stm32_pwm *priv, int ch)
> +static void stm32_pwm_disable(struct stm32_pwm *priv, unsigned int ch)
>  {
>  	u32 mask;
>  
