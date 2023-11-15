Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134D07E9997
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Nov 2023 11:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjKMKAg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Nov 2023 05:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjKMKAd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Nov 2023 05:00:33 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8473010D;
        Mon, 13 Nov 2023 02:00:27 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d0ceba445so22074936d6.0;
        Mon, 13 Nov 2023 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699869626; x=1700474426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbOR8jc4vESBCIxoa+hxCKP6qo+nQDlXSDfPg0qKWS8=;
        b=Gxt6jNL11g8ADqbbtUUu7sfCA5TCxef+Oi9O6UCpUMz2Hl9UAcCsrVGQSAJY0rchSa
         2fWXVq7AXmWx9ZEJFNMQFvJIZDkZIXeHv3rXTKLTInXimIL/ARnozwGG5lHaBnIYHq84
         T+nbbCmlUVIzSwHWnuogJ6NMqKpUOmuI7tlR1e4u+1y/C9grNtO1dK5DZHv0+RK28hi/
         RBU4Pd6DCFzy0+1+KS+0smnNeLou21/Q8HtbSTb8Mj8pOMM+xbjo3DeBsignlYjtGXvp
         OtNJiD4Po/PezVaW5KiouZMhCgMGPbaaOxgGUf2ydmM7atI4j9IyQ76HgLPRe0c3dX+g
         4wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699869626; x=1700474426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbOR8jc4vESBCIxoa+hxCKP6qo+nQDlXSDfPg0qKWS8=;
        b=ElWU8ncAAVEDWaTjvNLg4RUgiS5h6Ii4YjZrG6Fp0TZA6A7rlO0+9c7LCWHQ58dXU8
         8aPKc5TmZgdo/2ijwqylqewCBXF0IvLWEizVWEXR/HaEDefp2y/HFjWOzCZ9Hzi9EGl6
         dcOJ1yy5tF7xNafy7b4GKJ4GSle1SezSbSfXV9uq4SK+p8tNak1ot4oiaxumVobG8IFc
         6VUqBknm52oIehzckjwpEogdj29+Wl0WUQH9tnGQiuWCiZQI1k7okfN8XMdq+BWFD+Fe
         eeTDZCEWofJ83zSGwU7U0qY/eEtE62BAXsCw4ipi1iLWqwKHaBrpCJ4uds2yvq3hl3xf
         JcZw==
X-Gm-Message-State: AOJu0YxuqSIsvehFjH2URJaMUnmivfdqyzd4fIxT8nYTH7/rk1hhChTU
        CnRgg+Z0zB9QUrJasWU8NFjMsuXzsm0L7XKc7jM=
X-Google-Smtp-Source: AGHT+IGCUr7PujFC+poPa2QrZRvWL4HOk1bJVQMa23HsF2MY33M5q50/7KY3Uea2911BZ50MrpHn+FMZq5R37QecRrw=
X-Received: by 2002:ad4:45b4:0:b0:658:1eec:408a with SMTP id
 y20-20020ad445b4000000b006581eec408amr4664228qvu.40.1699869626386; Mon, 13
 Nov 2023 02:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-14-3d63a5f1103e@maquefel.me> <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
 <80ed91bb971516638fa1793d648939815eba7630.camel@gmail.com>
In-Reply-To: <80ed91bb971516638fa1793d648939815eba7630.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Nov 2023 11:59:49 +0200
Message-ID: <CAHp75VeYHscM-r94kTrpH44W=OGVq+qoNNQZoVrR5_n-_K_Xsw@mail.gmail.com>
Subject: Re: [PATCH v3 14/42] power: reset: Add a driver for the ep93xx reset
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
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

On Sat, Nov 11, 2023 at 8:18=E2=80=AFPM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Fri, 2023-07-21 at 19:37 +0300, Andy Shevchenko wrote:

...

> > > +       mdelay(1000);
> >
> > Atomic?! Such a huge delay must be explained, esp. why it's atomic.
>
> atomic or not, SoC is supposed to reset itself here.
> However there is an errata [1] and the SoC can lockup instead.

Good, and what I'm saying is that this piece of code must have a
comment explaining this.

> So even pr_emerg() makes sense to me.

This is irrelevant to the comment.

> > > +       pr_emerg("Unable to restart system\n");
> > > +       return NOTIFY_DONE;
>
> [1] http://web.archive.org/web/20161130230727/http://www.cirrus.com/en/pu=
bs/appNote/AN258REV2.pdf

--=20
With Best Regards,
Andy Shevchenko
