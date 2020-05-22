Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2861DE7FA
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 15:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgEVN0l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 09:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgEVN0l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 09:26:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F928C061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 06:26:41 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jc7h3-000574-6R; Fri, 22 May 2020 15:26:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jc7h1-0000Rm-DT; Fri, 22 May 2020 15:26:31 +0200
Date:   Fri, 22 May 2020 15:26:31 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v13 11/11] pwm: core: Convert period and duty cycle to u64
Message-ID: <20200522132631.sazoyq2d3krdvg6o@pengutronix.de>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <0ff7cc052b38411cba050d7066f17c9062a9101a.1587523702.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ff7cc052b38411cba050d7066f17c9062a9101a.1587523702.git.gurus@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 21, 2020 at 07:57:23PM -0700, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined as ints with units of
> nanoseconds, the maximum time duration that can be set is limited to
> ~2.147 seconds. Change their definitions to u64 in the structs of the
> PWM framework so that higher durations may be set.
> 
> Also use the right format specifiers in debug prints in both core.c as
> well as pwm-stm32-lp.c.
> 
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Joe Perches <joe@perches.com>
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

I like this change in general. I didn't check all the prepatory patches
in detail but the few I glanced over looked ok.

I think we have to prepare for having to fix a few fallouts but consider
it ok to expose this in next (but wouldn't send it for 5.8-rc1 yet).

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
