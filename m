Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385796DE51A
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDKTtB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKTtA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 15:49:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE8219AB
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:48:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt17so11077978ejb.11
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681242538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTUUbSrcyGYVVIkSI+DZBOfy0xrXgYqsQoFAd5zef+A=;
        b=qy2+KtbSGyvuu4a4hU27QatyQwEJPTa/E+ACtxaRobBDjyPpnBCHxqeuvVMicDLTs7
         aEOBu6eWzh9wopu1Ny/Xggx4F/dD2qFgGJFyVRwtJtQLBbnU6tJeQ0QXfEhs9CWbcwJ3
         Eh5OFvrGlkaCwN/7IQqrMRCBN78A4o67XTKEzqZzFVeqQ6JiLjk+ym6yFU+9BAtsNO3j
         kzYqZjdlSl15oVzLshHlp6VEowMUnk2+a6e9j7xGrQ1tTT7MQDUIhFYZbFdfC52nub5o
         tMIzOb9PXPdUWaJaD5WiM1vgfOzAwbItaWXTHUfj/lR8QnqYZyOHXbUoNv6+dpk0xbQK
         FIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681242538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTUUbSrcyGYVVIkSI+DZBOfy0xrXgYqsQoFAd5zef+A=;
        b=bECU8TED6MFSMS+CoLFXMAcjx+KUGf0b2E/0YbBloPSlG1aPcdOmIFDcWIbxUw25l8
         oOmTwZRQMPpRMBYxAxYJHjz70iJpNszrZnPPYtsRyOoIzqeEzqO4pjdMTZWPCu1XoTRH
         ZPUsPNswcjC9iTfOsWxmVY7IzGBToVpkcejIwErIsDOnVIMF36w2xSITHcIaYbL0yU6k
         DWtC3NQF01iNWSQuUH4yOH6bHor1b2FxQMNtNPf/EEc5ELFrmkbWKBkeWbED+QcjiJm+
         4RH485UvX++gcK0g+jtDwPznfX6LNrKbniE1fS5SyuiGA7wfzg6h5QDxDQH9nI0joflE
         Po+A==
X-Gm-Message-State: AAQBX9dt/uVeSX4x304PG516uS1vS+7kQU3BzxZJa/a7K0I/JvLQPdO+
        WggwAwrJdxyip823HeOW/rn3g2unTUir3c9VcGBChM80q8g=
X-Google-Smtp-Source: AKy350blABHYIEYUdGZEF3BT8eF8mXBkHbgI6Gds0qr/ylBa22+0ltEEoVq2d1aQv+F0cIMh4XD8yOOJ86Y4BH6iKLc=
X-Received: by 2002:a17:907:ea5:b0:94a:972c:c28d with SMTP id
 ho37-20020a1709070ea500b0094a972cc28dmr3811104ejc.6.1681242537771; Tue, 11
 Apr 2023 12:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com> <05e3b9de-ee38-97b6-7f39-5b6f7de1674f@gmail.com>
In-Reply-To: <05e3b9de-ee38-97b6-7f39-5b6f7de1674f@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Apr 2023 21:48:46 +0200
Message-ID: <CAFBinCAdXE+3VrPJAoik_0TFW6TsB0033s+fTYUTNehPrn=PZg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: meson: make full use of common clock framework
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
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

On Tue, Apr 11, 2023 at 9:26=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
[...]
> +               init.name =3D name;
> +               init.ops =3D &clk_gate_ops;
> +               init.flags =3D CLK_SET_RATE_PARENT;
As much as I don't want it: I think we need CLK_IGNORE_UNUSED here as well =
:-(
On GXBB, GXL and GXM SoCs the board design typically uses PWM
regulators (like the boards using 32-bit SoCs as well as newer boards
using G12A or later SoCs).
This means: if we enable that PWM controller and one of the channels
is firmware managed and the other isn't then we can end up disabling
the clock - taking away VCCK (which supplies the CPU) or VDDEE (which
supplies GPU and various other components).
I'd be happy if there are other suggestions around this though.


Best regards,
Martin
