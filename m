Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4E6DE1DF
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjDKRIJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDKRIJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 13:08:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8133AB3
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 10:08:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ga37so22506763ejc.0
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681232886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzSl70X4YWjLhFqxAPO4qw0JhRZO9Hie8h66AogpZTo=;
        b=TF9tqyaYEXBXP0nk+sLsW0brnEmnJQJF8yxmr/hlOND1lFDtun1Zg7heGe5lW79E7G
         qB9jrh1ESqk24Gm99U2lrOodPAWjxLDTx2Fgn/azX/udiw6HHtjHh3Y54PslbO2bDbGd
         ooIRmsm1N9ebyDX5ZCH79U0eN0D6e3I7ZQNn16+3S1SGwyWzHMH6mN+rfHmF3SPed35R
         nfZdra0KiCLvDzOuAFffkTMAe7C0lH5nM5qXoSFMNn5GzqNJCNoI12VlAMlef1Z4wB0L
         +Zc7jY/63+I3NfIns7sRxV6O11GmVUkH+vchRUguGTyOKFTOFqYTWsw7KHkvIJ9t3wjT
         2naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzSl70X4YWjLhFqxAPO4qw0JhRZO9Hie8h66AogpZTo=;
        b=HSsiypmopeN+aSNYdusXxooiJ9EHtbOoqdY8xrxtTODNa9nsDkA7P2M/UM45xViKQb
         NXbLw/pwoxNzTNsEEZDqgM5FU8PeXf1gTtz1sqsckRvkSM3IGi0xQkD+g0+BfCxHeaPF
         N0YSmY0V/bkIXnpJckDSo5Ago89Vn6I3+N+TDCnhFiMGFN0v/T3pDbBjrmTbeVx6h7aW
         vPjnQjj45W8kC7mWcz0+jZkgKlYgyFbPdUHQUiYEi15T65/th14AklNmrhoEnlKYB3RK
         1OauEYZaAxUeTvksLygA75fgyB1BT1MuQ2fmSCy5KwVkZdYNUb5Vzb0bnNK2R8T/SpSq
         k+ug==
X-Gm-Message-State: AAQBX9e9O8fWk6/SqgBdA9uypYrN/2Rq04K+97wUvDevc++AJYgrJmJi
        4GAbYi/DpmiEu6VLmWkH/8Hz1LK3+IM/+diVSQ0=
X-Google-Smtp-Source: AKy350ZjjRIVM6lJnoAgG3clDzfLdY+ssQ2Qkee1eQd3GIFHW0sOGBgGO42RE48P9zUQ7OQpVsO9bERyoM2zgigF2KY=
X-Received: by 2002:a17:906:a982:b0:92f:cbfe:1635 with SMTP id
 jr2-20020a170906a98200b0092fcbfe1635mr1755453ejb.6.1681232886368; Tue, 11 Apr
 2023 10:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <b53af028-28df-105a-eb50-21a1ed4e15b5@gmail.com>
In-Reply-To: <b53af028-28df-105a-eb50-21a1ed4e15b5@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Apr 2023 19:07:55 +0200
Message-ID: <CAFBinCBY7iH5zTKSNn5seqryfwjc2OTckwVjLJ7dxiUfSZDAGA@mail.gmail.com>
Subject: Re: [PATCH] pwm: meson: fix g12a ao clk81 name
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
        linux-pwm@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 11, 2023 at 7:34=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> Fix the name of the aoclk81 clock. Apparently name aoclk81 as used by
> the vendor driver was changed when mainlining the g12a clock driver.
>
> Fixes: f41efceb46e6 ("pwm: meson: Add clock source configuration for Meso=
n G12A")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
