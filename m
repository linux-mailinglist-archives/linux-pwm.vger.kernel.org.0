Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104846DE1EC
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDKRJ4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDKRJy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 13:09:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6056C40F2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 10:09:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50489c6171dso2405599a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681232992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+LovfMj5Y0fCLq+tJd34Pk+bOAIbnzd9GlCIhTrCFY=;
        b=MEiLqSI+mBvBUZtQPXMn04wmr975COI/+1cCkmtDNQUuRPtcKJID9wO3oazysIVii5
         TXKIBhG8hVjLMG4aui0YGC0ggOFIGT80oA9BwqfSI2S1m5a8v+9zkaF4PYVqvBAsUodY
         oWQUdxYRvgHHIYUejrBMCqOgKySz2fQbfJ1YFA9w34uD0J7vkU/Ci3wRe2vevxAmyraS
         RUA9wLf8jc4CavsDbTpGAsX20xxB4DX1LynkzlBMUFlFBXPJ9i5AMylLaMxk1+bL7L8J
         cfBQc41mw/iVjLU6YNogk3YPwcbyoCNWnHqy9e9k27CRjgQjXhETYiyUc8OGFBFkqB+s
         R/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+LovfMj5Y0fCLq+tJd34Pk+bOAIbnzd9GlCIhTrCFY=;
        b=1gUZm+/HCkQKD9g8bo4bjqnlaDXJBCSrk4sdzX3W5lEAuYcRcDS32NUgKD5bXtqoyY
         /8jRs2rfRP67pp5HQUy3diFAOayNB45listAV1n57m9VSNgVg7WFDLo5I8pFKyXjYsbu
         W11QOh60lE6F2sU1mUUj7OzNTEcx4h82nCwAou+PPbANOz6MQi6TYeIpVS5lAvUOF9CE
         5HZUYL9xY5FzeU3zfprZWYT6PgRjuPjAWyb/jvAA22YULWFMbsmB2+GTwdT9N0R4j69Q
         B4txxsb5MKQq/U6FCBK1W+U5zzKjNR5VKlIXxkOLN4OObORY9OoKoJz+rj+PGzRkH3zx
         hUqw==
X-Gm-Message-State: AAQBX9cDVPB+QYlPmyKBX2cL0Myz9k9m3vmHZikFgPtEAQIdVC29ibPQ
        TioaU9vSEHcwzsTCLLVnQWlF9qxiz7zy75H8nm8=
X-Google-Smtp-Source: AKy350azwMn/Osiqfu+ZdrahsW8SxHlklqm04Na0PGVJVJmFZcn+bqBSIUqvudSzQ0cHoNeD3a40ZUHs0X6yPDSIdkg=
X-Received: by 2002:a50:d69c:0:b0:4c1:6acc:ea5 with SMTP id
 r28-20020a50d69c000000b004c16acc0ea5mr5457829edi.4.1681232991705; Tue, 11 Apr
 2023 10:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <275c72a8-b9cb-e675-f1c0-4da658c3f98e@gmail.com> <a3fb613f-73d4-c9c7-f48f-ffd79fa654aa@gmail.com>
In-Reply-To: <a3fb613f-73d4-c9c7-f48f-ffd79fa654aa@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Apr 2023 19:09:40 +0200
Message-ID: <CAFBinCBtxQvDX8OSjACqRbFfM-DUtb5PoPp4Cwv4Q6PD8j0_gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: meson: omit video/hdmi clock as mux parent
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Heiner,

On Sat, Apr 8, 2023 at 10:43=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
[...]
> +               if (meson->data->omit_video_clock_parent)
> +                       channel->mux.table =3D (u32[]){ 0, 2, 3 };
Most likely it won't be relevant anymore once we switch to
clk_parent_data but this part of the code is currently a no-op.
A few lines below there's an unconditional assignment of
channel->mux.table =3D NULL;


Best regards,
Martin
