Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9117C501
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCFSEZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 13:04:25 -0500
Received: from muru.com ([72.249.23.125]:59188 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFSEZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 13:04:25 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D821E8027;
        Fri,  6 Mar 2020 18:05:10 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:04:22 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 3/6] pwm: omap-dmtimer: Fix pwm enabling sequence
Message-ID: <20200306180422.GI37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-4-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095651.32464-4-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
> To configure DM timer in pwm mode the following needs to be set in
> OMAP_TIMER_CTRL_REG using set_pwm callback:
> - Set toggle mode on PORTIMERPWM output pin
> - Set trigger on overflow and match on PORTIMERPWM output pin.
> - Set auto reload
> 
> This is a one time configuration and needs to be set before the start of
> the dm timer. But the current driver tries to set the same configuration
> for every period/duty cycle update, which is not needed. So move the pwm
> setup before enabling timer and do not update it in pwm_omap_dmtimer_config.

Still works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
