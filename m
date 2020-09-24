Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE89276AF1
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgIXHik (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 03:38:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:41811 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgIXHij (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 03:38:39 -0400
IronPort-SDR: gOQiatmwbKtM0oa9tPWqxtWNPDOq5Dr0GHSB5a7VhVYmrFvofTLSJDrrATAx/RCp5ykOZ0ZIJy
 wY0gJFY2fGbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="245927744"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="245927744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 00:38:39 -0700
IronPort-SDR: 1TKGJUP/ASGmynwQDHdulR8SYi0WFPZ4yh1V/8MPJ2vEEVpjuXxUvRHgpkjsjEIDicryobyTRs
 tSBh4Ldr8Zjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="291949973"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 24 Sep 2020 00:38:38 -0700
Received: from [10.214.160.191] (rtanwar-MOBL.gar.corp.intel.com [10.214.160.191])
        by linux.intel.com (Postfix) with ESMTP id 59B9858043C;
        Thu, 24 Sep 2020 00:38:35 -0700 (PDT)
Subject: Re: [PATCH v13 2/2] Add PWM fan controller driver for LGM SoC
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com, rtanwar@maxlinear.com
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
 <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
 <20200924065534.e2anwghhtysv63e7@pengutronix.de>
 <20200924071256.GA2480300@ulmo>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <110b5c82-e34c-8b0c-d85b-6bb861879fff@linux.intel.com>
Date:   Thu, 24 Sep 2020 15:38:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924071256.GA2480300@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 24/9/2020 3:12 pm, Thierry Reding wrote:
> On Thu, Sep 24, 2020 at 08:55:34AM +0200, Uwe Kleine-König wrote:
>> Hello,
>>
>> (hhm Thierry already announced to have taken this patch, so my review is
>> late.)
> There's also a build warning in linux-next caused by this patch, so I'm
> going to back it out.
>
> Rahul, please address Uwe's comments and make sure to fix the build
> warning as well.

Well noted, will do.

Regards,
Rahul

> Thierry

