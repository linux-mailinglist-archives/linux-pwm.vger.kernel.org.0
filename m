Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115B06F2877
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjD3KgL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 06:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KgJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 06:36:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24729128;
        Sun, 30 Apr 2023 03:36:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef34e948b1so7131921cf.2;
        Sun, 30 Apr 2023 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682850966; x=1685442966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dNET8HOuj2PeP2UuTx2ymn4h6dDe9tSyzJY0ILEBHU=;
        b=Bi4iXNoFtUBn2He+lXem1Puh/N9vgT/rhaANNpPC5lD9wY3znMuA8ofWOVOjGVRIV1
         +5LRaFCJm0UD+g+zad1LIbG2o8NLBECsiieY+u8Ui+UQ4zA+oDtF9x2LO0KTmoNi2oE2
         ZhlYVHYeUQZB+lqErTdnNadOLD3nQ6zp27T8gQAoiDOI3pqDMfTQLiV+sfFa3bR3VDjL
         QGs2hycBRHoMjYynL+F3d/bBiFHhSDAoeDd6icywT/6oTGMBMHqLz8xrqPTXnssdbcon
         eks1Ky+rnk3zFVyOzhpQi4XqjDF1PXsBDGbLQqscYAAFevzB+s21JeK8VhjZxxbm/dfb
         dGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682850966; x=1685442966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dNET8HOuj2PeP2UuTx2ymn4h6dDe9tSyzJY0ILEBHU=;
        b=byZupe/fqtQZj9BnmJhwxZltltkT0T+XnMpCBJTeAarqMfiXh9VxYr5VnU7yq9QhHn
         99x/KSlVbCreYsxuPR8zwJT4mYnvBZXF9Sd8NckSNcyQ+pnxxMsQQjcUaE8JJ7+SJN3r
         8C1HRmB0ghia6BVVsUNDjPrFlC+u+VbS2DPqBRIeraWbjSq4EuD8TZQHCOP+CTQ1e3nF
         ewCYAUnFxeQnaO/Rj8NDIB8w2CkB+frL7KjyjJeRRtgDgUGQTutORagQvvsC5SMhIk1u
         R7SKnKBtStiA2x2phRp8nJX36GKO8UiMJ/Q4dBAiUgMxN+OcAmsZdibkclTAhRMOpPDj
         UMlg==
X-Gm-Message-State: AC+VfDzVuV3Qpvrw7PHangrYKtNBCL09Ml+w0s0gIqDoYSwFnYDQA0bD
        jRUyRnjt+XmZT0hZamsvHhv5s21/7ZWME/dn5hs=
X-Google-Smtp-Source: ACHHUZ7KjpaQf0kDmYz1VZ+fCi0gNcCz5+pLKf3jrW1ancJIoAvh+wt/cn/P8xHq2hRiMGxE2+jkvakpF4g/lOED+j0=
X-Received: by 2002:a05:622a:386:b0:3ea:6f96:1915 with SMTP id
 j6-20020a05622a038600b003ea6f961915mr16265620qtx.24.1682850966039; Sun, 30
 Apr 2023 03:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230429181551.98201-1-hdegoede@redhat.com> <20230429181551.98201-10-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-10-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Apr 2023 13:35:30 +0300
Message-ID: <CAHp75VeeOpycDsR2pRCDs4TEd7Ck3wWSLyFo=St6qQC+tbGaOQ@mail.gmail.com>
Subject: Re: [PATCH 09/19] platform/x86: lenovo-yogabook: Use PMIC LED driver
 for pen icon LED control
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
> Use the (new) PMIC LED driver for pen icon LED control instead of using
> custom WMI calls for this.
>
> This will also work on the Android version of the Lenovo Yoga Book 1,
> where there is no WMI interface for this.
>
> The dev_id of the lookup is set using dev_name() so that it will also
> work for both the Windows YB1 WMI-device as well as the Android YB1
> platform-device. While at it also move the gpio_lookup to using dev_name(=
)
> for the dev_id.
>
> Note this also removes the need to turn of the LED during suspend since
> the PMIC LED driver now already does that.

...

> +       led_add_lookup(&yogabook_pen_led);
> +       data->pen_led =3D devm_led_get(dev, "pen-icon-led");
> +       led_remove_lookup(&yogabook_pen_led);

Wondering if we should start at some point helpers like

devm_led_get_with_table() which will do the above.

P.S. All the same probably makes sense to (ACPI) GPIO, PWM, etc calls.

--=20
With Best Regards,
Andy Shevchenko
