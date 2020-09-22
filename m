Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F32273DF0
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIVJCZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 05:02:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:45008 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVJCZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Sep 2020 05:02:25 -0400
IronPort-SDR: Wamf29qVPkYleXNnl4XaFab399XvPmyCi/3t8ZRYxW+73MHaZrIn3fQwN63ksCbqyfO2mUUuX7
 x/3GBFmdPTyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="157942549"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="157942549"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 02:02:22 -0700
IronPort-SDR: 2gm+p/XVaWVaaOhS8rv3wFSOvN9JPllVyXs/usfZ9AIONfyEYtIKGC942E4ybSN9TDcTa5TRem
 ema00WzZJ5PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="338220868"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2020 02:02:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kKe5Q-00135O-11; Tue, 22 Sep 2020 11:55:44 +0300
Date:   Tue, 22 Sep 2020 11:55:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     vijayakannan.ayyathurai@intel.com, thierry.reding@gmail.com,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v7 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Message-ID: <20200922085544.GI3956970@smile.fi.intel.com>
References: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
 <20200909162719.7585-3-vijayakannan.ayyathurai@intel.com>
 <20200921084401.gtesjzentxrly47c@pengutronix.de>
 <20200921103756.GP3956970@smile.fi.intel.com>
 <20200922063403.5sm6fk7qopggoitc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922063403.5sm6fk7qopggoitc@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Sep 22, 2020 at 08:34:03AM +0200, Uwe Kleine-König wrote:
> On Mon, Sep 21, 2020 at 01:37:56PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 21, 2020 at 10:44:01AM +0200, Uwe Kleine-König wrote:
> > > On Thu, Sep 10, 2020 at 12:27:19AM +0800, vijayakannan.ayyathurai@intel.com wrote:
> > > > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> > > > 
> > > > Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> > > > 
> > > > Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> > > > Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > 
> > > nitpick: Your S-o-b should always be last. This way it becomes clear who
> > > added the other tags.
> > 
> > I think it should reflect chronological order. If SoB has been given before
> > e.g. Ack then SoB should be followed by Ack and not other way around.
> 
> This is how I interpret the rules even though I admit it is not
> formalized explicitly. The idea is just what I wrote, when the patch
> ends up in git with:
> 
> 	Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> 	Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 	Reviewed-by: Rob Herring <robh@kernel.org>
> 	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 	Signed-off-by: Peter Maintainer <p.maintainer@tralala>
> 
> I'd expect that is was Peter M. who added Rob's and my tag, while when
> it is
> 
> 	Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> 	Reviewed-by: Rob Herring <robh@kernel.org>
> 	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 	Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 	Signed-off-by: Peter Maintainer <p.maintainer@tralala>
> 
> it was Vijayakannan who added them.
> 
> IMHO this makes sense as Vijayakannan modified the commit log and then
> it is usual to add the signature at the end. In my eyes this is more
> sensible than the date order, but it seems this is subjective.
> 
> I'm aware that most people don't care; and I don't care enough to argue
> this case any further.

This makes sense. Consider that we are on the same page.
Thanks!

-- 
With Best Regards,
Andy Shevchenko


