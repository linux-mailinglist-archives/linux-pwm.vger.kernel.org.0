Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC41689BE7
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfHLKvL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 12 Aug 2019 06:51:11 -0400
Received: from mailoutvs28.siol.net ([185.57.226.219]:57653 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727847AbfHLKvK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 06:51:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 837F7523530;
        Mon, 12 Aug 2019 12:51:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id t6JWQo8cCAfO; Mon, 12 Aug 2019 12:51:07 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 2C631521B92;
        Mon, 12 Aug 2019 12:51:07 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id AA26E522124;
        Mon, 12 Aug 2019 12:51:05 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date:   Mon, 12 Aug 2019 12:51:05 +0200
Message-ID: <2877943.4JjSNuc4x8@jernej-laptop>
In-Reply-To: <20190812104700.vzpdxx3yddthiif5@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190812095648.wuefcr2mep3dpkth@flea> <20190812104700.vzpdxx3yddthiif5@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne ponedeljek, 12. avgust 2019 ob 12:47:00 CEST je Uwe Kleine-König 
napisal(a):
> Hello Maxime,
> 
> the idea of my mail was to summarize quickly the discussion for the dt
> people to give their judgement to stop us circling in a discussion about
> the always same points.
> 
> I suggest we stop the discussion here now and wait for a reply from them
> instead.

Shouldn't we just go with compromise solution you suggested and Maxime 
accepted? I would like to send new version in time for 5.4.

Best regards,
Jernej

> 
> Best regards
> Uwe




