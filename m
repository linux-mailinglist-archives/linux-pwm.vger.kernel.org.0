Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E50BC764
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504806AbfIXMAJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 08:00:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40971 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbfIXMAJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 08:00:09 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCjUG-0003qy-FS; Tue, 24 Sep 2019 14:00:08 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCjUG-00071E-6D; Tue, 24 Sep 2019 14:00:08 +0200
Date:   Tue, 24 Sep 2019 14:00:08 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 4/4] [RFC] Documentation: pwm: rework documentation for
 the framework
Message-ID: <20190924120008.m3l4qsyhmuyfssnl@pengutronix.de>
References: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
 <20190107194938.3004-5-u.kleine-koenig@pengutronix.de>
 <20190726093912.q6m6syroot2eqie6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726093912.q6m6syroot2eqie6@pengutronix.de>
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

On Fri, Jul 26, 2019 at 11:39:12AM +0200, Uwe Kleine-König wrote:
> Hello Thierry,
> 
> On Mon, Jan 07, 2019 at 08:49:43PM +0100, Uwe Kleine-König wrote:
> > This is a draft for an in my eyes improved documentation describing
> > consumers, providers and backend drivers of the PWM framework.
> > 
> > The bigger changes include:
> > 
> >  - sysfs description is split into a separate document (otherwise unchanged)
> >  - Only the new style functions and callbacks are described; the legacy
> >    stuff is just mentioned shortly in a dedicated paragraph.
> >  - The expectations for the different callbacks (most importantly .apply)
> >    are mentioned explicitly.
> > 
> > There is a gap in the documentation because I didn't understand the
> > .capture callback. There is no documentation about it, just two drivers
> > implementing it. I guess it is about measuring an input signal, so it seems
> > to be misplaced in the PWM framework which otherwise is just about an
> > output pin.
> 
> I'm still waiting for feedback here. AFAICT there is nothing that should
> be controversial as I intended to just describe the status quo.

This patch doesn't apply any more since

	baa293e9544b ("docs: driver-api: add a series of orphaned documents")

. (The respective patch didn't make it to the linux-pwm list.)

Do you consider it worthwhile to update the patch? Should the sysfs
stuff live under Documentation/driver-api, too?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
