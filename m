Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2D184BAC
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2020 16:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCMPux (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Mar 2020 11:50:53 -0400
Received: from muru.com ([72.249.23.125]:60076 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMPux (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 13 Mar 2020 11:50:53 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 73F988087;
        Fri, 13 Mar 2020 15:51:38 +0000 (UTC)
Date:   Fri, 13 Mar 2020 08:50:49 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
Message-ID: <20200313155049.GE37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-5-lokeshvutla@ti.com>
 <20200306181443.GJ37466@atomide.com>
 <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
 <20200309180123.GP37466@atomide.com>
 <666dbb7a-db98-d16a-ee73-27d353d2a317@ti.com>
 <20200310155242.GT37466@atomide.com>
 <296e28b7-7925-5dfa-ce5a-c0b2a2f1c2e0@ti.com>
 <20200312005849.GY37466@atomide.com>
 <20200313153449.GD37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313153449.GD37466@atomide.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200313 15:35]:
> * Tony Lindgren <tony@atomide.com> [200312 00:59]:
> > * Lokesh Vutla <lokeshvutla@ti.com> [200311 04:14]:
> > > However, I see an issue with the patch itself as pm_runtime is not disabled
> > > after the pwm is stopped. Not sure how that could be nullified with this approach.
> > 
> > Hmm yeah not sure what could be used to clear things
> > when the current cycle is completed unless there's
> > some interrupt for it.
> 
> You could enable pm_runtime_use_autosuspend() for pwm use,
> then set the timeout to the cycle length, then in the
> runtime_suspend make sure the enable bit is cleared if
> requested.
> 
> But this too seems inaccurate, it would be best to clear
> the enable bit on some cycle completion interrupt if
> such thing is available.

I think enabling pm_runtime_use_autosuspend() for pwm,
adding a flag for pwm_enabled, and blocking cpu_pm if
pwm_enabled is set might do the trick though. Then clear
pwm_enabled flag in runtime_suspend if set.

This depend on cpuidle respecting NOTIFY_BAD that I
fixed in the recent thread:

[PATCH 0/3] Block idle in gpio-omap with cpu_pm

Regards,

Tony
