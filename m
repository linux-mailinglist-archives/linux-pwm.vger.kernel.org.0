Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371AE184AC6
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2020 16:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCMPbq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Mar 2020 11:31:46 -0400
Received: from muru.com ([72.249.23.125]:60044 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgCMPbq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 13 Mar 2020 11:31:46 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D0DBF8087;
        Fri, 13 Mar 2020 15:32:31 +0000 (UTC)
Date:   Fri, 13 Mar 2020 08:31:42 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 5/5] pwm: omap-dmtimer: Implement .apply callback
Message-ID: <20200313153142.GC37466@atomide.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-6-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312042210.17344-6-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200312 04:24]:
> Implement .apply callback and drop the legacy callbacks(enable, disable,
> config, set_polarity). In .apply() check for the current hardware status
> before changing the pwm configuration.

This set works just fine for me thanks, so for this patch too:

Tested-by: Tony Lindgren <tony@atomide.com>
