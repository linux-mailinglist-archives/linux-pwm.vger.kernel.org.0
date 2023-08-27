Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208DD789BEF
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Aug 2023 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjH0HyE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 27 Aug 2023 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjH0Hxx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 27 Aug 2023 03:53:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCEF100;
        Sun, 27 Aug 2023 00:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DAED60BA3;
        Sun, 27 Aug 2023 07:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8482C433C7;
        Sun, 27 Aug 2023 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122829;
        bh=ELQCtO1Zd3q5C9Y0nTZAqeXcZ3jFC9IKfb9OyAxP4/I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vDB0+XOMKs5lgDU2WQkzNwza4ImSxI7Wqzf1NwN/0CbHPkkF70JNZwvgsZlCXs2d1
         djwRZ0P36rMenREaIJErIokoDTb8+p92QpowOZyzp9g2xQr5mDiMrQvSZtGNmplHzt
         KEv/o3qzHboUzmyMdDeMlwttsfec/6GiMvfPs+2J3bCO0bkHeTh14NCh2nER6cyZ5M
         +gKibB04hl655+utWGLo+R+2l1Yx2orlsdfcK7bW0mQt72yDwVlUnrcdJQFiqhvTTb
         7A/yjSrCn6C1uNSeaXXMeZwbZiXGiNnFid9HhqNg/YIdGjWWxuKrfZhnEyVf/Y2lZU
         GuyHGsZRSD41w==
Message-ID: <0ec82a6f-3689-3695-3f47-df55cd8b6429@kernel.org>
Date:   Sun, 27 Aug 2023 09:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/2] dt-bindings: media: remove nokia,n900-ir as
 pwm-ir-tx is compatible
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>
References: <20230826171711.366710-1-sean@mess.org>
 <2b81baae-cd50-e46f-f560-33b3d186cb24@kernel.org>
 <ZOpi5fpDIoJOLnN9@gofer.mess.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZOpi5fpDIoJOLnN9@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 26/08/2023 22:39, Sean Young wrote:
> On Sat, Aug 26, 2023 at 09:54:04PM +0200, Krzysztof Kozlowski wrote:
>> On 26/08/2023 19:17, Sean Young wrote:
>>> The generic pwm-ir-tx driver works for the Nokia n900, so nokia,n900-ir
>>> can be removed.
>>>
>>> Signed-off-by: Sean Young <sean@mess.org>
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC. It might happen, that command when run on an older
>> kernel, gives you outdated entries. Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> You missed at least devicetree list (maybe more), so this won't be
>> tested by automated tooling. Performing review on untested code might be
>> a waste of time.
> 
> You are right, I -- again -- messed up. The Cc: list for 1/2 and 2/2 got
> mixed up.
> 
> I am sorry about this, it's getting embarrassing now.
> 
> Is there any tooling which does this automagically? I'm copying and
> pasting the output of scripts/get_maintainers.pl into shell scripts,
> which is very error-prone (as evidenced by today's mistake).

I am using this:
https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91

Other option, sending each patch to separate recipients, is:
[sendemail.linux]
	tocmd ="scripts/get_maintainer.pl --no-git --no-git-fallback --no-l
--no-roles --no-rolestats"
	cccmd ="scripts/get_maintainer.pl --no-git --no-git-fallback --no-m
--no-roles --no-rolestats"
	confirm = always

and then git send-email --identity=....

Best regards,
Krzysztof

