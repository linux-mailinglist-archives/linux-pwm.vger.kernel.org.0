Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7357684BE
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Jul 2023 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjG3KHr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Jul 2023 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjG3KHr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Jul 2023 06:07:47 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112E199B
        for <linux-pwm@vger.kernel.org>; Sun, 30 Jul 2023 03:07:45 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-79414715edeso842559241.0
        for <linux-pwm@vger.kernel.org>; Sun, 30 Jul 2023 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690711664; x=1691316464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2oAr85N7jIuIOf6N8qwpsuw4hE9GHBZ0Txc6l9b4Yw=;
        b=Vct+8odnAkK8g83M/9p9Ij3LNbbwVNMsSoIt4++UIPMwIPq3yzVmVivjjabKNt8YxM
         Lg+CuKkpNSfFbFn/3wPZ/rKyetGIM5AfpM6SrxDjnjNt/kxiRSEDSc1PSQQc4IJsSYeW
         EtGpVsm8W+8ss9Q2WxO5w+cbrYgKa9kvVauiOfJuALjNHU6Zv7OLhi8V0lzkZe8URldN
         /hFNTbm9NgQM0Y3CwSlLnzFRxpnLU00JCCINUzAnggSZ1SNa/nSYHiOnu0yzwwMsImVw
         zABb71XfwYSVXg/UaEzZe3PqU1CuqW0TjzzhGdLJ/9vJOGCy/jFDo2kLy7mPrAfH53nI
         S3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690711664; x=1691316464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2oAr85N7jIuIOf6N8qwpsuw4hE9GHBZ0Txc6l9b4Yw=;
        b=VsT6BxPmn1xCVfUUA/3/bq4ehhmPA274vHh+gf2TWFabVlUNJ0IyWffZxCr6p8YFzS
         Xtsl0PrUZ/3EC2XNRdPvU5+t2MS6yqT5dvv6jHDTwhzEXG/xphIR3mPwfLc4rybA36ss
         fx9hTOhqqW4qUs7Z7JKFKRSoIX452535rMxJR3/aZJnP725b4/wGtM8qkMzxmUVsuQUE
         AqjU4PQTPMfO5QzXWUkgi/zbSeVRprzL2fP7TM2+2CMxH6+9cnSqqaYFkljzqwpGyOa/
         MUHUuYcg+OvehqwlL52y8IBYYbfjrsfRwmUJS8r9PbvewhcvkeF/a8OWLXom8OcHWIg9
         N5jQ==
X-Gm-Message-State: ABy/qLbXX6M9fNRnMW2qeXGE/3048n3WEk980m2weuME1VTGlnqkCfbw
        ZInvkpxqzJn3Vbv2GlFC3IGw+aI01fra5xZOMbXEKQ==
X-Google-Smtp-Source: APBJJlEhIlXconpq4Q8ftTEx3NahahpUzgFz2AjdaW+gW8tZ0GWL3CP/and/cXapRyGITt837r7ZwvNlbBJ2Xh/WtbQ=
X-Received: by 2002:a67:f9c9:0:b0:446:e878:f24 with SMTP id
 c9-20020a67f9c9000000b00446e8780f24mr2398235vsq.14.1690711664548; Sun, 30 Jul
 2023 03:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-19-u.kleine-koenig@pengutronix.de>
 <CAMRc=MfGWvAGYAh8q7mOenGDMpKS3q7UK7-Yxw5bn1avhoQ-UQ@mail.gmail.com> <20230729213712.mkfqgk6cage6yqsd@pengutronix.de>
In-Reply-To: <20230729213712.mkfqgk6cage6yqsd@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 30 Jul 2023 12:07:33 +0200
Message-ID: <CAMRc=MeSg7Emhv4VKdsPLfjTrLtsN8M0uapnDFtYGfbJ8UjxJA@mail.gmail.com>
Subject: Re: [PATCH 18/18] gpio: mvebu: Make use of devm_pwmchip_alloc() function
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jul 29, 2023 at 11:37=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Bartosz,
>
> On Sat, Jul 29, 2023 at 04:09:40PM +0200, Bartosz Golaszewski wrote:
> > Looks good to me (although I have my reservations about the concept of
> > foo_alloc() for subsystems in the kernel...).
>
> Wolfram's EOSS talk[1] mentioned "__cleanup__ + kref as suggested by Bart=
osz?
> Paradigm shift, probably looong way to go". I guess that's what you'd
> prefer? Do you have a link for me to read about this?
>

For now I prefer the gpiolib model. One structure allocated and
controlled by the driver (struct gpio_chip) which needs to live only
as long as the device is bound to a driver and a second structure
private to the subsystem, allocated and controlled by the subsystem
(struct gpio_device) which also contains the referenced counted struct
device and is only released by the device's release callback.

IMO there shouldn't be any need for PWM drivers to dereference struct
device held by struct pwm_chip. If anything - it should be passed to
the drivers in subsystem callbacks.

I may be wrong of course, I don't know this subsystem very well but it
seems to follow a pattern that's pretty common in the kernel and
causes ownership confusion.

Bart

> > How do you want this to go upstream?
>
> I haven't thought about that yet. I first will have to convince
> Thierry that this is a good idea I guess. This version will not be
> merged for sure.
>
> Best regards
> Uwe
>
> [1] https://static.sched.com/hosted_files/eoss2023/e3/LifecycleIssues_Wol=
framSang_2023.pdf
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
