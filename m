Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0037AD48
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfG3QIm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jul 2019 12:08:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:35661 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfG3QIl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 30 Jul 2019 12:08:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 09:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="323249179"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2019 09:08:38 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hsUg1-0005Nn-AA; Tue, 30 Jul 2019 19:08:37 +0300
Date:   Tue, 30 Jul 2019 19:08:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        youling257@gmail.com,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static
 lookup-list when acpi_pwm_get fails
Message-ID: <20190730160837.GU23480@smile.fi.intel.com>
References: <20190730154848.5164-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730154848.5164-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 30, 2019 at 05:48:48PM +0200, Hans de Goede wrote:
> Commit 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
> made pwm_get unconditionally return the acpi_pwm_get return value if
> the device passed to pwm_get has an ACPI fwnode.
> 
> But even if the passed in device has an ACPI fwnode, it does not
> necessarily have the necessary ACPI package defining its pwm bindings,
> especially since the binding / API of this ACPI package has only been
> introduced very recently.
> 
> Up until now X86/ACPI devices which use a separate pwm controller for
> controlling their LCD screen's backlight brightness have been relying
> on the static lookup-list to get their pwm.
> 
> pwm_get unconditionally returning the acpi_pwm_get return value breaks
> this, breaking backlight control on these devices.
> 
> This commit fixes this by making pwm_get fall back to the static
> lookup-list if acpi_pwm_get returns -ENOENT.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Perhaps, we may switch to swnode API instead of lookup tables in the future?

> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=96571
> Reported-by: youling257@gmail.com
> Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index c3ab07ab31a9..8edfac17364e 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -882,8 +882,11 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  		return of_pwm_get(dev, dev->of_node, con_id);
>  
>  	/* then lookup via ACPI */
> -	if (dev && is_acpi_node(dev->fwnode))
> -		return acpi_pwm_get(dev->fwnode);
> +	if (dev && is_acpi_node(dev->fwnode)) {
> +		pwm = acpi_pwm_get(dev->fwnode);
> +		if (!IS_ERR(pwm) || PTR_ERR(pwm) != -ENOENT)
> +			return pwm;
> +	}
>  
>  	/*
>  	 * We look up the provider in the static table typically provided by
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko


