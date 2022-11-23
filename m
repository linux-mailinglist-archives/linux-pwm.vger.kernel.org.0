Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF79635A55
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 11:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiKWKj5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Nov 2022 05:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiKWKjZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Nov 2022 05:39:25 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9DB12D33
        for <linux-pwm@vger.kernel.org>; Wed, 23 Nov 2022 02:23:43 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN7WZj9023248;
        Wed, 23 Nov 2022 11:23:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=aRGfu+c5NaAQpXxdGToTual+Y1cMXTMKRyYCCxqaSnA=;
 b=fBuW5mmsENRNR7Ols/4jy4lj5nI9caW2YRQRtJ7shebyi9f7yzjxJJ2VQqK6r9yFUAS3
 EbzlvZJOm+wFfa+gG+TFwboWpP+dNKTYGJy2YjMdnY+otlo9l/e4WLyVeie/rqRzz238
 MADGVohZdNQgM4Hd1XBQ0gvbZUHMBptGdOR7eB1JFOSXoa85+4JlM+hFBFGCIgSGvoen
 8mBCmHefIIl1pBp3yecQpgoxVTvYDgsEKRImGTjLKq85Hc9YSqaHxOHJmHpgCqkBhnXU
 u8cNuEFNO98aN2DQi22uKyaNyTzg9BgUbHgf3VOPq9O/rmzPKaCcIEz8ICX5vyOMoVSc qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m10c4dr6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 11:23:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8562B100034;
        Wed, 23 Nov 2022 11:23:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DF75218CFF;
        Wed, 23 Nov 2022 11:23:18 +0100 (CET)
Received: from [10.48.1.102] (10.48.1.102) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 23 Nov
 2022 11:23:15 +0100
Message-ID: <b474ef48-f77b-807b-ce12-f5a200459933@foss.st.com>
Date:   Wed, 23 Nov 2022 11:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/5] pwm: stm32-lp: Use regmap_clear_bits and
 regmap_set_bits where applicable
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
 <20221115111347.3705732-5-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20221115111347.3705732-5-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_04,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/15/22 12:13, Uwe Kleine-König wrote:
> Found using coccinelle and the following semantic patch:
> 
> @@
> expression map, reg, bits;
> @@
> 
> - regmap_update_bits(map, reg, bits, bits)
> + regmap_set_bits(map, reg, bits)
> 
> @@
> expression map, reg, bits;
> @@
> 
> - regmap_update_bits(map, reg, bits, 0)
> + regmap_clear_bits(map, reg, bits)
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 3115abb3f52a..212bdc7d51ee 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -140,9 +140,8 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	if (reenable) {
>  		/* Start LP timer in continuous mode */
> -		ret = regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
> -					 STM32_LPTIM_CNTSTRT,
> -					 STM32_LPTIM_CNTSTRT);
> +		ret = regmap_set_bits(priv->regmap, STM32_LPTIM_CR,
> +				      STM32_LPTIM_CNTSTRT);

Hi Uwe,

One minor suggestion here: could fit into a single line.

You can add my:
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Thanks
Fabrice

>  		if (ret) {
>  			regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>  			goto err;
