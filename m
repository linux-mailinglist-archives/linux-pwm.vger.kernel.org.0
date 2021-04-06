Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCF355428
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 14:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbhDFMp6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 08:45:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22409 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243129AbhDFMp4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 08:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617713148; x=1649249148;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RreDx+hwN2KnXkp9m1HiIofVELZL3wH0B1Z6ElipDUE=;
  b=W7B5n/eNidvf3z0hLE3BFO68MbGw2xGgJ3dW65WDG0/SWf4Ff7xE5DR2
   aNM0mw27gmNGegYE3YRaR3+68V2gI30SPXdjZ+C9fZtifP2wknCeN+dsX
   6lNLSFeM+2nA2zz7PkI71c+5vZkCcfGC+p3wMLyTKRVSmoOj2pGA1zXDj
   k/NhOzEif3LkWuP6iISyRurUzpTZQJUbASottQH2ur6CftYVebRWPjq1Y
   bXX+uKJ2SzWDs7V/UhlMJMx1cpvVSXytHG8Y8plKQe5kENldb6OqzRhJu
   klaC+nHwcEdtsG5/I7o8CRECMyFKVrK6CpdLwrjrcN5HOOuxzzYcR3V5s
   w==;
IronPort-SDR: bk5v5L8RKiVbpr7+Ht/C5p3cQaLbTYxYccOH8PkaSW3cOUi+ISO2Q7nczzQ+UNBfYUgVyER4W9
 k6BLwxcnukxiq0QNCjwzpuBsyyzrJW1iIQsfaDwAznHC6x69qBhjiUFCj7JxPMba5KqaTQynhd
 +4CUtljX29b1yJvhlbYHW9zyC6qal1zv7JYWiNyQrM+QRxbj3FSrHFN8bBpYQKQdlb7YUH8rV6
 QpflU3athueaDCHVPHZco1jJvFyr5vsWfNvRPNFIt1IVjAIOWFJI0TqEg7Gf6D42+7lHs1Vk3H
 bWY=
X-IronPort-AV: E=Sophos;i="5.81,309,1610434800"; 
   d="scan'208";a="115984629"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2021 05:45:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 05:45:43 -0700
Received: from [10.12.73.192] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 6 Apr 2021 05:45:41 -0700
Subject: Re: [PATCH v4 3/6] pwm: atmel: Simplify using devm_clk_get_prepared()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <kernel@pengutronix.de>,
        <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
 <20210330181755.204339-4-u.kleine-koenig@pengutronix.de>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <822218d0-6b28-98d9-c23a-2dc3c3f0c84a@microchip.com>
Date:   Tue, 6 Apr 2021 14:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330181755.204339-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 30/03/2021 at 20:17, Uwe Kleine-König wrote:
> With devm_clk_get_prepared() caring to unprepare the clock the error
> path and remove callback can be simplified accordingly.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/pwm/pwm-atmel.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 5813339b597b..d65e23da2582 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -415,16 +415,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
>          if (IS_ERR(atmel_pwm->base))
>                  return PTR_ERR(atmel_pwm->base);
> 
> -       atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
> +       atmel_pwm->clk = devm_clk_get_prepared(&pdev->dev, NULL);
>          if (IS_ERR(atmel_pwm->clk))
>                  return PTR_ERR(atmel_pwm->clk);
> 
> -       ret = clk_prepare(atmel_pwm->clk);
> -       if (ret) {
> -               dev_err(&pdev->dev, "failed to prepare PWM clock\n");
> -               return ret;
> -       }
> -
>          atmel_pwm->chip.dev = &pdev->dev;
>          atmel_pwm->chip.ops = &atmel_pwm_ops;
>          atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> @@ -435,23 +429,18 @@ static int atmel_pwm_probe(struct platform_device *pdev)
>          ret = pwmchip_add(&atmel_pwm->chip);
>          if (ret < 0) {
>                  dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
> -               goto unprepare_clk;
> +               return ret;
>          }
> 
>          platform_set_drvdata(pdev, atmel_pwm);
> 
>          return ret;
> -
> -unprepare_clk:
> -       clk_unprepare(atmel_pwm->clk);
> -       return ret;
>   }
> 
>   static int atmel_pwm_remove(struct platform_device *pdev)
>   {
>          struct atmel_pwm_chip *atmel_pwm = platform_get_drvdata(pdev);
> 
> -       clk_unprepare(atmel_pwm->clk);
>          mutex_destroy(&atmel_pwm->isr_lock);
> 
>          return pwmchip_remove(&atmel_pwm->chip);
> --
> 2.30.2
> 


-- 
Nicolas Ferre
