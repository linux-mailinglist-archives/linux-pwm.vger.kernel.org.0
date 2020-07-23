Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE822A66A
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 06:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgGWEQZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 00:16:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:44677 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGWEQY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 23 Jul 2020 00:16:24 -0400
IronPort-SDR: 9GOXqDrua+V07IoOz1oMITzw90rxZP5GDtO6pjusCC1cm116jh36SsT4jRY0Np7k2dlZAz96Ez
 9AOdGy3+wjhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="212005799"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="212005799"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 21:16:22 -0700
IronPort-SDR: rpHIBZB6bPuv3oNaM50bZUknBDy+sYwfmQRnelBJL17bUfJOpOoX8J3DFyk6Szu4intgGr9/2i
 DVGSuZxFmu8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="288509462"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2020 21:16:22 -0700
Received: from [10.226.38.18] (unknown [10.226.38.18])
        by linux.intel.com (Postfix) with ESMTP id AEE69580299;
        Wed, 22 Jul 2020 21:16:19 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] Add PWM fan controller driver for LGM SoC
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <a74b18b68f26bf902c30a017050cc4ea070da887.1593503228.git.rahul.tanwar@linux.intel.com>
 <20200713191059.zsokzvv3k2hyaxcl@pengutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <409ee148-a6a6-327f-e4d7-455f98ef4c66@linux.intel.com>
Date:   Thu, 23 Jul 2020 12:16:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713191059.zsokzvv3k2hyaxcl@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Uwe,

Thanks for the feedback.

On 14/7/2020 3:10 am, Uwe Kleine-König wrote:
> Hello,
>
> On Tue, Jun 30, 2020 at 03:55:32PM +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  drivers/pwm/Kconfig         |  11 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-intel-lgm.c | 266 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 278 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c

[...]

>> +
>> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
>> +	u32 duty_cycle, val;
>> +	unsigned int period;
>> +
>> +	if (!state->enabled) {
>> +		lgm_pwm_enable(chip, 0);
>> +		return 0;
>> +	}
>> +
>> +	period = min_t(u64, state->period, pc->period);
>> +
>> +	if (state->polarity != PWM_POLARITY_NORMAL ||
>> +	    period < pc->period)
>> +		return -EINVAL;
> This check looks wrong. If you refuse period < pc->period there isn't
> much configuration possible.

I am kind of stuck here. I made this change of adding a check
period < pc->period based on your feedback on v2 patch.
In fact, you had specified this code in v2 review feedback
and i used the same exact code.

How should we handle it when the hardware supports fixed period.
We don't want user to change period and allow just changing
duty_cycle. With that intention, i had first added a strict check
which refused configuration if period != pc->period. Period is
intended to be a read only value.

How do you suggest we handle the fixed period hardware support?
Would you have any reference example of other drivers which also
supports fixed period? Thanks.

[...]
>> +static int lgm_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct lgm_pwm_chip *pc = platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	ret = pwmchip_remove(&pc->chip);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	clk_disable_unprepare(pc->clk);
>> +	reset_control_assert(pc->rst);
> Please swap the two previous lines to match the error patch of .probe.

Again, i had made this change based on your below review feedback
for v1. IMO, reverse of probe makes more sense.

"In .probe() you first release reset and then enable the clock. It's good
style to do it the other way round in .remove()."

Regards,
Rahul
