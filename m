Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556424E596
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 07:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgHVFVe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 01:21:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:31199 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgHVFVd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 22 Aug 2020 01:21:33 -0400
IronPort-SDR: /tgECFdLSz61qZ4rt/WqgVHIIGVNmxu8azP01t3xuApMr09oFS7l8wOcmpIN8WKrqZMWqqV/Ui
 jkF0KmEewaEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="219954727"
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="219954727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 22:21:33 -0700
IronPort-SDR: w+1lVZezxPiYtIAfwBALW9KJ6hUs7BWHPRIy8uzlAaArGVbklPYIzdYbBPISVJZxENsW3sWluk
 sE62Ty4DVTCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="311634014"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 21 Aug 2020 22:21:33 -0700
Received: from [10.214.149.112] (rtanwar-MOBL.gar.corp.intel.com [10.214.149.112])
        by linux.intel.com (Postfix) with ESMTP id C15CE58081E;
        Fri, 21 Aug 2020 22:21:29 -0700 (PDT)
Subject: Re: [PATCH v9 2/2] Add PWM fan controller driver for LGM SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
References: <cover.1598001442.git.rahul.tanwar@linux.intel.com>
 <fedf5d1ace7c389a5fc0116865b9b88aa3ddeaa5.1598001442.git.rahul.tanwar@linux.intel.com>
 <20200821105618.GO1891694@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <d8c85de1-dacf-e8eb-6e49-131d007f3a6b@linux.intel.com>
Date:   Sat, 22 Aug 2020 13:21:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821105618.GO1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Andy,

On 21/8/2020 6:56 pm, Andy Shevchenko wrote:
> On Fri, Aug 21, 2020 at 05:32:11PM +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
> ...
>
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
> We haven't settle this yet...

I investigated more about it. I was getting build error because we were
relying on of_device.h for including platform_device.h. You are right that
we are not using anything from of_device.h. So i removed of_device.h from
driver and added include <linux/platform_device.h> & build is ok.

Regarding mod_devicetable.h header, it gets included indirectly from
<linux/pwm.h> which includes of.h which includes mod_devicetable.h. So i
think no point including it again in the driver.

Regards,
Rahul

>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>

