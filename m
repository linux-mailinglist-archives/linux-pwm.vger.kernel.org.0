Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454C0275976
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIWOJI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 10:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgIWOJH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 23 Sep 2020 10:09:07 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679C423119;
        Wed, 23 Sep 2020 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600870146;
        bh=YdIBSxeNAvE6gQ5FC6DdEL/c8aPmX6JYu110Tn4pYb4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SCPL5h7I8Q2+Rqrmk3vTX4xl+c46yq9MI4bSDw5GroNsoIBP8ozU4ghJbq24G/Nng
         /4D6o/4C0E/pvBIOoaUpT6s7ClcusUZcUS+qb1d/YMD3S9mHHBbZwG6YL/Fe91/goa
         Q20KNMBVEbzDOzwVGsQxOdShPRPImq/OnuRUcRFk=
Received: by mail-ed1-f52.google.com with SMTP id i1so20072439edv.2;
        Wed, 23 Sep 2020 07:09:06 -0700 (PDT)
X-Gm-Message-State: AOAM531XWC7JkmCXfZyFV6COi3lGmtyxv7Jmf0LzwGfwA0tVnyQYDQ5l
        oUatQdHLbTrakusF9TEd6b+VoRZYh3lLS4S+hUc=
X-Google-Smtp-Source: ABdhPJwV6yPAy5gbNdaNXncZ2t260JTMWE7HddlqhxYJPw/t/7iwqoqe4AsHLWgMB6HEHZQn26BjmuJV5+rszBRI9Wk=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr9622063edb.143.1600870144956;
 Wed, 23 Sep 2020 07:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200825193536.7332-1-krzk@kernel.org> <20200825193536.7332-7-krzk@kernel.org>
 <20200923115201.GD1846003@ulmo>
In-Reply-To: <20200923115201.GD1846003@ulmo>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 23 Sep 2020 16:08:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcZuonCBK1Fc9r=rHzOL02MArrsE=R4x1tWGqov2nP0fA@mail.gmail.com>
Message-ID: <CAJKOXPcZuonCBK1Fc9r=rHzOL02MArrsE=R4x1tWGqov2nP0fA@mail.gmail.com>
Subject: Re: [PATCH v3 06/19] dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 23 Sep 2020 at 13:52, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 09:35:23PM +0200, Krzysztof Kozlowski wrote:
> > DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> > to fix dtbs_check warnings like:
> >
> >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
> >     compatible:0: 'fsl,imx8mm-pwm' is not one of ['fsl,imx1-pwm', 'fsl,imx27-pwm']
> >     From schema: Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> >
> >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
> >     compatible: ['fsl,imx8mm-pwm', 'fsl,imx27-pwm'] is too long
> >
> >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
> >     compatible: Additional items are not allowed ('fsl,imx27-pwm' was unexpected)
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
>
> Applied, thanks.

Thanks Thierry, but this was already picked up by Rob into DT tree.

Best regards,
Krzysztof
