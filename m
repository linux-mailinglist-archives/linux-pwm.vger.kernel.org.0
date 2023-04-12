Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA486E0003
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDLUlJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLUlI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 16:41:08 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114955A6
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 13:41:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qb20so31624702ejc.6
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681332065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmTn4okX9LMhUGLjcx12BLMMUvyQdi4ru6Z/q3wv2Tk=;
        b=Sjn1n/CrAAUqzuv5Z7X9Ev8IWeRw48fAxiNlHB0Yu/kVgOBLrQUMQ/k+d5HPTNfumR
         T5ngVBkmNjYXw2QhwlHnqSS2DpSYirS9TPc+YL4FKR8aJylPdQ8WIjT7I63bWGPfcA1V
         GIx88SgstrOhXGbMGR1L7CPUs9cpgYO9mstBqb8hwfXcHiQ03lF3FBjBLG55BLXTX6M6
         20pi09Lr70zyRFQ07QyfN7qYwF+K8jjuFwVs0tjH3Gr1UXvwqvI7xBInJ/tGaMDohMkD
         gIwYv+ptbgM80VrB1EW/XuktLkbN8Z6v1ZLi+UNBrBRYRA/LwRKrME44z7Jhxbnz/mNX
         slZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681332065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmTn4okX9LMhUGLjcx12BLMMUvyQdi4ru6Z/q3wv2Tk=;
        b=bWo2vuIl7Z6mdzMDsqkaNbtruyW4dJ2Zw6JMQZWeRZBDfmcOOZESgwmbWpg7Scx6RA
         MnflOp2cq2XkTzlSC3XT5nUTvpC7eSyK1vqqjftURUKTOzIVO+ZCyxQHbB2S4s8YQ+0H
         SGTm4ShwWCDcuwNt0GbwDDuQ2l7jNTfyY408rYhJZ7EA7x2sZ7sF8M8ka7WWuVR7y2Pb
         hD0OVlNsFIU0SLwQFw6b9r6HKxgqAmUExO/02t5JQKllPC0M3wmIVSdqmJYwd0uqsPt0
         GBy++hsxgD3Vg54l+HbbOQDuB3KpIbynhJtjb5XeUp4vIUVseZvY3IJGuICvRoWR9e33
         ksqQ==
X-Gm-Message-State: AAQBX9dHU8y5ImPW+SV8fChOHvwxQ7tennTkwMx3a9oGGkDby2AKo3kQ
        FeEwaGXWgOno1p0hKdVxaMtAxtQS0/QUPNOfLUU=
X-Google-Smtp-Source: AKy350Z2waaCpe8fjeWSSCCYhqnrAMpxatTSIzNcDu+s0HdyG+P1/z5s9D8e1V8Wxr/6pA/CEwjIwKTV+frQ6jWSgPQ=
X-Received: by 2002:a17:907:160c:b0:92f:cbfe:1635 with SMTP id
 hb12-20020a170907160c00b0092fcbfe1635mr118333ejc.6.1681332064761; Wed, 12 Apr
 2023 13:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com> <8a7c067d-b121-3bd0-b587-f53861b52bd5@gmail.com>
In-Reply-To: <8a7c067d-b121-3bd0-b587-f53861b52bd5@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 12 Apr 2023 22:40:53 +0200
Message-ID: <CAFBinCDMXT-a+XkmbmAsS3Tijv90KyFut=cUzj3L3r_XQbABBA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pwm: meson: switch to using struct clk_parent_data
 for mux parents
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 12, 2023 at 9:23=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> We'll use struct clk_parent_data for mux/div/gate initialization in the
> follow-up patches. As a first step switch the mux from using
> parent_names to clk_parent_data.
>
> Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
meson8b-odroidc1, sm1-x96-air
