Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1E2F47F7
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbhAMJra (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 04:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbhAMJr3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 13 Jan 2021 04:47:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94C1E233F6;
        Wed, 13 Jan 2021 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610531209;
        bh=tq1brvetrKhiwzczjGp9tJnO9KW5tGjlksHZeSJsMa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVBkHEpyIuUEfSOAXmHrwJuHwEiy7TsveroYIV6h/7HTckbBLTTxswjsjgXr8zjLd
         epaexdCwOzvBhYCmxHMhUwXVtdvYFJQeKru46f6aG/DyRDUVzZdRl6jG/v83OR2yRc
         H9fvXSZ+r4lycwONYx4He0U0v8CVj0o107CApG/E=
Date:   Wed, 13 Jan 2021 10:47:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] misc: servo-pwm: driver for controlling servo motors via
 PWM
Message-ID: <X/7By1uFKhucSxuB@kroah.com>
References: <20201222213342.2657026-1-angelo.compagnucci@gmail.com>
 <20210113093546.5v7kbjoog64dfpij@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210113093546.5v7kbjoog64dfpij@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 13, 2021 at 10:35:46AM +0100, Uwe Kleine-König wrote:
> [Cc += gregkh]
> 
> On Tue, Dec 22, 2020 at 10:33:42PM +0100, Angelo Compagnucci wrote:
> > +static int servo_pwm_probe(struct platform_device *pdev)
> > +{
> > [...]
> > +	ret = devm_device_add_groups(&pdev->dev, servo_pwm_groups);
> 
> There are very little cases where calling this function is correct and
> I think in the probe function of a platform driver it's always wrong.

That is correct, just set the platform driver's default groups pointer
and all will be handled properly and automatically.

As mentioned on IRC, this patch isn't describing these new sysfs files
in Documentation/ABI/ which is required for new files.  Angelo, for the
next version, please do that, thanks!

greg k-h
