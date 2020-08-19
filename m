Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392142493BD
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Aug 2020 06:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgHSEQI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Aug 2020 00:16:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:21778 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSEQI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 19 Aug 2020 00:16:08 -0400
IronPort-SDR: B2HGZKG4e5Xha573wK//ux9O2DJoyvRC7j7DtVe1sKYu8nSPodfo0p5SsoG+FsgPjeLOgd3n7d
 EFa5KqU3m3ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142860431"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="142860431"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 21:16:07 -0700
IronPort-SDR: yYEEsBJ88Yp4/3npUb5lXtlgmB1mqHQqfVYBWDeimD0/xCJwSnI81Tba7k1a/8xHc6fFLoVO07
 zgaQ+Oin+3cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="278226300"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2020 21:16:06 -0700
Received: from [10.249.73.187] (rtanwar-MOBL.gar.corp.intel.com [10.249.73.187])
        by linux.intel.com (Postfix) with ESMTP id A6E45580583;
        Tue, 18 Aug 2020 21:16:02 -0700 (PDT)
Subject: Re: [PATCH v7 0/2] pwm: intel: Add PWM driver for a new SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
References: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
 <20200818083852.GC1891694@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <37f7526e-5a04-1d27-347c-772fe085771e@linux.intel.com>
Date:   Wed, 19 Aug 2020 12:16:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818083852.GC1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Andy,

On 18/8/2020 4:38 pm, Andy Shevchenko wrote:
> On Tue, Aug 18, 2020 at 01:48:59PM +0800, Rahul Tanwar wrote:
>> Patch 1 adds dt binding document in YAML format.
>> Patch 2 add PWM fan controller driver for LGM SoC.
>>
>> v7:
>> - Address code quality related review concerns.
>> - Rename fan related property to pwm-*.
>> - Fix one make dt_binding_check reported error.
> I guess it misses the answer why pwm-fan can't be integrated into the soup?
>

Can you please elaborate more? I could not understand your point clearly.

Regards,
Rahul
