Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EFE36F3FD
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Apr 2021 04:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhD3CUc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 22:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3CUc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 22:20:32 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E8C06138B
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 19:19:44 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t24so11171319oic.10
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Gd0MgVT7NAzqGz0SDOQvL7OUfBTs+7oH+VCnAx8ZJM=;
        b=eujPtfaw2j4KXyTeMdxTfp6MhS/Pl/g3nL1hdwYUpHTqTI9nIuM6+IRroqYCIZ6s6x
         q5KIBw/Eby424UCTE9tG0cy1negKGKVEMrUYVxZHCMa7y14qrjsxQoK6WVoNtWYEmyop
         B7+6TWD0Zlir7O6UfKoyj8/Np+kYJfpdH4THi8zF5BZ5CUIX20HwFVhNzTg/M6CZfsjC
         Mns8KmQCk4NrnLLxYSkwaTVRsIcVzQlc8MgckD8jUaAdWWM13+z5lxjDU6XZZtT+sy05
         Ft1/iQf45YKwqP0tt0185F/l8mbPOFg2lTLq/eRbhfMXQecIPrjGYDVh0hpOv+gXjTwb
         Xkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Gd0MgVT7NAzqGz0SDOQvL7OUfBTs+7oH+VCnAx8ZJM=;
        b=QiVny94KqNcIJ515WWJdhcgofEdHQY/ylgm3ytDRejtZJkUrtzm0P5T+h4H7RgRSaq
         OKFm0b5lUw+C8MumcokeB7ROwEs+xfvujE/DCmtaEJJGGclCYhQPcLdlOm8RnbO2+d/Y
         wJ4z+pTbda5V0yHODeK2cNUM72QdzhH64zZFAD4+bJZDF0hzAuWYxg60H0sYfTd/NEbK
         pvxRxzedq4aUrDcD8XXiU0ac4kAvK+JKCAAglwawmd7FgiBEl8LL36f0GcwJ7zwKYAoj
         7p0vlOhpMeOFBza0DZjKNGlmvFzuNfT2Ur8Dr/hjTZYWaIPx3xUoRDe6I5uDXY/ZFaYq
         8bOQ==
X-Gm-Message-State: AOAM532tKTJRfJovEKnCgTOldIoU9IbgrbT1tgDnhLcBDWjS9Tr0dFs+
        zFfQQZQHxRHVdtuhvW3HBDCmln73ZK+kT/MiJ6rWcw==
X-Google-Smtp-Source: ABdhPJyLapc7Q/siTJmrN9S201JP7kswLoySQiqh0gf/H2JFPFIIQYMDXvGJSIaSjO2m/5tsaHv8f6R2K8KS3gD5se0=
X-Received: by 2002:aca:dd86:: with SMTP id u128mr2226013oig.155.1619749184117;
 Thu, 29 Apr 2021 19:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210428001946.1059426-1-roman.beranek@prusa3d.com>
 <20210428061357.725m72aikc52n4gg@pengutronix.de> <CAL8eAtpuAQUiesC-gxSQENDXrw44qQQvp5UqEjdfz1hX5CLHnQ@mail.gmail.com>
 <20210429120416.5ba7rq5fvhcfebzz@pengutronix.de>
In-Reply-To: <20210429120416.5ba7rq5fvhcfebzz@pengutronix.de>
From:   =?UTF-8?Q?Roman_Ber=C3=A1nek?= <roman.beranek@prusa3d.cz>
Date:   Fri, 30 Apr 2021 04:19:32 +0200
Message-ID: <CAL8eAtqBzUt6fP2nr-Ppg+qwhvKWk13A0P3+hoe07F+9VXCvmA@mail.gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Thu, Apr 29, 2021 at 2:04 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Roman,
>
> On Wed, Apr 28, 2021 at 02:14:31PM +0200, Roman Ber=C3=A1nek wrote:
> > Correct, the output may stay in an active state. I only discovered this
> > bug as I investigated a report of unreliable screen timeout. The period
> > we use the PWM with is 50 us.
>
> What I don't like here is that the delay is quite coarse and might still
> be too short. (Maybe I miss something, but consider the current period
> is quite long, then you configure a short one and then disable. In this
> case the inital long setting might still be active.)

The delay is calculated from the original period (cstate.period),
not the one that was just written into PWM_CHx_PRD 2 lines above.

> > Note: my apologies for the previous HTML message
>
> I didn't notice (because the message also contained a txt part). Another
> thing to improve is to reply inline instead of top posting :-)

Yeah, learning the conventions one reply at a time :-)

Cheers,
Roman
