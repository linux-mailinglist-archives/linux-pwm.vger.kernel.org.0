Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77EFCE2B1F
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2019 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408569AbfJXHaU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Oct 2019 03:30:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37463 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404582AbfJXHaU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Oct 2019 03:30:20 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNXZQ-0003WA-Vh; Thu, 24 Oct 2019 09:30:08 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNXZP-0006Wo-Vp; Thu, 24 Oct 2019 09:30:07 +0200
Date:   Thu, 24 Oct 2019 09:30:07 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Updates for the atmel PWM driver
Message-ID: <20191024073007.n7tlxhoxk3yvdtly@pengutronix.de>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190824001041.11007-1-uwe@kleine-koenig.org>
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

On Sat, Aug 24, 2019 at 02:10:35AM +0200, Uwe Kleine-König wrote:
> this is v2 of my series to update the atmel PWM driver. (Implicit) v1
> was sent on Aug 15, starting with Message-Id:
> 20190815214133.11134-1-uwe@kleine-koenig.org.
> 
> I updated the patches from the feedback I got in v1, see the individual
> patches for the details.

This patch series is marked "Superseeded" in patchwork[1] but AFAIC this
is the most recent version of this series.

Can you please reconsider applying this series?

Best regards
Uwe

[1] https://patchwork.ozlabs.org/project/linux-pwm/list/?series=127096&state=*

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
