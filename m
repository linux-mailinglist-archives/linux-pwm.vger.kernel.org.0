Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD02C33DA
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Nov 2020 23:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgKXWWg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Nov 2020 17:22:36 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33511 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgKXWWg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Nov 2020 17:22:36 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D53C823E3F;
        Tue, 24 Nov 2020 23:22:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606256553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84+rJsha9j459tKem2/3Yn5FLvXz4f2Q1YZsuN5CZwY=;
        b=uTwQqkCOuIjnRmuUdBxFaau5U4G3wqERuRfuL3adqU4+vhIuuJZsl1giFhFHJxL6zA0Xw/
        zeX5TEwImnaWsqlbL140RPikREF+R1KPeSHm2Mj0bUUWMD+/oJZ6+hfMfzGkc4Jed0/bf/
        6Tm6dyo0c9zk33ia07EyGpd+VSVZW6E=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 24 Nov 2020 23:22:33 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: sl28cpld: fix getting driver data in pwm callbacks
In-Reply-To: <20201124212432.3117322-1-u.kleine-koenig@pengutronix.de>
References: <20201124212432.3117322-1-u.kleine-koenig@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e92a3e855332b8e5fd6698a77852f758@walle.cc>
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

I wasn't able to reproduce the original bug, it seems it is really
timing/kernel/kernel config dependent. Thus I could only test if it
still working and could not verify that the original bug is fixed.
Nonetheless:

Tested-by: Michael Walle <michael@walle.cc>


Btw. the backtrace is available here:
   https://lavalab.kontron.com/scheduler/job/108#L950

-michael
