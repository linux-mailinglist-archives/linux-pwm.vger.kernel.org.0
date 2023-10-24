Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772A7D48D7
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Oct 2023 09:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjJXHoF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Oct 2023 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjJXHoE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Oct 2023 03:44:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED10B128
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698133436; x=1729669436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vrCz2QVYVFKF2QhWvOAOh0RDWmITta3TW2s1sbxJbSI=;
  b=iKzG9rWcG/XFZp78glYZDGCKLvqx++AMsSdw+4eR/tjUYIRwTIpo0WCR
   BIubKaJPN2EHXc3C1MzYlNOY2kovQPdLUGUJd6ZI55Th2SmAPddfixUa5
   DYM0bzQydLuQC5e4oCsfo/OmWcpnyH8S1N34geOc5FkEaNG5Wc9Zl001A
   XINCUlAS3WGRgRxd87bte8uDFFjdbNJUmch/mSif5ZMUsSEBwXja1Jq/Y
   LK6Sdp3wOGAplocGJ6IjVC1BgA4rrvPiPi9y6r3NA8aVUyT7rlc1yrjJ7
   6XDl4gO6t/czbRlkiMyqOKBUiMZw8Ri4LM9OWTvOCrkK3pXWt/1+nXTm6
   A==;
X-CSE-ConnectionGUID: T6FouotJTrS9Zheu/Quo4A==
X-CSE-MsgGUID: 7zlp7MJGTa+Z+KUfnfgCkQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="10493903"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2023 00:43:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 24 Oct 2023 00:43:22 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 24 Oct 2023 00:43:21 -0700
Message-ID: <a24c273a-487b-4654-906d-0ff516027707@microchip.com>
Date:   Tue, 24 Oct 2023 09:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS
 for PM functions
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
 <20231023174616.2282067-14-u.kleine-koenig@pengutronix.de>
Content-Language: en-US, fr-FR
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20231023174616.2282067-14-u.kleine-koenig@pengutronix.de>
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
> 
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/pwm/pwm-atmel-hlcdc.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 07920e034757..3f2c5031a3ba 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -180,7 +180,6 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
>          .div1_clk_erratum = true,
>   };
> 
> -#ifdef CONFIG_PM_SLEEP
>   static int atmel_hlcdc_pwm_suspend(struct device *dev)
>   {
>          struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
> @@ -210,10 +209,9 @@ static int atmel_hlcdc_pwm_resume(struct device *dev)
>          return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
>                                       &state);
>   }
> -#endif
> 
> -static SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
> -                        atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
> +                               atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
> 
>   static const struct of_device_id atmel_hlcdc_dt_ids[] = {
>          {
> @@ -297,7 +295,7 @@ static struct platform_driver atmel_hlcdc_pwm_driver = {
>          .driver = {
>                  .name = "atmel-hlcdc-pwm",
>                  .of_match_table = atmel_hlcdc_pwm_dt_ids,
> -               .pm = &atmel_hlcdc_pwm_pm_ops,
> +               .pm = pm_ptr(&atmel_hlcdc_pwm_pm_ops),
>          },
>          .probe = atmel_hlcdc_pwm_probe,
>          .remove_new = atmel_hlcdc_pwm_remove,
> --
> 2.42.0
> 

