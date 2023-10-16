Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71E7CA5F3
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Oct 2023 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJPKpT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 16 Oct 2023 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPKpS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Oct 2023 06:45:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2753695
        for <linux-pwm@vger.kernel.org>; Mon, 16 Oct 2023 03:45:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8DJY3KTHz6K8tv;
        Mon, 16 Oct 2023 18:44:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 11:45:13 +0100
Date:   Mon, 16 Oct 2023 11:45:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH v2 04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for
 PM functions
Message-ID: <20231016114512.0000556a@Huawei.com>
In-Reply-To: <20231013174204.1457085-17-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
        <20231013174204.1457085-17-u.kleine-koenig@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 13 Oct 2023 19:42:09 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
> care about when the functions are actually used, so the corresponding
> 
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.
> 
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Given the bit I commented on in v1 has gone away...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pwm/pwm-brcmstb.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
> index b723c2d4f485..0fdeb0b2dbf3 100644
> --- a/drivers/pwm/pwm-brcmstb.c
> +++ b/drivers/pwm/pwm-brcmstb.c
> @@ -259,7 +259,6 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int brcmstb_pwm_suspend(struct device *dev)
>  {
>  	struct brcmstb_pwm *p = dev_get_drvdata(dev);
> @@ -275,17 +274,16 @@ static int brcmstb_pwm_resume(struct device *dev)
>  
>  	return clk_prepare_enable(p->clk);
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
>  	.driver = {
>  		.name = "pwm-brcmstb",
>  		.of_match_table = brcmstb_pwm_of_match,
> -		.pm = &brcmstb_pwm_pm_ops,
> +		.pm = pm_ptr(&brcmstb_pwm_pm_ops),
>  	},
>  };
>  module_platform_driver(brcmstb_pwm_driver);

