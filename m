Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5076E767
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Aug 2023 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjHCLvr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Aug 2023 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjHCLvq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Aug 2023 07:51:46 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5882D4E;
        Thu,  3 Aug 2023 04:51:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372589662"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="372589662"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872901112"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2023 04:51:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qRWrk-00AxRa-1Q;
        Thu, 03 Aug 2023 14:51:40 +0300
Date:   Thu, 3 Aug 2023 14:51:40 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 18/18] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <ZMuUzChRuEckOHIE@smile.fi.intel.com>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-19-u.kleine-koenig@pengutronix.de>
 <CAMRc=MfGWvAGYAh8q7mOenGDMpKS3q7UK7-Yxw5bn1avhoQ-UQ@mail.gmail.com>
 <20230729213712.mkfqgk6cage6yqsd@pengutronix.de>
 <CAMRc=MeSg7Emhv4VKdsPLfjTrLtsN8M0uapnDFtYGfbJ8UjxJA@mail.gmail.com>
 <20230803094212.g3il26hqbboppiz4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803094212.g3il26hqbboppiz4@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 03, 2023 at 11:42:12AM +0200, Uwe Kleine-König wrote:
> On Sun, Jul 30, 2023 at 12:07:33PM +0200, Bartosz Golaszewski wrote:

...

>  - the locking scheme in gpiod_request_commit() looks strange. gpio_lock
>    is released and retaken possibly several times. I wonder what it
>    actually protects there. Maybe doing
> 
> 	diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> 	index edab00c9cb3c..496b1cebba58 100644
> 	--- a/drivers/gpio/gpiolib.c
> 	+++ b/drivers/gpio/gpiolib.c
> 	@@ -2064,13 +2064,11 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
> 				goto out_free_unlock;
> 			}
> 		}
> 	+	spin_unlock_irqrestore(&gpio_lock, flags);
> 		if (gc->get_direction) {
> 			/* gc->get_direction may sleep */
> 	-		spin_unlock_irqrestore(&gpio_lock, flags);
> 			gpiod_get_direction(desc);
> 	-		spin_lock_irqsave(&gpio_lock, flags);
> 		}
> 	-	spin_unlock_irqrestore(&gpio_lock, flags);
> 		return 0;
> 	 
> 	 out_free_unlock:
> 
>    simplifies the code and given that gpiod_get_direction() rechecks
>    gc->get_direction unlocked I don't think we'd loose anything here.

Wouldn't this break sleeping bus accesses (I2C gpio expanders, etc)?

-- 
With Best Regards,
Andy Shevchenko


