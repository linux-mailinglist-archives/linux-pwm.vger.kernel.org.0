Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0C762A9
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jul 2019 11:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfGZJjO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jul 2019 05:39:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53419 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfGZJjO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Jul 2019 05:39:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hqwgz-0001tg-3C; Fri, 26 Jul 2019 11:39:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hqwgy-0002qG-Qb; Fri, 26 Jul 2019 11:39:12 +0200
Date:   Fri, 26 Jul 2019 11:39:12 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 4/4] [RFC] Documentation: pwm: rework documentation for
 the framework
Message-ID: <20190726093912.q6m6syroot2eqie6@pengutronix.de>
References: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
 <20190107194938.3004-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107194938.3004-5-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Mon, Jan 07, 2019 at 08:49:43PM +0100, Uwe Kleine-König wrote:
> This is a draft for an in my eyes improved documentation describing
> consumers, providers and backend drivers of the PWM framework.
> 
> The bigger changes include:
> 
>  - sysfs description is split into a separate document (otherwise unchanged)
>  - Only the new style functions and callbacks are described; the legacy
>    stuff is just mentioned shortly in a dedicated paragraph.
>  - The expectations for the different callbacks (most importantly .apply)
>    are mentioned explicitly.
> 
> There is a gap in the documentation because I didn't understand the
> .capture callback. There is no documentation about it, just two drivers
> implementing it. I guess it is about measuring an input signal, so it seems
> to be misplaced in the PWM framework which otherwise is just about an
> output pin.

I'm still waiting for feedback here. AFAICT there is nothing that should
be controversial as I intended to just describe the status quo.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
