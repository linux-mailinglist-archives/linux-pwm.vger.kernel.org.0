Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1234AA870
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Feb 2022 12:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359370AbiBELxR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Feb 2022 06:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358613AbiBELxR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Feb 2022 06:53:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73E7C061353
        for <linux-pwm@vger.kernel.org>; Sat,  5 Feb 2022 03:53:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so5342813wms.3
        for <linux-pwm@vger.kernel.org>; Sat, 05 Feb 2022 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rtVdDv1SeuwFPst+Z3HZwK7VoU9zHizWiVCZ6cJ+BIo=;
        b=cITyTzHhFb0YMzr+7/e0HR4JRCbfeP0KZUPmTysb/4NCGjw33dKpu8L8wjGdrraAy3
         gV0ontgxmFJZX9kz8NpfJuYkSi6dCKmFGv7wOyu0tLnIIAzj1iyKmi12nCzjq6HauMdu
         Mobbeh7Myhso5XnpHy2OQnfrc7DX76yyUQX02j1eDINyAdE8cSsvDhwHPpJ2uKiUgjRo
         VkGC3wQDdc6Vx7VTELanwNrv6LBW+AQIKz8nLyweRXKMiLW3uld6/Vna14X8txEtoDzz
         +yqWSte/QpfEf0iIq7hgR3lplxyZhXVkBYzF3GmJGCfSmPdfrxqMt0FChwfmBf+GDV3u
         XEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rtVdDv1SeuwFPst+Z3HZwK7VoU9zHizWiVCZ6cJ+BIo=;
        b=KjZgI9oMzLrWvC2cwALoCgWBB+VrzB2Q6SIdMvPkhzykyLKqVKTLsgP7jCueJiH3U1
         rLVxbB8KsXPaD6cBXE0Cua1IW9VoHh81czcodGu3rTBErZyG/rgwvHe8RqKZMdsiN964
         paeBIYrRwvR1uQQJN99swrYGkM9mZE1MZT7xo4zrRT4eSIKlrG82WxBR1WyPxs6c7epg
         FqZYDGssQ6ZBBXyfWeGBr+AiVi6KE/Nis+0qAWnVO150VkKxeXJnNT/nDDzyND4BLM7L
         jNDxLVVmssaHJbtldGwsGbfWQFoiWZ7YtTNHbwobI5OpNhCuoJFoJgAm+iIH8qxzBedd
         qlqg==
X-Gm-Message-State: AOAM532QFU3qZ/z3WgbU0FrWDwQOpCjTAY/ZKqOFk+kXIDxVia1NTgUL
        Y4+NnCCBTiCMvP7LIrN6//ICjg==
X-Google-Smtp-Source: ABdhPJxeJTKPg8tXjCf0sXV/a7RsIqYexP/xQzazsuPTUGiHexWKDv2XfFJqtgOghrL+rcR9WPkPWg==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr6209206wmh.38.1644061993045;
        Sat, 05 Feb 2022 03:53:13 -0800 (PST)
Received: from [192.168.2.116] ([109.78.72.167])
        by smtp.gmail.com with ESMTPSA id o2sm12859992wmq.21.2022.02.05.03.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 03:53:12 -0800 (PST)
Message-ID: <81cb8c53-c703-1a44-11cd-9f79e169147d@conchuod.ie>
Date:   Sat, 5 Feb 2022 11:53:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 03/12] dt-bindings: i2c: add bindings for microchip
 mpfs i2c
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Conor.Dooley@microchip.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, jassisinghbrar@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, geert@linux-m68k.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org, krzysztof.kozlowski@canonical.com,
        bin.meng@windriver.com, heiko@sntech.de, Lewis.Hanly@microchip.com,
        Daire.McNamara@microchip.com, Ivan.Griffin@microchip.com,
        atishp@rivosinc.com
References: <20220131114726.973690-1-conor.dooley@microchip.com>
 <20220131114726.973690-4-conor.dooley@microchip.com>
 <CAL_JsqJkFaGmpAi3eEUROWyOr_PQEZ209TneLhsOkpf3w8jQdw@mail.gmail.com>
 <84e1d43f-4d3d-1501-5bc1-c982272e1ce3@microchip.com>
 <Yf2scqKFRFwWBIlC@robh.at.kernel.org>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <Yf2scqKFRFwWBIlC@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 04/02/2022 22:45, Rob Herring wrote:
> On Mon, Jan 31, 2022 at 03:55:32PM +0000, Conor.Dooley@microchip.com wrote:
>> On 31/01/2022 15:39, Rob Herring wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On Mon, Jan 31, 2022 at 5:45 AM <conor.dooley@microchip.com> wrote:
>>>>
>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>
>>>> Add device tree bindings for the i2c controller on
>>>> the Microchip PolarFire SoC.
>>>>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>
>>>
>>> There should not be a blank line here.
>>>
>>> Also, tags should be in chronological order typically. If Daire sent
>>> this patch out with my tag, then the order is correct. If I gave it on
>>> a version you sent, then it goes between Daire's and your S-o-b which
>>> is the case here.
>> Oh, thanks. Probably been messing this up right/left/centre.
>>
>> On another note, I know I'm still missing a RB still on some of the
>> bindings, but what is the acceptance path for this series?
>> Any left over bindings not taken by subsystems via yourself and the dts
>> changes via Palmer's tree?
> 
> They should go via subsystems. I can take if you want, but not with
> missing dependencies. I need my tree working.

I should just drop the dependency on the clock binding from the 
examples, not really much reason to have it there. Still a dep. for the 
device tree itself but would just make it easier for the bindings 
themselves.

Conor.
