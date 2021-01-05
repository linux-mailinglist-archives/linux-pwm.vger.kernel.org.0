Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B959B2EAA0A
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Jan 2021 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbhAELii (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Jan 2021 06:38:38 -0500
Received: from regular1.263xmail.com ([211.150.70.200]:48640 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbhAELii (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Jan 2021 06:38:38 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 06:38:36 EST
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id C8FBF1D3C;
        Tue,  5 Jan 2021 19:26:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.8] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P25764T139971161745152S1609845976148085_;
        Tue, 05 Jan 2021 19:26:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <768ea1c198b2de55ad84ca1b0aefa9c3>
X-RL-SENDER: david.wu@rock-chips.com
X-SENDER: wdc@rock-chips.com
X-LOGIN-NAME: david.wu@rock-chips.com
X-FST-TO: steven.liu@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v3_0/7=5d_pwm=3a_rockchip=3a_Eliminate_pot?=
 =?UTF-8?B?ZW50aWFsIHJhY2UgY29uZGl0aW9uIHdoZW4gcHJvYmluZ+OAkOivt+azqOaEjw==?=
 =?UTF-8?B?77yM6YKu5Lu255Sxa2V2ZXIueWFuZ0BnbWFpbC5jb23ku6Plj5HjgJE=?=
To:     Kever Yang <kever.yang@rock-chips.com>,
        Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de,
        Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org,
        Heiko Stuebner <heiko@sntech.de>, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, steven.liu@rock-chips.com
References: <CAKUh=Ry7=WUmN5OYv5g_E1EHk8jNE-QcOtw_BrMbH+_aP68w8Q@mail.gmail.com>
From:   David Wu <david.wu@rock-chips.com>
Message-ID: <fdd2b3c3-5eaf-bcad-ba57-54b13e891f4a@rock-chips.com>
Date:   Tue, 5 Jan 2021 19:26:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKUh=Ry7=WUmN5OYv5g_E1EHk8jNE-QcOtw_BrMbH+_aP68w8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Simon,

This series of patches are okay for me, simplify to read pwm
register to check pwm whether it is enabled. So,

Revieded-by: David Wu <david.wu@rock-chips.com>

在 2020/12/25 下午3:10, Kever Yang 写道:
> + David and Steven,
> 
> Hi Steven,
>      please help to review this patch set.
> 
> Thanks
> - Kever
> Simon South <simon@simonsouth.net <mailto:simon@simonsouth.net>> 于2020 
> 年12月24日周四 上午12:01写道：
> 
>     This patch series aims to eliminate the race condition Trent Piepho
>     identified[0] in the Rockchip PWM driver's rockchip_pwm_probe()
>     function, by moving code that checks whether a device is enabled ahead
>     of the code that registers it via pwmchip_add().
> 
>     It has grown to include a number of other small fixes and improvements
>     to the driver. It now also
> 
>     - Fixes a potential kernel hang introduced by my earlier commit
>        457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
>        probing") by ensuring a device's APB clock is enabled before its
>        registers are accessed;
> 
>     - Removes a superfluous call to clk_unprepare() that could result in
>        warnings from the kernel;
> 
>     - Clarifies the driver's error messages by replacing "bus clk" with
>        "PWM clk";
> 
>     - Removes the now-unneeded goto targets from rockchip_pwm_probe();
> 
>     - Tries to improve rockchip_pwm_probe() by having it enable the signal
>        clock of only PWM devices that are already running; and
> 
>     - Ensures the driver enables a clock before querying its rate with
>        clk_get_rate(), as stated as a requirement in that function's
>        documentation.
> 
>     The first patch ("Enable APB clock...") is unchanged from version 2.
> 
>     New in version 3 are
> 
>     - Finer patch granularity, with patches 2 and 5 added to clarify
>        changes included with others in v2;
> 
>     - A rewritten patch 6 ("Enable PWM clock...") with a smaller change
>        and the use of if...else in place of a ternary operator;
> 
>     - Patches 3 and 7 with fixes suggested by Robin Murphy and Uwe
>        Kleine-König; and
> 
>     - Rewritten and (hopefully) more accurate commit messages.
> 
>     I've tested these changes on my (RK3399-based) Pinebook Pro with its
>     screen backlight enabled by U-Boot and each one appears to work fine.
> 
>     I'd (still) be grateful for help with testing on other devices,
>     particularly those with SoCs like the RK3328 that use separate bus and
>     signal clocks for their PWM devices. (My ROCK64 uses its PWM-output
>     pins for other purposes and wasn't of help here.)
> 
>     [0] https://www.spinics.net/lists/linux-pwm/msg14611.html
> 
>     --
>     Simon South
>     simon@simonsouth.net <mailto:simon@simonsouth.net>
> 
> 
>     Simon South (7):
>        pwm: rockchip: Enable APB clock during register access while probing
>        pwm: rockchip: rockchip_pwm_probe(): Remove superfluous
>          clk_unprepare()
>        pwm: rockchip: Replace "bus clk" with "PWM clk"
>        pwm: rockchip: Eliminate potential race condition when probing
>        pwm: rockchip: rockchip_pwm_probe(): Remove unneeded goto target
>        pwm: rockchip: Enable PWM clock of probed device only if running
>        pwm: rockchip: Enable clock before calling clk_get_rate()
> 
>       drivers/pwm/pwm-rockchip.c | 64 ++++++++++++++++++++++++--------------
>       1 file changed, 40 insertions(+), 24 deletions(-)
> 
>     -- 
>     2.29.2
> 
> 
>     _______________________________________________
>     Linux-rockchip mailing list
>     Linux-rockchip@lists.infradead.org
>     <mailto:Linux-rockchip@lists.infradead.org>
>     http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 


