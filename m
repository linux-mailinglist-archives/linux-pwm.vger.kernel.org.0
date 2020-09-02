Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE5125B4FF
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 22:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBUCR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 16:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIBUCQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 16:02:16 -0400
X-Greylist: delayed 1154 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Sep 2020 13:02:15 PDT
Received: from pmg01-out3.zxcs.nl (pmg01-out3.zxcs.nl [IPv6:2a06:2ec0:1:b::ffeb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAADC061244
        for <linux-pwm@vger.kernel.org>; Wed,  2 Sep 2020 13:02:15 -0700 (PDT)
Received: from pmg01.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg01.zxcs.nl (ZXCS) with ESMTP id E9240103D74;
        Wed,  2 Sep 2020 21:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID
        :References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KNenMuIKDW/cG/OCNrUxLUJ9j1/2p1rYL+aDVLwuqv4=; b=hdXDtFwYQb1ag7/bFm3Zz3rLW7
        1qF0TdHjx1k4Ord2Ywa+wPX7L+PSAxxUoxQL+7chtN5gqrIbIgfHxIjcaltzzS1/1j9FbGnIwpJ70
        8pm/DOcJvEIk/cAwXgIVsPH3/uSpbw/2fYteubtA3mH2fWsx13CaMF42E4U6/dHRFg9Om4DlNZ/t+
        ZalA0iOA/yAIGX63hb/Rjc/jmwa9swMYwGKRM321jwUQA0KnJUVaP5JnkOUrex1txUV4ZdP0mGe7g
        1GbI6h3lTq+/kvPA83ovp/d3GsoiN9cksY7bEOH/vtmDmCQzotBFnm8U3Tr0IllzamX/18GQMn5XO
        6crHMZqg==;
MIME-Version: 1.0
Date:   Wed, 02 Sep 2020 21:42:49 +0200
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Andrey Lebedev <andrey@lebedev.lt>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Emil Lenngren <emil.lenngren@gmail.com>
Subject: Re: pwm-sun4i: PWM backlight is not turned off on shutdown
In-Reply-To: <913a5324-a7d2-f1d5-701e-1c28359286f2@lebedev.lt>
References: <ae58976c-a8d7-0d00-fe72-d21579b37240@lebedev.lt>
 <20200902095402.pombrirqqjdew34b@holly.lan>
 <913a5324-a7d2-f1d5-701e-1c28359286f2@lebedev.lt>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <5302741318a28e39239db08a1f05ecb7@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AuthUser: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Thank you for adding me. Emil (also added now) and I spent a while on 
trying to figure out how to solve this. The Allwinner PWM controller has 
some quirks.

Unfortunately I never got around to perform some more tests and fix it 
indefinitely. It's still on my todo list..

> On 9/2/20 12:54 PM, Daniel Thompson wrote:
>> There's some rather odd logic in sun4i_pwm_apply() that results in the
>> PWM being disabled twice... once when it applies the initial config
>> and again after waiting for a duty_cycle.

That's true. To properly turn off the controller you have to turn the 
controller off first and keep the gate on for at least two full clock 
cycles. Then the gate must be turned off. Otherwise it might get stuck. 
That's probably what is trying to be done here.

On 2020-09-02 21:05, Andrey Lebedev wrote:
> Indeed, this fixes the issue for me. The display goes dark reliably on
> writing 4 to "/sys/.../bl_power" as well as when system is halted. I 
> did
> not notice any negative side effects so far.

Problems start to arise when combining bl_power and brightness setting 
in a particular order or at the same time (with for example a backlight 
driver which sets both bl_power and brightness). I can't recall exactly 
what caused problems and when, but one thing I was sure of is that 
timing was of the essence. Once I added some delays here and there it 
started to work.

If this patch works for you then that's great, but unfortunately it 
isn't a complete solution.

Regards,
Pascal

