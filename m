Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC592C7F9E
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 09:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgK3ISi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 03:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgK3ISh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Nov 2020 03:18:37 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F38C0613CF
        for <linux-pwm@vger.kernel.org>; Mon, 30 Nov 2020 00:17:57 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3C1C122802;
        Mon, 30 Nov 2020 09:17:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606724273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFHl2x4I9P6Gmq4//o9+dV3k8p1FlI4kDNfLwKfyZLU=;
        b=STF85pFqVE6SXRcoH4wDgRoMQ46enxDnNJvippcTuq2q2dtBezXKSKRRGTZizSMqH6Eh7t
        S3RoPDAOllPtGr2I6Srk+3RWsWwU0p3e/FeRvfLYPPS/eCGvS88P/rqA3zvw2Czu9Qzjy3
        meZhabw8yWTK3BP865QpM8b5OaGPFL0=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Nov 2020 09:17:52 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: sl28cpld: fix getting driver data in pwm callbacks
In-Reply-To: <20201124212432.3117322-1-u.kleine-koenig@pengutronix.de>
References: <20201124212432.3117322-1-u.kleine-koenig@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <3becef43bd9119c624cf6c3c8ee5b472@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-11-24 22:24, schrieb Uwe Kleine-König:
> Currently .get_state() and .apply() use dev_get_drvdata() on the struct
> device related to the pwm chip. This only works after .probe() called
> platform_set_drvdata() which in this driver happens only after
> pwmchip_add() and so comes possibly too late.
> 
> Instead of setting the driver data earlier use the traditional
> container_of approach as this way the driver data is conceptually and
> computational nearer.
> 
> Fixes: 9db33d221efc ("pwm: Add support for sl28cpld PWM controller")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> in v4 of the driver Michael still used container_of and then changed to
> use dev_get_drvdata() as Lee suggested. I didn't notice this 
> suggestion,
> otherwise I would have expressed my variance about this already 
> earlier.
> 
> I noticed this problem because Michael contacted me via irc and showed
> me the resulting oops, so I think applying this before 5.10 would be
> good. It's not entirely clear to me why .get_state() is called that
> early in his case, but the theory is clear: The callbacks can be called
> as soon as pwmchip_add() is called.
> 
> Best regards
> Uwe

Ping. Would be nice if this makes it into v5.10.

-michael
