Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE6113DB9
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 10:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfLEJXG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 04:23:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43500 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfLEJXF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 04:23:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id t25so2075638oij.10
        for <linux-pwm@vger.kernel.org>; Thu, 05 Dec 2019 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2+ymVaiKpxCGbb6mLFBeFKK14AzTNra8/JGSC81CVMs=;
        b=MMlHVQzjz8BNYnpFpiDs0UZPUGaTU2TrVR0oiTh126oHkRd3AnBTqVTxB0eqFevSHE
         uvkikS9S3YhLrdQrYkkl/bCSUrtcejYVB3JJO2XbcQ7MYu8m4AZYS0lSmxxNiTPbLzMn
         nXUU7sP4YagfcJmxGE4f0bEubpdanZ3jz3gV3eEQ4PcyE5jQqaG75Ey955ZOAMymako3
         9ONlwtVwrX9v02HlpHDiU8pdZQmbEK9nRiAFFVkR4ZHNB9/8UccCXy9m56Mjfc0jRXD/
         b6kgwNvw5Mmif95Df/GoIY23DCIg3D8iLnKaQUL6k2xqJhZDk5BgkfBggDGe2BBVH+KB
         Ez3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2+ymVaiKpxCGbb6mLFBeFKK14AzTNra8/JGSC81CVMs=;
        b=ibK3FB2X9xAHIBskOb2hVBQqV7AVvM9PrvbKm0PFrcESdqwbi7nD9/OvROFdhNtPLm
         NPCZGaWb72f7jhY/sUdErADiI9FJrMTmrJOChY0PzpKrUi12xmIBRX+53892TO89sVqF
         UCcNAik8ksBBN77Udoip4iXD6rYMRWEKifT+35T2nwOJ+OCFORC4e8lj6vuz35shQcMC
         +1no+QyfXOBt/5dmblV9NBbnrRa3blvynDi3abLaa2qp/4YvKqSkeN/wYW1Akg468apt
         RgNTry1NZIDQQaiQ87hTmW/4jVzrWAB/DtHEWxrBBm+jxBjasBo18/KwBLbv+hoLl/UL
         KMCQ==
X-Gm-Message-State: APjAAAWuGgaPlv4ZU4ut7IhQV3w2AG8pUPAPlXq5Nt4WdtEp7m4FZLpA
        5S/ij5pGc2amUG9TmaOVUa2EQaKAbhAgZ0JNdZl71g==
X-Google-Smtp-Source: APXvYqzluMSEyFEWEKRhdKW5xwVBPzAcJZFuTB7zoWh9ETQZ9ypQXyOujHC2HKRdnKfUdK5vQuhu+X0cBR17KlbGyAQ=
X-Received: by 2002:aca:4e90:: with SMTP id c138mr6418889oib.147.1575537784750;
 Thu, 05 Dec 2019 01:23:04 -0800 (PST)
MIME-Version: 1.0
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
 <20191204072422.vfo3mrrcaav75jv4@pengutronix.de> <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
 <20191204184754.5oj2xoem2v3544rx@pengutronix.de>
In-Reply-To: <20191204184754.5oj2xoem2v3544rx@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Dec 2019 10:22:53 +0100
Message-ID: <CAMpxmJU-WK1aXK3M_q12E_u8+wwEimuonmjFa7Hm3Z6Dp7DP_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

=C5=9Br., 4 gru 2019 o 19:47 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Wed, Dec 04, 2019 at 05:33:04PM +0100, Bartosz Golaszewski wrote:
> > =C5=9Br., 4 gru 2019 o 08:24 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > >
> > > On Wed, Dec 04, 2019 at 04:20:41AM +0000, Peng Fan wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > platform_irq_count() is the more generic way (independent of
> > > > device trees) to determine the count of available interrupts. So
> > > > use this instead.
> > > >
> > > > As platform_irq_count() might return an error code (which
> > > > of_irq_count doesn't) some additional handling is necessary.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > Reviewed-and-Commit-Log-Provided-by: Uwe Kleine-K=C3=B6nig <u.kleine-=
koenig@pengutronix.de>
> >
> > This is not a valid tag, but I take it as Suggested-by and Reviewed-by.=
 :)
>
> If you care about the validity of such tags, I suggest you take a look
> at the output of
>
>         $ git rev-list v4.0..v5.4 | while read rev; do git cat-file commi=
t $rev; done | sed -n 's/ *\(.*-by\):.*/\1/p' | sort | uniq -c | sort -n
>
> (which finds all tags used between 4.0 and 5.4 with its usage count).
>
> A few of the tags (admittedly with low usage count :-) included there are=
:
>
>   Badly-reviewed-by
>   Bonus-points-awarded-by
>   Compile-tested and Reviewed-by
>   Enthusiastically-Acked-by
>   Mea-culpa-by
>   \o/-by
>   Brown-paper-bag-by
>
> Best regards
> Uwe

I am well aware of this and there has been a discussion on LKML some
time ago (I can no longer find it though) about introducing stricter
rules for tags. I don't remember the outcome either though.

Bart
