Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD58BAA9
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 15:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfHMNoJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Aug 2019 09:44:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42340 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfHMNoJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Aug 2019 09:44:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id j7so27795779ota.9
        for <linux-pwm@vger.kernel.org>; Tue, 13 Aug 2019 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G+G9l6sHBySdRwXOFFe8DEk9Xv/ufJQ2kG5hgA77tBk=;
        b=oNyITElNlRS5IKoO27dbnlQeDTR3di9cBknbLl/TzRy0OfFrN7FrszKKF9RogU+82h
         dh650Zy/aJ4tb2PDVCTCfpkkEtuK7CP6wyvhe59rsHuW4ArpqsV5CicnCSEDxJvq8knl
         pxnMGex44S9+BkbN+5C35qqGSCMt3pRK06ciJuCeUc2AuQ1Gyy/RH5yzkEcWx2Zp0ykC
         nP8+N08rETqiN+2n5IEgRGCOBFtUKkdarfGWJvBcf464iZJc5meuswLu6uVksgkDyLtR
         I+FyVSHqKfTjSTFMaRiP0la+7BNZVziBcovbP5SIe7+1EiEDcVAHrjaSYDSusCvhisMx
         6OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G+G9l6sHBySdRwXOFFe8DEk9Xv/ufJQ2kG5hgA77tBk=;
        b=YqYNm6C22ehULnRyxyvLq/2colE5zi2Xy8OG8tj+VRRR9BP/X5X1Te3/stxju/GopR
         PeyHN0tH1YmDK6nl0EcPGZNEXytAlj89zXy02gr1aoFT4QIkN0gVjyyQdcLE2PTdDREj
         nB25zvjpKGiO1KD+jYwkzq1ObgL6ZxnPYsNxLKIIgMyhmX+lyl3IdaFnRU4bRmn1SxY9
         Bxsleo4p5FKefizw6XkK8g3tpMRPhr6EUed8DTRWFvSl1LMePVeGqYTV0LqI1G0DQ69+
         j/r4xNBnXQ+fPu4MDbqlA51TQryrIACHfoTdbxbc2zeYYHwdQndcLqtmQfAWSzvGL5Pb
         eGCg==
X-Gm-Message-State: APjAAAUuULSWQ0l2YUATSjfRU7Il7XesbD6bMA+FmqTF4jP3q1nhFVDS
        8K384qkwsaKpMbJsWBSJFxWPJIrDT363LBVzNb87QXL4iQzU1A==
X-Google-Smtp-Source: APXvYqxsl0OjYU2QpOHrN2OzlJzdHW5Wiwko6BTDqu1Xxe8c8ISrQKbzx5myTiJVU5yAF7c/V/QpovgcR7IAVS7lIKo=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr22258479otk.145.1565703848169;
 Tue, 13 Aug 2019 06:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de> <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
In-Reply-To: <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 13 Aug 2019 21:43:56 +0800
Message-ID: <CAMz4kuL-YFpV-JxAq2cM2=vKo1AUU2uWzrfG6SXG0NFqzOnq3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, 9 Aug 2019 at 18:06, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>  Hi Uwe,
>
> On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > > From: Neo Hou <neo.hou@unisoc.com>
> > >
> > > This patch adds the Spreadtrum PWM support, which provides maximum 4
> > > channels.
> > >
> > > Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> > > Co-developed-by: Baolin Wang <baolin.wang@linaro.org>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/pwm/Kconfig    |   10 ++
> > >  drivers/pwm/Makefile   |    1 +
> > >  drivers/pwm/pwm-sprd.c |  311 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 322 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-sprd.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index a7e5751..4963b4d 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -423,6 +423,16 @@ config PWM_SPEAR
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called pwm-spear.
> > >
> > > +config PWM_SPRD
> > > +     tristate "Spreadtrum PWM support"
> > > +     depends on ARCH_SPRD || COMPILE_TEST
> >
> > I think you need
> >
> >         depends on HAS_IOMEM
>
> OK.
>
> >
> > > +     help
> > > +       Generic PWM framework driver for the PWM controller on
> > > +       Spreadtrum SoCs.
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called pwm-sprd.
> > > +
> > >  config PWM_STI
> > >       tristate "STiH4xx PWM support"
> > >       depends on ARCH_STI
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 76b555b..26326ad 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)  +=3D pwm-rockchip.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> > >  obj-$(CONFIG_PWM_SIFIVE)     +=3D pwm-sifive.o
> > >  obj-$(CONFIG_PWM_SPEAR)              +=3D pwm-spear.o
> > > +obj-$(CONFIG_PWM_SPRD)               +=3D pwm-sprd.o
> > >  obj-$(CONFIG_PWM_STI)                +=3D pwm-sti.o
> > >  obj-$(CONFIG_PWM_STM32)              +=3D pwm-stm32.o
> > >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> > > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > > new file mode 100644
> > > index 0000000..f6fc793
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sprd.c
> > > @@ -0,0 +1,311 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2019 Spreadtrum Communications Inc.
> >
> > If there is a publicly available reference manual available, please add
> > a link to it here.
>
> Sure.

Sorry, we have not supplied a publicly available reference manual now.
So no change for this comment in next version.

--=20
Baolin Wang
Best Regards
