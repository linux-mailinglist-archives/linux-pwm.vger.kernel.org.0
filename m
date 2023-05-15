Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63007703868
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 19:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbjEORcU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbjEORbw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 13:31:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D631434F;
        Mon, 15 May 2023 10:28:52 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7327186065;
        Mon, 15 May 2023 19:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684171730;
        bh=crCwT4TX1zO2PVvZj3xRRhcty3U4InjeDBsKxGQdQK4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hofG9PPw5u0+sUKvb8qr6FJwBANMtENxnU9ooEEsqoNDGBic9nJzv+Wkp7agwczJP
         2SVjwIp7k908I57wfF9RlvBmQ53uajjlSZfw56l2+MFpt42z1dTkfIOTTOhWZjJDSi
         VtXxXdh+7hTg/q09vfmgixSjMlLvkyleidFFEra2/xomTjuKIYW4Hnzo6SMUWSRL8Y
         AziuRrmUvYBg3IjWbhLxhILAT2AFlLJFiewVhEPTt8aZf3kx6hz4dwCEwPr2rPZIm3
         HxRnTFuM2WnOT5cD2D4JCOSEbLwkhg4uwRSQTWEwh69AuL+kwshUmliKo6fGYK6LD2
         JwvYP4W/xSYyA==
Message-ID: <d77e8c22-27af-b0c3-df76-59adb6a2d678@denx.de>
Date:   Mon, 15 May 2023 19:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: AW: AW: [PATCH] Input: pwm-beeper - Support volume setting via
 sysfs
Content-Language: en-US
To:     Traut Manuel LCPF-CH <Manuel.Traut@mt.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20230512185551.183049-1-marex@denx.de>
 <AS8PR03MB76211DFFD1261B00E55FF50BFA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
 <a5293af4-8d02-ed8f-52d1-722c71d47f37@denx.de>
 <AS8PR03MB76216EADE882B038464E9E76FA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <AS8PR03MB76216EADE882B038464E9E76FA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
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

On 5/15/23 17:24, Traut Manuel LCPF-CH wrote:
> Hi Marek,

Hi,

>>> I tend to not change existing user-space interfaces. I would prefer to have an additional event or using sysfs.
>> I am increasingly concerned about the race condition between change of volume (via sysfs) and frequency (via SND_TONE) . So I would be banking toward additional event, like SND_TONE_WITH_VOLUME or something along those lines.
> 
> SND_TONE_WITH_VOLUME is also ok from my side. But implementing some locking shall also be possible.
> 
>>>> NOTE: This uses approach similar to [1], except it is much simpler.
>>>>        [1]
>>>> https://patchwork.kernel.org/project/linux-input/cover/20230201152128
>>>> .614439-1-manuel.traut@mt.com/
>>>
>>> This one is more complex, because the mapping between duty cycle and volume is not linear. Probably it depends also on the used beeper hardware which values are doing a significant change in volume. Therefore the patchset introduced a mapping between volume levels and duty cycle times in the device-tree to allow user-space applications to control the beeper volume hardware independently.
> 
>> I wonder whether this mapping shouldn't be considered policy and left to userspace to deal with, instead of swamping the kernel or DT with it ?
> How could a Linux distribution detect which mapping is required to be installed?
> For me it seems to be easier to have the device-specific information in the device-tree.

The alternative might be to have volume in 0..65535 range (i.e. the top 
16 MSbits) and be done with it, then the PWM subsystem is responsible 
for mapping this to 0..50% of PWM duty cycle .
