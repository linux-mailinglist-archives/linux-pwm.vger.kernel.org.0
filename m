Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182BE7EB12B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 14:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjKNNrZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 08:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjKNNrY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 08:47:24 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C7BA
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 05:47:20 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AEBdFkk018228;
        Tue, 14 Nov 2023 14:47:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=GPfXh45l5xjoW/qmzZsmUNCc8lVGCMSh/mwfCaeACY4=; b=NP
        +GI5c3axXAl/0GyQ6++oiy7d6p0IfmsPFANf+zhG8pl+jmFHxGG9UIfa76fRa58f
        PhIbwLz81axJ6mv7mboDBVYp2Pmw64wIrBT9LagleoYTSRnaTkCBeBD1Ddb9sLsH
        5zKXaZz3OmIVuqVBFZp5d4AK7NPl4BqqryIJiescB0SeuUkRQt86qhqk+BljJcXh
        229roZr4wzkJuNGimJ4NsrPz5j8ZdbyNte9IATy8jwxbfI1imIH3siR/k4UA4P7D
        1j84psH/y9Ob10du3gKY2jrREfoxfuSNUVZjC+NHdVOJCiBgkTaceDafLPmF14Vd
        4cJyPGprIYsjGq2t6PIg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1ch41yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:47:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E006100057;
        Tue, 14 Nov 2023 14:47:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 941F02132FB;
        Tue, 14 Nov 2023 14:47:07 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 14 Nov
 2023 14:47:05 +0100
Message-ID: <95ec2b8d-8805-4ef9-9573-d796755f24d1@foss.st.com>
Date:   Tue, 14 Nov 2023 14:47:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] pwm: stm32-lp: Use DEFINE_SIMPLE_DEV_PM_OPS for
 PM functions
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
 <20231023174616.2282067-21-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231023174616.2282067-21-u.kleine-koenig@pengutronix.de>
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
>  drivers/pwm/pwm-stm32-lp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Hi Uwe,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for the cleanups.
Fabrice

> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index b67974cc1872..439068f3eca1 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -218,7 +218,7 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
> +static int stm32_pwm_lp_suspend(struct device *dev)
>  {
>  	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
>  	struct pwm_state state;
> @@ -233,13 +233,13 @@ static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
>  	return pinctrl_pm_select_sleep_state(dev);
>  }
>  
> -static int __maybe_unused stm32_pwm_lp_resume(struct device *dev)
> +static int stm32_pwm_lp_resume(struct device *dev)
>  {
>  	return pinctrl_pm_select_default_state(dev);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
> -			 stm32_pwm_lp_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
> +				stm32_pwm_lp_resume);
>  
>  static const struct of_device_id stm32_pwm_lp_of_match[] = {
>  	{ .compatible = "st,stm32-pwm-lp", },
> @@ -252,7 +252,7 @@ static struct platform_driver stm32_pwm_lp_driver = {
>  	.driver	= {
>  		.name = "stm32-pwm-lp",
>  		.of_match_table = stm32_pwm_lp_of_match,
> -		.pm = &stm32_pwm_lp_pm_ops,
> +		.pm = pm_ptr(&stm32_pwm_lp_pm_ops),
>  	},
>  };
>  module_platform_driver(stm32_pwm_lp_driver);
