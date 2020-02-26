Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E601706CF
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 18:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgBZR5u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 12:57:50 -0500
Received: from muru.com ([72.249.23.125]:57804 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgBZR5u (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Feb 2020 12:57:50 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 737AB8022;
        Wed, 26 Feb 2020 17:58:34 +0000 (UTC)
Date:   Wed, 26 Feb 2020 09:57:46 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/4] pwm: omap-dmtimer: Allow for dynamic pwm period
 updates
Message-ID: <20200226175746.GS37466@atomide.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224052135.17278-1-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200224 05:23]:
> This series fixes minor issues in config callback and allows for on the
> fly updates for pwm period and duty cycle. This is mainly intended to
> allow pwm omap dmtimer to be used to generate a 1PPS signal that can be
> syncronized to PTP clock in CPTS module in AM335x and AM57xx SoCs.
> 
> Series tested after applying the following series:
> - https://patchwork.kernel.org/patch/11379875/
> - https://patchwork.kernel.org/project/linux-omap/list/?series=246183 
> 
> Full dependencies can be seen here:
> https://github.com/lokeshvutla/linux/tree/devel/pwm-1pps-generation
> 
> Lokesh Vutla (4):
>   pwm: omap-dmtimer: Drop unused header file
>   pwm: omap-dmtimer: Fix pwm enabling sequence
>   pwm: omap-dmtimer: Do not disable pwm before changing
>     period/duty_cycle
>   pwm: omap-dmtimer: Implement .apply callback

FYI, things seem to work for me after this set, but as it looks like
there will be v2 set of patches I want to test again with v2 out
before any Tested-by.

Thanks,

Tony
