Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA0197F4A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgC3PMe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 11:12:34 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:57178 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgC3PMe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Mar 2020 11:12:34 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 81AF1C028FA;
        Mon, 30 Mar 2020 17:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1585581152;
        bh=owWsc4oE1uz/vgJXIvKbvjOwxqJ8BtE9s6a1tLJFCQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2BdfEdZXZazeotMsRW0DdmPwflxF8eSoHPIHQ0tHMUbYig+LXhUrNodmO5g1ZAm2
         7XAVjuS392ZPa7bboNXxL0/kkYpjbxjFnobbyCYYnHXRQ6pNMPZDUyFsdT79E3A29W
         TX0QhZ1KTNG/rdio4m41YvZ3bSlt69/xPeW+CSyo=
Date:   Mon, 30 Mar 2020 17:12:31 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Message-ID: <20200330151231.GA1650@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
 <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Wed, Feb 26, 2020 at 06:03:02PM +0100, Matthias Schiffer wrote:
> As it turns out, this driver is broken in yet another way I didn't find
> before: For changing the global prescaler the chip needs to be put into
> sleep mode, but the driver doesn't follow the restart sequence
> described in the datasheet when waking it back up. In consequence,
> changing the period of one PWM does not only modify the period of all
> PWMs (which is bad enough, but can't be avoided with this hardware),
> but it also leaves all PWMs disabled...

I am unable to reproduce this: If I set a specific duty cycle on a
channel and then change the period, the channel stays active.
I can see the brightness of an LED decrease if I increase the period.

This is expected, because after the SLEEP bit is set, we wait for
500usecs and then write to the LED ON/OFF registers.
This leaves the channel enabled with the new period (but with old
duty_ns value => different ratio)

A few years ago, I played around with the idea of remembering the
duty_ns to period_ns ratio and setting it accordingly after a period
change, possibly also with a shortcut of setting the RESTART bit if the
ratio did not change. Maybe after the switch to the atomic API, this
would be a nice improvement.

Best regards,
Clemens
