Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01651897D0
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 10:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRJUz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 05:20:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51595 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRJUz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 05:20:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEUsa-0006vf-Bx; Wed, 18 Mar 2020 10:20:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEUsZ-0006yY-8Y; Wed, 18 Mar 2020 10:20:47 +0100
Date:   Wed, 18 Mar 2020 10:20:47 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Message-ID: <20200318092047.25gjkx43jwfyywsl@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
 <20200317225656.GK2527@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317225656.GK2527@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Laurent,

On Wed, Mar 18, 2020 at 12:56:56AM +0200, Laurent Pinchart wrote:
> On Tue, Mar 17, 2020 at 02:32:27PM +0200, Oleksandr Suvorov wrote:
> > PWM can have a normal polarity and a reverted one. The reverted polarity
> > value is defined.
> 
> I would squash this patch with 2/7, apart from that it looks fine.
> However, I also agree with Thierry that the PWM cell that contains this
> value is a bitmask, so once we get more flags it may get a bit awkward.

For me the usefulness of PWM_POLARITY_NORMAL increases with more bits
used. That's because if there are 5 things that can be set there and the
patch author mentions only the two that are non-zero, I as a reviewer
don't know if the author actually know and thought about the other
three. If however they spell out PWM_POLARITY_NORMAL it's quite sure
they want normal polarity.

> Will we have one macro for each flag that will evaluate to 0 to report
> that the flag isn't set ?

Yes. Given the above mentioned advantage this is cheap enough in my
eyes.

> Or should we define a single PWM_FLAG_NONE (or
> similarly named) macro ?

I like one macro for each bit field better for the above mentioned
reason.

> In retrospect, maybe PWM_POLARITY_INVERTED
> should have been named PWM_FLAG_POLARITY_INVERTED.

Seems to be subjective. I don't see much added semantic that justifies
the longer name.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
