Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4EC7EE3E0
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Nov 2023 16:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbjKPPFe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Nov 2023 10:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345400AbjKPPFc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Nov 2023 10:05:32 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A49D4A
        for <linux-pwm@vger.kernel.org>; Thu, 16 Nov 2023 07:05:27 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AGEbDG3015626;
        Thu, 16 Nov 2023 16:05:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=foZ+0zsZkQOMr0h9cc6snUTMOiYLnKSLyxuVrbJeOlY=; b=RD
        M4EIh0ZX45jr20tRYkGMMjBqcLyyBK41WSOUDI3Jgf5MB6f7rRt2hhMLqueTCGXg
        DG3Ko487dQKAAa1brKW07f/sBMbnUNM2MrW/YPwyOkb2NX8HyTV6IdyytP9Ddd0O
        3v7ng8vVWBeqDL3NMMJGHUhEE/w5HoQuXALNVztGT/1X+6LDf33keSohTGExPSQU
        25fsdk7Y0Q7Boo7BV2evUq8dF9BLNMnIuOEdxZslaOkauaom27k4otDRC52gmu09
        6NuUYts9qmPGmYQX6tvK9YUyNnPdbHR3mxuvFeMvABTxYBHzCNYeV8XJs4wdYxcH
        W8q9yaWVB/h9vMEfYWkQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3udn0m03s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 16:05:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68937100056;
        Thu, 16 Nov 2023 16:05:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5E233235F02;
        Thu, 16 Nov 2023 16:05:06 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 16 Nov
 2023 16:05:05 +0100
Message-ID: <363a8b67-1b6d-49e3-a2e0-3a0c97759ada@foss.st.com>
Date:   Thu, 16 Nov 2023 16:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] pwm: stm32: Fix enable count for clk in .probe()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
 <20231019200658.1754190-12-u.kleine-koenig@pengutronix.de>
 <c2da3f60-595c-4938-809a-c5640388c13c@foss.st.com>
 <20231114212009.44r742f3xqosswod@pengutronix.de>
 <e7034e83-7c1a-4706-8382-536b260284eb@foss.st.com>
 <20231115210155.p6m5rbahpzusy6bc@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231115210155.p6m5rbahpzusy6bc@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_15,2023-11-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/15/23 22:01, Uwe Kleine-König wrote:
> Hello Fabrice,
> 
> On Wed, Nov 15, 2023 at 10:02:20AM +0100, Fabrice Gasnier wrote:
>> (with or without a Fixes tag) Could you add a check on global counter
>> enable bit (TIM_CR1_CEN) both in the .get_state(), and in the
>> stm32_pwm_detect_channels(), that counts the num_enabled channels ?
> 
> I'd address that separately, mostly because the patches forwarded here
> are not mine.

Ok, let's go this way.

> 
>> In case the TIM_CR1_CEN isn't set (but some of the TIM_CCER_CCXE are),
>> the driver will report enabled channels. But physically, the pwm output
>> will be inactive.
> 
> Huuu, that means if channel #0 is running and I start a capture on
> channel #1 which results in unconditionally calling
> regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN); (in
> stm32_pwm_raw_capture()) channel #0 stops to toggle!

Basically no, please find my answers sent separately on "[PATCH] pwm:
stm32: Mark capture support as broken"

> 
>> That's more a robustness case... depending on what's been done possibly
>> by bootloader. What to you think ?
> 
> I would assume that a bootloader that sets the CCXE bits also enables
> TIM_CR1_CEN and so in practise Philipp's patch is fine. But I agree that
> doing things properly would be better.

ok, thanks,
Best Regards,
Fabrice
> 
> Best regards
> Uwe
> 
