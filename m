Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97361FBA5
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2019 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfD3Oi2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Apr 2019 10:38:28 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37692 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfD3Oi2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Apr 2019 10:38:28 -0400
Received: by mail-ua1-f68.google.com with SMTP id l17so4834233uar.4
        for <linux-pwm@vger.kernel.org>; Tue, 30 Apr 2019 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=leSKHNU1Kx61Evh+FDlJRg0VdWvRcdsUW3kM7dqpOPk=;
        b=eyyIXAxLl6gwku8PvSM3A4rlLJxL0nvyURAkYDDqN7tK1AQqVzwtOe8F8LQfvst5vm
         iPy+Ms7gonZUSTmE/f7rVtigNp+ekj1TePjJ/h0IsHJXBVHnqWccseNmdeOov3Z5zIZf
         6gZd6uhETna9187T3drWp6uCUtAZkokwvjtIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=leSKHNU1Kx61Evh+FDlJRg0VdWvRcdsUW3kM7dqpOPk=;
        b=oswJwS26m8wnN1eFkHPG6+dZIU+DkI2gVYGiJ1uo9zQkxW+/CVED8wC0QZo+Oa2ARk
         aY3Qsmwd85NhyZBqAcIz8m0lhP6L2dWAuPhu7e4YxdtpRxaDG8qy6HHEuAgw01vR4EJD
         9aP4B+z2x1aAev6h2aRwEfkhZQ1TU+csRcyBPYLsgtWGYzsbJ5lHiqeHo1qAlDDZlOKN
         nAbC2kclXeRgLb8R77rDy3DZQVJyoHkg1gh1Cxr5EnobSxgW/nLfIX7y154NbTgEhrGn
         EcgZAIqyWaipALqMVdr48XCtYjCO036pNIHiOCK4vek+d4Jt6GoFrxA4BvtszKSQzHGo
         dBNQ==
X-Gm-Message-State: APjAAAXzE3/qcH8nFxwMSEmyXAvEhvuL9kPLqpHKYe3UD+MfJCYXpHXo
        CIPPPOMrL/D2m0Xin7FO+dAJLy3p2KE=
X-Google-Smtp-Source: APXvYqx4OUavE+AWh0HdP9oHJZHtASvme2ZxfvzL1toTPv2Gn3EAvKh+n+83hRBPmh+80xJGRAVYVQ==
X-Received: by 2002:a9f:37a1:: with SMTP id q30mr31800528uaq.114.1556635107131;
        Tue, 30 Apr 2019 07:38:27 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id v132sm467618vkd.44.2019.04.30.07.38.22
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 07:38:22 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id h127so3143666vkd.12
        for <linux-pwm@vger.kernel.org>; Tue, 30 Apr 2019 07:38:22 -0700 (PDT)
X-Received: by 2002:a1f:8382:: with SMTP id f124mr20102803vkd.70.1556635102187;
 Tue, 30 Apr 2019 07:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de> <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de> <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de> <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190430092824.ijtq3gfh6mqujvnk@pengutronix.de>
In-Reply-To: <20190430092824.ijtq3gfh6mqujvnk@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Apr 2019 07:38:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUi0NbsRDJA_4WeC62QYXjLNH2OygU1FOCx==W0SyqpQ@mail.gmail.com>
Message-ID: <CAD=FV=WUi0NbsRDJA_4WeC62QYXjLNH2OygU1FOCx==W0SyqpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Tue, Apr 30, 2019 at 2:28 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> > > Also it should be possible to know the result before actually
> > > configuring the hardware. Otherwise things might already go wrong
> > > because the driver implements a setting that is too far from the
> > > requested configuration.
> >
> > Later in this thread Thierry didn't like the "round rate" idea due to
> > races.  One way to solve that could be to indicate to the PWM
> > framework which direction you'd like it to error in: a higher duty
> > cycle or a lower one.
>
> I don't think this would result in settings as optimal as with my
> suggestion. If you don't agree and want to convince me: Show how your
> suggestion would work with a PWM that can implement only multiples of 3
> for duty_cycle and period and you want 20% duty cycle with period <=3D 1
> ms (without making use of the knowledge about the limitation of the
> PWM in the algorithm).

I guess I was assuming that somehow this would percolate down into an
API call that the PWM driver would implement, so you could make use of
the PWM knowledge in the algorithm.

...but I don't have any real strong feelings about this API so I'll
leave it to you and Thierry to hash out what makes you both happy.


-Doug
