Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8936F753
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Apr 2021 10:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhD3Ism (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Apr 2021 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3Ism (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Apr 2021 04:48:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1886C06174A
        for <linux-pwm@vger.kernel.org>; Fri, 30 Apr 2021 01:47:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r9so104075446ejj.3
        for <linux-pwm@vger.kernel.org>; Fri, 30 Apr 2021 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=ix10HKl4Ji6QvrIhi2BCp+LJFNaL/wGngqRsoRAXrcw=;
        b=qnXj4HI03B4usnHFixzqm+1A77XNUTnUhCdyrDYv/KkmDCNT7krP3Sji70SjV9YsxN
         BzSmnnPPltZ6X5GBtHSUBLRGC2ae1ITVpbJznYSh2kT5/9lkl50v1HO+1++ZLeRuqBDd
         lwW49APmr5oMSYEYMpLZPwqiEXi9GJtJPwRlgdysZTzhBAcJ/gECj3nJpz6RY91pP3Tv
         j6R2yNajDuns9TNFmJRUZhYjMCTpdBjnGZq/QTDXKy5ZODGw1ZsAMnuVhK2W6zr09p42
         nmZbXvDpMdUiHwQwpOSaPlXEvD/vp8B4jbC5Dk592yZ3fk6GqSEuSzKzuKxjZ59at1ms
         wBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=ix10HKl4Ji6QvrIhi2BCp+LJFNaL/wGngqRsoRAXrcw=;
        b=D5RaVNViG4pfuS9r5ZaXT0xrre99qCj2rWp4Oo1VDgjTlB73yOYZ2e1jjGPT/YRgEw
         XXsieSnhxqoP+EpTyOIMiG6PAm3+U0FfqTn1WHnx59JFvOjzdvcstJe58V5WU841NWtW
         Yfid6+jGQG656RT3CH/wcZxsQxvEhHJuFw0brxKhrW3NTmiRwaivGRKmF82DKYZiFAPx
         MXUCYA5usPOVYz+iNJKfPWWS2tguCQKZ1x5bQ3NJfB/rdqwD+BlrVxcPPiL2h5WyAxC0
         p5jxoujTrf9RUHjcJr28K2Ei5gCVvn1Lo/yVb2DYqmbKsBT1ZJq7/+tKRy1nbiz3lyHs
         3l7Q==
X-Gm-Message-State: AOAM531uYhF4+6PxxXEC1sR3roSY8FzdGneE4NIkSrZHYM+Y+meka7xU
        NWYi+3pURWdWAtXaSCX1FE8V0A==
X-Google-Smtp-Source: ABdhPJydNhoRcU4F9++M7+BFSAGysOcXhyO8/MEtoORm2Fzk3Ykujk6hiDy48VdoeeQHgRWdM6RLbA==
X-Received: by 2002:a17:906:7257:: with SMTP id n23mr3146650ejk.412.1619772471402;
        Fri, 30 Apr 2021 01:47:51 -0700 (PDT)
Received: from localhost (ip-213-220-236-33.net.upcbroadband.cz. [213.220.236.33])
        by smtp.gmail.com with ESMTPSA id s20sm751262edu.93.2021.04.30.01.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 01:47:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Thierry Reding" <thierry.reding@gmail.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-sunxi@googlegroups.com>,
        "Roman Beranek" <roman.beranek@prusa3d.com>
Subject: Re: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
From:   "Roman Beranek" <roman.beranek@prusa3d.cz>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date:   Fri, 30 Apr 2021 09:17:49 +0200
Message-Id: <CB0VI785HYEE.3PXPB7BDOUPFC@zen.local>
In-Reply-To: <20210430064145.nzlcw3lpayzapnbx@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Fri Apr 30, 2021 at 8:41 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Apr 30, 2021 at 04:19:32AM +0200, Roman Ber=C3=A1nek wrote:
> > On Thu, Apr 29, 2021 at 2:04 PM Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Apr 28, 2021 at 02:14:31PM +0200, Roman Ber=C3=A1nek wrote:
> > > > Correct, the output may stay in an active state. I only discovered =
this
> > > > bug as I investigated a report of unreliable screen timeout. The pe=
riod
> > > > we use the PWM with is 50 us.
> > >
> > > What I don't like here is that the delay is quite coarse and might st=
ill
> > > be too short. (Maybe I miss something, but consider the current perio=
d
> > > is quite long, then you configure a short one and then disable. In th=
is
> > > case the inital long setting might still be active.)
> >=20
> > The delay is calculated from the original period (cstate.period),
> > not the one that was just written into PWM_CHx_PRD 2 lines above.
>
> Yes, but that's not good enough. Consider the PWM is running with a
> period of 4s and the period just started. Then you call
>
> pwm_apply_state(mypwm, &(struct pwm_state){
> .period =3D 20,
> .enabled =3D 1,
> ...
> })
>
> This doesn't result into the waiting code being run, because
> .enabled =3D 1. Then immidiately after that call:
>
> pwm_apply_state(mypwm, &(struct pwm_state){
> .period =3D 20,
> .enabled =3D 0,
> ...
> })
>
> which triggers the waiting but only based on a period of 20 ns while the
> 4s period is still active.

OK, now I see what you mean. To remedy this, the delay shall occur
regardless of state->enabled.

In my view, this lies beneath the scope of the patch though and would be
better served as a follow-up.

Cheers,
Roman
