Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AB56E0010
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDLUml (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDLUmh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 16:42:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C595FD5
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 13:42:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dm2so32170519ejc.8
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681332153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1NzP44NJ7Zn3Q3csjGxZmv7aNxzXOUtIWmezQUNt6E=;
        b=nVpR91sBcS+KRq1o4GWnYRP56PPkTUMykZd7SYQKXAnRLpGCDIi9XrqOTT2uUFnDV5
         /LnSEl2PBVTcu9Ide2+m73pjDhP4LGoo3dnx7T7CbNohxN0Rh76DRka0cCSBTchrWbV8
         U8yvnzy/So7PLyNcOH2F/4fIsoRrSUIgfmy8zZebiFBhEcHZcMfGDnqdxGu+aFU84olk
         MTedAOn0MrUsxrCVvyyqfyHb1fBP4fWKAKqPz25UenxM8GjBrS9sTLehd/wFLJ7JoPCB
         HmlgoPOhqnMjqleD4WJi78wgxw4aKSrl2YPf6eNbjo8Gliexo7poGyJD/2kexrNszh0s
         LgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681332153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1NzP44NJ7Zn3Q3csjGxZmv7aNxzXOUtIWmezQUNt6E=;
        b=DyJIzyW2ydqTCpmfvr84Oryjf55o5DoXtFcOJHgfrBOISVdUGNiQIsIMibgxWavKEY
         9H5owAkp9ITp1JoepvCnErJRq99pKA32i6VTXUqf94voBFJbwm1sE87K9CRac0j9nPYV
         dLsb094dQRQij12xr7w2GKlYiv84hZ/ntSh0Mr24CdVYFk59EbuyZJ72Naxw5ll0S74b
         xjioHN+MM1sf0UMVzxrP0eLmwb/1vU2mxNRtv/U0cNhPmYCVjPzE/Zf30WBBVW8smVAE
         PlAvMEmSyvywNOd9bZXmE6e1yqNpvGDgxYNRQGkY3VKHErwd3U+BKlu84M5EW6PY9cgQ
         LXbQ==
X-Gm-Message-State: AAQBX9d285s9DVLYTIl9sIqqK1lOTY++C9C+DQHKn2MiP8X4Pd8GvkRm
        MvUUdODHk3qjE+EuZ26e6nk8C969CBaJjJ9nMWo=
X-Google-Smtp-Source: AKy350aA3TVqCUEdmigMYtd8tjauavWkkGNE5hxWY9vTVePvJvvL8i1e/EM8+pVrx1lgnPq/1ySeGA5/op6xhuQtOaE=
X-Received: by 2002:a17:907:1c02:b0:932:4577:6705 with SMTP id
 nc2-20020a1709071c0200b0093245776705mr127456ejc.6.1681332153223; Wed, 12 Apr
 2023 13:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com> <8c6ac288-a59d-7c51-aced-3dbcfa828cdd@gmail.com>
In-Reply-To: <8c6ac288-a59d-7c51-aced-3dbcfa828cdd@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 12 Apr 2023 22:42:22 +0200
Message-ID: <CAFBinCCbQhj0X5mNHF77PQWTmdvHrd=s09N-a6OxyxQxwW7Gdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] pwm: meson: don't use hdmi/video clock as mux parent
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
> meson_vclk may change the rate of the video clock. Therefore better
if you have to re-send for some reason then it would be great if this
first sentence could be extended a little more, for example with: "the
meson_vclk code from the display driver may change ..." to make it
clear what meson_vclk is.

> don't use it as pwm mux parent. After removing this clock from the
> parent list pwm_gxbb_data and pwm_g12a_ee_data are the same as
> pwm_meson8b_data. So we can remove them.
>
> Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
