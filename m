Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263D07A89E
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 14:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfG3Mfl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jul 2019 08:35:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33421 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfG3Mfk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jul 2019 08:35:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsRLj-0005tb-FO; Tue, 30 Jul 2019 14:35:27 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsRLf-0001Vh-M1; Tue, 30 Jul 2019 14:35:23 +0200
Date:   Tue, 30 Jul 2019 14:35:23 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
Message-ID: <20190730123523.cjtmr3tpttn6r3pt@pengutronix.de>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722154538.5314-3-david@lechnology.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 22, 2019 at 10:45:36AM -0500, David Lechner wrote:
> This adds a new counter driver for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) module.
> 
> Only very basic functionality is currently implemented - only enough to
> be able to read the position. The actual device has many more features
> which can be added to the driver on an as-needed basis.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  MAINTAINERS               |   6 +
>  drivers/counter/Kconfig   |  12 ++
>  drivers/counter/Makefile  |   1 +
>  drivers/counter/ti-eqep.c | 381 ++++++++++++++++++++++++++++++++++++++
>  drivers/pwm/Kconfig       |   2 +-

It's not obvious why the change to drivers/pwm/Kconfig is needed. Can
you please motivate that in the change log?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
