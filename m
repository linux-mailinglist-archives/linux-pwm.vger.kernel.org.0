Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A75E9A71
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Sep 2022 09:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiIZHaw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Sep 2022 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiIZHav (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 03:30:51 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65A20BFD;
        Mon, 26 Sep 2022 00:30:50 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id g4so3853457qvo.3;
        Mon, 26 Sep 2022 00:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PD9kRGu3xP06426an9uPmLar4Br/xl9PzLRr4C+tbrw=;
        b=7Oj36kkQgBDsmZKKbKnJoIX9d194NeacrbL4hAfi5knLaV/9xzaZe6ojIak4KcZSo0
         XPZOb7nWf4WOuuh5WRgcIjZJ+L0qxuIrX2fYmhiNzAKoCcovKdxe5iqRtX5pxzjzsySO
         NO4NqXCSq9SOH4V2ktmpZfzt4XyOypW4BrpJYNa2KktLmujje8EKePsHw1o7HsqHDsxY
         aGzzN+D6gAKSwIqTr7CdSTBfaN0kXtLi774OOjYtpdp+GtKDSf9uK9o13Ss8TJzfFoNq
         7BPoSLnon15Wh+N5bFEL2rMxEO6n8iaxD9oC6YabA3dIM1Qk5K2ZZan7p7RDR0DuORsz
         oWJg==
X-Gm-Message-State: ACrzQf3ZIIEpEUWWMAOo40OSi+ihB/gTb1IyJ+mnhMrKGCVg0P1EBJlY
        RJz6dVlpjZtg6NNh46wl4tDm3pxoEuI=
X-Google-Smtp-Source: AMsMyM7i9IZ3oKY/XdPBB8qswSZUQwg/wKw5aLJbdDrhimL0SWJfrtAi4qlqKkoQ8kkr9gnx9KYi1A==
X-Received: by 2002:a05:6214:2129:b0:4ac:8dfe:9d82 with SMTP id r9-20020a056214212900b004ac8dfe9d82mr16056290qvc.98.1664177448999;
        Mon, 26 Sep 2022 00:30:48 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a444c00b006af1f0af045sm11458785qkp.107.2022.09.26.00.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 00:30:48 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3487d84e477so59409067b3.6;
        Mon, 26 Sep 2022 00:30:48 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:344:fca5:9b44 with SMTP id
 g9-20020a0ddd09000000b00344fca59b44mr19280461ywe.358.1664177448106; Mon, 26
 Sep 2022 00:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de> <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de> <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220922053605.qivxzwon52orbdgz@pengutronix.de> <OS0PR01MB59220ECD0B2D42DF5012B6C7864E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <TYCPR01MB59336AAF4DD1D304FA53451286509@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <20220924134233.m7uyvwyulbmo3mrv@pengutronix.de> <OS0PR01MB5922B479EE78E840DA9B8F0E86509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922B479EE78E840DA9B8F0E86509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 09:30:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_-Y_MV=6t+ri_MicEMK+Z5JhxHHp3AsDU+4KgdMsXSQ@mail.gmail.com>
Message-ID: <CAMuHMdU_-Y_MV=6t+ri_MicEMK+Z5JhxHHp3AsDU+4KgdMsXSQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

On Sat, Sep 24, 2022 at 6:10 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Note:
> I have a plan to develop another PWM driver using MTU IP on the same SoC.
> The work is not started yet.

That is the MTU3, which seems to be a further evolution of the MTU2
in e.g. RZ/A1, which is already supported as a timer through the
sh_mtu2 driver?

> For this IP, I planned to use MFD framework for the MTU driver and
> Will add counter driver, timer driver(clock source, clock event)
> and pwm driver as child devices.
>
> Currently the MFD driver and 16-Bit Phase Counting using counter framework
> is almost done.

Do you really need an MFD? (MFDs trigger a red flag for me ;-)
E.g. there are two sets of bindings for renesas,tpu: when #pwm-cells
is present, it is used for PWM, otherwise it is used as a timer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
