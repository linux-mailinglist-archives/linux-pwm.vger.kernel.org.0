Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18226516D25
	for <lists+linux-pwm@lfdr.de>; Mon,  2 May 2022 11:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbiEBJSZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 May 2022 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiEBJSY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 May 2022 05:18:24 -0400
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F4369F3;
        Mon,  2 May 2022 02:14:55 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id A1198440E71;
        Mon,  2 May 2022 12:14:01 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1651482841;
        bh=IHzfFhChYt8SgTD+q8xq4d8FxaC2AUqpiPUeC1tATXc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=hgcBQoNEkkWdqCFN9vcySUZyrHu8z5Q24vTijDOJwEaBb63y9MmoHWd+2F048kwN7
         fvgqqRS4lnZVaBZQKvDy+R6LPhi0WkGJrY73ZeWQGZKUKbka87/fkbw3NR7xtZ+JM6
         TxzcQkPdzTrnHIKQf2+L9nzirhK/QiKU5rY+IlYEZnLhA3cgKkDNNHt0G/hq+0TNBV
         65iXtY9hAID8ieIFHUoOyHhabnLtrLA9o+sxPQKSwLtXIM6duQALLSV2VV/MPyFyod
         O8rM7DUP/vHvuasVvv+NM8jfzZc6wG4qwJP4Hjwe38CetWRpQmlT++ZyuyABvoEJrt
         Y1zZMTF+BzWIg==
References: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
 <CAMRc=Mei_ZWPzSMHpC1Ao8nU487_SUq7qQGEDkxwdRb0jmx7cQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: mvebu: drop pwm base assignment
Date:   Mon, 02 May 2022 12:10:57 +0300
In-reply-to: <CAMRc=Mei_ZWPzSMHpC1Ao8nU487_SUq7qQGEDkxwdRb0jmx7cQ@mail.gmail.com>
Message-ID: <87ee1cxpmb.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bartosz,

On Mon, May 02 2022, Bartosz Golaszewski wrote:
> On Mon, Apr 11, 2022 at 8:25 AM Baruch Siach <baruch@tkos.co.il> wrote:
>>
>> pwmchip_add() unconditionally assigns the base ID dynamically. Commit
>> f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
>> dropped all base assignment from drivers under drivers/pwm/. It missed
>> this driver. Fix that.
>>
>> Fixes: f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

[...]

> Queued for fixes, thanks!

Thanks. I see it's in your tree (brgl/linux). Is that the main GPIO
development tree now? The MAINTAINERS entry for GPIO SUBSYSTEM currently
lists linusw/linux-gpio.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
