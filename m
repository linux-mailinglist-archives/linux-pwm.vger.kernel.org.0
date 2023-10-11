Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4D7C51C6
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Oct 2023 13:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjJKLWq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 11 Oct 2023 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbjJKLWd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Oct 2023 07:22:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02E12699
        for <linux-pwm@vger.kernel.org>; Wed, 11 Oct 2023 04:20:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S59J648TXz6K61b;
        Wed, 11 Oct 2023 19:18:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:20:46 +0100
Date:   Wed, 11 Oct 2023 12:20:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/11] pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for
 PM functions
Message-ID: <20231011122045.00000500@Huawei.com>
In-Reply-To: <20231010075112.755178-3-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
        <20231010075112.755178-3-u.kleine-koenig@pengutronix.de>
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

On Tue, 10 Oct 2023 09:51:03 +0200
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

I did a lot of these so I still have how it works fresh in my mind
making review hopefully easy :)

> ---
>  drivers/pwm/pwm-atmel-tcb.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index c00dd37c5fbd..a2be4cb4c073 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -490,7 +490,6 @@ static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int atmel_tcb_pwm_suspend(struct device *dev)
>  {
>  	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
> @@ -523,16 +522,15 @@ static int atmel_tcb_pwm_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(atmel_tcb_pwm_pm_ops, atmel_tcb_pwm_suspend,
> -			 atmel_tcb_pwm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(atmel_tcb_pwm_pm_ops, atmel_tcb_pwm_suspend,
> +				atmel_tcb_pwm_resume);
>  
>  static struct platform_driver atmel_tcb_pwm_driver = {
>  	.driver = {
>  		.name = "atmel-tcb-pwm",
>  		.of_match_table = atmel_tcb_pwm_dt_ids,
> -		.pm = &atmel_tcb_pwm_pm_ops,
> +		.pm = pm_ptr(&atmel_tcb_pwm_pm_ops),
>  	},
>  	.probe = atmel_tcb_pwm_probe,
>  	.remove_new = atmel_tcb_pwm_remove,

