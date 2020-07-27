Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6722E5B0
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 08:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgG0GFB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 02:05:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:20400 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgG0GFA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Jul 2020 02:05:00 -0400
IronPort-SDR: 5GO/oIOCsY7AOev2+zWpeuCKfW4Jb+j76bUD8vSAbeFA4ghWcJBZPd3xYF9ImZ1cIVuluEHPDg
 ZW11fW8GJXfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="148842551"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="148842551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 23:05:00 -0700
IronPort-SDR: ATP/V/OSOyilyayPRGX5a8AuuiTtLDt0SpZbXi9pG7yOYszbkEr/9NsdNqmQ1zO3owdu8oEOOQ
 iRSsGgFLxFOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="273166720"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2020 23:05:00 -0700
Received: from [10.249.75.97] (rtanwar-MOBL.gar.corp.intel.com [10.249.75.97])
        by linux.intel.com (Postfix) with ESMTP id 3F769580297;
        Sun, 26 Jul 2020 23:04:57 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] Add PWM fan controller driver for LGM SoC
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
References: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
 <0f47648107ec23f72868ca37f29ea43e15c08e08.1595489518.git.rahul.tanwar@linux.intel.com>
 <20200723161553.ey47oijnwitf4hvu@pengutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <c2ef8f5c-af23-a63d-5f72-de0c307be8eb@linux.intel.com>
Date:   Mon, 27 Jul 2020 14:04:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723161553.ey47oijnwitf4hvu@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Uwe,

On 24/7/2020 12:15 am, Uwe Kleine-König wrote:
> Hello,
>
> On Thu, Jul 23, 2020 at 03:44:18PM +0800, Rahul Tanwar wrote:
>> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
>> +	u32 duty_cycle, val;
>> +	int ret;
>> +
>> +	if (!state->enabled) {
>> +		ret = lgm_pwm_enable(chip, 0);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * HW only supports NORMAL polarity
>> +	 * HW supports fixed period which can not be changed/configured by user
>> +	 */
>> +	if (state->polarity != PWM_POLARITY_NORMAL ||
>> +	    state->period != pc->period)
>> +		return -EINVAL;
> At least for state->polarity you have to check before state->enabled, as
> the expectation on
>
>         .enabled = false
>         .polarity = PWM_POLARITY_INVERSED
>
> is that the output becomes constant high. Also as confirmed at the end
> of v4, state->period < pc->period was the right check to do.

For below case:

.enabled = false
.polarity = PWM_POLARITY_INVERSED

Since our HW does not support inversed polarity, the output for above case
is expected to be constant low. And if we disable PWM before checking for
polarity, the output becomes constant low. The code just does that. Sorry,
i could not understand what is wrong with the code. It looks correct to me.

Given the fact that we support fixed period, if we allow
state->period < pc->period case then the duty cycle will be evaluated as
higher than the requested one because the state->period is lesser than
the actual fixed period supported by the HW. Can you please elaborate
on why you think we should allow state->period < pc->period case?

Thanks,

Regards,
Rahul

