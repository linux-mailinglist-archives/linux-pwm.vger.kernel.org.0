Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2DB1E05
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2019 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfIMM71 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Sep 2019 08:59:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:32839 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbfIMM70 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 13 Sep 2019 08:59:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 05:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,501,1559545200"; 
   d="scan'208";a="200954962"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 13 Sep 2019 05:59:23 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 13 Sep 2019 15:59:22 +0300
Date:   Fri, 13 Sep 2019 15:59:22 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v2] pwm: pca9685: Fix regression for GPIO use
Message-ID: <20190913125922.GH28281@lahna.fi.intel.com>
References: <20190830182830.81627-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830182830.81627-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 30, 2019 at 09:28:30PM +0300, Andy Shevchenko wrote:
> The commit e926b12c611c ("pwm: Clear chip_data in pwm_put()") breaks GPIO usage
> by actually removing a crucial call to pwm_set_chip_data(), which is being used
> as a flag to understand the mode (GPIO vs. PWM) in which pin is currently
> working. Now, if once I requested GPIO, I may not be able to free and request
> it again.

There was another patch from Sven (cc'd) fixing the same issue here:

  https://lore.kernel.org/patchwork/patch/1084046/

But I don't think it was ever merged anywhere. Maybe you can try it out
and give your tested-by?

> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: drop leftovers in Fixes tag
>  drivers/pwm/pwm-pca9685.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 168684b02ebc..7cdec56ab3ec 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -165,6 +165,7 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
>  	pm_runtime_put(pca->chip.dev);
>  	mutex_lock(&pca->lock);
>  	pwm = &pca->chip.pwms[offset];
> +	pwm_set_chip_data(pwm, NULL);
>  	mutex_unlock(&pca->lock);
>  }
>  
> -- 
> 2.23.0.rc1
