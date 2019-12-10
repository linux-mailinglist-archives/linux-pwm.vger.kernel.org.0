Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CD118EC9
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2019 18:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfLJRUh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Dec 2019 12:20:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51963 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfLJRUg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Dec 2019 12:20:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so860771wmd.1;
        Tue, 10 Dec 2019 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vXNgKnKakq//mqsjHx2g+hBYoldB3gxR/8Kku6DLL+U=;
        b=CZ0bHp90mZ89RJhZ5yeN2D65NblE7wKE0cp66lieBBsxBZc5lAmTZuxm5C9j8z2ddz
         d7XTirSpIozZ8RuBDecQ10Zi1Pde6T4J9Bh0mj6TFDaIYi0frSMXMUNE8ZEVMhgrhi2m
         L+OkGfKViJ6zdA76ZinbMbuxJ5BTebyhU84OQlBQ1VPCmXudz4wr0Nc6FpWzeCx/aXG7
         BHT6H2167RZV1xAk//4oWSW/Jp6w/Kra1N47pxDGvFTvnJoklLfZIpWVi652VFVARlZT
         VuEkS8l8aVU7Enz09V2pFbMok3B7iPSpMDEk6KTYZHx5uqs6+OW3gtj/BfnhmpVqA8ky
         ncUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vXNgKnKakq//mqsjHx2g+hBYoldB3gxR/8Kku6DLL+U=;
        b=EXIylpDxwZgf0wiF0vFhyhPrpgLIyTpD2ZQtNut8sPMrKlKmT+s3KJIyu4nxsRmDPY
         rsf1sHLzUgLXu2EsvoiHFT7TKXcRRM/6MHRGKdBECuAEFvOx2Vg3cm+coiSvw9UJpm5e
         /n0KvMOf9P+wjb70ZlWDzRa6LNZTIpjfZmkr/dLtTn0jpBvkVifRK0aSx4cbGtqE4ztY
         VZpgvCbDSL+PZaE/9T8jDRCO5xEFe9whm9vPFOSIlqO0k3UIkP2qm2Dh60ImTzJbd2vu
         Qy93hlnOrmjnLn11+EWrqKrVj/Wl9hv0IKczRb/BsCCuSgF5eOZg5HECZIpHABXrmk8V
         MsgQ==
X-Gm-Message-State: APjAAAX+ESZv/fyJ+k4ScUx/GA4mWDJDjRZNpzRO680/v4CmricW7NXy
        xoI9bK5XrJlQKdghjCnkv23xtfN18dFfCZL2AcY=
X-Google-Smtp-Source: APXvYqzq2LF8lClRiVJknmho7Xph1Cns7f+NRbX50kA9+PcdLQvbd5vJqhRZzwD+i28IAUbyBTJ6d0Se3jofTsXHQ4I=
X-Received: by 2002:a1c:a7c8:: with SMTP id q191mr6114178wme.176.1575998434072;
 Tue, 10 Dec 2019 09:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20191119175319.16561-1-peron.clem@gmail.com> <20191121072408.GE4345@gilmour.lan>
 <CAL_JsqJevcG2qv+BYKTnP=out0jPxuEcdYuLq7idxK04Q05fag@mail.gmail.com>
In-Reply-To: <CAL_JsqJevcG2qv+BYKTnP=out0jPxuEcdYuLq7idxK04Q05fag@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 10 Dec 2019 18:20:22 +0100
Message-ID: <CAJiuCcd3ttm_DxBrpB8b+yWAZLbvP1zAEp=vL4iNXD8cD=Zxyw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for H6 PWM
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

On Tue, 10 Dec 2019 at 17:48, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Nov 21, 2019 at 1:24 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Tue, Nov 19, 2019 at 06:53:11PM +0100, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > Hi,
> > >
> > > This is a rework of Jernej's previous work[1] taking account all the
> > > previous remarks.
> > >
> > > Bindings is still strict but probe in the driver are now optionnals.
> > >
> > > If someone could confirm that the PWM is not broken, as my board
> > > doesn't output it.
> > >
> > > I didn't add the acked-tags as there are big changes.
> >
> > Applied 1 and 7 for 5.6, thanks!
>
> I believe patch 7 breaks linux-next:

Sorry for that,

>
> Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.exam=
ple.dts:35.37-38
> syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-p=
wm.example.dt.yaml]
> Error 1
>
> Usually that's due to a missing include.
Indeed include are missing.

I will send a patch ASAP with a fixes tag.

Thanks for the report,
Cl=C3=A9ment

>
> Rob
