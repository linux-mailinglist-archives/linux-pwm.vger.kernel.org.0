Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF8C4CB8A
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2019 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfFTKIC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jun 2019 06:08:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:61835 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfFTKIC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 20 Jun 2019 06:08:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 03:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="335450601"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2019 03:08:00 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hdtz5-00077J-IU; Thu, 20 Jun 2019 13:07:59 +0300
Date:   Thu, 20 Jun 2019 13:07:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: lpss: Convert to use SPDX identifier
Message-ID: <20190620100759.GR9224@smile.fi.intel.com>
References: <20190620092443.4854-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620092443.4854-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jun 20, 2019 at 12:24:43PM +0300, Mika Westerberg wrote:
> This gets rid of the license boilerplate duplicated in each file.
> 
> No functional changes intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c      | 5 +----
>  drivers/pwm/pwm-lpss-platform.c | 5 +----
>  drivers/pwm/pwm-lpss.c          | 5 +----
>  drivers/pwm/pwm-lpss.h          | 5 +----
>  4 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index c1527cb645be..5e47d9bccf22 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Intel Low Power Subsystem PWM controller PCI driver
>   *
>   * Copyright (C) 2014, Intel Corporation
>   *
>   * Derived from the original pwm-lpss.c
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #include <linux/kernel.h>
> diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
> index 757230e1f575..ce77539a0855 100644
> --- a/drivers/pwm/pwm-lpss-platform.c
> +++ b/drivers/pwm/pwm-lpss-platform.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Intel Low Power Subsystem PWM controller driver
>   *
>   * Copyright (C) 2014, Intel Corporation
>   *
>   * Derived from the original pwm-lpss.c
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #include <linux/acpi.h>
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 2ac3a2aa9e53..9a1b25926956 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Intel Low Power Subsystem PWM controller driver
>   *
> @@ -7,10 +8,6 @@
>   * Author: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>
>   * Author: Chew Chiau Ee <chiau.ee.chew@intel.com>
>   * Author: Alan Cox <alan@linux.intel.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #include <linux/delay.h>
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index 3236be835bd9..f47dede100f8 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -1,13 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Intel Low Power Subsystem PWM controller driver
>   *
>   * Copyright (C) 2014, Intel Corporation
>   *
>   * Derived from the original pwm-lpss.c
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #ifndef __PWM_LPSS_H
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


