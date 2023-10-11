Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9E7C51BE
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Oct 2023 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346720AbjJKLVI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 11 Oct 2023 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346400AbjJKLUh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Oct 2023 07:20:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4C18C
        for <linux-pwm@vger.kernel.org>; Wed, 11 Oct 2023 04:19:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S59Js0lGPz6K6nF;
        Wed, 11 Oct 2023 19:19:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:19:45 +0100
Date:   Wed, 11 Oct 2023 12:19:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/11] pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS
 for PM functions
Message-ID: <20231011121944.0000378e@Huawei.com>
In-Reply-To: <20231010075112.755178-2-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
        <20231010075112.755178-2-u.kleine-koenig@pengutronix.de>
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

On Tue, 10 Oct 2023 09:51:02 +0200
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
>  drivers/pwm/pwm-atmel-hlcdc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index e271d920151e..95a806c7f623 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -181,7 +181,6 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
>  	.div1_clk_erratum = true,
>  };
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int atmel_hlcdc_pwm_suspend(struct device *dev)
>  {
>  	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
> @@ -211,10 +210,9 @@ static int atmel_hlcdc_pwm_resume(struct device *dev)
>  	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
>  				     &state);
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
> -			 atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
> +				atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
>  
>  static const struct of_device_id atmel_hlcdc_dt_ids[] = {
>  	{
> @@ -298,7 +296,7 @@ static struct platform_driver atmel_hlcdc_pwm_driver = {
>  	.driver = {
>  		.name = "atmel-hlcdc-pwm",
>  		.of_match_table = atmel_hlcdc_pwm_dt_ids,
> -		.pm = &atmel_hlcdc_pwm_pm_ops,
> +		.pm = pm_ptr(&atmel_hlcdc_pwm_pm_ops),
>  	},
>  	.probe = atmel_hlcdc_pwm_probe,
>  	.remove_new = atmel_hlcdc_pwm_remove,

