Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE17D9BCEC
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfHXKFQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 06:05:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:44611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbfHXKFQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 06:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566641101;
        bh=lvvUBllP8YjpHl+AwkJh9GpCJPewvvJkQ1av/DtIVuM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LLOyWhBSXVnNzlToQthw2cdQoHkMHQ3lMhRz4ddq338z1OVJYqljRKGyDuED/ljWF
         +P5ay1rnqhdvMtXRWEkCnI7f1iABww/c4lDyCAzY/aZZHn0Lbs1j0D2pPgwTNGthmY
         jNQQqRK5E7SxT+yTKMUTVVIwSdIVhu/AGoRsAEQ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1hi3AE2sB9-00XpQC; Sat, 24
 Aug 2019 12:05:01 +0200
Subject: Re: [PATCH 0/3] pwm: bcm2835: Minor fixes
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
 <20190824092553.j4rjpzaz4m6yaa5t@pengutronix.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <22f8e65b-2d65-84e7-de50-ba6538a84292@gmx.net>
Date:   Sat, 24 Aug 2019 12:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824092553.j4rjpzaz4m6yaa5t@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:4z62qMWLlNaolZbmt76kTmFWj0dZ5pHrSNRqCtqV0bLWAZx7AUb
 wmcRK4vk9wcnfxFGRrmVczcEZm+XatA482G9gT8sYKJtKCqZYmgMX6MqFrWuDrvFFN+5LZH
 XnmimvEFUsGMO8Ufu3JndIkp+xb7drDHcouRdOONiscbOPAKXajvZvLPln+sgyUlhWbGF23
 W+6SerMknpI0eyK7VXQXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nK48pk74P7g=:xyYbUEc0YrFPZ2syY5/12Q
 Sv0mc8zxnNYoxGZkWFj+mBtEXVFr21pl5Qg8hvSc9wQFUHZhVn+hDrY9MR1RJZ4rU70U1IKTa
 C02VVRN6snKt8g5W5Uzeu0nihKLNtnASkUJ3k5oDsZh4QbLPmUJXaaxOJuK5XPP6l6a0p0BEC
 yhVVCAbn2xOiHnAFLVTi15ChDg+bkM78o1Si6KHdszsKbyaCZxX04gT0zTZeqk55kVkbzdIDp
 fqtFc533tFAP0DY1dqT/l4rN4NLBv+Si754x8GlsYEFGbYAvXnYq2Wv+ShkHxJkfAqYkRIwLM
 MgeTXFp/PHP8IYYunXQx0eKoxoSqEbUoPBlq6tpZlKzoqdfMIm20K8G1K8J7dcmSc6IcUvVaZ
 8Avxu0aNrfDrAMcn+2xHpFeNDXkYbVLQNt5jkEN6JuNwf8XvNamxibNHAZy5u48hCTI75CEzh
 GlLq6jVh4gRGkyJPF71nMCn1Uc2lDhP/6wev51wcjUE2/CauNh0uiRfFHxYsXhlSuTqrGEIiP
 78TnDWah/RGCrnfgf03xxch6zphkQ0XYFYUttL9DvKfNsq/hzas0MuHpZYjyN9o7PWWYwQnZm
 4597Y/yFXuHTmdudluQGKHYhd9GaErprEijVJWimTy1IBzhP6jKClE3htGxhh9HRzkBVLqlgW
 mLVQEKarlFc3G/ou/9Uew2YdV7OmiLHJSfWOa15o9efbV9VdlTSm7RcUcW+SK9Lk85HiDkgI9
 i34+8hENk3eRs5KLFo21pnxkEzWnK8FKhoXas0TjJtPllo8ImIpeGTqeqcMonEL8Oos/nU9xT
 ettSOA2EOFCGiY3aXEfrprRSK0s9geAxWzoXP5tCRXA251iwri00qlPSE/p5LImJefWMO9D1V
 ebnutOQrU2+BwAnXNDufaNgYSdaeP+U3eZ1EgowqbRqDftDXJAs+ZevQzmNq3FSx86lRCtAWC
 0A1wg5M80L84hTSncGF92NbZCRg9Eujlp7A+tKWIz49yeME861mazq2mRd85rFRSTIZjkawDV
 3tQc+XuLVe9qSMrONfqZxv68YebuhY+fDd07HqZO+H7OqEc0QLrKpFjGlKkYV8E4n5rrVvfer
 2I0B0J3sqfY1NxTfUtgOzebtCKLNox1m7s+k0ZP0RKldXNmHuOSLbZvmZHF8gzSEeAGNuUoI8
 u3vWg=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Am 24.08.19 um 11:25 schrieb Uwe Kleine-K=C3=B6nig:
> Hello Stefan,
>
> On Sat, Aug 24, 2019 at 09:07:22AM +0200, Stefan Wahren wrote:
>> This small patch series contains minor fixes for clock handling and the
>> period range check.
> I'd like to understand the various different usecases of PWMs. The
> in-kernel consumers are kind of obvious, but sysfs users are not. It
> seems you are one of the latter.
>
> Would you mind sharing what you control using the PWM?
not really a PWM user with BCM2835. It's more the motivation as a
platform maintainer to keep the drivers in shape. At work we are using
sysfs interface for user applications to control ventilation (via hwmon
interface) and EV charging (IEC 61851) with a different SoC.
>  Does it bother
> you that the sysfs interface doesn't allow atomic configuration?
To be honest not really, but i think a lot of user could benefit and
might stop using hacky Python scripts which manipulate the registers
directly.
>
> Assuming you have some interest in this driver: It still uses the legacy
> stuff implementing .config, .enable, .disable, .set_polarity. Are you
> willing to test (or even implement) a switch to .apply instead?
Yes, definitely. This is one of my never ending TODO list [1]. But i
would be suprised that you wont have access to a Raspberry Pi.
>
> Just from a quick lock into the driver I wonder a few things, maybe you
> can shed some light here. If there is publicly available documenation
> for this piece of hardware, feel free to point this out, then I might be
> able to work out some of the answers myself.
Fortunately yes [2]
>
> The overall (and common) design of the PWM is an input clk, a counter, a
> duty and a period register.
>
> The slightly simplified logic in .config is:
>
> 	scaler =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
> 	writel(DIV_ROUND_CLOSEST(duty_ns, scaler), PWM_DUTY);
> 	writel(DIV_ROUND_CLOSEST(period_ns, scaler), PWM_PERIOD);
>
> This is loosing precision while the calculation could be cheaper (in CPU
> cycles) and more exact when using:
>
> 	writel(DIV_ROUND_CLOSEST(duty_ns * rate, NSEC_PER_SEC), PWM_DUTY);
> 	writel(DIV_ROUND_CLOSEST(period_ns * rate, NSEC_PER_SEC), PWM_PERIOD);
>
> This is only two divisions instead of three. And assuming a rate of 9.2
> MHz and a request of duty_ns =3D 499945, period_ns =3D 999891 the origin=
al
> calculation yields
>
> 	DUTY =3D 4587
> 	PERIOD =3D 9173
>
> 	real_duty_ns =3D 498586.95652173914
> 	real_period_ns =3D 997065.2173913043
>
> 	error_duty_ns =3D 1358.0434782608645
> 	error_period_ns =3D 2825.7826086956775
>
> With my suggestion you'd get
>
> 	DUTY =3D 4599
> 	PERIOD =3D 9199
>
> 	real_duty_ns =3D 499891.3043478261
> 	real_period_ns =3D 999891.304347826
>
> 	error_duty_ns =3D 53.69565217389027
> 	error_period_ns =3D -0.30434782605152577
>
> (But having said this, I'd prefer to use rounding down instead of
> rounding closest).
>
> Also I wonder if reprogramming the hardware completes the currently
> running period and how the hardware behaves on disable. (In the latter
> case I'm interested in "Does it complete the running period?" and "Which
> state does the output stop in?")

I need to make logic analyzer traces to make any statement.

Thanks

[1] - https://github.com/lategoodbye/rpi-zero/issues/16

[2] -
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pd=
f

>
> Best regards
> Uwe
>
