Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED87D49B3
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Oct 2023 10:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjJXIPw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Oct 2023 04:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjJXHo2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Oct 2023 03:44:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4A9B7
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698133466; x=1729669466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UWsk3wRzyFM05ANVRF7Vq8Nt6NuNDTN6URxMBk+lxhY=;
  b=a5k/wDZnBV6FA6PtCFDPYeqPrrYDg4GjI2PbS1DhmdA/Fpc0MbBn6Muu
   Kkdf3G/6YoQ6UGxNC4d2hOZj8GTdtPl8eVEB2kj3of+aVt4+H/F0iRS+T
   DwyAzgKQy9mWB5wyC78wd00LnZGbL/dx09xdXHiyyoaExofwB659B2OOY
   BHZkCgw2tdXO5D8eXzy4/EIMoSv0iOa4fIbRRtZxU3TsR5tgF1sg8IhyG
   kp1VMtSfnOUE3TAp3OBkavput4Jpx+C3cVQSjoxrv7pEDdQnCFCjiEDfT
   e9j/oHr7Pirxma3fJ4BU77djpo0m9vHpi6pwV9H9unI5M1P1+DNSzYhbH
   w==;
X-CSE-ConnectionGUID: cqGc5osmQsquJVDgRwckmw==
X-CSE-MsgGUID: jWqu4dinRsOrBzGt1iFo0A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="10590949"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2023 00:44:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 24 Oct 2023 00:44:09 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 24 Oct 2023 00:44:07 -0700
Message-ID: <3e40b74c-11b5-4355-b90d-e6f455729586@microchip.com>
Date:   Tue, 24 Oct 2023 09:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for
 PM functions
Content-Language: en-US, fr-FR
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
 <20231023174616.2282067-15-u.kleine-koenig@pengutronix.de>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20231023174616.2282067-15-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/10/2023 at 19:46, Uwe Kleine-König wrote:
> This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
> care about when the functions are actually used, so the corresponding
> #ifdef can be dropped.

Commit message is fine ;-)

> 
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks Uwe for this cleanup. Best regards,
   Nicolas

> ---
>   drivers/pwm/pwm-atmel-tcb.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 98b33c016c3c..d42c897cb85e 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -489,7 +489,6 @@ static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
> 
> -#ifdef CONFIG_PM_SLEEP
>   static int atmel_tcb_pwm_suspend(struct device *dev)
>   {
>          struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
> @@ -522,16 +521,15 @@ static int atmel_tcb_pwm_resume(struct device *dev)
> 
>          return 0;
>   }
> -#endif
> 
> -static SIMPLE_DEV_PM_OPS(atmel_tcb_pwm_pm_ops, atmel_tcb_pwm_suspend,
> -                        atmel_tcb_pwm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(atmel_tcb_pwm_pm_ops, atmel_tcb_pwm_suspend,
> +                               atmel_tcb_pwm_resume);
> 
>   static struct platform_driver atmel_tcb_pwm_driver = {
>          .driver = {
>                  .name = "atmel-tcb-pwm",
>                  .of_match_table = atmel_tcb_pwm_dt_ids,
> -               .pm = &atmel_tcb_pwm_pm_ops,
> +               .pm = pm_ptr(&atmel_tcb_pwm_pm_ops),
>          },
>          .probe = atmel_tcb_pwm_probe,
>          .remove_new = atmel_tcb_pwm_remove,
> --
> 2.42.0
> 

