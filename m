Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05336FB78E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 May 2023 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjEHTrW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 May 2023 15:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjEHTqp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 May 2023 15:46:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E47EFE
        for <linux-pwm@vger.kernel.org>; Mon,  8 May 2023 12:45:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so7659634a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 May 2023 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683575102; x=1686167102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9o0ZDuc/WFoj87oQCLOSGD/EQg39NiBUlIoA/BbiRY=;
        b=S2JqzLyhyW/ccbu5l86MwFo8X2qO3ccr/zyJQ8n+GCSuHAIvZlzLgZFhkjcnqqQmj8
         5zdKB3Y4Y9o8H9+t2vpkTucrO/se7TWM2bqG5DzWVxrapw2HR3yp+KasgaE7HT/MOt/q
         s6IKD9LmzdFsG9cyc9h4Bqt9shrA7y4pWCNY+mHh9ySI6ELLqlLB2iwoqmOnaUyCCQmn
         GZrc/PJi9OzIMEVww2eHtGOBEUdbLDeNe/OK+k4YclUiE/Uzq9Hv0bM/inarb2Zo2h/p
         NLrVuGJprLQw249ZOOpw+CLeFrP1AygfVKukaHaW/OyDAt4Vt7UduC5MzVRqsgXPkYtY
         vbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575102; x=1686167102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9o0ZDuc/WFoj87oQCLOSGD/EQg39NiBUlIoA/BbiRY=;
        b=AJNuUues50ak3/C6D1FLUhZgwqI4MhsfiSQfRaznul2j2KN44393U5wP1l1giG4Qbo
         KV2fwCz9Qh0/lOdD134ebHx/w0BeH+recFp8XMOj2Zu/t6Mi2B1vUQKXVmORHuZG7YOr
         rdepFTv8tjido2hu5AK7EcuHlGR1v5zJ5ctEP2HyFapbjaA2U7KTfOKmyp5YQHguu+dM
         rM6wBFrDjlQcX8jJfgUSqHTyPc23KJYDxKd9dc/CK3JxOvjSFwJSKqkPRjH0p9MMnpTk
         JHHbwpUjpifYRBdcLKPBD2v1YDsRiPPdfFLlzHeYgGTL8sGuzjsURgcWw2rUdgMHYXtH
         pCgw==
X-Gm-Message-State: AC+VfDzMLmDovw76jEf/+SYFu9OS3hxaPkTf5vJ+QRii0LrKQkk26tHJ
        1BecX7OT97QU0kJ9FUDntw2Mm6ni3I78CeJYkxc36Oitcm4=
X-Google-Smtp-Source: ACHHUZ5wsU06NVXtBYFA7e1UP/o9q6kVeaNQWEyuf0g4wqzYx+wkJFzRCED4KE+XBuIHCb1RaNlz1wiWpu0hR39zD5k=
X-Received: by 2002:a17:907:608c:b0:94e:6a24:9463 with SMTP id
 ht12-20020a170907608c00b0094e6a249463mr10586313ejc.28.1683575101494; Mon, 08
 May 2023 12:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com>
In-Reply-To: <23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 8 May 2023 21:44:50 +0200
Message-ID: <CAFBinCAYXdSJDy9oLh+_3GY=Xyr8W5Yge84aTeOWmadxJvorwA@mail.gmail.com>
Subject: Re: [PATCH v3] pwm: meson: modify and simplify calculation in meson_pwm_get_state
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
        linux-pwm@vger.kernel.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
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

On Tue, May 2, 2023 at 10:33=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> I don't see a reason why we should treat the case lo < hi differently
> and return 0 as period and duty_cycle. The current logic was added with
> c375bcbaabdb ("pwm: meson: Read the full hardware state in
> meson_pwm_get_state()"), Martin as original author doesn't remember why
> it was implemented this way back then.
> So let's handle it as normal use case and also remove the optimization
> for lo =3D=3D 0. I think the improved readability is worth it.
>
> Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_p=
wm_get_state()")
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
