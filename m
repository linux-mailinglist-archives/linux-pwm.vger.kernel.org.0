Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55A2B97C
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfE0Rqz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 13:46:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40675 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfE0Rqz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 13:46:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id r136so12400593oie.7;
        Mon, 27 May 2019 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvWmgSpOjlIMaMZlqMhXFOz9qSbgkNwvRngL97A0kDQ=;
        b=sr5PZkAr/7xMIJI1iE3rnlUf2W//7xEl0rEv8uMQxjtApmCeIfuxKSdL2GConU+qlx
         P9vCZsz/G7nRW6fh6wnGHfcswe1ykoaXPZpMAXM4lJmzGKnyA6dHHJ15yy41O2Q8EXK1
         G+q+o9iv6qd6cYrH8i06p+Fg7y+4luf4xPg26eTOT1gSFEWOBF6Wjaf92UcGcuxHr6eL
         dg7JyncH0+v4PWErlFOWs4YwVy609jJvfk7DjwLW12TL9qjU0xy5wSQcqA/UlzLuX/ai
         ECfO4NlD85myKsx73AYmyq/4B4G8vl0wKKPVxaRGc0nrhWkVWEP4RxerxdRskW36zJLW
         yaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvWmgSpOjlIMaMZlqMhXFOz9qSbgkNwvRngL97A0kDQ=;
        b=USCUnHILWJTHnj13t2bM6g1RSMvuYp8RQ36gEIKU3yM3/AHhFm2c2pjeaEvTwZQAEa
         fzpWYZAqHXEMeHyElIKdMsaDfd96sfKh1XNzdCNiubrcA2w/BnTvWEy9TxAYUrp/hc3c
         uh7Vd66elvacepKRB6eh4ab1nkwTzInVW96bgblex/gp3QCR2a/W1bnNsE1L77bSiNRa
         g4aqsRIZUO2PtVC7Ny2dzCP7uuETIwFX1h4PRlzaiS1COw9i3wFsaYG8e/+3CEVcCqKE
         cVVbI/AgZPx4n+KuqK/Rs2Z3++GMcyTb5mpoNYNXFNLvOpz9DEbphkJdL7FBiFmIGmII
         K83g==
X-Gm-Message-State: APjAAAVap+KXBQG0A0iRc3pTT4rYIGvEOVDIpbPxiKO+54U4iQ5Slbv7
        rnkbJ415/8o14n9TXyahyZi/5nxbVkf7itpjWfQ=
X-Google-Smtp-Source: APXvYqzOlHtTysG/NJMjTORoX4YkIoqs/i6VO44tMBIFa71EQ6WOH2ZGotkbC3hvW9Rj4y8Ks7VrpPwwNZd83dEYYlI=
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr93471oih.39.1558979214200;
 Mon, 27 May 2019 10:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-5-martin.blumenstingl@googlemail.com> <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com>
In-Reply-To: <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 19:46:43 +0200
Message-ID: <CAFBinCDXNy4=6U2gsh6vK6WEtJKAdfDGPMrpPJthbp5Rru1hbg@mail.gmail.com>
Subject: Re: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Neil,

On Mon, May 27, 2019 at 2:26 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 25/05/2019 20:11, Martin Blumenstingl wrote:
> > MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
> > a bit-mask. Rename and change the macro to be a bit-mask so that
> > conversion is not needed anymore. No functional changes intended.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/pwm/pwm-meson.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > index c62a3ac924d0..84b28ba0f903 100644
> > --- a/drivers/pwm/pwm-meson.c
> > +++ b/drivers/pwm/pwm-meson.c
> > @@ -33,7 +33,7 @@
> >  #define MISC_A_CLK_DIV_SHIFT 8
> >  #define MISC_B_CLK_SEL_SHIFT 6
> >  #define MISC_A_CLK_SEL_SHIFT 4
> > -#define MISC_CLK_SEL_WIDTH   2
> > +#define MISC_CLK_SEL_MASK    0x3
>
> NIT I would have used GENMASK here
that was my initial idea but I decided against it.
the variant I came up with was: #define MISC_CLK_SEL_MASK    GENMASK(1, 0)

however, the actual offset is either 4 or 6 (depending on the PWM channel)
and I felt that duplicating the macro would just make it more complicated
so instead I chose to be consistent with MISC_CLK_DIV_MASK

Let me know if you would like me to change it (then I prefer to update
MISC_CLK_DIV_MASK as well).


Martin
