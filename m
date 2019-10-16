Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188E0D8D54
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 12:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390344AbfJPKJN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 06:09:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6866 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727235AbfJPKJN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 06:09:13 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G9vJSb022321;
        Wed, 16 Oct 2019 12:08:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=DRK6nnWxIpQcRpa27goNNKQ6VsydMmtRJ5E896Ce4Mg=;
 b=bgO95zmf6k2aVs9w1Xi40fm7M97azWEHfHLRVkbo0ZJC5b8wbkMYjy3JqcGa/3hDtU0V
 a05oW0Z2xC+WtxdaqXmFvJSIC5d8mRebsgQ2gbwHQCcHBrjAlDqrdLtQG869tjSoHhtP
 bB9U3dxRq3HkKMd4MSk5tFrPp0gemXEoUjf8Chyhjstyx9zuSluokafzcfjR6hcdMNUH
 ZTTJ/EKLLxFqT+Wx4Y/tB9Go12HCV/e7mZuqVVqTs6yBEmPhYXEb0NDZ/5mVM9AcTrOZ
 yBiTzslx4ssweZHkXlP4z3lwYc8XBKg+K4PgT3xZQFZtj0PaIz3KNoZS0hOVI8iOVFPq GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vk4kx5eyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 12:08:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 07B0410002A;
        Wed, 16 Oct 2019 12:08:56 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C67EE205D2C;
        Wed, 16 Oct 2019 12:08:56 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 16 Oct
 2019 12:08:56 +0200
Received: from [10.48.0.192] (10.48.0.192) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 16 Oct 2019 12:08:56
 +0200
Subject: Re: [PATCH v2 3/3] pwm: stm32: add power management support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
 <1570193633-6600-4-git-send-email-fabrice.gasnier@st.com>
 <20191016070635.GC1296874@ulmo>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <15371530-a932-08b7-dd78-a7e20d213203@st.com>
Date:   Wed, 16 Oct 2019 12:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016070635.GC1296874@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/16/19 9:06 AM, Thierry Reding wrote:
> On Fri, Oct 04, 2019 at 02:53:53PM +0200, Fabrice Gasnier wrote:
>> Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
>> channel isn't active. Let the PWM consumers disable it during their own
>> suspend sequence, see [1]. So, perform a check here, and handle the
>> pinctrl states. Also restore the break inputs upon resume, as registers
>> content may be lost when going to low power mode.
>>
>> [1] https://lkml.org/lkml/2019/2/5/770
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Changes in v2:
>> Follow Uwe suggestions/remarks:
>> - Add a precursor patch to ease reviewing
>> - Use registers read instead of pwm_get_state
>> - Add a comment to mention registers content may be lost in low power mode
>> ---
>>  drivers/pwm/pwm-stm32.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
> 
> Applied, thanks. I made two minor changes, though, see below.
> 
>>
>> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
>> index cf8658c..546b661 100644
>> --- a/drivers/pwm/pwm-stm32.c
>> +++ b/drivers/pwm/pwm-stm32.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/mfd/stm32-timers.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/pinctrl/consumer.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pwm.h>
>>  
>> @@ -655,6 +656,42 @@ static int stm32_pwm_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static int __maybe_unused stm32_pwm_suspend(struct device *dev)
>> +{
>> +	struct stm32_pwm *priv = dev_get_drvdata(dev);
>> +	unsigned int ch;
> 
> I renamed this to just "i", which is more idiomatic for loop variables.
> The function is small enough not to need to differentiate between loop
> variables.
> 
>> +	u32 ccer, mask;
>> +
>> +	/* Look for active channels */
>> +	ccer = active_channels(priv);
>> +
>> +	for (ch = 0; ch < priv->chip.npwm; ch++) {
>> +		mask = TIM_CCER_CC1E << (ch * 4);
>> +		if (ccer & mask) {
>> +			dev_err(dev, "The consumer didn't stop us (%s)\n",
>> +				priv->chip.pwms[ch].label);
> 
> Changed this to:
> 
> 	"PWM %u still in use by consumer %s\n", i, priv->chip.pwms[i].label
> 
> I think that might help clarify which PWM is still enabled in case the
> consumers don't set a label.

Hi Thierry,

Many thanks for all the improvements on this series!

Best Regards,
Fabrice

> 
> Thierry
> 
>> +			return -EBUSY;
>> +		}
>> +	}
>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
>> +}
>> +
>> +static int __maybe_unused stm32_pwm_resume(struct device *dev)
>> +{
>> +	struct stm32_pwm *priv = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = pinctrl_pm_select_default_state(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* restore breakinput registers that may have been lost in low power */
>> +	return stm32_pwm_apply_breakinputs(priv);
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
>> +
>>  static const struct of_device_id stm32_pwm_of_match[] = {
>>  	{ .compatible = "st,stm32-pwm",	},
>>  	{ /* end node */ },
>> @@ -667,6 +704,7 @@ static struct platform_driver stm32_pwm_driver = {
>>  	.driver	= {
>>  		.name = "stm32-pwm",
>>  		.of_match_table = stm32_pwm_of_match,
>> +		.pm = &stm32_pwm_pm_ops,
>>  	},
>>  };
>>  module_platform_driver(stm32_pwm_driver);
>> -- 
>> 2.7.4
>>
