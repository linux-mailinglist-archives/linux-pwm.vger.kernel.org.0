Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75EA780CF8
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Aug 2023 15:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356014AbjHRNuX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Aug 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377370AbjHRNtn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2023 09:49:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9F4496;
        Fri, 18 Aug 2023 06:49:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="375883552"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="375883552"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="981661912"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="981661912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2023 06:49:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qWzqZ-00AVSZ-1A;
        Fri, 18 Aug 2023 16:49:03 +0300
Date:   Fri, 18 Aug 2023 16:49:03 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, j-keerthy@ti.com,
        vz@mleia.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org,
        shubhrajyoti.datta@amd.com, srinivas.neeli@amd.com,
        michal.simek@amd.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH -next 01/11] gpio: cadence: Use helper function
 devm_clk_get_enabled()
Message-ID: <ZN92z8CPw9Qpx8nY@smile.fi.intel.com>
References: <20230818093018.1051434-1-lizetao1@huawei.com>
 <20230818093018.1051434-2-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093018.1051434-2-lizetao1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 18, 2023 at 05:30:08PM +0800, Li Zetao wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
> prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
> can now be replaced by devm_clk_get_enabled() when the driver enables
> (and possibly prepares) the clocks for the whole lifetime of the device.
> Moreover, it is no longer necessary to unprepare and disable the clocks
> explicitly.

...

> -			"Failed to retrieve peripheral clock, %d\n", ret);
> +			"Failed to retrieve and enable peripheral clock, %d\n",

In some drivers you changed the message in some not.
I suggest to avoid changing messages for now and do this separately.
Also consider switching them to use dev_err_probe() instead.

-- 
With Best Regards,
Andy Shevchenko


