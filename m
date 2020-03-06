Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C117C4FD
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 19:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgCFSDd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 13:03:33 -0500
Received: from muru.com ([72.249.23.125]:59164 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFSDd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 13:03:33 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5DDA28027;
        Fri,  6 Mar 2020 18:04:18 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:03:29 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/6] pwm: omap-dmtimer: Drop unused header file
Message-ID: <20200306180329.GG37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095651.32464-2-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
> pwm_omap_dmtimer.h is used only:
> - to typedef struct omap_dm_timer to pwm_omap_dmtimer
> - for macro PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE
> Rest of the file is pretty mush unsed. So reuse omap_dm_timer
> and OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE in pwm-omap-dmtimer.c
> and delete the header file.

Acked-by: Tony Lindgren <tony@atomide.com>
