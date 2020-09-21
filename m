Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458FE27214E
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Sep 2020 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIUKiE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 06:38:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:19050 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgIUKiD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 21 Sep 2020 06:38:03 -0400
IronPort-SDR: w58FHKHQC/nDxp8RHI1jI08BAl5SkatJBsthvaevqkq+dwj4peLKyk3aYkWh7YKYHntU1T/eAA
 6ZnbXRf8Wkjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="161275198"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="161275198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 03:38:02 -0700
IronPort-SDR: VRyQ4+EwVz9MYEg7d273qAC/eR7nhRYAfXu9CdC7DpSEX798ksxaCbYiDTdBa3z3zrUUEZZv8E
 jtncxHR2ebQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="337822045"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Sep 2020 03:37:59 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kKJCm-000iJf-1H; Mon, 21 Sep 2020 13:37:56 +0300
Date:   Mon, 21 Sep 2020 13:37:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     vijayakannan.ayyathurai@intel.com, thierry.reding@gmail.com,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v7 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Message-ID: <20200921103756.GP3956970@smile.fi.intel.com>
References: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
 <20200909162719.7585-3-vijayakannan.ayyathurai@intel.com>
 <20200921084401.gtesjzentxrly47c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200921084401.gtesjzentxrly47c@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 21, 2020 at 10:44:01AM +0200, Uwe Kleine-König wrote:
> On Thu, Sep 10, 2020 at 12:27:19AM +0800, vijayakannan.ayyathurai@intel.com wrote:
> > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> > 
> > Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> > 
> > Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> > Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> nitpick: Your S-o-b should always be last. This way it becomes clear who
> added the other tags.

I think it should reflect chronological order. If SoB has been given before
e.g. Ack then SoB should be followed by Ack and not other way around.

But it's my interpretation of the chapter 12. Actually it doesn't say anything
about placement (ordering) of Ack.

So, formally the above follows the letter of law.

What did you have in mind when commenting that? Perhaps I missed documentation.

-- 
With Best Regards,
Andy Shevchenko


