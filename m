Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E479175CE8
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCBOXr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 09:23:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48913 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgCBOXr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2020 09:23:47 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j8lys-0006BU-0S; Mon, 02 Mar 2020 15:23:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j8lyo-0005zd-PI; Mon, 02 Mar 2020 15:23:34 +0100
Date:   Mon, 2 Mar 2020 15:23:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Lee Jones <lee.jones@linaro.org>, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200302142334.orvi7aqbsbnfspy5@pengutronix.de>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
 <20200302120458.GY3494@dell>
 <20200302141117.GA11787@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302141117.GA11787@labundy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Mar 02, 2020 at 08:11:17AM -0600, Jeff LaBundy wrote:
> On Mon, Mar 02, 2020 at 12:04:58PM +0000, Lee Jones wrote:
> > On Thu, 27 Feb 2020, Jeff LaBundy wrote:
> > 
> > > Hi Lee,
> > > 
> > > On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> > > 
> > > [...]
> > > 
> > > > 
> > > > Well done Jeff.  Good job.
> > > > 
> > > > Applied, thanks.
> > > > 
> > > 
> > > Thank you for your kind words as well as your support in fleshing out this
> > > series.
> > > 
> > > Just to confirm, does your offer to take the remainder (once everything is
> > > approved) through immutable branches still stand?
> > 
> > Depends how quickly you can get the other drivers turned around.
> 
> With Uwe's approval from Friday, all five drivers are complete.

Note that I'm "only" reviewer of the PWM stuff and Thierry is the one
responsible for the pwm-tree. So you need his ack to take the pwm patch
through a different tree.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
