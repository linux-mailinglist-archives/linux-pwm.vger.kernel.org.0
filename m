Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A34D63E705
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 02:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLABSE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 20:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLABSD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 20:18:03 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A525C772
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 17:18:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VW4uAYm_1669857479;
Received: from 30.97.48.64(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VW4uAYm_1669857479)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 09:18:00 +0800
Message-ID: <0b2d9ae3-94f8-d01f-d9e4-440e85b5cddf@linux.alibaba.com>
Date:   Thu, 1 Dec 2022 09:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 10/11] pwm: sprd: Propagate errors in .get_state() to
 the caller
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-11-u.kleine-koenig@pengutronix.de>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221130152148.2769768-11-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 11/30/2022 11:21 PM, Uwe Kleine-König wrote:
> .get_state() can return an error indication. Make use of it to propagate
> failing hardware accesses.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/pwm/pwm-sprd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index bda8bc5af976..d866ce345f97 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -83,7 +83,7 @@ static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (ret) {
>   		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
>   			pwm->hwpwm);
> -		return 0;
> +		return ret;
>   	}
>   
>   	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE);
