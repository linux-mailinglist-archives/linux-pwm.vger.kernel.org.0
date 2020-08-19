Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134C224987E
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Aug 2020 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHSIrC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Aug 2020 04:47:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:7927 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgHSIrB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 19 Aug 2020 04:47:01 -0400
IronPort-SDR: NtMXpUc5Du7joJk6kDh5/E8+2aiKmErhqybp4OZhRg34NiA7U1DroZer4hU/FEdatHkvfmmlvj
 7Kv+PfyEsimQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142702420"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="142702420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 01:47:00 -0700
IronPort-SDR: RYAH+K/pkHTPZiI8w1HkUJPP8dvjwEmvCVdfPCwcyoRY95UawtTuXLMCNTXXGBfBb6tWL/+oEQ
 RursUpawwOOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="497681371"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2020 01:46:59 -0700
Received: from [10.213.152.90] (rtanwar-MOBL.gar.corp.intel.com [10.213.152.90])
        by linux.intel.com (Postfix) with ESMTP id 9FF86580628;
        Wed, 19 Aug 2020 01:46:55 -0700 (PDT)
Subject: Re: [PATCH v7 0/2] pwm: intel: Add PWM driver for a new SoC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com, rtanwar@maxlinear.com
References: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
 <20200818083852.GC1891694@smile.fi.intel.com>
 <37f7526e-5a04-1d27-347c-772fe085771e@linux.intel.com>
 <CAHp75VfDq7bRe6YQdUQyv=8jK737-QwpxZjGZ2HxCJ7iaQPwMg@mail.gmail.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <8fba2174-9010-19f3-29bf-0a31219d3793@linux.intel.com>
Date:   Wed, 19 Aug 2020 16:46:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfDq7bRe6YQdUQyv=8jK737-QwpxZjGZ2HxCJ7iaQPwMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Andy,

On 19/8/2020 3:54 pm, Andy Shevchenko wrote:
> On Wed, Aug 19, 2020 at 7:18 AM Tanwar, Rahul
> <rahul.tanwar@linux.intel.com> wrote:
>>
>> Hi Andy,
>>
>> On 18/8/2020 4:38 pm, Andy Shevchenko wrote:
>>> On Tue, Aug 18, 2020 at 01:48:59PM +0800, Rahul Tanwar wrote:
>>>> Patch 1 adds dt binding document in YAML format.
>>>> Patch 2 add PWM fan controller driver for LGM SoC.
>>>>
>>>> v7:
>>>> - Address code quality related review concerns.
>>>> - Rename fan related property to pwm-*.
>>>> - Fix one make dt_binding_check reported error.
>>> I guess it misses the answer why pwm-fan can't be integrated into the soup?
>>>
>> Can you please elaborate more? I could not understand your point clearly.
> It's not mine, it's Uwe's. There is an hwmon module called pwm-fan. As
> far as *I* understand this, it can be utilized to control fans via PWM
> APIs. And Uwe asked you if you considered that and why you don't
> integrated  (coupled) it here.

Thanks for clarification. I now understand what Rob, Uwe & you mean by
pwm-fan. I will check in detail about it if we can integrate it with
pwm-fan hwmon driver.

Regards,
Rahul

