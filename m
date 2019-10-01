Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D738C364A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2019 15:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfJANtV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Oct 2019 09:49:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388742AbfJANtV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Oct 2019 09:49:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DjjgS031055;
        Tue, 1 Oct 2019 15:49:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=VTfdc7EtTRCHZkR5Z0IufvapWWMJ4Y5qlpHlU5Eyteg=;
 b=FOODUL1nm0XxmlHPZNPuIZ6lsuKBXdFScx6DXuAH/et+6+kRHI3IT8MREbMP3v10y3Z9
 geiSYaaM8bMxQOldJ7fdI30/Sm8RqJRk9p+MYe/DG5rrtB1bzaiGSl/ofq8zVaDoKkpS
 mGy/PGmYXj/cdgew3D19qs9pWTbE64yF3fLC7mYSoOrN2QeOdT8mR9ATL5SHcMEUCzgH
 XITVRQtkMkO3UP9pUqF7E6ajUcCY/FeR8ofIzTMzg9Wgk4M7DxgJ29D85cFxDP5clzgi
 yWVJK69+sNpI+Fz2aMPm4cg+3UnWJWKJlHixbeCLHyAPciY+IedRQXvIvuWOeoBlGqCc BQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9vna9h6w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 01 Oct 2019 15:49:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6F95750;
        Tue,  1 Oct 2019 13:48:55 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8966F2CE746;
        Tue,  1 Oct 2019 15:48:54 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 1 Oct 2019
 15:48:54 +0200
Received: from [10.48.0.192] (10.48.0.192) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 1 Oct 2019 15:48:53
 +0200
Subject: Re: [PATCH 2/2] pwm: stm32: add power management support
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
 <1569857951-20007-3-git-send-email-fabrice.gasnier@st.com>
 <20191001070450.4zogfryzo7a5ssbd@pengutronix.de>
 <3c6e551b-98a2-a418-c4ee-002077e46f31@st.com>
 <20191001095119.ws36f7liwgvbokem@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <f0fd1926-9fca-99c5-4a54-99252b865bc6@st.com>
Date:   Tue, 1 Oct 2019 15:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001095119.ws36f7liwgvbokem@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_07:2019-10-01,2019-10-01 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/1/19 11:51 AM, Uwe Kleine-König wrote:
> Hello Fabrice,
> 
> On Tue, Oct 01, 2019 at 10:18:31AM +0200, Fabrice Gasnier wrote:
>> On 10/1/19 9:04 AM, Uwe Kleine-König wrote:
>>> On Mon, Sep 30, 2019 at 05:39:11PM +0200, Fabrice Gasnier wrote:
>>>> Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
>>>> channel isn't active. Let the PWM consumers disable it during their own
>>>> suspend sequence, see [1]. So, perform a check here, and handle the
>>>> pinctrl states. Also restore the break inputs upon resume, as registers
>>>> content may be lost when going to low power mode.
>>>>
>>>> [1] https://lkml.org/lkml/2019/2/5/770
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> ---
>>>>  drivers/pwm/pwm-stm32.c | 82 +++++++++++++++++++++++++++++++++++++------------
>>>>  1 file changed, 62 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
>>>> index 740e2de..9bcd73a 100644
>>>> --- a/drivers/pwm/pwm-stm32.c
>>>> +++ b/drivers/pwm/pwm-stm32.c
>>>> @@ -12,6 +12,7 @@
>>>>  #include <linux/mfd/stm32-timers.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/of.h>
>>>> +#include <linux/pinctrl/consumer.h>
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/pwm.h>
>>>>  
>>>> @@ -19,6 +20,12 @@
>>>>  #define CCMR_CHANNEL_MASK  0xFF
>>>>  #define MAX_BREAKINPUT 2
>>>>  
>>>> +struct stm32_breakinput {
>>>> +	u32 index;
>>>> +	u32 level;
>>>> +	u32 filter;
>>>> +};
>>>> +
>>>>  struct stm32_pwm {
>>>>  	struct pwm_chip chip;
>>>>  	struct mutex lock; /* protect pwm config/enable */
>>>> @@ -26,15 +33,11 @@ struct stm32_pwm {
>>>>  	struct regmap *regmap;
>>>>  	u32 max_arr;
>>>>  	bool have_complementary_output;
>>>> +	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
>>>> +	unsigned int nbreakinput;
>>>>  	u32 capture[4] ____cacheline_aligned; /* DMA'able buffer */
>>>>  };
>>>>  
>>>> -struct stm32_breakinput {
>>>> -	u32 index;
>>>> -	u32 level;
>>>> -	u32 filter;
>>>> -};
>>>> -
>>>>  static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
>>>>  {
>>>>  	return container_of(chip, struct stm32_pwm, chip);
>>>> @@ -512,15 +515,27 @@ static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
>>>>  	return (bdtr & bke) ? 0 : -EINVAL;
>>>>  }
>>>>  
>>>> -static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
>>>> +static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
>>>> +{
>>>> +	int i, ret = 0;
>>>> +
>>>> +	for (i = 0; i < priv->nbreakinput && !ret; i++) {
>>>> +		ret = stm32_pwm_set_breakinput(priv,
>>>> +					       priv->breakinput[i].index,
>>>> +					       priv->breakinput[i].level,
>>>> +					       priv->breakinput[i].filter);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>
>>> Can you explain what the effect of this function is? This is something
>>> that is lost during suspend?
>>
>> Yes, that's what I explain in the commit message: ...registers content
>> may be lost when going to low power mode.
>> Do you think I need to rephrase ?
> 
> Ah, right I missed it in the commit log. It might be worth adding that
> to a code comment. Also having the purpose of this function described
> would be great. Does it configure some electrical characteristics? Or
> has it to do with pinmuxing? Why is an input relevant for a PWM?

Hi Uwe,

I'll add a comment in the suspend routine to mention the need to restore
breakinput registers that may have been lost in low power.

Regarding the purpose of the break feature, maybe I can enhance comment
bellow (e.g. Because "st,breakinput" parameter is optional...) to
something like:

/*
 * Some timer instances can have BRK input pins (e.g. basically a fault
 * pin from the output power stage). The break feature allow a safe shut
 * down of the PWM outputs to a predefined state.
 * Because "st,breakinput" parameter is optional do not make probe
 * failed if it doesn't exist. Note the pinctrl handle must be inline
 * with "st,breakinput" property.
 */

FYI, the feature is described in Application note AN4277, "Using STM32
device PWM shut-down features..."

Would it answer your concern here? But I think this should be done in a
separate patch (not related to PM support).

> 
>>> I wonder why the patch is so big. There are some rearrangements that
>>> should have no effect and I think it would be beneficial for
>>> reviewability to split this patch in a patch that only does the
>>> restructuring and than on top of that add the PM stuff.
>>
>> I can split this to ease the review.
>>>
>>>> +
>>>> +static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
>>>>  				       struct device_node *np)
>>>>  {
>>>> -	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
>>>> -	int nb, ret, i, array_size;
>>>> +	int nb, ret, array_size;
>>>>  
>>>>  	nb = of_property_count_elems_of_size(np, "st,breakinput",
>>>>  					     sizeof(struct stm32_breakinput));
>>>> -
>>>>  	/*
>>>>  	 * Because "st,breakinput" parameter is optional do not make probe
>>>>  	 * failed if it doesn't exist.
>>>> @@ -531,20 +546,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
>>>>  	if (nb > MAX_BREAKINPUT)
>>>>  		return -EINVAL;
>>>>  
>>>> +	priv->nbreakinput = nb;
>>>>  	array_size = nb * sizeof(struct stm32_breakinput) / sizeof(u32);
>>>>  	ret = of_property_read_u32_array(np, "st,breakinput",
>>>> -					 (u32 *)breakinput, array_size);
>>>> +					 (u32 *)priv->breakinput, array_size);
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> -	for (i = 0; i < nb && !ret; i++) {
>>>> -		ret = stm32_pwm_set_breakinput(priv,
>>>> -					       breakinput[i].index,
>>>> -					       breakinput[i].level,
>>>> -					       breakinput[i].filter);
>>>> -	}
>>>> -
>>>> -	return ret;
>>>> +	return stm32_pwm_apply_breakinputs(priv);
>>>>  }
>>>>  
>>>>  static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
>>>> @@ -614,7 +623,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
>>>>  	if (!priv->regmap || !priv->clk)
>>>>  		return -EINVAL;
>>>>  
>>>> -	ret = stm32_pwm_apply_breakinputs(priv, np);
>>>> +	ret = stm32_pwm_probe_breakinputs(priv, np);
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> @@ -647,6 +656,38 @@ static int stm32_pwm_remove(struct platform_device *pdev)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static int __maybe_unused stm32_pwm_suspend(struct device *dev)
>>>> +{
>>>> +	struct stm32_pwm *priv = dev_get_drvdata(dev);
>>>> +	struct pwm_state state;
>>>> +	unsigned int i;
>>>> +
>>>> +	for (i = 0; i < priv->chip.npwm; i++) {
>>>> +		pwm_get_state(&priv->chip.pwms[i], &state);
>>>
>>> pwm_get_state is a function designed to be used by PWM consumers. I
>>> would prefer to check the hardware registers here instead.
>>
>> It's also useful for PWM provider: This PWM driver is part of a MFD that
> 
> I don't doubt "useful". But still you should only call it if you called
> pwm_get (or a similar function) to get a PWM handle.
> 
>> also take care of IIO trigger (can be used simultaneously). Simply
>> reading a register doesn't tell us that the timer is used/configured as
>> a PWM here. That's the reason to use this helper to read pwm->state.
> 
> How can the pwm driver be bound and the hardware not be used a PWM?
> 
>> Do you wish I add a comment to clarify this here ?
> 
> No, I wish you inspect the hardware to determine what you need to know :-)

Ok, finally I found out the "active_channels()" routine does the job
(e.g. read CCER register), and is already used for that purpose (check
for active channels).
I'll use it in v2.

Thanks,
Fabrice

> 
>>> What if there is no consumer and the PWM just happens to be enabled by
>>> the bootloader? Or is this too minor an issue to be worth consideration?
>>
>> That's the purpose of returning -EBUSY: "PWM should not stop if the PWM
>> user didn't call pwm_disable()" ... "to avoid situation where the PWM is
>> actually suspended before the user". This has been enforced in later
>> series with the device_link_add(). See our previous discussions here:
>> https://lkml.org/lkml/2019/2/5/770
>> So, I guess this would point exactly a lack for a PWM user to manage it
>> after the boot stage, in the kernel.
>>
>> Could you please clarify, provide an example here ?
> 
> This is something different than I asked for. Not having a consumer
> isn't an error. Still the pwm might be running (for a good reason or
> not). (This is more a question that affects how a driver should behave
> in general, it is not specific to the stm32 driver here.)
> 
> Best regards
> Uwe
> 
