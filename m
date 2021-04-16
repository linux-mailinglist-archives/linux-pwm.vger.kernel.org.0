Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55D362418
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhDPPjw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 11:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236141AbhDPPjv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Apr 2021 11:39:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F040561222;
        Fri, 16 Apr 2021 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618587567;
        bh=ysgpDz+BTTXYH0RnwQoQvpA6pJla49qmtt338wMhnUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sA/oNszQk49bAP/+H3BmykaTAQenh0iw/Gpf7uZ+GwDgztxBf05slIkJ18rtE3vgt
         6QAX+ltavm9lwirWjcgh+xIT+8pAJF2SmfSKB3ljq+JiNQFSUUiYMRQ+i4yM9C9gxd
         j3phuIcFMg2fM8hlack0KOlcPk1Fzlx3ZzuSd0FHbGz3rBtMVfgHCwJM9kij8xZkaj
         w3hZ74yumnv50xxRMCuJfBdxa3mJmGkWGbAK/83+9CyOGbmJDOd5kr6cwNXQwCRk09
         kLMQIvZlBpeA5eH5Uq5CWKBvRRjVkjpbGo7ub8jYpasd2QZ800U5T+kQM8XziNmiVA
         KGLAmXuUUfXLw==
Received: by mail-ej1-f46.google.com with SMTP id w23so26962029ejb.9;
        Fri, 16 Apr 2021 08:39:26 -0700 (PDT)
X-Gm-Message-State: AOAM531eCdSgwLYf3jaXNtVYynLhC/Kq37Ha//da4IFdtBVKyk2lUhWD
        jyOMojJGLZiL4Y/Y7sfZyiC2xjhkd5dpCYPgpA==
X-Google-Smtp-Source: ABdhPJzFqy5Zhk2BT4rI/0OIAYEXZHtqzMK+r4zLrmuDcRgl1XfMcGCbqbDrhsyfDhzhIy4/n6neYfSAgSfwWszGhb8=
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr8390324ejm.130.1618587565661;
 Fri, 16 Apr 2021 08:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com> <YHmXPyf+XjgJs3C8@orome.fritz.box>
In-Reply-To: <YHmXPyf+XjgJs3C8@orome.fritz.box>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Apr 2021 10:39:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ3MU+iCr+R784r7UkPEsmDUgsgL-Qvi7edKnpe3T8M5g@mail.gmail.com>
Message-ID: <CAL_JsqJ3MU+iCr+R784r7UkPEsmDUgsgL-Qvi7edKnpe3T8M5g@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 16, 2021 at 8:54 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > Add the flag and corresponding documentation for PWM_USAGE_POWER.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> >  include/dt-bindings/pwm/pwm.h                 | 1 +
> >  2 files changed, 4 insertions(+)
>
> Rob, what are your thoughts on this? I've been thinking about this some
> more and I'm having second thoughts about putting this into device tree
> because it doesn't actually describe a property of the PWM hardware but
> rather a use-case specific hint. It's a bit of a gray area because this
> is just part of the PWM specifier which already has use-case specific
> "configuration", such as the period and the polarity.

I'm pretty neutral. My main hesitation from what I've followed is
'power' seems a bit indirect. A PWM signal doesn't have a 'power' any
more than a GPIO signal does.

> Perhaps a better place for this is within the PWM API? We could add the
> same information into struct pwm_state and then consumers that don't
> care about specifics of the signal (such as pwm-backlight) can set that
> flag when they request a state to be applied.

Yeah, seems like this is fairly well tied to the class of consumer.

Rob
