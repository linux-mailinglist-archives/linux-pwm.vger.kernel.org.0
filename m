Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568177EB12F
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 14:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjKNNro (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 08:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjKNNrl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 08:47:41 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609DD42
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 05:47:38 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AEBSCt8010156;
        Tue, 14 Nov 2023 14:47:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=gPgWQLbGuX1xfMN6bhRJjTURxQgjWKKVTTzmR4O4jPk=; b=Wt
        zrPVyq4nBAgLoKTm8L3YI+acv5Uuo9ZlWkvipuul/Gxl/ecrDFPiHaljpZQ8Kz1u
        N86JYTmIXvmPpuRusjBieiB9aLs/j8vNr0tECAcQNSbIV3D8drOH0BM6wZ8lEZgX
        NkV4fPElagc4X9deTo67dtaxR09AeRqAUw71gQgx7IMsuIa3lDa8RNOZqvMB7lrA
        b1m8quHWcoy3msgNItrJSauo7X+JhkHSpa3M8YGma9ciKX6OwM7qFPtLMYj7RVzX
        dieM+/YVxpMFIGHuBfNieO7nQyjxDqKH3yEbP5Jh0AfwtcnMKWE4kga+HpYjE7YK
        S8Gsq+UFVAUiAxnFa/2Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1u1uxtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:47:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E7F4100065;
        Tue, 14 Nov 2023 14:47:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3A97F2138CA;
        Tue, 14 Nov 2023 14:47:20 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 14 Nov
 2023 14:47:19 +0100
Message-ID: <c33b4dac-e29c-4568-964e-7b578ff64f17@foss.st.com>
Date:   Tue, 14 Nov 2023 14:47:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] pwm: stm32: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
 functions
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
 <20231023174616.2282067-22-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231023174616.2282067-22-u.kleine-koenig@pengutronix.de>
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

On 10/23/23 19:46, Uwe Kleine-König wrote:
> This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
> care about when the functions are actually used, so the corresponding
> __maybe_unused can be dropped.
> 
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Hi Uwe,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for the cleanups.
Fabrice
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 3303a754ea02..8be037757b8b 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -645,7 +645,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_pwm_suspend(struct device *dev)
> +static int stm32_pwm_suspend(struct device *dev)
>  {
>  	struct stm32_pwm *priv = dev_get_drvdata(dev);
>  	unsigned int i;
> @@ -666,7 +666,7 @@ static int __maybe_unused stm32_pwm_suspend(struct device *dev)
>  	return pinctrl_pm_select_sleep_state(dev);
>  }
>  
> -static int __maybe_unused stm32_pwm_resume(struct device *dev)
> +static int stm32_pwm_resume(struct device *dev)
>  {
>  	struct stm32_pwm *priv = dev_get_drvdata(dev);
>  	int ret;
> @@ -679,7 +679,7 @@ static int __maybe_unused stm32_pwm_resume(struct device *dev)
>  	return stm32_pwm_apply_breakinputs(priv);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
>  
>  static const struct of_device_id stm32_pwm_of_match[] = {
>  	{ .compatible = "st,stm32-pwm",	},
> @@ -692,7 +692,7 @@ static struct platform_driver stm32_pwm_driver = {
>  	.driver	= {
>  		.name = "stm32-pwm",
>  		.of_match_table = stm32_pwm_of_match,
> -		.pm = &stm32_pwm_pm_ops,
> +		.pm = pm_ptr(&stm32_pwm_pm_ops),
>  	},
>  };
>  module_platform_driver(stm32_pwm_driver);
