Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB95B3389F0
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 11:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhCLKVG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 05:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233158AbhCLKUj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Mar 2021 05:20:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF53464FEE;
        Fri, 12 Mar 2021 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615544439;
        bh=i8BTjPbaSBD2WJf+zlHsnLnWtJt4ZNHViJXbI9JhEOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4W12jvokMyP69k/o3RM4oRWptEwBlstuCjbqt7jkGTjgNcZpz87dPbcymvIrP6ws
         h2drR+xGaBZLdCWSx7yf0WZqEeCkE51pGYD9wdlukDF/052Z69CJx9gaFWPoNcWAT6
         eVnvKjS1PVvX8MmpUyijhLWYr/RvJZd12NZTDqIE=
Date:   Fri, 12 Mar 2021 11:20:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: lifetime of pwm devices
Message-ID: <YEtAdbNA/c/FtVgX@kroah.com>
References: <20210312083449.5htbbr2zgqfxc3wo@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312083449.5htbbr2zgqfxc3wo@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 12, 2021 at 09:34:49AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> currently PWM consumers (like for example a PWM fan) get a device link
> to the PWM device that ensures that if the PWM device goes away, the
> consumer is removed, too.
> 
> (This results in:
> 
> [   67.234400] pwm-fan pwm-fan: Dropping the link to 3f20c000.pwm
> [   67.234429] device: 'platform:3f20c000.pwm--platform:pwm-fan': device_unregister
> [   67.234694] device: 'hwmon1': device_unregister
> [   67.235384] device: 'pwmchip0': device_unregister
> [   67.235488] device: 'pwmchip0': device_create_release
> 
> when I do
> 	echo 3f20c000.pwm > /sys/bus/platform/drivers/bcm2835-pwm/unbind
> 
> on a rpi3 like device with a PWM fan and some debugging enabled.)
> 
> Before the device link was established in commit
> 
> 	b2c200e3f2fd ("pwm: Add consumer device link")
> 
> for v5.3-rc1 the machine was easy to crash after the PWM disappeared by
> making the consumer use the gone PWM.
> 
> Now I wonder if it is just harder to trigger such a crash or if the link
> is good enough to cover all corner cases.
> 
> I wonder if the pretty approach would be to ensure that the pwmchip's
> lifetime is tracked using a struct dev that ensures that the pwmchip
> doesn't go away until the consumer releases it. Is there an urge to
> address this?

Preventing user-causable oopses is always good :)

The driver model should solve this, if it is used properly, why isn't
the pwm layer using a struct device today?

thanks,

greg k-h
