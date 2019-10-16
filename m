Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698C4D8B08
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfJPIdE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 04:33:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56861 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfJPIdE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 04:33:04 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKeju-00015O-Hv; Wed, 16 Oct 2019 10:33:02 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iKejt-0006er-LR; Wed, 16 Oct 2019 10:33:01 +0200
Date:   Wed, 16 Oct 2019 10:33:01 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/3] pwm: stm32: Minor cleanups
Message-ID: <20191016083301.63okdbunkq2slevu@pengutronix.de>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016073842.1300297-1-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 09:38:39AM +0200, Thierry Reding wrote:
> Hi,
> 
> Looking at Fabrice's STM32 patches I noticed that we're now passing the
> breakinput values (u32) into a function via int parameters. The easiest
> way to fix this inconsistency is by just passing a pointer to the break
> input structure. There's some preparatory work here that makes the code
> slightly more readable, in my opinion, but it's really marginal, so I'm
> not terribly thrilled by this series in retrospect.
> 
> If nobody else thinks this is a big improvement I'll just scrap it.

I like it. Together with my suggestion to add parameters to the register
offsets I think it's worth the effort.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
