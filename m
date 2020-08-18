Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084B02480CF
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Aug 2020 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgHRIi6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Aug 2020 04:38:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:40951 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgHRIi6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 18 Aug 2020 04:38:58 -0400
IronPort-SDR: ThzcvRNih6gaZ+ZVlV8r/mVbMjXo1qVlBh0zH/UJs0eqC403X+Hr6MpDqttOvtfUlD3z5us0YW
 sEWCICRARk4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219178879"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="219178879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 01:38:57 -0700
IronPort-SDR: hW1dBlOMun3XElEII6JR+7rP79PhsMX9IakJeaErX+ZQLz/ddxkdALzHL0MhlRrgKuUms+r7FX
 J3AkbfoOGHLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="326667846"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 01:38:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k7x8u-009biL-Ep; Tue, 18 Aug 2020 11:38:52 +0300
Date:   Tue, 18 Aug 2020 11:38:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v7 0/2] pwm: intel: Add PWM driver for a new SoC
Message-ID: <20200818083852.GC1891694@smile.fi.intel.com>
References: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 18, 2020 at 01:48:59PM +0800, Rahul Tanwar wrote:
> Patch 1 adds dt binding document in YAML format.
> Patch 2 add PWM fan controller driver for LGM SoC.
> 
> v7:
> - Address code quality related review concerns.
> - Rename fan related property to pwm-*.
> - Fix one make dt_binding_check reported error.

I guess it misses the answer why pwm-fan can't be integrated into the soup?

-- 
With Best Regards,
Andy Shevchenko


