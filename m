Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA96ADB3C
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Mar 2023 10:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCGJ7L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Mar 2023 04:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjCGJ7J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Mar 2023 04:59:09 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEEB1F930;
        Tue,  7 Mar 2023 01:59:08 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id u15so4199860qkk.4;
        Tue, 07 Mar 2023 01:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678183147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ0tdLQj/jiT8jrWgvMIoZTVxGsykYl9zNPWhiOhfAc=;
        b=ReAle524orp8GEE9M5UmWik1hU+8JVFWzjGzCyAX7D44nYyb/w3tJZUDeXM6w/yFhI
         04liiM2AT2vE0o+zJpYZoraFL7GU3qycNvd5E5KHzEWyHycUMpdj62g5SlzP3lfCzPfv
         5sI13E/D7La/giWYYwRRo2Q3QsLVTR+eTSR0sx8FxU1SvrdLxiCXGdX+kFkNv5TmgGW/
         XpsZwGogC/yU974aneXSnb0xaKQcxgMCyupCjCeoisk3ZymCbEf6j6XRu4QkNz8PfoBg
         hXRbi40MFZOndtkBOzWxubX8+9sFlLzDJOev0JA3pyUo5FhEe5yQRz+mMzzLNpoIc04N
         bTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ0tdLQj/jiT8jrWgvMIoZTVxGsykYl9zNPWhiOhfAc=;
        b=pnfk4fda1OMCpUMrGHSmnU2IVvJuR79WYqRJjtbXw3/m34Tu6eLamyOq3UXLwJxae0
         RvbuPS6fOiR+DPTO1z1GnqbC0DKUMy0r6amr3ooxoWYM0xnw4FY53NdG8jdpXutbxjuW
         TqqvLldfKz8t6GGkLFiEz7GriMbn0Q+7PgPWV4qLdWJYr9FltbzgYhgOu3JIBO+vDki/
         aVrqC1gzFrYcl1mWzOAr4V+sxIYbA8HkhY+hQ1mykmLDZHq75rW/m2RNGGLv1MYowuWV
         ULK4rQqsWn1XFBI57jfYD35DIh5zmzVeRhka+EtG3wn44DdlmsnJ7PS8Cl0Vxx8K2XAz
         QEYQ==
X-Gm-Message-State: AO0yUKWNg+ctZt6B1sEHS0g1mws5QZHWBWUHcbQwYXzmcIjr6CZRSUcp
        2p1iVgqOI+V1/zSFMcOn5UqoJ2UVHhlAul3t8gEzcGPpAjmgXA==
X-Google-Smtp-Source: AK7set/CiCq707dbpX/hKgH1aTZBUAC8OJjzoVHotLwHp+UdMBoIH1iX7cH8htmAmS2dhpI7VMpR9YiqRKPfAYZNZTM=
X-Received: by 2002:a37:68ce:0:b0:71f:b8f8:f3db with SMTP id
 d197-20020a3768ce000000b0071fb8f8f3dbmr3637880qkc.1.1678183147317; Tue, 07
 Mar 2023 01:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
 <20230306090014.128732-7-biju.das.jz@bp.renesas.com> <ZAZ43tylTNxPIun8@surfacebook>
 <OS0PR01MB59223AF6B7850592F34CABF086B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59223AF6B7850592F34CABF086B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Mar 2023 11:58:31 +0200
Message-ID: <CAHp75Vcdyq-XKRFKzEjHFQ_0Qv61HkMEVu0Dg-ffsnVc9R3-ww@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 7, 2023 at 10:53=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
> > From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>
> > Sent: Monday, March 6, 2023 11:36 PM
> > Mon, Mar 06, 2023 at 09:00:07AM +0000, Biju Das kirjoitti:

...

> > > +static void rzg2l_poeg_write(struct rzg2l_poeg_chip *chip, u32 data)
> > > +{
> > > +   iowrite32(data, chip->mmio);
> > > +}
> > > +
> > > +static u32 rzg2l_poeg_read(struct rzg2l_poeg_chip *chip) {
> > > +   return ioread32(chip->mmio);
> > > +}
> >
> > Why not regmap MMIO?
>
> Some drivers used iowrite32, some uses writel, some uses regmap.
>
> will use regmap for read/write,If the preference is regmap MMIO
> as it comes with spinlock for MMIO access.

Lock can be disabled. It's up to the user of regmap.

--=20
With Best Regards,
Andy Shevchenko
