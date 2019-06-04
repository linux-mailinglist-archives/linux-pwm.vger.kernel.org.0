Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A787434AD9
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2019 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfFDOre (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 Jun 2019 10:47:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:43104 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbfFDOrd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 Jun 2019 10:47:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 07:47:32 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 04 Jun 2019 07:47:29 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 04 Jun 2019 17:47:28 +0300
Date:   Tue, 4 Jun 2019 17:47:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] pwm: pca9685: fix pwm/gpio inter-operation
Message-ID: <20190604144728.GY2781@lahna.fi.intel.com>
References: <20190603151223.5311-1-TheSven73@gmail.com>
 <20190604091425.GL2781@lahna.fi.intel.com>
 <CAGngYiUc5_A1umM=8f12BLejq-3aqHnExEQ2RxNABv8u3HdqnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUc5_A1umM=8f12BLejq-3aqHnExEQ2RxNABv8u3HdqnA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 04, 2019 at 09:34:46AM -0400, Sven Van Asbroeck wrote:
> Thank you for the review, Mika ! See comments below.
> 
> On Tue, Jun 4, 2019 at 5:14 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > > This approach will also prevent the request of the "all" pwm channel, if any
> > > other pwm channel is already in use. Is this correct behaviour?
> >
> > Sounds correct to me.
> 
> Something that occurred to me right after I pressed the send button:
> 
> This patch will prevent a pwm 'all channels' request if at least one
> of the pwm's is in use. But it will not guard against the opposite:
> after the 'all channels' pwm is requested, it will still allow requests
> for other pwms/gpios !
> 
> This is identical to the old behaviour. But maybe this is an oversight
> and not a feature?

Most probably an oversight.

> Proposal:
> 1. prevent request of 'all channel' if any of the pwms/gpios are in use
> 2. prevent request of all other pwms/gpios if 'all channels' is in use

Makes sense.
