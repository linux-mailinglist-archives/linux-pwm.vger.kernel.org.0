Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9D17C422
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCFRTV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 12:19:21 -0500
Received: from muru.com ([72.249.23.125]:59146 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFRTU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 12:19:20 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B45718027;
        Fri,  6 Mar 2020 17:20:05 +0000 (UTC)
Date:   Fri, 6 Mar 2020 09:19:17 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 0/6] clocksource: timer-ti-dm: Prepare for dynamic pwm
 period updates
Message-ID: <20200306171917.GF37466@atomide.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305082715.15861-1-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200305 08:29]:
> This series fixes dm_timer_ops used for enabling the pwm and enables
> cpu_pm notifier for context save and restore. This acts as a preparatory
> series for enabling dynamic period updates for pwm omap dm timer driver.
> 
> Changes since v2:
> - Incorporated changes from Tony

I just gave this series another try here and it still works
for me just fine and is good to go as far as I'm concerned.

Thanks for doing this.

Regards,

Tony
