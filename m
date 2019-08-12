Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31089BD6
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 12:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfHLKrF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 06:47:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55661 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfHLKrF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 06:47:05 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx7qw-0001B8-KY; Mon, 12 Aug 2019 12:47:02 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx7qu-0001m9-Up; Mon, 12 Aug 2019 12:47:00 +0200
Date:   Mon, 12 Aug 2019 12:47:00 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Message-ID: <20190812104700.vzpdxx3yddthiif5@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <173825848.1FZsmuHfpq@jernej-laptop>
 <20190729185108.tpilwoooxvi2z72e@pengutronix.de>
 <2452836.v7ux4bnEjb@jernej-laptop>
 <20190730080900.hhxrqun7vk4nsj2h@pengutronix.de>
 <20190730170601.a7ei43wku6jsjanu@flea>
 <20190731065230.mqbtn5sfoxrkevw5@pengutronix.de>
 <20190812095648.wuefcr2mep3dpkth@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812095648.wuefcr2mep3dpkth@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Maxime,

the idea of my mail was to summarize quickly the discussion for the dt
people to give their judgement to stop us circling in a discussion about
the always same points.

I suggest we stop the discussion here now and wait for a reply from them
instead.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
