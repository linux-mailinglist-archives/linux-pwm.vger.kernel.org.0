Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633B36EC162
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Apr 2023 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDWRe5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Apr 2023 13:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDWRe4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 Apr 2023 13:34:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB0E77
        for <linux-pwm@vger.kernel.org>; Sun, 23 Apr 2023 10:34:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-953343581a4so506660466b.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Apr 2023 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682271290; x=1684863290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E95S2h7SC5peJBhaFGdGC1nCRzFdlNEvGeNQ+tRZiEg=;
        b=KEsOnVti2sX97MrcpR/U0c+U9xLXeEvx5pHhg7QjYzGUnQ5rHwGPJ3wifSP6hFn/wh
         7jbnz2czpouy4BkvSZwwSpI0r6MNjjO0+UaATdhHhEw/Ovof+WJr1KoE8Xnq9lZftTCW
         ToKEPWcQwwTi+jsa66XOKGvGdh55snCHXQGE3U2jukOtFBTM0f2OANf1UM8iX7KvdXnZ
         Z0Qd9sBSJ9cQueUjAq1MJnzCjzSL0KkAmEIlhSnjeHda5KLVJKRCXWKmP9EwgiiLsAat
         joYyFg7JJJD6NBhCYa72RzqxFDXSEV02SAO56L2uFBIlzB3v/a1CedxFScOF7z2JeGLs
         DcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682271290; x=1684863290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E95S2h7SC5peJBhaFGdGC1nCRzFdlNEvGeNQ+tRZiEg=;
        b=Mz6dw8VIxvxdKOyhUJW5GHDZpOSlqD9sdRgE/tTmqpTCIwN8Y8mU4Ze3L36dCVZ/D8
         An7UL0xqEXvBtArXmS1N+IewHjw3A+uKqNYDkCcyYLrz1PRDGHpjdmEgjtB7vIW78E2Y
         vEVhDU4juyjsJjVN4komVIk/Q9b/03T7WOiIBJECT15GH7aTALXNsDlY3D0cE/wRyF/g
         EkBfE+oz/jMQPi6mxF56OY+q1ln/Eeo3T49Q381WPryDX9hz5zX6Vb50F9fQaNGLjl84
         b0KTt7GBYUhfRMTDqAhueUy7/AqN3l1KwKGzTdP0fJu5sEimeq09gobNF8qKUm1+iqYp
         lYDg==
X-Gm-Message-State: AAQBX9c98Ha1Ne0ehXhMeTEyZaYVbQTOlyVlQLQQ8SP60d8eM6Qo9Ghp
        RaUTDAy45i3jaHSEVSZ2h7VbA2Pdlz6HjHmRne5420cG
X-Google-Smtp-Source: AKy350ZbjxgZoee3SG7STHRsvuzR6nW94qRQoaRfeuGn9gUgoAa9/bT0GM8UpFH+/h0c8QZDwvlvxiwIQBCZrXm3bOM=
X-Received: by 2002:a17:906:6447:b0:94e:e30e:7245 with SMTP id
 l7-20020a170906644700b0094ee30e7245mr8271124ejn.8.1682271289582; Sun, 23 Apr
 2023 10:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
 <05e3b9de-ee38-97b6-7f39-5b6f7de1674f@gmail.com> <CAFBinCAdXE+3VrPJAoik_0TFW6TsB0033s+fTYUTNehPrn=PZg@mail.gmail.com>
 <ZDfHtvZawSWWGTRP@orome> <CAFBinCBNA_AWy63P9RwSU98xNJ1-F8KHJWm9Dq1kmrZ7aFbpJw@mail.gmail.com>
 <ZD0Q-fUjMKRrPjXn@orome>
In-Reply-To: <ZD0Q-fUjMKRrPjXn@orome>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 19:34:38 +0200
Message-ID: <CAFBinCBeoAb_VKyBfSHWz=AAmiJV+FmzfS4yR_zXUEu==Vfbqg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: meson: make full use of common clock framework
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 17, 2023 at 11:27=E2=80=AFAM Thierry Reding
<thierry.reding@gmail.com> wrote:
[...]
> It seems to me like really your only option is to completely hide that
> clock from Linux. Even if you use CLK_IGNORE_UNUSED, you could still run
> into a situation where the clock gets turned off.
>
> Actually the same is true of the PWM channel. Once the PWM channel is
> registered somebody could try and use the sysfs interface to control it.
> So even if nothing in the DT makes use of the "reserved" PWM channel,
> people could still try to use it, which means that even if the clock
> were to remain always on, somebody could modify the period and
> destabilize the CPU.
>
> I think reserving specific PWM channels is the only way to safely make
> this work. People could still abuse this by patching the DT, but once
> you can do that, you can probably do a whole bunch of other things as
> well, so if there's no hardware mechanism to prevent access to the PWM
> channel, that's about as good as it'll get.
I agree with you. It should be done in a separate patch(set), not as
part of this CCF conversion as the issue which you mention is already
present even without Heiner's changes.


Best regards,
Martin
