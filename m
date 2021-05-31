Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967BD3968BD
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhEaU3z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 16:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhEaU3y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 16:29:54 -0400
X-Greylist: delayed 430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 May 2021 13:28:13 PDT
Received: from pmg01-out1.zxcs.nl (pmg01-out1.zxcs.nl [IPv6:2a06:2ec0:1::ffeb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56879C061574
        for <linux-pwm@vger.kernel.org>; Mon, 31 May 2021 13:28:13 -0700 (PDT)
Received: from pmg01.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg01.zxcs.nl (ZXCS) with ESMTP id BCDC91061D2
        for <linux-pwm@vger.kernel.org>; Mon, 31 May 2021 22:21:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID
        :References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JZmFLiAjzHRQOpVd4kN6fWiDdTeT4sWd4zxcaKOicbA=; b=eR//+iq3F13fcdq27DJGciZMNj
        BCTBdTCg4qTtU1B/AtmYa1H3F+oBA1iXHVCP/NKc9PavEbpzBs+KYEzJF3OxQrzHWC2w9f+swhEJ9
        J/HKkspj3LwYp9451PAaVnsYdCpOz4HLiyuYOD3DwXDt59TnR0yYMs+3TOZX+86j4hXqMqkp5dJmk
        KXD4N4trtCrcqNzzBjr9KnBhQxD0O36zjHsJy8EyBKTmK+vy8bs1AAAMcajo0dzxgil8n+8mddrx8
        fKBp2+kYgu7hGrs/HuWXnVWf7rcepQtdQnLMpIzujI8jImP8hOjkkdH+SBFVQD8k/lgEdlY0FzD3y
        L0CIUO8Q==;
MIME-Version: 1.0
Date:   Mon, 31 May 2021 22:20:55 +0200
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Roman Beranek <roman.beranek@prusa3d.cz>,
        =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/6] pwm: sun4i: only wait 2 cycles prior to disabling
In-Reply-To: <CAO1O6sdBX8D13tNKFAUynC2AcOX_Oo7tBEJi1vPPueSSQLfJOg@mail.gmail.com>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
 <e63e2b31c63bb9e227ed9ec04a8af54e@pascalroeleven.nl>
 <CAO1O6sdBX8D13tNKFAUynC2AcOX_Oo7tBEJi1vPPueSSQLfJOg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3626bda2eb9cd93744eca6f19c189feb@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Forwarded-For: linux-pwm@vger.kernel.org
X-AuthUser: dev@pascalroeleven.nl
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2021-05-31 22:01, Emil Lenngren wrote:
> You could look at the devmem source code, and in C write a script that
> writes to pwm register to disable the pwm, insert a usleep, then
> disable the gating. This can be done for various sleep values, then
> retrying with same sleep value multiple times. Assuming the overhead
> is low (you can check the overhead by checking the current timestamp
> at the beginning and at the end of the program, take the diff and then
> subtract the sleep time), you will get one range where it never works,
> one range where it works sometimes, and one range where it always
> works. The uncertain range's condition for succeeding will depend on
> when in the cycle you run the code.
> Assuming we believe 3 cycles are enough on A10 and prescaler is 72000,
> the thresholds for these ranges are 0-6 ms, 6-9 ms and 9+ ms.

Thank you I will give this a shot if there is still an uncertainty about
the cycles in the end. I performed my tests with a Busybox rootfs, so I
assumed the overhead was low as well.

> About "being stuck", I'm not sure exactly what you mean but it's
> expected that writes to the period register won't be visible (if you
> read it after a write) when the clock gating is disabled. Three full
> cycles (with the gating is on) must take place before the change is
> visible (i.e. need to wait four cycles to be sure). At least on >=A13.
> I documented that here:
> https://linux-sunxi.org/PWM_Controller_Register_Guide.

By being stuck, I mean being in an state from which it can't recover.
The controller will keep outputting seemingly the same signal regardless
what you write to the period register. You can read the values back, but
they aren't effecting the output anymore. No matter in what order or
with what delay I try to re-enable and disable the gate or enable bit,
it'll keep outputting the same signal until you reset the device.

