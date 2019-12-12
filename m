Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9111D1E1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Dec 2019 17:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfLLQIu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Dec 2019 11:08:50 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41479 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfLLQIu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Dec 2019 11:08:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id k40so1006265qtk.8
        for <linux-pwm@vger.kernel.org>; Thu, 12 Dec 2019 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6xL5oHx6JhfySW6vNlCWxSH0U7ZkAzHSyw1I4MBhOBU=;
        b=bX0qcXCfrctzXDS/zTTqs6TEaaJAU5p5CsU4r/5/bKGYfQYofP2Ae0gBQel5/wwdh0
         iJ2cx1hOBcJw2uT6qMHTzMHRo5U9ndec/mh1nW0E/oy3kDUHngJDaI5a6Mt6QDB7Zh3O
         dyjAz+ug5qnFQxQ4IZoRP5rMghfhGc8NldSweIlVJQmGdoxJpU7aUh0qRmlziBJnQ/fk
         u4pmrr77wEOXvqc2gbXJ3o/0AbdNr9l2Y6k4PNoxH0z8nDQuxY9GR6ta87xJ75rBJUzs
         umrKZYrpChkC2N72J/mQTVKQbOj0TPfkwPb9o2seXvtOtZkLELyaLh/6USr4/sHNARPF
         WpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6xL5oHx6JhfySW6vNlCWxSH0U7ZkAzHSyw1I4MBhOBU=;
        b=S6TaZe4CSnIvRFgF4IcfrcMPgxzKLABUXSnUINdqXXmbp0ULYEEFFy1WoC6E1S2IXU
         TaHKkx2QXG1FvP2V7JC0NUMXwJlicoQWV2yoT7HuK14QA2RwZoKTO3uHb0l4QGh2geC+
         1PtAo68yz+YeG9Wy1xGnSV3OdeVHb6aXaxnmfkaq3r4wxEpg7J2fWu89Le0Hueya1shG
         TZZA/UJMVWzTBASQdytefx5hvUrzQkejm7CBSLULoAP/SN0foLuc/l555Furq1Ml7L8o
         N7K/t7w2X0HMJjMDuy3sc5LLYqWQyHi9DeoflI4yPoTUfgN22nNIMjF7cfShzUcMerhu
         +Efw==
X-Gm-Message-State: APjAAAXxXy9gMicsj/gqosvMCuAdPt+H/fuY7L/O1DbxCT899OGN9MAf
        hrgPDE9icajJuqV9sHBTZ+CogD+5isSVIgq6SfJ3Lg==
X-Google-Smtp-Source: APXvYqyHX+4gkmFrb0PetZfIRJsKK01/Htm4j9k5//KWMeGY8spRtLpR1itsFlTDdkQHvk5JZswQdyreZWZAfH/iR44=
X-Received: by 2002:ac8:6784:: with SMTP id b4mr7837731qtp.27.1576166929494;
 Thu, 12 Dec 2019 08:08:49 -0800 (PST)
MIME-Version: 1.0
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
 <CACRpkdaTLVNXd+-j_gkOfKnTk02XaZiMA_XxUeM0_4zZ_F-=ug@mail.gmail.com> <CACRpkdYjCnx46kOuWXMZFme3emm1TugqjQPDctakOppAeCZvZg@mail.gmail.com>
In-Reply-To: <CACRpkdYjCnx46kOuWXMZFme3emm1TugqjQPDctakOppAeCZvZg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 12 Dec 2019 17:08:38 +0100
Message-ID: <CAMpxmJX73eufsaXzFjkb2S9Adztv7PqDEhBSDHfmbB_+VGrXEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: use platform_irq_count
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

czw., 12 gru 2019 o 16:31 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Thu, Dec 12, 2019 at 4:29 PM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >
> > On Tue, Dec 3, 2019 at 7:04 AM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Use platform_irq_count to replace of_irq_count
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V1:
> > >  Code inspection, not tested
> >
> > Patch applied.
>
> Oops dropped again now that I see there are comments on
> 2/2 that warrants a v2 of this as well.
>
> Yours,
> Linus Walleij

Linus,

FYI I picked up v3 of this series into my tree.

Bart
