Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F8243ABBF
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 07:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhJZFmf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Oct 2021 01:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbhJZFme (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Oct 2021 01:42:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C0DC061348
        for <linux-pwm@vger.kernel.org>; Mon, 25 Oct 2021 22:40:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g8so8241173edb.2
        for <linux-pwm@vger.kernel.org>; Mon, 25 Oct 2021 22:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MkqVgBcrznf4Pr0wJGssB9gSBJuewofuwrw0+z+Rgbo=;
        b=L86uXANiQs7rb80p4BM7qa/8MvgO83mpHo/AmglG2hk6snqbvcQHLUcbJR/+STATyW
         uHa7tmbl/cu9aVZUtW6NMMKn3CFsLlVI7rwxtRqXp/cpXvlKAoqyglBylYGQQp4YfyYS
         33kabitBA/k58C4rCnX6LXLRp3f/AXzj51lkdvcYDtOmcz5zyvUqbgsp/Ti3DjFhXu2C
         I34p58uBToMqX5gFZVOF9ilN0tu2uEWxLvujS1LzyfUPChyB6EPk15y+dpIa7LXc9tDs
         5LeOC9XsOcS6lOrfORwxI7a/i1Dujq3eYwg7RBD2RUFnYjslOMGCLzCjbZ1t9L4g/DtU
         +pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MkqVgBcrznf4Pr0wJGssB9gSBJuewofuwrw0+z+Rgbo=;
        b=cl38VSKzpedUQ9aVifEOjvbNnf+FAOYDJLwTGztTUXwPJ3CT1cr65j65W6jy95cIor
         B80t+gxxXujsuP0e67M6/vBKFvhko7iLrKPoCOBWcwYqQse1rNFnIs7qm3XoJq0HhyUD
         euRbEvXf1Qrtodt0BppvcPcd9GRHEGS2eXEZfH+ADCzIKRGBRYJ+E1ekXpqDymdNjWsA
         tT/pQyRMG6ObsKxlw+LQfvQJM21vLIPtR5I/p/DeztYLSJjYqdS7J7KvRpBmbemq2qsb
         2rkJvYVnifDfvvL7ot5bh77HqP7+n5YIQ7CsJt2Ung2JTsZqN0aO41123PplH/874e1U
         n3mg==
X-Gm-Message-State: AOAM532iFJXu6KmMmXfsX/UnwrNNj2ltp17DE3JvKyjbBZkuKPX1YbQj
        +GqfhgtE0+hdt2gNk4CwKzm6Wg==
X-Google-Smtp-Source: ABdhPJwJ0wbVltsIGqTo/dNxhZtNWyRuXPvW7RdxFUOxPp/9rwIaJDKfrrSXigGTdiJ0F05h78/tog==
X-Received: by 2002:aa7:d5c2:: with SMTP id d2mr2138476eds.56.1635226807724;
        Mon, 25 Oct 2021 22:40:07 -0700 (PDT)
Received: from ?IPV6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id m3sm2616810edc.36.2021.10.25.22.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 22:40:07 -0700 (PDT)
Message-ID: <3270b8b7-ed9a-b505-52e0-319ad655a3ab@monstr.eu>
Date:   Tue, 26 Oct 2021 07:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v9 1/3] microblaze: timer: Remove unused properties
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh@kernel.org>
References: <20211025180605.252476-1-sean.anderson@seco.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20211025180605.252476-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10/25/21 20:06, Sean Anderson wrote:
> This removes properties not used by either the PWM or timer drivers.
> This lets us set additionalProperties: false.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> (no changes since v8)
> 
> Changes in v8:
> - Remove additional properties from microblaze device tree
> 
>   arch/microblaze/boot/dts/system.dts | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/microblaze/boot/dts/system.dts b/arch/microblaze/boot/dts/system.dts
> index b7ee1056779e..22252451ec09 100644
> --- a/arch/microblaze/boot/dts/system.dts
> +++ b/arch/microblaze/boot/dts/system.dts
> @@ -347,12 +347,7 @@ xps_timer_1: timer@83c00000 {
>   			interrupts = < 3 2 >;
>   			reg = < 0x83c00000 0x10000 >;
>   			xlnx,count-width = <0x20>;
> -			xlnx,family = "virtex5";
> -			xlnx,gen0-assert = <0x1>;
> -			xlnx,gen1-assert = <0x1>;
>   			xlnx,one-timer-only = <0x0>;
> -			xlnx,trig0-assert = <0x1>;
> -			xlnx,trig1-assert = <0x1>;
>   		} ;
>   	} ;
>   }  ;
> 

Only this one patch applied to microblaze/next. The rest should go via 
pwm tree.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

