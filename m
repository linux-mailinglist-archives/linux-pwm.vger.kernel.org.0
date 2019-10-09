Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0233CD0BCA
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2019 11:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfJIJvS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Oct 2019 05:51:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14316 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727228AbfJIJvS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Oct 2019 05:51:18 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x999k2Tq018596;
        Wed, 9 Oct 2019 11:51:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=wZHBdNbfW8cemZbtM4EyVZqKxEgCY/Nj31PdlfGQS9w=;
 b=ygm2/EHfTI96Znm/14gtNcEhtO2j8lgebssB8pz/Uu2kujmiis96wSn+laxTxviRv3hc
 0VG8qHKo6ajKRj/bkz7qTLPzNhySRBzi/C7vlVBSD4SpTsXP+/Zq6cmqJVHxyVFfrM5L
 e80fsS3gxj0xHLWXMIIF2HF20gYN12D1oZMDN8M/dE3w8Y1E1qMY5gL+DChB3UEoUNuR
 lqWdXvBmTLOTETuApSs9mdvAB+zdeSOat4Vr61wJg+i+V1oXcOJGT6wB59wRDBuOsstL
 vDbKaDt5rMrFff+4fOCcWkMRB4RdY8iTN9GKrcuYv2uodGBnPkCLXcqi3aqcuzkCtCjY qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vegah5vm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 11:51:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B681B10002A;
        Wed,  9 Oct 2019 11:51:06 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A777320681A;
        Wed,  9 Oct 2019 11:51:06 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019
 11:51:06 +0200
Received: from [10.48.0.192] (10.48.0.192) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019 11:51:06
 +0200
Subject: Re: [PATCH] pwm: stm32: add comment to better describe breakinput
 feature
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <alexandre.torgue@st.com>,
        <benjamin.gaignard@st.com>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1570534887-26181-1-git-send-email-fabrice.gasnier@st.com>
 <20191008144531.pjt525xuz7n5a3hq@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <5c05893b-e938-4db8-e33a-803b1a498f97@st.com>
Date:   Wed, 9 Oct 2019 11:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008144531.pjt525xuz7n5a3hq@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_05:2019-10-08,2019-10-09 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/8/19 4:45 PM, Uwe Kleine-König wrote:
> On Tue, Oct 08, 2019 at 01:41:27PM +0200, Fabrice Gasnier wrote:
>> Add a comment to better describe the purpose of breakinput feature that
>> can be found on some STM32 timer instances. Briefly comment on the
>> characteristics of this input for PWM, and pinmuxing as suggested in [1].
>>
>> [1] https://lkml.org/lkml/2019/10/1/207
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  drivers/pwm/pwm-stm32.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
>> index 359b085..6406ebb 100644
>> --- a/drivers/pwm/pwm-stm32.c
>> +++ b/drivers/pwm/pwm-stm32.c
>> @@ -522,8 +522,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
>>  					     sizeof(struct stm32_breakinput));
>>  
>>  	/*
>> +	 * Some timer instances can have BRK input pins (e.g. basically a fault
>> +	 * pin from the output power stage). The break feature allows a safe
>> +	 * shut-down of the PWM outputs to a predefined state. Further details
>> +	 * are available in application note AN4277, "Using STM32 device PWM
>> +	 * shut-down features..."
> 
> Without having read the application note I don't understand the purpose.
> Not sure if this should be a show stopper though.

Hi Uwe,

I can rephrase this. Do you think the bellow comment would be more
relevant and easy to understand ?

/*
 * The break feature allows a safe shut-down of the PWM outputs.
 * It's based on the BRK event signal defined in the dt-bindings
 * by <index level filter> values.
 * Because "st,breakinput" parameter is optional do not make probe
 * failed if it doesn't exist.
 */

> 
>>  	 * Because "st,breakinput" parameter is optional do not make probe
>> -	 * failed if it doesn't exist.
>> +	 * failed if it doesn't exist. The pinctrl handle must hold the BRK
>> +	 * pin(s) when using "st,breakinput" property.
> 
> Is this a comment that has a better place in the binding doc?

You're right, this is unneeded here. I'll remove this.

Please advise,
BR,
Fabrice

> 
> Best regards
> Uwe
> 
> 
