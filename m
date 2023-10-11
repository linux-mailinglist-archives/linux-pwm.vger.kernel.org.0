Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0347C51C7
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Oct 2023 13:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjJKLWq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 11 Oct 2023 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjJKLWd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Oct 2023 07:22:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BF810E6
        for <linux-pwm@vger.kernel.org>; Wed, 11 Oct 2023 04:21:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S59JC38KTz6J9b7;
        Wed, 11 Oct 2023 19:18:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:21:53 +0100
Date:   Wed, 11 Oct 2023 12:21:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH 04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
 functions
Message-ID: <20231011122152.00007595@Huawei.com>
In-Reply-To: <20231010075112.755178-5-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
        <20231010075112.755178-5-u.kleine-koenig@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Tue, 10 Oct 2023 09:51:05 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
> care about when the functions are actually used, so the corresponding
> #ifdef can be dropped.
> 
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.

The additional change to potentially return an error when not doing so before
wants to be called out in the description.

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-brcmstb.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
> index a3faa9a3de7c..7510b85dd9dd 100644
> --- a/drivers/pwm/pwm-brcmstb.c
> +++ b/drivers/pwm/pwm-brcmstb.c
> @@ -283,7 +283,6 @@ static void brcmstb_pwm_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(p->clk);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int brcmstb_pwm_suspend(struct device *dev)
>  {
>  	struct brcmstb_pwm *p = dev_get_drvdata(dev);
> @@ -297,14 +296,11 @@ static int brcmstb_pwm_resume(struct device *dev)
>  {
>  	struct brcmstb_pwm *p = dev_get_drvdata(dev);
>  
> -	clk_enable(p->clk);
> -
> -	return 0;
> +	return clk_enable(p->clk);
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
> -			 brcmstb_pwm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
> +				brcmstb_pwm_resume);
>  
>  static struct platform_driver brcmstb_pwm_driver = {
>  	.probe = brcmstb_pwm_probe,
> @@ -312,7 +308,7 @@ static struct platform_driver brcmstb_pwm_driver = {
>  	.driver = {
>  		.name = "pwm-brcmstb",
>  		.of_match_table = brcmstb_pwm_of_match,
> -		.pm = &brcmstb_pwm_pm_ops,
> +		.pm = pm_ptr(&brcmstb_pwm_pm_ops),
>  	},
>  };
>  module_platform_driver(brcmstb_pwm_driver);

