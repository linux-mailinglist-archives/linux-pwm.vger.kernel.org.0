Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC31E393D
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2020 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgE0G26 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 May 2020 02:28:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:3448 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgE0G26 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 27 May 2020 02:28:58 -0400
IronPort-SDR: WPnP6rejn/oFiZ0aBVouUEBbdfcAvNtRWk7ARNfavpoxqFZ6xXQ88wU95uiObMAsESqNRjJS6D
 LQL7o7riYZ8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 23:28:57 -0700
IronPort-SDR: bkCRZ90oJrkR7iPFP9fBSIOLyx9V59salad5X/SdN71GDSH/5LcbXt5XaArMm10zU8nXqhN0h+
 rpKrqE4ImG8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="scan'208";a="255386847"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 26 May 2020 23:28:57 -0700
Received: from [10.214.150.18] (rtanwar-mobl.gar.corp.intel.com [10.214.150.18])
        by linux.intel.com (Postfix) with ESMTP id 72BAC580101;
        Tue, 26 May 2020 23:28:54 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        linux-pwm@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <3a1f1e83-2d9d-ddbf-e2e6-9c8bab87372b@linux.intel.com>
Date:   Wed, 27 May 2020 14:28:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200522085613.ktb2ruw2virj337v@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Uwe,

Thanks for review.

On 22/5/2020 4:56 pm, Uwe Kleine-König wrote:
> Hello,
>
> On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:
>> Add PWM controller driver for Intel's Lightning Mountain(LGM) SoC.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  drivers/pwm/Kconfig         |   9 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-intel-lgm.c | 356 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 366 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index eebbc917ac97..a582214f50b2 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -232,6 +232,15 @@ config PWM_IMX_TPM
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-imx-tpm.
>>  
>> +config PWM_INTEL_LGM
>> +	tristate "Intel LGM PWM support"
>> +	depends on X86 || COMPILE_TEST
>> +	help
>> +	  Generic PWM framework driver for LGM SoC.
[...]
>> +};
>> +
>> +static void tach_work(struct work_struct *work)
>> +{
>> +	struct intel_pwm_chip *pc = container_of(work, struct intel_pwm_chip,
>> +						 work.work);
>> +	struct regmap *regmap = pc->regmap;
>> +	u32 fan_tach, fan_dc, val;
>> +	s32 diff;
>> +	static u32 fanspeed_err_cnt, time_window, delta_dc;
>> +
>> +	/*
>> +	 * Fan speed is tracked by reading the active duty cycle of PWM output
>> +	 * from the active duty cycle register. Some variance in the duty cycle
>> +	 * register value is expected. So we set a time window of 30 seconds and
>> +	 * if we detect inaccurate fan speed 6 times within 30 seconds then we
>> +	 * mark it as fan speed problem and fix it by readjusting the duty cycle.
>> +	 */
> I'm a unhappy to have this in the PWM driver. The PWM driver is supposed
> to be generic and I think this belongs into a dedicated driver.

Well noted about all other review concerns. I will rework the driver in v2.
However, i am not very sure about the above point - of having a separate
dedicated driver for tach_work because its logic is tightly coupled with
this driver.

Regards,
Rahul
