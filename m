Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C317C51CF
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Oct 2023 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjJKLXM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 11 Oct 2023 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJKLXA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Oct 2023 07:23:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E9B6;
        Wed, 11 Oct 2023 04:22:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S59NR14qSz6K6fp;
        Wed, 11 Oct 2023 19:22:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:22:51 +0100
Date:   Wed, 11 Oct 2023 12:22:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <kernel@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH 07/11] pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
 functions
Message-ID: <20231011122250.00004e96@Huawei.com>
In-Reply-To: <20231010075112.755178-8-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
        <20231010075112.755178-8-u.kleine-koenig@pengutronix.de>
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

On Tue, 10 Oct 2023 09:51:08 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
> care about when the functions are actually used, so the corresponding
> #ifdef can be dropped.
> 
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pwm/pwm-samsung.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index e8828f57ab15..041e2f9476ff 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -630,7 +630,6 @@ static void pwm_samsung_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(chip->base_clk);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int pwm_samsung_resume(struct device *dev)
>  {
>  	struct samsung_pwm_chip *our_chip = dev_get_drvdata(dev);
> @@ -663,14 +662,13 @@ static int pwm_samsung_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(pwm_samsung_pm_ops, NULL, pwm_samsung_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(pwm_samsung_pm_ops, NULL, pwm_samsung_resume);
>  
>  static struct platform_driver pwm_samsung_driver = {
>  	.driver		= {
>  		.name	= "samsung-pwm",
> -		.pm	= &pwm_samsung_pm_ops,
> +		.pm	= pm_ptr(&pwm_samsung_pm_ops),
>  		.of_match_table = of_match_ptr(samsung_pwm_matches),
>  	},
>  	.probe		= pwm_samsung_probe,

