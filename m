Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDA67C51CA
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Oct 2023 13:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjJKLW5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 11 Oct 2023 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJKLWq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Oct 2023 07:22:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A673E136
        for <linux-pwm@vger.kernel.org>; Wed, 11 Oct 2023 04:22:22 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S59Kw1ZCYz6K61b;
        Wed, 11 Oct 2023 19:20:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:22:20 +0100
Date:   Wed, 11 Oct 2023 12:22:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH 06/11] pwm: imx-tpm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
 functions
Message-ID: <20231011122219.00002972@Huawei.com>
In-Reply-To: <20231010075112.755178-7-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
        <20231010075112.755178-7-u.kleine-koenig@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 10 Oct 2023 09:51:07 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
> care about when the functions are actually used, so the corresponding
> __maybe_unused can be dropped.
> 
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pwm/pwm-imx-tpm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 98ab65c89685..da22f9bb367e 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -390,7 +390,7 @@ static void pwm_imx_tpm_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(tpm->clk);
>  }
>  
> -static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
> +static int pwm_imx_tpm_suspend(struct device *dev)
>  {
>  	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
>  
> @@ -409,7 +409,7 @@ static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
> +static int pwm_imx_tpm_resume(struct device *dev)
>  {
>  	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
>  	int ret = 0;
> @@ -421,8 +421,8 @@ static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
> -			 pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
> +				pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
>  
>  static const struct of_device_id imx_tpm_pwm_dt_ids[] = {
>  	{ .compatible = "fsl,imx7ulp-pwm", },
> @@ -434,7 +434,7 @@ static struct platform_driver imx_tpm_pwm_driver = {
>  	.driver = {
>  		.name = "imx7ulp-tpm-pwm",
>  		.of_match_table = imx_tpm_pwm_dt_ids,
> -		.pm = &imx_tpm_pwm_pm,
> +		.pm = pm_ptr(&imx_tpm_pwm_pm),
>  	},
>  	.probe	= pwm_imx_tpm_probe,
>  	.remove_new = pwm_imx_tpm_remove,

