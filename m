Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509B124D355
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHUK4Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Aug 2020 06:56:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:2823 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbgHUK4Y (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 Aug 2020 06:56:24 -0400
IronPort-SDR: gSnvnVK8oPywWPZBB9Byf6WSXnIERHyvOUeeGsuma0Q/QG2slIa7vf/py4xCsJ5BtQX/rJFDXt
 YSoxwvHdic/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="173558562"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="173558562"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 03:56:24 -0700
IronPort-SDR: CsJI5Wj63gTb3B1Tl19oudAImk8ftZNnw0BHjXy5zUCr3I316Q5cyB9SpxPu/pXvyjHqi0wDjp
 0MoNshqIqnIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327731752"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 03:56:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k94iY-00AK7y-OP; Fri, 21 Aug 2020 13:56:18 +0300
Date:   Fri, 21 Aug 2020 13:56:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v9 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200821105618.GO1891694@smile.fi.intel.com>
References: <cover.1598001442.git.rahul.tanwar@linux.intel.com>
 <fedf5d1ace7c389a5fc0116865b9b88aa3ddeaa5.1598001442.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fedf5d1ace7c389a5fc0116865b9b88aa3ddeaa5.1598001442.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 21, 2020 at 05:32:11PM +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> This PWM controller does not have any other consumer, it is a
> dedicated PWM controller for fan attached to the system. Add
> driver for this PWM fan controller.

...

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>

> +#include <linux/of_device.h>

We haven't settle this yet...

> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>

-- 
With Best Regards,
Andy Shevchenko


