Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3236D713
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhD1MP2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhD1MP2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 08:15:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9701FC061574
        for <linux-pwm@vger.kernel.org>; Wed, 28 Apr 2021 05:14:43 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso53375539otv.6
        for <linux-pwm@vger.kernel.org>; Wed, 28 Apr 2021 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=blwCN4z8fnT4WO+IxhUlIEQzIENMKAtSNrtdk6Z42BY=;
        b=DFAC/wU0n6VjRh9yMmgmvJ//oKQo1IY64egGbMueD8eh9G6AeaSwpxBaQu95TLlVA1
         LJwkVUU/tnooIbihWqmncv3NlGbCvH2P/eJgX4GvMZN7wmAViQpri202ZGLXJaMLjsXX
         TLFtykQZyCCFKK98De8iwkqi/CxkGIPRKUFP4DrqyCqVPqoKUBgVLjG7IfX9HTYfw62y
         9rMY2XQW940x+T2BfEJc2gJcsAbf0d5aREguaLK0eCv6I3grTbnVqKVCeEf6q9bdFDUq
         fDauCWkSs7WjzDLAOJuEaHM0EpThHw+hCp5BUDnSBcMhEGYxB0jPSXkFpgD8HSMP5uAE
         Qvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=blwCN4z8fnT4WO+IxhUlIEQzIENMKAtSNrtdk6Z42BY=;
        b=nf/Or/YVmsMuvHOEEqIkeeWIAPLJ6FGTS5l9LeaII/5mKvIDa0B0jBun8GW0Ac8+bh
         jwA5wAWStMhGbrmItqZqeIqjQtqYg1WwFhQIPzPhP8XvD0iG1aPN2SkebZcceM5xxdGM
         WDTOka/E2LkXsLkAo6+j9Ur8usaPFdXBqBpZqjQ5flvGhSQjhMFumnLcCVcyh1ff7BCv
         4FSVyeeCWh76/Z8VA56P6PdJEsszyy8HvCe2q5TzI3Efs6496KOn1HJBzVkgEFaP0+l9
         L2RJpEj8x9A70ofnID7TDtgGZ8sTc04kEsDQkvkk5CSfobeOlGm6kqKSL8yMBk4Yt3O+
         6rMg==
X-Gm-Message-State: AOAM533S68ftmBp7xynE1Xm027qHaBB9GkCcAWG9dYwhfX21iV3+f5kD
        DETNkpLVT+FuGXhS6eiRqmkY+/XG5bbeOBpWhXFYjw==
X-Google-Smtp-Source: ABdhPJyC5NiFpBGlBxWjICm2oaRf2m9DqpET7381CC2a5yxAZsDxaPp4/HQr9aaebE+z0uQABTeGig8icammVnLjjqQ=
X-Received: by 2002:a05:6830:23a5:: with SMTP id m5mr23370359ots.127.1619612083007;
 Wed, 28 Apr 2021 05:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210428001946.1059426-1-roman.beranek@prusa3d.com> <20210428061357.725m72aikc52n4gg@pengutronix.de>
In-Reply-To: <20210428061357.725m72aikc52n4gg@pengutronix.de>
From:   =?UTF-8?Q?Roman_Ber=C3=A1nek?= <roman.beranek@prusa3d.cz>
Date:   Wed, 28 Apr 2021 14:14:31 +0200
Message-ID: <CAL8eAtpuAQUiesC-gxSQENDXrw44qQQvp5UqEjdfz1hX5CLHnQ@mail.gmail.com>
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

Correct, the output may stay in an active state. I only discovered this
bug as I investigated a report of unreliable screen timeout. The period
we use the PWM with is 50 us.

The PWMx_RDY bit stays 0 well after the last period ends, so if the bit
has any function at all, this one is certainly not it.

Cheers,
Roman

Note: my apologies for the previous HTML message


On Wed, Apr 28, 2021 at 8:14 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Roman,
>
> On Wed, Apr 28, 2021 at 02:19:46AM +0200, Roman Beranek wrote:
> > More often than not, a PWM period may span nowhere near as far
> > as 1 jiffy, yet it still must be waited upon before the channel
> > is disabled.
>
> I wonder what happens if you don't wait long enough. Is this a
> theoretical issue, or do you see an (occasional?) breakage that is fixed
> by this patch?
>
> I guess the problem is that if you disable too early the output freezes
> and that might be in a state where the output is still active? Would
> polling the PWMx_RDY bit in the control register help here?
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
