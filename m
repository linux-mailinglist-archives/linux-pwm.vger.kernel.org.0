Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73871DAC54
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405669AbfJQMev (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 08:34:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35957 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfJQMev (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 08:34:51 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so2775339iof.3;
        Thu, 17 Oct 2019 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqcMAOPR2X7ODa41IdyQT/JuuAWdzynnAq9471NRIDI=;
        b=Te4UGA+/OOQ96uWoNtOe1qRVDSkTsnMurWE+LWhaG1HrDNjU+KKm0bzT4t1seQT6+0
         mu3Q00/TucWB4siDGjY96JaDIErAU9e5Ri4e2CYHryI3v5cVqh05zM9rXl6Bivl9xi2M
         EP66YXXKIlMv/syN/WfvqVe2fq16Uhl/YhNOYYBOQOcUYYtFzJmmbqTxtjCjyfAYSwl2
         ly6NzpCDZgXNzwA150d4r/uJ+2hkCgi62yqGHgGUarGSmBm6jolshk2VbEzY4ozvVPIu
         Ks9rIOtkVx+vXvanEJ5b5tTrqcL+Bq4mUIrarY2BgjeGrucRGpr5fq79WAbe4iaC58S4
         JtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqcMAOPR2X7ODa41IdyQT/JuuAWdzynnAq9471NRIDI=;
        b=TbUKQpTw4qUyFX6txyewn16NIcqOpFYpiB+jmKAkjZ+m6hgHWekYwGySN1BaNtuTlE
         PhfT7h8u3pIdeEcFE1qj59xLjJEPeZx4cJu7UlXY19+D17ocr5NZ53HsOjeXCTiOlD0J
         laLaIW+R3gjG+eorqNrS+YsZBh8JL+D/cmgEd/Ls8Y7nVEXyq6e0QKH+FU9D1vroD1S/
         9EFdGfK5YuHtw3BrTPtdkd8XNwOmrkSPJqRWDcFqkl8LBHppkR3/GLdcyywbUKRVvr5W
         Yxv1Nd8lNaOTTU7cL1FCVc336hIoOcqgvv2JLsHpryE4iJQUwMESH8eJ1wnsdmd3agJ+
         g80A==
X-Gm-Message-State: APjAAAXdNXFfZ+zzgXIBRTgCS+FOd0RNQJC2/buJh6Mi3XpLKh2B96km
        VR2h4LBm0FiyFSDG1qp/uEZDXUI2zPEUaGPCYPA=
X-Google-Smtp-Source: APXvYqzR/+y0NTzJ2GAikr+XbmnFDQ09ygbG13oYC4gGevg+GtEzatL+TZA22iHddVSAPyKb8f+hNX53YJ26zaLYEhM=
X-Received: by 2002:a02:40c6:: with SMTP id n189mr3094296jaa.52.1571315689789;
 Thu, 17 Oct 2019 05:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan> <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
In-Reply-To: <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Oct 2019 07:34:38 -0500
Message-ID: <CAHCN7xKogdqoLmbbTatPdtLzqz+MKh-jgrHkkCh+YA-bwwOkDA@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 7:19 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> > On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > pwm_get_state() return the last implemented state")) changed the
> > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > problem in lowlevel PWM drivers. By not relying on the period and dut=
y
> > > cycle being retrievable from a disabled PWM this type of problem is
> > > worked around.
> > >
> > > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > > combo once is also more effective.
> >
> > I'm only interested in the second paragraph here.
> >
> > There seems to be a reasonable consensus that the i.MX27 and cros-ec
> > PWM drivers should be fixed for the benefit of other PWM clients.
> > So we make this change because it makes the pwm-bl better... not to
> > work around bugs ;-).
>
> That's fine, still I think it's fair to explain the motivation of
> creating this patch.
>
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> > > index 746eebc411df..ddebd62b3978 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_=
data *pb)
> > >
> > >  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> > >  {
> > > -   struct pwm_state state;
> > > -
> > > -   pwm_get_state(pb->pwm, &state);
> > > -   if (!pb->enabled)
> > > -           return;
> > > -
> >
> > Why remove the pb->enabled check? I thought that was there to ensure we
> > don't mess up the regular reference counts.
>
> I havn't looked yet, but I guess I have to respin. Expect a v2 later
> today.

I would agree that a high-level fix is better than a series of low
level driver fixes.  For what its worth, your V1 patch worked fine on
my i.MX6Q.  I can test the V2 patch when its ready.

adam
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
