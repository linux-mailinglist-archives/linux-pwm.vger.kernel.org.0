Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A24E6DCCB0
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Apr 2023 23:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDJVRy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Apr 2023 17:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJVRx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Apr 2023 17:17:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727B1BF7
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 14:17:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ud9so15229300ejc.7
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681161471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX4pMm0HUYEgd2HxlMec5J8tdhlQ5dZZpC9ZyoRDBIw=;
        b=Mf/2sJDz+Q4/r6ZzIqgYpTRIMkeidgGXr5qgvkaW0hCi1LnR/EN45FJeDOZGhdmn9Z
         qYqbrpBGAhFgBHngNfpROJXLRi/Ggsuh3bhekiBgZhJz6Yf2FNqzuRt0R5s5TYLbUDBG
         0C/nLRQpZiIUpxAVu4BySNEh+mYV4SY4fNOoBxEttoOtX1nq6C6+4qum/rEemEJ/3mjV
         1IC2gBBSjHCR9h7G/x0n9qksEZ7ckpaDnw5ZPUdunTdlGqG2oJjyI4JvkiLAjqq2bBZ3
         12E7YZKDtYFDSz2i0LqM5svjqWfFThBkqHw6DEDcM1sIf6bcTz72EY2deds3/QONc9GI
         IWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681161471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX4pMm0HUYEgd2HxlMec5J8tdhlQ5dZZpC9ZyoRDBIw=;
        b=HLyrQXM3aWQPvJE5soXnvuGB+Bv0gMEEKfjgfUFNNvelFEu0/MT+2hRolQBgt2S6ZX
         e9Hd/LyJ/b3/GM8F6CQ1X9CYxRPXegZpL15Vj9aiGqKSLDkwbS3gB8ciG+uhdkCNDgc9
         iPqxt4pseJKunEXhqcLymUqosUE5i3Em0NUHoTJfRARdITi3qxhCeiL/hhT6ZHzSHSU1
         SxIVCOz16IkGD74tjyov7+Ijrx871o75CuN36f5fqvNHFNFIIwY+s3kEVUqXsQEn/7b9
         vug939LoTLrGUDP4GtLevBH5HqF+ZSDn9Od0WeLG/+HggGmp6c3wl0vPo8jtzifOVx8L
         RBmQ==
X-Gm-Message-State: AAQBX9cmUEje0ZmY+Ftpk+azZ9HS011ISCvgJ67McJqiNY+rz/PygvbV
        HqKqzWp7tvuaUWQ+LiBSP/3rM5Kf9F+sQqYacRc=
X-Google-Smtp-Source: AKy350YXOtyl8kqEN+naCYoiJKtnE7t02F/SyPuKcF33pzLILbum3kNrqoFNlOANdeMKlYMnoqA1VBXvBdAwgJAstFw=
X-Received: by 2002:a17:906:b301:b0:930:90ce:a1a6 with SMTP id
 n1-20020a170906b30100b0093090cea1a6mr3288633ejz.6.1681161470764; Mon, 10 Apr
 2023 14:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <ffc3e4e7-b2ea-1a56-4fff-6554ad3775c0@gmail.com>
In-Reply-To: <ffc3e4e7-b2ea-1a56-4fff-6554ad3775c0@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 10 Apr 2023 23:17:40 +0200
Message-ID: <CAFBinCAbG1apYVgaMuegk=aT67YXer9dfc3NEuLbjxDwPEJR0Q@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: meson: fix axg ao mux parents
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

On Sun, Apr 9, 2023 at 5:15=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> This fix is basically the same as 9bce02ef0dfa ("pwm: meson: Fix the
> G12A AO clock parents order"). Vendor driver referenced there has
> xtal as first parent also for axg ao. In addition fix the name
> of the aoclk81 clock. Apparently name aoclk81 as used by the vendor
> driver was changed when mainlining the axg clock driver.
>
> Fixes: bccaa3f917c9 ("pwm: meson: Add clock source configuration for Meso=
n-AXG")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
