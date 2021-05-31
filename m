Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0292C396840
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhEaTJj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 15:09:39 -0400
Received: from pmg02-out3.zxcs.nl ([185.220.172.251]:56589 "EHLO
        pmg02-out3.zxcs.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhEaTJi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 15:09:38 -0400
Received: from pmg02.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg02.zxcs.nl (ZXCS) with ESMTP id EDA0182B8F;
        Mon, 31 May 2021 21:07:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID
        :References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LD6UHQO51Dg3HgJ9uiOrHpVNhVTobRPfvJr+H5j46UU=; b=FlabRISFHdUqKMnGbTHrMRUfM9
        fkaMQ4yX3pEY61AdyZqfJCYNW+h87v54/uor0wX/sLxZTLqwgHq2uLIhJxnF1nI55NuUtH0HsORmu
        wEbNuYiy52w6OTT6SYBdOEaKkqJzsuAJQJZMHS/OgEp8u/ndjH+yMvh3QUxXw6zD6LTS6z2szD1sR
        7Hh6YEbSoRQ7plZsX4O4/jlgly6E5xJEtaikUfyh6TgKEpOsCpwpYlzZ5xxCqQTcYzOxXbeYOiArd
        FDAndpzMFBBz+5NBYSQprP3JWN2OjolNCYFVOsDmMLeDrBGernxDuBUAxVUCGOwi91iNUm2NLz9sD
        BGfw7psA==;
MIME-Version: 1.0
Date:   Mon, 31 May 2021 21:07:54 +0200
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Roman Beranek <roman.beranek@prusa3d.cz>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/6] pwm: sun4i: only wait 2 cycles prior to disabling
In-Reply-To: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <e63e2b31c63bb9e227ed9ec04a8af54e@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Forwarded-For: roman.beranek@prusa3d.cz
X-AuthUser: dev@pascalroeleven.nl
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2021-05-31 06:46, Roman Beranek wrote:
> As Emil Lenngren has previously shown [1], actually only 1-2 cycles of
> the prescaler-divided clock are necessary to pass before the PWM turns
> off, not a full period.
> 
> To avoid having the PWM re-enabled from another thread while asleep,
> ctrl_lock spinlock was converted to a mutex so that it can be released
> only after the clock gate has finally been turned on.
> 
> [1] https://linux-sunxi.org/PWM_Controller_Register_Guide
> 
> Roman Beranek (6):
>   pwm: sun4i: enable clk prior to getting its rate
>   pwm: sun4i: disable EN bit prior to the delay
>   pwm: sun4i: replace spinlock with a mutex
>   pwm: sun4i: simplify calculation of the delay time
>   pwm: sun4i: shorten the delay to 2 cycles
>   pwm: sun4i: don't delay if the PWM is already off
> 
>  drivers/pwm/pwm-sun4i.c | 56 +++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 30 deletions(-)

Hi Roman,

Thanks for your attempt to fix this.

Unfortunately on my A10 device (Topwise A721), the controller still gets
stuck in an unrecoverable state after disabling and re-enabling the PWM
when it was already on (set in U-Boot), or when enabling it when it was
off. In this state, any changes to the period register (using devmem)
don't seem to have any effect. It seems to be stuck in the state it was
before disabling. The only thing which still works is enabling and
disabling.

I can't reproduce this behavior manually so I'm not sure what is causing
this.

Regarding the amount of cycles of sleep; Using a prescaler of 72000 the
PWM clock is 3 ms. Although timing tests using devmem seem unreliable
(too much overhead?), in U-Boot I need to 'sleep' for at least 7 ms
between the commands to make sure the output doesn't sometimes get stuck
in the enabled state. So in my case it seems to be at least 3 cycles. I
am not sure how reliable this method is. However even if I can get it
stuck in the enabled state using a shorter time, it doesn't cause the
behavior I mentioned before. I was always able to recover it manually.
Increasing the number of cycles to sleep therefore also doesn't solve my
problem. Until we can solve that I cannot confirm nor deny if 2 cycles
is enough.

Regards,
Pascal

