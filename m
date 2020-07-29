Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD82232815
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgG2X3f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 19:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2X3e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jul 2020 19:29:34 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF7C061794
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2020 16:29:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so19017563qtg.4
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2020 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ag+H1hGpAomnJAeq4yPJoXLabOM0ywnHRdghtWviE98=;
        b=QD2LhtSLWQP2TNjnoS6mqe5UA59jgN6HCy0aixdV7r2I3Q8LEf8OrJM9/XFxaYNCcw
         uY2t0zTQv3j7VlE0kUPrSVjp+11jncgubttjbEX4ea9KW03tLTBubx4v3oNnKVf+itvm
         9hRts8LGnfKWgqhOtqyOgmuWhSeaQP2Z278L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ag+H1hGpAomnJAeq4yPJoXLabOM0ywnHRdghtWviE98=;
        b=MzatQmA9u9An1yx7h59+zuKdMOE/AeYujFkBsyRwlop2P8YEXJPogwHI8bTUmg5wkX
         8j+U+dlv02FGVfay8thSZy47zrLuWSYJm8jL0fDd0RYHCk5KTN2uyQ9PoLlkGe2J2rwd
         LATSaQp1rP5sRNwKoxnQk7knWbhSwDBlL3GG8lkGr4Flxx/uym4yzImYkA6pkOZlt1nP
         Zha2QW5mKXm0ZN8QZZZccK804S7mLHNCVQ6n44Cla58OWJAGbHDZOX9T7bgeoRRA6KJI
         wpsSVjBdFtXE0M8tajcnAOMILRag4e3+68g4Dlh1nbVr36ntxdrp/4vK+mZo8ipSvJQh
         COuw==
X-Gm-Message-State: AOAM532KEd0IQ9owELUHmupEV5Yjckxy28awVvHnFU1N4wrM5MRYPklq
        YLqz/OrTVcKKoSV2duK+T0jXfMOd6pE=
X-Google-Smtp-Source: ABdhPJzQLqhd5zU1YHmYLZfyba/G1RFJUkzjGaCWfJP21zjcgXuxoMPd1e/Ixuviexhrai5VTUqhZw==
X-Received: by 2002:ac8:502:: with SMTP id u2mr238182qtg.331.1596065371996;
        Wed, 29 Jul 2020 16:29:31 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id t127sm2858739qkc.100.2020.07.29.16.29.29
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:29:30 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id 2so19900300qkf.10
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2020 16:29:29 -0700 (PDT)
X-Received: by 2002:a05:620a:5f7:: with SMTP id z23mr20316631qkg.206.1596065368695;
 Wed, 29 Jul 2020 16:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200726220101.29059-1-linux@roeck-us.net> <20200726220101.29059-7-linux@roeck-us.net>
 <20200729222150.GA970863@google.com> <ae5aeae1-4dfc-0fd7-3392-bf1ca3540866@roeck-us.net>
In-Reply-To: <ae5aeae1-4dfc-0fd7-3392-bf1ca3540866@roeck-us.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 29 Jul 2020 16:29:16 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNSiuXEUmKhM8KvySK2OrW62yO1ZhR4Eigtx57CG33i4A@mail.gmail.com>
Message-ID: <CA+ASDXNSiuXEUmKhM8KvySK2OrW62yO1ZhR4Eigtx57CG33i4A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, linux-pwm <linux-pwm@vger.kernel.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jul 29, 2020 at 4:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/29/20 3:21 PM, Brian Norris wrote:
> > On Sun, Jul 26, 2020 at 03:01:01PM -0700, Guenter Roeck wrote:
> >> --- a/drivers/platform/chrome/cros_ec_proto.c
> >> +++ b/drivers/platform/chrome/cros_ec_proto.c

> > ^^ Maybe we want to double check 'ret != 0'? Or maybe
> >
> >                       ret = cros_ec_error_map[result];
> >                       if (!ret) {
>
> 'ret' won't ever be 0 here. Above:
>                                                         && cros_ec_error_map[result]
>
> and below:
>
>                 else
>                         ret = -EPROTO;

Ah, I'm reading too quickly. You're correct, sorry.

> >                               ret = -EPROTO;
> >                               dev_err(..., "Unexpected EC result code %d\n", result);
> >                       }
> >
> > ? Could even be WARN_ON(), since this would be an actionable programming
> > error, not exactly an external factor. Or maybe I'm being paranoid, and
> > future programmers are perfect.
> >
> I think, if anything, we might consider adding the message below (result >=
> ARRAY_SIZE(cros_ec_error_map) is just as bad). Not sure myself. I am
> open to adding it if people think it would be useful/desirable.

No, my primary motivation was that I thought the logic left room for
error if there were holes. I was mistaken on that point. Secondarily,
it was also potentially useful to point out when we fell into those
holes. I'm not sure logging the warning is that important. Generally,
we only care about a handful of result codes, and as long as the rest
don't end up as "success", I think we're in OK shape.

Sorry for the noise. Here's my tag (which given my misreading so far,
should probably have a heavy discount on its value):

Reviewed-by: Brian Norris <briannorris@chromium.org>
