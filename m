Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A997B703DD7
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbjEOTvA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjEOTvA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 15:51:00 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D66AD2C
        for <linux-pwm@vger.kernel.org>; Mon, 15 May 2023 12:50:57 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id ADD7A846AF;
        Mon, 15 May 2023 21:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684180256;
        bh=K5ErJnLY2c0J9VZXTW2Q+MsS4G1mrdx4FyjTZI2r9u0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mzUo3FoNCHv2/jn4mj6XArziLohBqsS7nJqdbuD2CM3/PXsPGmev7z2TAzaRa1Bnm
         kX9YDcRmzOE180UR55VZuo2a+var/YN1aBVyLkN2cBbJyKtGN9aPZNxkTbwO9GgqAy
         XGWCJye+X8ZWBEQWtvcyRfXejHu9XbPoWMPCBQ0Z76xln9BgxxXt7Y4jibxCj6hr6w
         E0xTdUZdPUWc+Z9SNrGSI3mklSV+JRbpxBfS/zJW2ya9onQxG2kOFdCofEUEW9OeLk
         2htfhucQJ4ji72mEESnFsX7mPVlE+IvCEGSaqSKv0ThkgAVbRaV8MYoJFH27H4qqoq
         1e/E4OIE4bWqA==
Message-ID: <26f920ec-6cd0-6d83-2a14-f727e789bcfd@denx.de>
Date:   Mon, 15 May 2023 21:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pwm: sysfs: Do not apply state to already disabled PWMs
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-pwm@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230512164736.53615-1-marex@denx.de>
 <ZGJ5X5UG6+TyqPpl@google.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ZGJ5X5UG6+TyqPpl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/15/23 20:26, Brian Norris wrote:
> Hi,

Hi,

> On Fri, May 12, 2023 at 06:47:36PM +0200, Marek Vasut wrote:
>> If the PWM is exported but not enabled, do not call pwm_class_apply_state().
>> First of all, in this case, period may still be unconfigured and this would
>> make pwm_class_apply_state() return -EINVAL, and then suspend would fail.
>> Second, it makes little sense to apply state onto PWM that is not enabled
>> before suspend.
>>
>> Failing case:
>> "
>> $ echo 1 > /sys/class/pwm/pwmchip4/export
>> $ echo mem > /sys/power/state
>> ...
>> pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 returns -22
>> pwm pwmchip4: PM: failed to suspend: error -22
>> PM: Some devices failed to suspend, or early wake event detected
>> "
>>
>> Working case:
>> "
>> $ echo 1 > /sys/class/pwm/pwmchip4/export
>> $ echo 100 > /sys/class/pwm/pwmchip4/pwm1/period
>> $ echo 10 > /sys/class/pwm/pwmchip4/pwm1/duty_cycle
>> $ echo mem > /sys/power/state
>> ...
>> "
>>
>> Do not call pwm_class_apply_state() in case the PWM is disabled
>> to fix this issue.
>>
>> Fixes: 7fd4edc57bbae ("pwm: sysfs: Add suspend/resume support")
> 
> My first thought was that this still belongs as:
> 
> Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")
> 
> but then I realized sysfs suspend/resume support was added *after* that,
> so indeed, your Fixes tag makes the most sense.
> 
> And yes, I think this solution (addressing sysfs.c directly) is best
> too:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> Side question: I wonder if this belongs in linux-stable. It's definitely
> a bug fix, but the bug has been around a while, with a
> {under,non}-specified ABI, and it's easy enough to work around I
> suppose. But inevitably, *any* patch with a Fixes tag gets picked up by
> somebody's cherry-picking bot, so maybe it doesn't matter...
> ...Anyway, I guess I'm saying it's probably going to go to linux-stable,
> whether we want it to or not; and maybe that's OK :)

To provide a bit more context. This was discovered a person writing 
userspace application who couldn't suspend the machine because of this, 
but they also couldn't find out why. So I think this is good candidate 
for stable as it makes this edge a little less sharp.

I agree it can be worked around and I told them how to update the user 
application, but still, this was inobvious and obscure.
