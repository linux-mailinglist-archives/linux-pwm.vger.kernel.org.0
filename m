Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AAA27FCCC
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Oct 2020 12:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgJAKGw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Oct 2020 06:06:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:41820 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbgJAKGw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 1 Oct 2020 06:06:52 -0400
IronPort-SDR: OyOxrY2H67PqtXlSu2hc6Fg0RwI9iv6s3ozrHq4BWlP2k2VZ8DiygGSgkAAW9Dw/uTzcbSnCT0
 9VZbE41oyOGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="226807279"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="226807279"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 03:06:51 -0700
IronPort-SDR: DtnqfC+OjMxDl1qfLU4CbOt76fh+SG23n+DepQWOlHH0VGZYBqhrbjk26AKldi2jfc9DBw1KPX
 x7xuuNULy+pQ==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="339493734"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 03:06:48 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kNvU3-003Ccm-N7; Thu, 01 Oct 2020 13:06:43 +0300
Date:   Thu, 1 Oct 2020 13:06:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     vijayakannan.ayyathurai@intel.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v9 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201001100643.GA3956970@smile.fi.intel.com>
References: <20201001053751.10405-1-vijayakannan.ayyathurai@intel.com>
 <20201001053751.10405-2-vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001053751.10405-2-vijayakannan.ayyathurai@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 01, 2020 at 01:37:50PM +0800, vijayakannan.ayyathurai@intel.com wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 
> The Intel Keem Bay SoC requires PWM support.
> Add the pwm-keembay driver to enable this.
> 
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

> Reported-by: kernel test robot <lkp@intel.com>

No, the absence of the driver is not what was reported.
If you wish to give a credit to LKP, use changelog for that.


-- 
With Best Regards,
Andy Shevchenko


