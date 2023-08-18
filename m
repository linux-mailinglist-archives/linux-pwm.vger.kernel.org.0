Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ACE780D2B
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Aug 2023 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377478AbjHRN4i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Aug 2023 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377535AbjHRN4T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2023 09:56:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41D81706;
        Fri, 18 Aug 2023 06:55:56 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="459458908"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="459458908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="908891296"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="908891296"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 18 Aug 2023 06:55:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qWzx2-00AjO6-0a;
        Fri, 18 Aug 2023 16:55:44 +0300
Date:   Fri, 18 Aug 2023 16:55:43 +0300
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
Subject: Re: [PATCH -next 06/11] gpio: mvebu: Use helper function
 devm_clk_get_enabled()
Message-ID: <ZN94X3PAFo/sp5Vq@smile.fi.intel.com>
References: <20230818093018.1051434-1-lizetao1@huawei.com>
 <20230818093018.1051434-7-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093018.1051434-7-lizetao1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 18, 2023 at 05:30:13PM +0800, Li Zetao wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
> prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
> can now be replaced by devm_clk_get_enabled() when the driver enables
> (and possibly prepares) the clocks for the whole lifetime of the device.
> Moreover, it is no longer necessary to unprepare and disable the clocks
> explicitly.

...

> -	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
>  	/* Not all SoCs require a clock.*/
> -	if (!IS_ERR(mvchip->clk))
> -		clk_prepare_enable(mvchip->clk);
> +	mvchip->clk = devm_clk_get_enabled(&pdev->dev, NULL);

The clk is only used in the PWM part, move it there and remove clk member from
the private struct.

-- 
With Best Regards,
Andy Shevchenko


