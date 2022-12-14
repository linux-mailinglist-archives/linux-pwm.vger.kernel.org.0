Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474A464CCE1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Dec 2022 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLNPKF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Dec 2022 10:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbiLNPKE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Dec 2022 10:10:04 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6485627B0E
        for <linux-pwm@vger.kernel.org>; Wed, 14 Dec 2022 07:10:02 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEB7JkC006574;
        Wed, 14 Dec 2022 16:09:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SIBWmy60wKzIkLVwzp7ptxbSfFJ4w6J54f2O2l/WalQ=;
 b=fvwq4tGvpIh7y8hr4Wr/1HLhwVNUB5t5ene5wIpGxZgtRboI4ZR3LOglyEvY+Ky/1NSX
 QOCsY4X7HPfG3Gosux0a+Li40jOggIw+Z0SYw37U6zsCFMTc+LsNRR++G1mL4lL9mgLv
 DgsjsVVCENmgn37cwoyCza5mcZU1H4yo4wxK+kwlq6NO8MImy/r4ZYJYQhwlnPRCWvuO
 ujOcMTkaQ5U7+G17Jm0h3dnozrEWWwLhwfbjfNPjjXTqEOxKIFYVVU9nANlbypIRfa7Y
 F5Ivf/MzJNqLWn/TPWQxLm8woJ71nnTVXUBM6Spu0AGOJTXZZ/wr7FCQLao6ewezVGSV +Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mf6v6cegb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 16:09:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3CEA2100038;
        Wed, 14 Dec 2022 16:09:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 360AF22A6F9;
        Wed, 14 Dec 2022 16:09:30 +0100 (CET)
Received: from [10.252.31.140] (10.252.31.140) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 14 Dec
 2022 16:09:29 +0100
Message-ID: <2ab70bb7-dbf1-5f19-8118-6cfd9b5dc278@foss.st.com>
Date:   Wed, 14 Dec 2022 16:09:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] pwm: stm32: enforce settings for pwm capture
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221213102707.1096345-1-olivier.moysan@foss.st.com>
 <20221213105128.74skjowy5v7dlaf6@pengutronix.de>
Content-Language: en-US
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20221213105128.74skjowy5v7dlaf6@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.31.140]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On 12/13/22 11:51, Uwe Kleine-König wrote:
> Hello Olivier,
> 
> [Cc: += William Breathitt Gray, linux-iio@v.k.o]
> 
> On Tue, Dec 13, 2022 at 11:27:07AM +0100, Olivier Moysan wrote:
>> The PWM capture assumes that the input selector is set to default
>> input and that the slave mode is disabled. Force reset state for
>> TISEL and SMCR registers to match this requirement.
> 
> When does the problem occur? Only if the bootloader changed that
> setting? Regarding the urgency: With the current knowledge I'd say this
> patch is material for the next merge window. Do you recommend
> backporting to stable?
> 

Yes, the PWM may not be in the default expected state, if the 
configuration has been changed in the bootloader. This is not an actual 
case today, so this patch can wait the next merge window and there is no
urgency to have it in stable.

BRs
Olivier

>> Note that slave mode disabling is not a pre-requisite by itself
>> for capture mode, as hardware supports it for PWM capture.
>> However, the current implementation of the driver does not
>> allow slave mode for PWM capture. Setting slave mode for PWM
>> capture results in wrong capture values.
> 
> What is your usecase for PWM capture support? I didn't double check, but
> I think you're the first contributor to PWM capture since 2018 (i.e. the
> commit you're fixing).
> 
> Did you check if the counter subsystem would solve your problems? If it
> doesn't I assume William would like to hear about that.
> 
> Looking at drivers/counter/stm32-timer-cnt.c it does seem to work in
> slave mode, TISEL isn't touched though. So maybe this driver needs a
> similar fix?
> 
> Apart from that the change looks reasonable:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Best regards
> Uwe
> 
