Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0A39D828
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFGJEf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 05:04:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:52280 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhFGJEf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Jun 2021 05:04:35 -0400
IronPort-SDR: /sJNLeNMCdh0gBwGoltttUtAcrC8v/EBrclop4iYdAnIKRoOZHxKS78IUSnox1gZ8LFItZG01f
 I2ho0F9Pychg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="184957542"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="184957542"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:02:44 -0700
IronPort-SDR: hGIn9itGSSU60y8NlEbk6Qd8VRhRGVXX+B74XXOmTcpMycJ22YtwjKudMOJlvY3W1lWLgfnCzI
 uDMKLZtwIx9Q==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="418439215"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:02:40 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqB9Z-000DHw-HD; Mon, 07 Jun 2021 12:02:37 +0300
Date:   Mon, 7 Jun 2021 12:02:37 +0300
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
Message-ID: <YL3grTQ00lFCXyCp@smile.fi.intel.com>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
 <20210531194947.10770-2-andriy.shevchenko@linux.intel.com>
 <20210606213054.bmqgs5hehbowa62d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210606213054.bmqgs5hehbowa62d@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jun 06, 2021 at 11:30:54PM +0200, Uwe Kleine-König wrote:
> Hello Andy,
> 
> On Mon, May 31, 2021 at 10:49:42PM +0300, Andy Shevchenko wrote:
> > It makes little sense to make PWM flags optional since in case
> > of multi-channel consumer the flags can be optional only for
> > the last listed channel.
> 
> I think the same holds true for dt references.

Can you elaborate this? I haven't got what you are talking about, not a DT
expert here.

> > Thus always require PWM flags to be provided.
> 
> I'm not sure I want to follow that conclusion. Most consumers only need
> a single PWM and then not providing flags is fine, isn't it? Or does
> this change fix an error?

The current ACPI DSD implementation in the Linux kernel doesn't allow to use
variadic arguments in the list of tuples.

So, the current code states that we may use (x, y, z) or (x, y, z, t).
That's true as long as that is the last tuple in the array (*). However,
the case (x1, y1, z1, x2, y2, z2, t2) is not supported. It can be either
(x1, y1, z1, t1, x2, y2, z2) or (x1, y1, z1, t1, x2, y2, z2, t2).
But this makes a little sense and Linux APIs in use and first ABI that uses
that API (GPIO) has never been designed for a such. What is allowed is to skip
tuple in a form of NULL:ifying, like (0, x2, y2, z2, t2).

*) Yes, the comments said that PWM supports only a single reference, but this
may be expanded in the future and this patch allows to do that (it's not a fix
per se, but rather a good clarification to the APIs/ABIs).

-- 
With Best Regards,
Andy Shevchenko


