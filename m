Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E117324C7
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2019 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFBUjE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Jun 2019 16:39:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:48159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfFBUjE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 2 Jun 2019 16:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559507918;
        bh=Q+Zt9ln5iZCO1/TfDlIC1bVEulm4W33SVa1zU1MY8is=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IzRTQePMfVDv9en5jyG6PJ9Ws5yqWKLjtz3YDubVAqYW0Kx620kw/x1Mb/tZcSSeg
         0Iul1Wr/kbdpvTFoAY/LlqQmfYfWSN1HwdMs9TsQwtVUhaVL86StTW6PJGeaclE+AL
         8xR9gXmAJVySqhEl2Bi/kdjFxMTPaDFN+zQKjebM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1hGYKS2rhK-00IFi0; Sun, 02
 Jun 2019 22:38:38 +0200
Subject: Re: [PATCH] pwm: bcm2835: increase precision of pwm
To:     Sean Young <sean@mess.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas Christ <andreas@christ-faesch.ch>
References: <20190602102350.zzwmfvlky3mnlqln@gofer.mess.org>
 <0e6eef35-244a-4d52-2d87-e8ff22355f09@gmx.net>
 <20190602200318.ymyewngns745m2vx@gofer.mess.org>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <83f18bc9-a0d9-8ed9-ea4f-29072358b224@gmx.net>
Date:   Sun, 2 Jun 2019 22:38:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602200318.ymyewngns745m2vx@gofer.mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:+PG278H9E/NcBtz0FZXqSx9eLx0phN/rHEE5iByBc5YojdnMLoR
 afvLqWiUtZxjxDmbYFu5imufH+Bkg/uqoQyjeDZYoNBdWcJJu1QbbmSbUH7z1/EGtcA7dSf
 MJcHtTEJBYXPHdd+pfc1XQ+8ODSKd/kPNvxRsYoL1d1HLlWzedvXXvcr4plTnKizRwTsxbS
 +0dsD0zUJ9x/LFv0qj3uQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BfIw+xURT1I=:r23lx/rIciI//Q2g5icrPD
 VIe2LYQnz4s2dolbiyINLF9Riv+IdAqn/LT/nTSt4EwEd3FQpvri+cXMkEWPUBaKy39269evL
 nOm3QHMI3m/pd8qG7JoPjjQBORbslvfPWzCadTMwYrib76YMq/w9W/BtOKofrjnW+eGSRAXG5
 HeV/08lmMEAj013doWx5J0nA33Dza0KSWzg4K3YYQOVXdcsiCl4NopZnHkup7n7p0kQ8F5Q3x
 XH1EE9a1A+fRRcG+WZiG+L4xTN+zU6kv577Rk+8KzpbybdShAEjDShq7vEwxisJBfCpk4hG8m
 YW/oJMHi+e6K+b2zOLu0nNxZwDzkf5YMsLMkHEGGoaTS4nsJVrn9KXOBdRoHAWharTjyfnLKB
 h+T8Ora0C2NPPvlNBfaVMs4e5yEAcyKdv+NtDWnlOgFTVik2Uuttlde7QtXYkfC7EWNu4UxAQ
 0iiEJezpvwHU7WqsgK8WrQXL3BYI+IfCqOJQxbbKvL8AvN1FViBWM01QBbHe99eYfMy2m5L4Q
 693vWnU+x5tJeTLN2XRU3dGSFHARzgV4SDqEVbRPm4UJqqdRALyezk+aViIOTRQGIvo/FseSA
 y6hfYY7JjHkwG1lmWD0P4dPVdMF7+M6VKWjKGw0B5CL/DSo2NQUsU4s0hL9CgX8rzFqwNsmxg
 ryyQh/FGrPAk+/UiuwRSEXGkwsOt0elipX4Cyl+ygBbqiK19ZZuDhJ/dN+ivLAFJdkh3CtIYt
 0Ytc7vHDY6OtyuEfTMilQAFpncvIzF+qMRDp+CZMKNGzqADOh7J2fDygMf+ABCMpuqF3qOKHy
 dQ380XE+UX2Csx3Hb/94x3fPH3Ze+AsiJQMuKmdDxH7cxOPfNW+rlj5Pr/YSV7/H316zbW8ye
 A3dNZTLUWKq2O6J1ABY4ORZu6ApwgNRE4cta+tWuLotOmr0KGet19CaI0QhzNpk1+zdtzuAaB
 qltj+LXFzF7ptluUOAhjIHAt8lsdtlZNhe8JH+TNDMGSIs4RlPte3
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sean,

Am 02.06.19 um 22:03 schrieb Sean Young:
> Hi Stefan,
>
> On Sun, Jun 02, 2019 at 06:45:44PM +0200, Stefan Wahren wrote:
>> Am 02.06.19 um 12:23 schrieb Sean Young:
>>> If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
>>> carrier ends up being 476kHz.
>>>
>>> A carrier of 455kHz has a period of 2198ns, but the arithmetic truncat=
es
>>> this to 2.1ns rather than 2.2ns. So, use DIV_ROUND_CLOSEST() to reduce
>>> rounding errors, and we have a much more accurate carrier of 454.5kHz.
>>>
>>> Reported-by: Andreas Christ <andreas@christ-faesch.ch>
>>> Signed-off-by: Sean Young <sean@mess.org>
>>> ---
>>>  drivers/pwm/pwm-bcm2835.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
>>> index 5652f461d994..edb2387c49a2 100644
>>> --- a/drivers/pwm/pwm-bcm2835.c
>>> +++ b/drivers/pwm/pwm-bcm2835.c
>>> @@ -63,14 +63,14 @@ static int bcm2835_pwm_config(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>>>  {
>>>  	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
>>>  	unsigned long rate =3D clk_get_rate(pc->clk);
>>> -	unsigned long scaler;
>>> +	unsigned int scaler;
>> according to the commit log i wouldn't expect this change. Maybe it's
>> worth to mention.
> Yes, you are right, that needs explaining. I am trying to avoid an
> unnecessary 64 bit division. I'll roll a v2.

okay, but please give potential reviewer some time and don't post V2 too
soon.

In order to reproduce your results it would be helpful to know the
parent of the pwm clock (i assume plld_per) and the assigned clock rate
of pwm clock which differ between down- and upstream. I'm only
interested, so there is no need to add this to the commit log.

While looking at the code, i noticed another issue. The pwm driver was
written before the bcm2835 clk driver and used a fixed clock. Now with a
dynamic clock the range check for period_ns is wrong. I think the best
way is to check the calculated period value, which shouldn't be smaller
than 2.

I know this is a different issue, but while at this we should fix that
too (my untested draft below).

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 5652f46..d6ee85f 100644
=2D-- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -21,7 +21,7 @@
=C2=A0#define PERIOD(x)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (((x) * 0x10)=
 + 0x10)
=C2=A0#define DUTY(x)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 (((x) * 0x10) + 0x14)
=C2=A0
-#define MIN_PERIOD=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 108=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 /* 9.2 MHz max. PWM clock */
+#define PERIOD_MIN=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x2
=C2=A0
=C2=A0struct bcm2835_pwm {
=C2=A0=C2=A0=C2=A0=C2=A0 struct pwm_chip chip;
@@ -64,6 +64,7 @@ static int bcm2835_pwm_config(struct pwm_chip *chip,
struct pwm_device *pwm,
=C2=A0=C2=A0=C2=A0=C2=A0 struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long rate =3D clk_get_rate(pc->clk);
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long scaler;
+=C2=A0=C2=A0=C2=A0 u32 period;
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 if (!rate) {
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(pc->dev, "failed to ge=
t clock rate\n");
@@ -71,15 +72,13 @@ static int bcm2835_pwm_config(struct pwm_chip *chip,
struct pwm_device *pwm,
=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 scaler =3D NSEC_PER_SEC / rate;
+=C2=A0=C2=A0=C2=A0 period =3D period_ns / scaler;
=C2=A0
-=C2=A0=C2=A0=C2=A0 if (period_ns <=3D MIN_PERIOD) {
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(pc->dev, "period %d not sup=
ported, minimum %d\n",
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 period_ns, MIN_P=
ERIOD);
+=C2=A0=C2=A0=C2=A0 if (period < PERIOD_MIN)
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
-=C2=A0=C2=A0=C2=A0 }
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 writel(duty_ns / scaler, pc->base + DUTY(pwm->hwp=
wm));
-=C2=A0=C2=A0=C2=A0 writel(period_ns / scaler, pc->base + PERIOD(pwm->hwpw=
m));
+=C2=A0=C2=A0=C2=A0 writel(period, pc->base + PERIOD(pwm->hwpwm));
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
=C2=A0}

