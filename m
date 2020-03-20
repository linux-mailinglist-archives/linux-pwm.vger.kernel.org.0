Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7050518D56C
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 18:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCTRMB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Mar 2020 13:12:01 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51599 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTRMB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 13:12:01 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MLi4c-1ixfmK03g8-00Hekv; Fri, 20 Mar 2020 18:12:00 +0100
Received: by mail-qk1-f177.google.com with SMTP id d11so7635489qko.3;
        Fri, 20 Mar 2020 10:11:59 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0gyI7RLssROPQbrDBTAn9ptg+hCClBtDDiCaZmiTO95e66qysq
        poI/UDmbo6ov7h2735uX8Vs1c7MOhGTcbKWXuus=
X-Google-Smtp-Source: ADFU+vuTYNwVuJguhjzyHCuhUFNGAgsZlJ6L/zCdvZ31pFGtIywmjBS6Hofw9ebST4uDNGjv5IkCOSYkx89n56+FxCA=
X-Received: by 2002:a37:6455:: with SMTP id y82mr9138019qkb.286.1584724318696;
 Fri, 20 Mar 2020 10:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584667964.git.gurus@codeaurora.org> <3dc95ebc6539066cc58bc44c0e6e53ac979fe9a9.1584667964.git.gurus@codeaurora.org>
In-Reply-To: <3dc95ebc6539066cc58bc44c0e6e53ac979fe9a9.1584667964.git.gurus@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Mar 2020 18:11:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ueOXLFPd_C4nbqHwEmVOa5eFfSivbsMPKNCmjMiWF1Q@mail.gmail.com>
Message-ID: <CAK8P3a0ueOXLFPd_C4nbqHwEmVOa5eFfSivbsMPKNCmjMiWF1Q@mail.gmail.com>
Subject: Re: [PATCH v11 04/12] pwm: clps711x: Cast period to u32 before use as divisor
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0U8GQp3km2ZJiFaPar3epPUHYGwejvDlD6kTLCBx98NAiXNoeZf
 5+64Xo9SF4PUX0UC5mF0GOo3asD9+3wKCip1dMYtCwoojIMoGgM1AYPfds9y5RocWV6jCK1
 E0l5BO0lBir4269DSljTmbNYMhSSQi67lyEqSwnys8q+BgSziR3ltOfOmd7ybWcP0znpeuU
 Ypn3KezyH/rblgikeSkKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PrW3MYUJLXk=:gYXvSJ19Gr9XGEU7eaLiST
 fkLaaoeSgiv5BOXPeexHdc+RUdyoQQE/Ivo0DTXfmPV9UjkejlSwUP4kRKJpR5pGERhbLv19R
 S2iZ1CNyCnAs6BhYil0mJkCY9MHBu4gu4F1kLKW+mIViAuB7O3jMT2mHfAB0LBNcect2V3NSl
 rw6+dnwZses8gjz3LujydUgpDbaEp8OczlgTgAbOfcXjkVsHYjgKVDuKTsXtZscBmc6psy1F+
 PgUQfiSutCVdTEPZs5VXO8ywSq7tVZciLvhZSs4UIgnKwjodnQJZ97v6evgYUtSzLnyz3Q/QD
 jTpjuCwbHFQHtYun3YKvEuUlwdpe4ecK/BKdVozn970QsKQRshVCucG03tl/Xm6LqH0Hod/rH
 yMWiWsE8oxGN612f+g5OBX3VvVxETltnjIk2AmftrvvVodC2JQpWk7sreV26L2WT5sOsL7FuF
 66vhxhTkPas2Y7eoI25HtzDs4l7HZOJGmFnETzbtKbHBj8fgWxqeTCsbjyguUq7arRD9q+rrj
 SzviY+hTDJ3R3HEifp+/NXgGP2OwzOXACC7+A/l8Ef2EVKryix7CGaw9O01RDU451BbpdH7eb
 W0PQCOLcopVleesQY6OyeSftlb+kzyoBvhYDpwyTr4Es5GmzmcnOPhbZH77pOe3d4kUCB1AIk
 Ujsa4+oynU/m2X9A/N0E1exhnf4UbGNdZ8D9ke/cxE9hbJhHW73wgNBPT6I0tQ6rsHd0bfz5+
 23xBHRoWu2J5mI4wjSpdDGVI4E4it5gv+FsNirTToQGx7kXgBRyRJVck0bLe8g8QwXycReBJX
 fGr3YRbhKddMWbHK2XMb2lRuDekSIzUf7a8ZyN7bLWAzg0N8jM=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 20, 2020 at 2:41 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by typecasting it to u32.
>
> Also, since the dividend is still a 32-bit number, any divisor greater
> than UINT_MAX will cause the quotient to be zero, so return 0 in that
> case to efficiently skip the division.
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
