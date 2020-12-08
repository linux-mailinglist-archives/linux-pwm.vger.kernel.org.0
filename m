Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79D22D2D6E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 15:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgLHOpf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 09:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHOpe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 09:45:34 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065EC061749;
        Tue,  8 Dec 2020 06:44:54 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id j142so3975890vkj.9;
        Tue, 08 Dec 2020 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IBntS1UR26V0tRM5vYKd+gGG5su3Y6srXHRCMFQ2Zek=;
        b=JKr5mhFau93wkACoY7j4hb6IXyF/m51b+Auzjm7/7wxTB2uW7o9ukKT21fkZ3y9c3b
         dNC84klZSs/mAehx8NgOXeJ8A0XwxAUb0sFnecF1K4lsoRFJ/hcrDIdKQ3sfhzihNpiK
         mK1vs1urN0AAzZ2NcuhTlt66defkBFCJP5jA395neZ7Am5Ey42vYucf8xEdxCi2vopwu
         xC6Cprjr0BiEvX7kf2GnFmJOpikBHkur12mvfKbwtyWAKdGUOXjFMiZM3vCvFgFdRfLI
         Qy9zbTnn/bXnhl4ktBMcOBjNaHTN4LcPw20n3CvNQXVwO1gH6E2ZGzHtCKbNei9zDYUH
         Px6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IBntS1UR26V0tRM5vYKd+gGG5su3Y6srXHRCMFQ2Zek=;
        b=NkCWVEYMz9KCw8VrksreV0CGyndi6qP8MPLPvgbv7+omyfLTd3TR5Xm/wmSm1Wxfxg
         nanZ8TQHPS3y6KZyWiKdCEYsFgrfB20Tafnr9Tlgqg4KMFkNjCKMgxv+P1k0Mi5qlPMY
         ThW48ypJmhAwk1v4WYbvHuT1b1YSzh9neCFnpcbfoEA09ppoQEdzOwC+wHncl8HorM53
         hrRv9ueX3zwnufR6Eq8uMmrDGE442L0MgWq95RtFK89MchpCgo9XrRdl7TLalePeWixl
         /sH86N/Hf1AYb0jAQCAu2mdK89RcYlMbiS/12iE1ymdIsnPCZ2CXJG0joLB34evHjBz9
         DqAw==
X-Gm-Message-State: AOAM531o89NJN4YkXwDGgDDnvVWOhhLv0tm7JW9nffAqO8W/dnyPrT/B
        eVg67IwfO4OPBQs0YXGt5omV+8K7sjV9v5MP6KoBUIaaK0eg3Q==
X-Google-Smtp-Source: ABdhPJwm1iw0/CdG0TZqhQabg4tUL0iiYeyghigIqHBbcqSFMpn+YoRi3JJjEYzVrxDMPPQxE/RgVsTJQQIV+slZrgU=
X-Received: by 2002:a05:6122:69c:: with SMTP id n28mr16138230vkq.21.1607438693346;
 Tue, 08 Dec 2020 06:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de> <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de> <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
In-Reply-To: <X8+DI7ZN7mXtsxv9@ulmo>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 8 Dec 2020 09:44:42 -0500
Message-ID: <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Uwe, Thierry,

On Tue, Dec 8, 2020 at 4:10 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> If this is already in the old code, this probably warrants a separate
> fix, and yes, I consider this a severe bug. (Consider one channel
> driving a motor and reconfiguring an LED modifies the motor's speed.)
>

I think you are 100% correct, this would be a severe bug. I have only used
this chip to drive LEDs, where the actual period is not that important. But
for motor control, it's a different story.

Basically you are suggesting: the period (prescaler) can only be changed if=
f
its use-count is 1.

This however brings up a whole load of additional questions: consider the c=
ase
where the chip outputs are also used in gpio mode. the gpio functionality
only sets "full on" and "full off" bits. On a scope, a gpio output will loo=
k
identical, no matter the value of the period. So when a gpio output is in u=
se,
does it increment the prescaler use-count ?

Example:
1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1/200=
Hz)
2. output 2: set led mode (full-on bit set)
3. output 1: change period(enabled=3Dtrue, duty_cycle=3D50%, period=3D1/100=
Hz)

Do we have to make (3) fail? I would say no: although output 2 is in use,
it's not actually using the prescaler. Changing prescale won't modify
output 2 in any way.

Which brings us to an even trickier question: what happens if a pwm output
is set to 0% or 100% duty cycle? In that case, it'll behave like a gpio out=
put.
So when it's enabled, it does not use the prescaler.
But! what happens if we now set that output to a different duty cycle?

Example:
1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  period=3D1/20=
0Hz)
2. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, period=3D1/40=
0Hz)
  fail? no, because it's not actually using the period (it's full on)
3. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, period=3D1/20=
0Hz)
  fail? no, because it's not actually using the period (it's full on)
4. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  period=3D1/40=
0Hz)
  fail? no, because only output 1 is using the prescaler
5. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1/400=
Hz)
  fail? no, because output 2 is not changing the prescaler
6. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, period=3D1/200=
Hz)
  fail? yes, because output 2 is changing prescaler and it's already in use

IMHO all this can get very complicated and tricky.

We can of course make this much simpler by assumung that gpio or on/off pwm=
s
are actually using the prescaler. But then we'd be limiting this chip's
functionality.
