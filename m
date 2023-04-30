Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8286F287F
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjD3KpS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KpR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 06:45:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6551BFF;
        Sun, 30 Apr 2023 03:45:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ef3ce7085bso7004661cf.2;
        Sun, 30 Apr 2023 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682851516; x=1685443516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJJEke1W76o+rYzj7Dd75GKzdp2VshGKb5uPKlFtgQ8=;
        b=GVRrIx5Z9bAgabQ/RJkW2jae6N62bK7dy+cQDFkbvcN81+r5v9vzfr20fgvTbVtlk7
         1k6rV2bDnoUbMt+I4RSpYgpuBIiPgN6dufrf79+zg355Wl3ZJyaT/JI/sic6jrmV6xoy
         9q9rZbOQv1cIv2aX/UlQEc38uRjpOU1cN1hVaYvfE1tkDTs9KybfVeuaVUckDzs630Qb
         BBoeqnjTuDqQ83YPu7T2odikR0OIzsVU8mDWcmUry2VLsu4CStl3R1zoShbbpeiL2okr
         Aq2sUVvr6+FERyUII6+juEjA7mBVoFzTxbkIjXY8BL6ZPlVta3lav/8vjA+5dmhwAyqM
         vXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682851516; x=1685443516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJJEke1W76o+rYzj7Dd75GKzdp2VshGKb5uPKlFtgQ8=;
        b=Hlq0SDQXU2mQ8fskz6spjQQhxHwlmwN8aV70+NZOFHa+gK8l+lYS78bPhAla+9xjnx
         tvbVoDV1ta9wvWBLUJtxCs06Z5OFpoiZf5+gbYR4MEcnwcVC2aZwtJaAF74MF87xVQe/
         +veaZSbP59LNCOL59RVIFcpnvZyx7IEIA2tQ8240/L6qeb/1ocrptCoW+e5N22f8y/iJ
         AQAuBqfWA1bRyKBLMxcBHaYUCgxz2oPprxbUvcZIMTTd+UOgReEwTG7NzHF643QKRJRv
         3LzzF+u53nzxp4GcOWDntUFMTa43QW+jBCsO1lcIgbiJqGhujePGP1Q3vHovzH4sgCQi
         pcZA==
X-Gm-Message-State: AC+VfDyRzsX60k0kJTjU+IRRfZs8M/rR/VSMGygAz5RBUfWaND8dXI3G
        szEhocleyrUna/MpeZP/XHyNk2JtWBH9HDh2Abg=
X-Google-Smtp-Source: ACHHUZ6QhNXpSsLdn7eQ6W7Iu0+ng3IacxjOJhLNMSJ9mYPfsK6ghoLJVqQFavWfuQRe6R+6KBrWD+S89zNzijI5aHw=
X-Received: by 2002:a05:622a:4d3:b0:3e9:aa91:3627 with SMTP id
 q19-20020a05622a04d300b003e9aa913627mr17022466qtx.65.1682851515798; Sun, 30
 Apr 2023 03:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230429181551.98201-1-hdegoede@redhat.com> <20230429181551.98201-15-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-15-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Apr 2023 13:44:39 +0300
Message-ID: <CAHp75VckABp6ZJ9Rg8VVYrao6io3oPkk=vbONcQvESdK4ksi0w@mail.gmail.com>
Subject: Re: [PATCH 14/19] platform/x86: lenovo-yogabook: Drop _wmi_ from
 remaining generic symbols
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
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

On Sat, Apr 29, 2023 at 9:16=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Change the yogabook_wmi_ prefix of remaining generic (non WMI specific)
> symbols to yogabook_ .
>
> This is a preparation patch for making lenovo-yogabook-wmi also work
> on the Android version of the Yoga Book 1 which does not have a WMI
> interface to deal with toggling the keyboard half between
> touch-keyboard and wacom-digitizer mode.

...

> -       struct yogabook_wmi *data =3D
> -               container_of(cdev, struct yogabook_wmi, kbd_bl_led);
> +       struct yogabook_data *data =3D
> +               container_of(cdev, struct yogabook_data, kbd_bl_led);

...

> -       struct yogabook_wmi *data =3D
> -               container_of(cdev, struct yogabook_wmi, kbd_bl_led);
> +       struct yogabook_data *data =3D
> +               container_of(cdev, struct yogabook_data, kbd_bl_led);

Perhaps a helper as many other drivers do?

#define ... container_of()

or even static inline. Also consider constification of the data passed
here and there (if it makes sense).

--=20
With Best Regards,
Andy Shevchenko
