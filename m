Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9A2D694C
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 22:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393909AbgLJVBo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 16:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393907AbgLJVBk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 16:01:40 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7E4C0613D6
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 13:01:00 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so5310848pfu.1
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 13:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPHH24YwLAMs21kNmL4LSTAD+hhvdVBd+0DZSMEAuqk=;
        b=oeIuwL8YGCRilYpstqg6XEsqx87cqsviwsZBfuNAw2utu6tAJ/yjgNwYvy5Y08F+qL
         mVGMEY4u+aeBmv0iz7M+PuyM0CgaE0Hs+R03NLIcrOtSorbKfFS/CUfrXecCjyBRVvlP
         X9NgwC4B1pXbn+as+njljJ8LGIaFsjMUl0hiJ33CEWZPZT/uzMaJ+FaD/wbQiRNauuI6
         tq1/FkEFA0SqRx2u5wXG5Cn9SmslYwz0DxQTHGP7p9mddua+VC91n0X2MyaMvURlxBoS
         ptrKUzEQDsaBMTGoa82d2SkAM8UC8/MMRgc5yLVSazBJQbmFeww1Paaxoo9lRZePLz1G
         Lb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPHH24YwLAMs21kNmL4LSTAD+hhvdVBd+0DZSMEAuqk=;
        b=qX190l3AXke/4QqZYCxPPiMm8vueDMH7TFNB/ABB1A/RX0lYayVXZ/ZNl/jvATfZW/
         q5k1spqVMid6uUKHn30sreGx/WxCnUvqEuPbEVPvNfl2Faqm9Ub1BeayOTmOMIQeXe4V
         7yNr6+03bsnlJfmr0rYo9nvfll7k1zWm9ZU5LXdGNX00Qra6kSHHPSzQI90QS8NaPYd9
         LE429eV1Vayepn2VDJ/M33AhJr8iP7Exm/W45zgip1D9b2NvsObhNHmsDyOsflB0gkPM
         FKe7cfzMR/YS+rP3EpHGmeeD1TkZsDWD0mnieD0Q7E+jD5A5dv47zm49NRwfA4ENneeM
         eGVQ==
X-Gm-Message-State: AOAM5311n+NYJBQGj78wy5XBEI0r8LTFkF+tl9ENB/s3BS/YLTNGaok9
        rqj5BsxrjW3tMvb0nk3NY4A=
X-Google-Smtp-Source: ABdhPJzvTJCdjJcoko+gRT0vkMz0zNwNZoP8uJuNCXxbpHxV7kTGG3Og5g93Kh4IYpjNEbe8gJ+2pg==
X-Received: by 2002:a62:7a91:0:b029:19e:55db:9ddc with SMTP id v139-20020a627a910000b029019e55db9ddcmr8412355pfc.68.1607634059585;
        Thu, 10 Dec 2020 13:00:59 -0800 (PST)
Received: from zen.local ([71.212.189.78])
        by smtp.gmail.com with ESMTPSA id u198sm6983712pgc.84.2020.12.10.13.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:00:58 -0800 (PST)
From:   Trent Piepho <tpiepho@gmail.com>
To:     Simon South <simon@simonsouth.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] pwm: rockchip: Eliminate potential race condition when probing
Date:   Thu, 10 Dec 2020 13:00:57 -0800
Message-ID: <2304095.iZASKD2KPV@zen.local>
In-Reply-To: <X9JfbpTnfqUVk6iN@ulmo>
References: <875z5nof46.fsf@simonsouth.net> <20201130004419.1714-1-simon@simonsouth.net> <X9JfbpTnfqUVk6iN@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thursday, December 10, 2020 9:48:30 AM PST Thierry Reding wrote:
> On Sun, Nov 29, 2020 at 07:44:19PM -0500, Simon South wrote:
> > @@ -326,21 +329,38 @@ static int rockchip_pwm_probe(struct
> > platform_device *pdev)>=20
> >  		return ret;
> >  =09
> >  	}
> >=20
> > -	ret =3D clk_prepare_enable(pc->clk);
> > +	ret =3D clk_prepare(pc->clk);
> >=20
> >  	if (ret) {
> >=20
> > -		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
> > +		dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);
> >=20
> >  		return ret;
> >  =09
> >  	}
> >=20
> > +	/*
> > +	 * If it appears the PWM has already been enabled, perhaps by a
> > +	 * bootloader, re-enable its clock to increment the clock's enable
> > +	 * counter and ensure it is kept running (particularly in the case
> > +	 * where there is no separate APB clock).
> > +	 */
> > +	enable_conf =3D pc->data->enable_conf;
> > +	ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> > +	enabled =3D (ctrl & enable_conf) =3D=3D enable_conf;
>=20
> Given that we don't enable the bus clock before this, is it even safe to
> access registers on the bus if the clock is disabled? I've seen a lot of
> cases where accesses to an unclocked bus either lead to silent hangs or
> very noisy crashes, and I would expect something like that (or something
> in between) to happen on Rockchip SoCs.

I would also assume register access with the clock disabled would hang or
otherwise fail.  There are possibly two clocks, one called "bus clock" and
the other "APB clock".  APB being Advanced Peripheral Bus.  Not the greatest
choice of names.  I assume the APB clock is needed for register access and
the "bus clock" is used to generate the PWM signal and does not need to be
enabled for register access.  Unfortunately the RK3399 docs do not have a
clock diagram for the PWM or include details such as these.

There is a low power mode bit in the control register that disables the PWM
signal's clock.  And which clock does that disabled, the "ABP clock" or the
"bus clock"?  I quote =C2=A718.6.4, "the APB bus clock =E2=80=A6 is gated=
=E2=80=A6"  It's like
they're being intentional ambiguous.

Anyway, from the existing code, it seems clear that pc->pclk needs to be
enabled for register access and pc->clk to generate a signal.  The call to
clk_prepare(pc->pclk) should become clk_prepare_enable(pc->pclk) and moved
to before the enabled_conf check.  Then clk_disable(pc->pclk) afterward.
The existing code will disable pclk even if the PWM is enabled, so unless
that is also a bug, it should be ok to disable pc->pclk after enabling
pc->clk.


