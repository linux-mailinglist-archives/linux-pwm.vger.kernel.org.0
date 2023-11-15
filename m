Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300FD7EBEFC
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Nov 2023 10:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjKOJCs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Nov 2023 04:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOJCs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Nov 2023 04:02:48 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE3114
        for <linux-pwm@vger.kernel.org>; Wed, 15 Nov 2023 01:02:44 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AF60kvO030368;
        Wed, 15 Nov 2023 10:02:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=jTZBldcCzRDJ/o8lXUBW/3C7mfzdAv5i1O3ggFoUvFI=; b=tL
        5FgaC0lzWW6JxZeMpzYkqXEhUG34Ha88Wb/2Y3+e2cfcP3Gr5Tfwmz3yoDL/HOkV
        YVf+fdPOy2AoWaz7MkjOcUiNh+zCIc4FZPyxB5fdIvcDts5xWizMds12VxxJFVMm
        n5pBUOaBp062FpyH+9G7ewIsVj5qHyVC4T55rncpInU5waK6KaIZlMRzeYECJSYJ
        dGYTUxB3R85KAEJGfzk1OxavZltJ6+zrxaiZ2bkmc4etB2sICpyO4VeC0ic6x+Rh
        uHts/PP2oNzqRpBY4ykWdubF8qVLFyGuj+oyT7GUin69ATaWKv5+e7t4cQ8hQv4f
        S1uAGjg5nv8Z9/oKiL9g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1u1yr32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 10:02:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 456FC100053;
        Wed, 15 Nov 2023 10:02:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3BA6521B536;
        Wed, 15 Nov 2023 10:02:22 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 15 Nov
 2023 10:02:21 +0100
Message-ID: <e7034e83-7c1a-4706-8382-536b260284eb@foss.st.com>
Date:   Wed, 15 Nov 2023 10:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] pwm: stm32: Fix enable count for clk in .probe()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>, <kernel@pengutronix.de>,
        <linux-pwm@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
 <20231019200658.1754190-12-u.kleine-koenig@pengutronix.de>
 <c2da3f60-595c-4938-809a-c5640388c13c@foss.st.com>
 <20231114212009.44r742f3xqosswod@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231114212009.44r742f3xqosswod@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_07,2023-11-14_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/14/23 22:20, Uwe Kleine-König wrote:
> On Tue, Nov 14, 2023 at 02:35:19PM +0100, Fabrice Gasnier wrote:
>> On 10/19/23 22:07, Uwe Kleine-König wrote:
>>> From: Philipp Zabel <p.zabel@pengutronix.de>
>>>
>>> Make the driver take over hardware state without disabling in .probe()
>>> and enable the clock for each enabled channel.
>>>
>>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>> [ukleinek: split off from a patch that also implemented .get_state()]
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> ---
>>>  drivers/pwm/pwm-stm32.c | 18 ++++++++++++++----
>>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>>
>> Hi Uwe,
>>
>> I'd only have a suggestion on the commit title:
>> pwm: stm32: Fix enable count for clk in .probe()
>>             ^
>> On first sight, the "Fix" may suggest that this fixes something older in
>> the tree. This would suggest a Fixes tag which isn't the case in this
>> series, as this is a split of the .get_state() patch.
>> Is it possible to rephrase ?
> 
> IMHO it is a fix, the hw state wasn't properly taken over before.

Hi Uwe,

Indeed, the HW state wasn't taken. Instead the driver used to be
forcibly stop each channel: regmap_clear_bits(priv->regmap, TIM_CCER,
TIM_CCER_CCXE);
So the clk enable count (of 0) reflects this. That's kind of consistent
state.

> If you want a Fixes line, that's:
> 
> Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")

Well, the original driver didn't implement the .get_state.
BUT, more thinking about this, I think it lacks to read the global
enable status of the timer, e.g. TIM_CR1_CEN.

Original driver stops each channel (clear CCXE), but after probing, the
global TIM_CR1_CEN bit may remains 1 (from bootloader), without a
running clock.

If we're talking about fixing the original driver (probably unrelevant
without a working .get_state), then I think this part is missing.

(with or without a Fixes tag) Could you add a check on global counter
enable bit (TIM_CR1_CEN) both in the .get_state(), and in the
stm32_pwm_detect_channels(), that counts the num_enabled channels ?

In case the TIM_CR1_CEN isn't set (but some of the TIM_CCER_CCXE are),
the driver will report enabled channels. But physically, the pwm output
will be inactive.
That's more a robustness case... depending on what's been done possibly
by bootloader. What to you think ?

> 
>> something like: set clk enable count when probing channels ?
>>
>> Apart from that, you can add my:
>> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>
>> ---
>> I've additional questions, unrelated to this patch. I had a look at
>> pwm-stm32-lp.c, the clock enabling is done directly in the .get_state()
>> routine. I think this should be moved to the .probe() routine as done
>> here. There's likely a risk, that clk enable count gets increased
>> artificially, at least since commit cfc4c189bc70 "pwm: Read initial
>> hardware state at request time".
>> Shall I send a patch for pwm-stm32-lp.c, similar as this patch ? Or has
>> it been spotted already ?
> 
> I'm not aware of someone working on stm32-lp, so feel free to prepare a
> patch!

Ok thanks! Will look into it.
Best Regards,
Fabrice

> 
> Best regards and thanks for your review,
> Uwe
> 
