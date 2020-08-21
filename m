Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0B24D13C
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgHUJOg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Aug 2020 05:14:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:48118 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHUJOf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 Aug 2020 05:14:35 -0400
IronPort-SDR: 2bns/17trGbkQnY4S7+BxZdgY8gYPsXzpbOvpomQpnkAR+z5t0oI4mOwtL4CBR4Xt8dYydJqbQ
 rxOaP6PSRWvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="154763282"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="154763282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 02:14:34 -0700
IronPort-SDR: Bkh9B8RFZMBPfu5d+mES5xY/5CkXNFpuBirBk/Y5TY8vuOOQ78Brr5064ufoZuL6MOD7aUnrpv
 HwUbzpdy7gdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="321195575"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2020 02:14:35 -0700
Received: from [10.214.149.100] (rtanwar-MOBL.gar.corp.intel.com [10.214.149.100])
        by linux.intel.com (Postfix) with ESMTP id 9FFA458045A;
        Fri, 21 Aug 2020 02:14:30 -0700 (PDT)
Subject: Re: [PATCH v8 2/2] Add PWM fan controller driver for LGM SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
References: <cover.1597898872.git.rahul.tanwar@linux.intel.com>
 <b6d0a65625a2bc231c649c970c0a1af1ff3a5dd5.1597898872.git.rahul.tanwar@linux.intel.com>
 <20200820105255.GB1891694@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <56c2a40d-6872-8ae7-7214-420b8bb9f027@linux.intel.com>
Date:   Fri, 21 Aug 2020 17:14:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820105255.GB1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 20/8/2020 6:52 pm, Andy Shevchenko wrote:
> On Thu, Aug 20, 2020 at 12:50:46PM +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
> ...
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
>> +#include <linux/of_device.h>
> This should be mod_devicetable.h.

Inlcuding mod_devicetable.h instead of of_device.h results in
build failure related to all platform calls. Build is ok if
i remove it. Just FYI..

Regards,
Rahul

