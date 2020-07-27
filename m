Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1A22E690
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgG0HaX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:30:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:37225 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgG0HaW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Jul 2020 03:30:22 -0400
IronPort-SDR: 5NlcthIJqQFLnri3xAiV4NCUMtAtrPkxeWdpm0Be9eSPseLU7AcFdeAW2nbxwejLNs4YnWIkAa
 qeBKtt8ED/6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150950820"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="150950820"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 00:30:21 -0700
IronPort-SDR: klYhuM+dWW4fZNlkwtpjyfPXHdxUfs8O+YHwId7kpOPBUYr3DgLL12mT9xXXrzfE5hQrCjXbJ8
 Pnb6UYrc9YjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="273181847"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2020 00:30:21 -0700
Received: from [10.215.255.196] (sangkeet-MOBL.gar.corp.intel.com [10.215.255.196])
        by linux.intel.com (Postfix) with ESMTP id BAD365807FC;
        Mon, 27 Jul 2020 00:30:17 -0700 (PDT)
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
 <c2ef8f5c-af23-a63d-5f72-de0c307be8eb@linux.intel.com>
 <20200727070126.2juwfmra3i67lxfw@pengutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <70fde2ba-b38f-a0d6-bc2d-89c074afd466@linux.intel.com>
Date:   Mon, 27 Jul 2020 15:30:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727070126.2juwfmra3i67lxfw@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Uwe,

On 27/7/2020 3:01 pm, Uwe Kleine-König wrote:
> On Mon, Jul 27, 2020 at 02:04:56PM +0800, Tanwar, Rahul wrote:
>> Hi Uwe,
>>
>> On 24/7/2020 12:15 am, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> On Thu, Jul 23, 2020 at 03:44:18PM +0800, Rahul Tanwar wrote:
>>>> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>> +			 const struct pwm_state *state)
>>>> +{
>>>> +	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
>>>> +	u32 duty_cycle, val;
>>>> +	int ret;
>>>> +
>>>> +	if (!state->enabled) {
>>>> +		ret = lgm_pwm_enable(chip, 0);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * HW only supports NORMAL polarity
>>>> +	 * HW supports fixed period which can not be changed/configured by user
>>>> +	 */
>>>> +	if (state->polarity != PWM_POLARITY_NORMAL ||
>>>> +	    state->period != pc->period)
>>>> +		return -EINVAL;
>>> At least for state->polarity you have to check before state->enabled, as
>>> the expectation on
>>>
>>>         .enabled = false
>>>         .polarity = PWM_POLARITY_INVERSED
>>>
>>> is that the output becomes constant high. Also as confirmed at the end
>>> of v4, state->period < pc->period was the right check to do.
>> For below case:
>>
>> .enabled = false
>> .polarity = PWM_POLARITY_INVERSED
>>
>> Since our HW does not support inversed polarity, the output for above case
>> is expected to be constant low. And if we disable PWM before checking for
>> polarity, the output becomes constant low. The code just does that. Sorry,
>> i could not understand what is wrong with the code. It looks correct to me.
> As your hardware can only support normal polarity, the code must have:
>
> 	if (state->polarity != PWM_POLARITY_NORMAL)
> 		return -EINVAL;
>
> 	if (!state->enabled) {
> 		ret = lgm_pwm_enable(chip, 0);
> 		return ret;
> 	}
>
> That's what I meant writing: "At least for state->polarity you have to
> check before state->enabled".

Ok, i understand your point now.

>> Given the fact that we support fixed period, if we allow
>> state->period < pc->period case then the duty cycle will be evaluated as
>> higher than the requested one because the state->period is lesser than
>> the actual fixed period supported by the HW. Can you please elaborate
>> on why you think we should allow state->period < pc->period case?
> You should not allow it. In v4 you had:
>
> 	if (state->polarity != PWM_POLARITY_NORMAL ||
> 	    state->period < pc->period)
> 		return -EINVAL;
>
> That's the right thing to do (even though I was unsettled at one point
> and wrote it was wrong). The check in v5 with state->period !=
> pc->period is wrong.
>

Does that mean we should allow state->period >= pc->period cases?
If the state->period is greater than HW supported pc->period and
if we allow it then the duty cycle will again be evaluated to be
incorrect/higher than requested duty cycle. Am i missing something
else? Thanks.

Regards,
Rahul
