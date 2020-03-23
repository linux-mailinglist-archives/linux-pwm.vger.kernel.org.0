Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70918F17E
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 10:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgCWJN7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 05:13:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42324 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgCWJN7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:13:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id t21so9579964lfe.9
        for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2020 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wWs92IouvEIpZgtyLlUCar33wlELXd5YoEyPXlLiTro=;
        b=QbDeCI7dYNFzd6fyHyqfAHAq63bQLRiJHT19fT4MkRi6jTMuI0QC28e9a4Pak1jEUa
         s11EYGMPEm6ADD5Mq5hQuV9351l3yGYjAbg+dzzd7aio3ISGAIuswd0yNbbHR9YIu30S
         M+ZYpecb4mDH7vTudL1qV/c8X68h61ZfXm89Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wWs92IouvEIpZgtyLlUCar33wlELXd5YoEyPXlLiTro=;
        b=Wtg6+AV8YUepIBAs/729DpHNScDAGM2Y9lNLPl1cxtOVRz5VDkAjObhAUVxvgksAAt
         uiAnHbnLc81HQMG4+lIGe2v0i0S2d6LLz+rA95tf+G+ObZpWkVzPEF8Eod2zxDVOZd4M
         Nf98D/eP27+xfbGJb47ibm+awhv/gLKKAaKitw46XowD6bnKqccSkiqLNU1lqeT0I+za
         DGHWLhYImZtfpiyPPq+K3wTkPQpTioVMjHT0RAg/L/iuSRWyH3el2vDpnaovNJCTuWNq
         1FAe11c3S0HazbI7LQgRT0LfzDeoWpQMOkfnSTPaPe42/SILzH6z490HLMYqWCoJx0Lx
         +LPg==
X-Gm-Message-State: ANhLgQ0Kp9y60WuCBSrMuh9kCV2dGdcAXz4RFSj4dPmcbJyF9cFLE/ZK
        glCCEjqB+PxkZYRxC4teFR9ZEQW4kbv0TR4rrPF8Gw==
X-Google-Smtp-Source: ADFU+vvx8jnLhfOgnWnseH4FTxIWcdY7WQsK5Ay/qiqPamQPGqpt4kJFOWL+guGHsaQwYq7XlwwWqRibftYmyeWIuKk=
X-Received: by 2002:a05:6512:3041:: with SMTP id b1mr12674571lfb.167.1584954837051;
 Mon, 23 Mar 2020 02:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
 <20200323065318.16533-3-rayagonda.kokatanur@broadcom.com> <20200323082823.twvpagq7tvrt76ws@pengutronix.de>
In-Reply-To: <20200323082823.twvpagq7tvrt76ws@pengutronix.de>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Mon, 23 Mar 2020 14:43:45 +0530
Message-ID: <CAHO=5PHUPy=2_HZg26Akogv3Hbic7JPydGpz0j3QfA=3TUgCJw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pwm: bcm-iproc: remove unnecessary check of 'duty'
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 23, 2020 at 1:58 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Mar 23, 2020 at 12:23:18PM +0530, Rayagonda Kokatanur wrote:
> > Variable 'duty' is u32. Hence the less-than zero
> > comparison is never true, remove the check.
>
> How did you find that one? I assume it was a compiler warning you fixed
> here? In this case quoting the warning improves the commit log.
Its reported by internal coverity tool.
>
> Also the commit log suggests that IPROC_PWM_DUTY_CYCLE_MIN is zero.
> Maybe mentioning that explicitly is a nice addition, too.
Okay, will add this to commit message. Thanks.
>
> > Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controlle=
r")
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  drivers/pwm/pwm-bcm-iproc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> > index 8bbd2a04fead..1bb66721f985 100644
> > --- a/drivers/pwm/pwm-bcm-iproc.c
> > +++ b/drivers/pwm/pwm-bcm-iproc.c
> > @@ -149,8 +149,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               value =3D rate * state->duty_cycle;
> >               duty =3D div64_u64(value, div);
> >
> > -             if (period < IPROC_PWM_PERIOD_MIN ||
> > -                 duty < IPROC_PWM_DUTY_CYCLE_MIN)
> > +             if (period < IPROC_PWM_PERIOD_MIN)
> >                       return -EINVAL;
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
