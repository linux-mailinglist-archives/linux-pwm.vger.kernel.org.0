Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89C6DE516
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDKTp6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 15:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDKTp0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 15:45:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA335449A
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:45:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a39f6e8caso221142266b.0
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681242308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16DK7JVkIBKk1X1RnBApJrHcGzylPyjEeubCA97lzVA=;
        b=bqo0K8x6PYNDLuglLAzdr8URi5f3vLumuQ8FRRpT9si/x+FYW/o4xDl/IUC58UVmZy
         egScxBPEI+AwN8OhsXRx008lIkZkd3FKrdGM5tm9EMADbkkCTAVW2D+Qf2kKu+pdyn9n
         ge3q8/enWjEFHkgxmycXsSRGo/VeoSI8lbccjXnvsG7SwSFics0UStpE9WouIFqiWCiu
         RrMWFNR9OgzftJFVO5Q8P9H4NtFvmJFRnL1pB0SLs3CcUr4fJoD+oPEuAN0GgqDf2oQe
         gIlYyP5I1mv07vyKiKE3T0a/ZsZYH8CVFUXydtkZZfLCybuPHklCeZ+lmp0BYPjMHAPx
         oSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681242308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16DK7JVkIBKk1X1RnBApJrHcGzylPyjEeubCA97lzVA=;
        b=j6SlpboFWTwEaW218kzl+0SSCa2U5KqfIRuRKrOOp/7cD0zmh7nr5ecQIRlx9vcxVg
         2oamTWHBp3T9sSIZgh7V0IcBO3YGyDTJHeA99fq0mwTgZ+X7H3sX3mg7YpCPu445hdv0
         9FJ/yldnZd1ZRuo0lBfFVugmM76BU5c2OFnDLlI/i5cZqZLGSBCKzHXKKTyh/6+DluJj
         COYG1H2k4IEj+bJ2asqsIOO8H3jml1TQhJjLdfRb99N+bGvmFomx8xHkGO9yg3SBUU8+
         8U7iTZpYqTA6agOKmwIheBd0rf/jNnKReQeIwnZzBrQtSsHvPQ8eCKssN6ZJrtON2j6l
         tkTQ==
X-Gm-Message-State: AAQBX9efwfxHtHzHEhICaUSPGJg1SH9Ff6ht6DNWr8J78zrWHhQq+5BR
        Cy0oEPvPQrHrHiyFZhKtndbqUXRLIU4HEN0pH1c=
X-Google-Smtp-Source: AKy350a6qPIedDe76S+SXxuTWn9C2oeOWwUieHap6qzAfoMbTcOAzs0i5Ia2U8POkmAGXxy1cfSmKg3D0EkmfLJ3T2I=
X-Received: by 2002:a50:d69c:0:b0:4bb:e549:a2ad with SMTP id
 r28-20020a50d69c000000b004bbe549a2admr5550761edi.4.1681242308080; Tue, 11 Apr
 2023 12:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com> <2760498e-23a6-f787-bac2-0460566a995d@gmail.com>
In-Reply-To: <2760498e-23a6-f787-bac2-0460566a995d@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Apr 2023 21:44:57 +0200
Message-ID: <CAFBinCAWs=FT1W+ckneOpZZnfSNZYODUhMNXUB+1MzKqKNjtVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pwm: meson: switch to using struct clk_parent_data
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Heiner,

On Tue, Apr 11, 2023 at 9:26=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> We'll use struct clk_parent_data for mux/div/gate initialization in the
> follow-up patches. As a first step switch the mux from using
> parent_names to clk_parent_data.
great, thanks!

[...]
> +               for (j =3D 0; j < meson->data->num_parents; j++) {
> +                       mux_parent_data[j].index =3D -1;
> +                       mux_parent_data[j].name =3D meson->data->parent_n=
ames[j];
> +               }
I think this can be moved outside the npwm loop because the clock
inputs are for the whole IP block, not per PWM channel
