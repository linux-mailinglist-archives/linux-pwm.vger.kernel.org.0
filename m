Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0D129019
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Dec 2019 22:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfLVVtC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Dec 2019 16:49:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52993 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfLVVtC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 22 Dec 2019 16:49:02 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ij95p-0002Wh-9Q; Sun, 22 Dec 2019 22:48:53 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ij95n-000697-Bk; Sun, 22 Dec 2019 22:48:51 +0100
Date:   Sun, 22 Dec 2019 22:48:51 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20191222214851.kapsro6b6qylke43@pengutronix.de>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
 <20191220031924.GA2658@labundy.com>
 <20191220085948.iagsdpjqd6ixdo7j@pengutronix.de>
 <20191221032755.GA3051@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191221032755.GA3051@labundy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Jeff,

On Sat, Dec 21, 2019 at 03:28:01AM +0000, Jeff LaBundy wrote:
> I heard back from the vendor today; they've acknowledged the limitation and
> are considering adding support for 0% in a future ROM spin. In the meantime,
> they've agreed to describe the high-impedance behavior in the data sheet as
> well as include the pull-down resistor in an example schematic.

Oh wow, seems like a good vendor then. :-)

> > > Option (3) seems like overkill for such a simple PWM, and ultimately doesn't
> > > add any value because I don't want to allow option (1) behavior in any case.
> > > Whether the PWM is disabled because it is truly disabled or to simulate a 0%
> > > duty cycle as in option (2), the pull-down is ultimately required regardless
> > > of whether or not the data sheet happens to go into such detail.
> > 
> > Actually I like option 3 best.
> >  
> 
> Based on your other feedback, I'm moving forward under the impression that
> you'll still accept option (2); please let me know if I have misunderstood
> (thank you for being flexible).

Yeah, that's fine. If in the end it shows that this is a bad idea we can
still change to (3).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
