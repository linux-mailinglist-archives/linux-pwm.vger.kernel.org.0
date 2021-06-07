Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95F939D97A
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFGKXA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 06:23:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:50986 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhFGKW7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Jun 2021 06:22:59 -0400
IronPort-SDR: EgvVF5FwAX0BDBJ0kjmEwUkf0BJKlNFP99SWCDdfK46fWhpRYHyJunZmdpYE3Q7OtVhaGvMLDt
 fdtdeuPAG9ww==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="290222965"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="290222965"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 03:21:08 -0700
IronPort-SDR: KAVwJ8SOXmoipagfCWW0N+nqntivHVMgALuZ37ntjj1WZSX0oqNpYJcjdlQjMQJKTkRdHSPuzx
 n5ND3wXjp9Ow==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="484727492"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 03:21:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqCNR-000EF9-KD; Mon, 07 Jun 2021 13:21:01 +0300
Date:   Mon, 7 Jun 2021 13:21:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Flavio Suligoi <f.suligoi@asem.it>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/7] pwm: core: Always require PWM flags to be provided
Message-ID: <YL3zDUWsY9mUW0eQ@smile.fi.intel.com>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
 <20210531194947.10770-2-andriy.shevchenko@linux.intel.com>
 <20210606213054.bmqgs5hehbowa62d@pengutronix.de>
 <YL3grTQ00lFCXyCp@smile.fi.intel.com>
 <20210607095324.yaiu5lzb5zgoejpa@pengutronix.de>
 <YL3xuJyAcbPLW7yG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL3xuJyAcbPLW7yG@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 07, 2021 at 01:15:20PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 07, 2021 at 11:53:24AM +0200, Uwe Kleine-König wrote:
> > On Mon, Jun 07, 2021 at 12:02:37PM +0300, Andy Shevchenko wrote:
> > > On Sun, Jun 06, 2021 at 11:30:54PM +0200, Uwe Kleine-König wrote:
> > > > On Mon, May 31, 2021 at 10:49:42PM +0300, Andy Shevchenko wrote:
> > > > > It makes little sense to make PWM flags optional since in case
> > > > > of multi-channel consumer the flags can be optional only for
> > > > > the last listed channel.
> > > > 
> > > > I think the same holds true for dt references.
> > > 
> > > Can you elaborate this? I haven't got what you are talking about, not a DT
> > > expert here.
> > 
> > Ah no, I mixed that up. While the function that parses the phandle is
> > flexible, for each pwm controller the number of arguments is fixed, so
> > 
> > 	pwms = <&pwm1 100000 &pwm2 100000 &pwm3 1000000>;
> > 
> > cannot be interpreted as 3-argument references to two PWMs. This is
> > different to ACPI (I guess, not an ACPI expert here :-) because &pwm1
> > "knows" if it needs 1 or 2 additional parameters (#pwm-cells).
> 
> It's not about ACPI, it's about "the ACPI glue layer in Linux kernel".
> Used API is a part of it and it does allow only two cases, either NULL entry
> (by having 0 as an argument) or full-length supplied tuple (in case of PWM it's
> 3, so, means 4 parameters.
> 
> Let's consider examples:
> 
> (0, 0, x3, y3, z3, t3) // NULL, NULL, PWM3
> (x1, y1, z1, t1, 0, x3, y3, z3, t3) // PWM1, NULL, PWM3
> 
> So, making last parameter "flexible" will work only for the last tuple in the
> array.
> 
> Read this [1] for further information.
> 
> [1]: https://elixir.bootlin.com/linux/latest/source/drivers/acpi/property.c#L629

Hmm... I have read the actual implementation and it seems it's possible to have
flexible array, so this patch needs to be reconsidered.


-- 
With Best Regards,
Andy Shevchenko


