Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BC0183766
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 18:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLR1E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 13:27:04 -0400
Received: from muru.com ([72.249.23.125]:59944 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgCLR1E (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Mar 2020 13:27:04 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BDF7380BF;
        Thu, 12 Mar 2020 17:27:48 +0000 (UTC)
Date:   Thu, 12 Mar 2020 10:26:59 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 0/6] clocksource: timer-ti-dm: Prepare for dynamic pwm
 period updates
Message-ID: <20200312172659.GZ37466@atomide.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200306171917.GF37466@atomide.com>
 <f40cd563-c05b-90b6-c526-196fcd4fa146@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40cd563-c05b-90b6-c526-196fcd4fa146@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

* Daniel Lezcano <daniel.lezcano@linaro.org> [200312 11:11]:
> On 06/03/2020 18:19, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla@ti.com> [200305 08:29]:
> >> This series fixes dm_timer_ops used for enabling the pwm and enables
> >> cpu_pm notifier for context save and restore. This acts as a preparatory
> >> series for enabling dynamic period updates for pwm omap dm timer driver.
> >>
> >> Changes since v2:
> >> - Incorporated changes from Tony
> > 
> > I just gave this series another try here and it still works
> > for me just fine and is good to go as far as I'm concerned.
> 
> How do you want this series to be merged?
> 
> Shall I pick the patches falling under drivers/clocksource or ack them?

I think best would be if you picked them and applied them into
an immutable branch against v5.6-rc1 that can also be merged
into pwm driver branch as needed.

Regards,

Tony
