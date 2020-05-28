Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9851E56EF
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2020 07:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgE1FpX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 May 2020 01:45:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:32821 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgE1FpX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 28 May 2020 01:45:23 -0400
IronPort-SDR: TvNdECNE0GLbEgia/8w1TcEMCvXymZI+K8Ev5ndhOwWDgnwTDRFpVuhy6Yp7jtRZFBP3VX5lYN
 orGYCJWE+vZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 22:45:23 -0700
IronPort-SDR: wqJuowIbzykwuNKn/6B37pK+9yb1KXjCDJGVttOP4Pq+CIyOE+TGBSjpBvzeCytLXvu9j/bmE2
 4fdnqSU5usGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="345797637"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2020 22:45:22 -0700
Received: from [10.215.243.213] (rtanwar-mobl.gar.corp.intel.com [10.215.243.213])
        by linux.intel.com (Postfix) with ESMTP id 342BF5803C1;
        Wed, 27 May 2020 22:45:19 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        linux-pwm@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
 <3a1f1e83-2d9d-ddbf-e2e6-9c8bab87372b@linux.intel.com>
 <20200527091521.GH1634618@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <42553091-1ce0-e7b8-b61b-eca5d723bb32@linux.intel.com>
Date:   Thu, 28 May 2020 13:45:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527091521.GH1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 27/5/2020 5:15 pm, Andy Shevchenko wrote:
> On Wed, May 27, 2020 at 02:28:53PM +0800, Tanwar, Rahul wrote:
>> On 22/5/2020 4:56 pm, Uwe Kleine-König wrote:
>>> On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:
> ...
>
>>> I'm a unhappy to have this in the PWM driver. The PWM driver is supposed
>>> to be generic and I think this belongs into a dedicated driver.
>> Well noted about all other review concerns. I will rework the driver in v2.
>> However, i am not very sure about the above point - of having a separate
>> dedicated driver for tach_work because its logic is tightly coupled with
>> this driver.
> Actually I agree with Uwe.
> Here is layering violation, i.e. provider and consumer in the same pot. It's
> not good from design perspective.
>

Just to clarify, the PWM controller in our SoC serves just one purpose which
is to control the fan. Its actually named as PWM Fan Controller. There is no
other generic usage or any other consumer for this PWM driver. So separating
out this part seems redundant to me. Also, if we separate it out as a
dedicated driver, this will endup as a very small daemon which is going to be
very hard to justify while upstreaming..

Regards,
Rahul 
