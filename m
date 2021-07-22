Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7037C3D1B55
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 03:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhGVAcQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Jul 2021 20:32:16 -0400
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:47874 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhGVAcP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Jul 2021 20:32:15 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2021 20:32:15 EDT
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 4C6F620F4F;
        Thu, 22 Jul 2021 01:03:50 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 3FCA020100;
        Thu, 22 Jul 2021 01:03:47 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 9B2513F1CC;
        Thu, 22 Jul 2021 03:03:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id DB91B2A0C8;
        Wed, 21 Jul 2021 21:03:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1626915822;
        bh=yDd2oKbRqrkbem8gSLtEdP0ZNN5cwHjZF/28VLiVO1c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LP4z8i74x9ARwf819TDIJpJHMFyM0kvG55HQI5uVR6q9LcPp6UqxYH82zLxqn0B6E
         ItOP341JR915D4jr9YcCSMHrFDl4TfB4DkCvH+BCUg+8DxVk97vucv7ydwQmlK/KTC
         fJwTd/VdUDYSw7oi604DxPFUnRIrgJYbT9Amxp/g=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jHCk167GoQY0; Wed, 21 Jul 2021 21:03:42 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 21 Jul 2021 21:03:41 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 560CD40CD0;
        Thu, 22 Jul 2021 01:03:40 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="vhOhl0fc";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [192.168.0.49] (unknown [14.154.30.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3D19640CD0;
        Thu, 22 Jul 2021 01:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1626915809; bh=yDd2oKbRqrkbem8gSLtEdP0ZNN5cwHjZF/28VLiVO1c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vhOhl0fckjsIGH1fYlKrhjgywXlH1bqwZz1xhQrlfvzyvMsfWEZ99FdPuk2qQIZ95
         2jyvCtefM1DfNXbXnCStBZaNalvIaZ+MekKRq9I6YhBCAOeU+CXNKaZUeOGAYgwX2o
         m1crbdVRm0S4qnZC7QG4vzxpYnQRRprxIbgdxNaw=
Message-ID: <0a9bda1e91246c7e473fcbb833ac94159d13b084.camel@aosc.io>
Subject: Re: [PATCH v3 0/6] PWM support for allwinner sun8i R40/T3/V40 SOCs.
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Hao Zhang <hao5781286@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mturquette@baylibre.com, sboyd@kernel.org, thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
Date:   Thu, 22 Jul 2021 09:03:18 +0800
In-Reply-To: <20181125161534.GA4481@arx-s1>
References: <20181125161534.GA4481@arx-s1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 560CD40CD0
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         RECEIVED_SPAMHAUS_PBL(0.00)[14.154.30.9:received];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[14];
         FREEMAIL_TO(0.00)[gmail.com,kernel.org,arm.com,bootlin.com,csie.org,baylibre.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hao,

Would you mind me to continue on this work? Newer Allwinner SoCs have
PWM controllers similar to the R40 one.

Yours sincerely,
Icenowy Zheng


在 2018-11-26星期一的 00:18 +0800，Hao Zhang写道：
> PWM support for allwinner sun8i R40/T3/V40 SOCs.
> 
> The sun8i R40/T3/V40 PWM has 8 PWM channals and divides to 4 PWM
> pairs,
> each PWM pair built-in 1 clock module, 2 timer logic module and 1
> programmable dead-time generator, it also support waveform capture.
> It has 2 clock sources OSC24M and APB1, it is different with the
> sun4i-pwm driver, Therefore add a new driver for it.
> 
> Some test method:
> cd /sys/class/pwm/pwmchip0
> echo 0 > export
> cd pwm0
> echo 1000 > period
> echo 500 > duty_cycle
> echo 1 > enable
> then check the PB2 pin with oscilloscope.
> 
> v3 Changes:
> 1. fix coding format.
> 2. use 2/ilog2 instead of divide table
> 3. remove spinlock.
> 4. remove sun8i_pwm_data structure and use DT to parse pwm-channals  
> 5. remove inline because complier knows it better.
> 6. don't hardcode clock source and parse two clock source from dt
> "mux-0"
>    and "mux-1"
> 7. remove bypass method.
> 8. add a method to change clock source when mux-0 is not support the
>    input period it can change to mux-1.
> 9. add cycle range check.
> 10. add some variable to make it more readability.
> 11. add clk_disable_unprepare when some false accur.
> 
> v2 Changes:
> 1. change sun8i-r40 symbol to sun8i.
> 2. change pwm0_pin, pwm0-pin to pwm_ch0_pin, pwm-ch0-pin.
> 3. remove clk_disable_unprepare(), check !match and IS_ERR(pwm-
> >regmap).
> 
> Hao Zhang (6):
>   Documentation: ARM: sunxi: pwm: add Allwinner sun8i.
>   ARM: dtsi: add pwm node for sun8i R40.
>   ARM: dts: add PWM for Bananapi M2 Ultrar board.
>   DEV: CLK: add function to check the using clock name of driver.
>   DEV: CLK: sunxi ccu: export clk_apb1 for sun8i-r40 soc pwm.
>   ARM: PWM: add allwinner sun8i R40/T3/V40 PWM support.
> 
>  .../devicetree/bindings/pwm/pwm-sun8i.txt          |  24 ++
>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
>  arch/arm/boot/dts/sun8i-r40.dtsi                   |  17 +
>  drivers/clk/clk.c                                  |   6 +
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h               |   4 +-
>  drivers/pwm/Kconfig                                |  12 +-
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-sun8i.c                            | 418
> +++++++++++++++++++++
>  include/dt-bindings/clock/sun8i-r40-ccu.h          |   2 +
>  include/linux/clk-provider.h                       |   1 +
>  10 files changed, 489 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-
> sun8i.txt
>  create mode 100644 drivers/pwm/pwm-sun8i.c
> 

