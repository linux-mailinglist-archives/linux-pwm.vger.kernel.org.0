Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA86F823D
	for <lists+linux-pwm@lfdr.de>; Fri,  5 May 2023 13:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjEELoX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 May 2023 07:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjEELoV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 May 2023 07:44:21 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DB11607;
        Fri,  5 May 2023 04:44:20 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-61b60d0c5b8so7302176d6.0;
        Fri, 05 May 2023 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683287060; x=1685879060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+bbaqSd9YZw2df9CDJeO5CzvhDoNZKC+TExeyLVHVM=;
        b=k3TjWeeC26lLlQD3CO3t99E+HIyPX/SAl9VAL1Bjwr7RiL07G+JwnE/2EW5tCS6/k0
         OqmZ2yaxeCcZ3+vTkJ69gdDWnu+ey1wcOy+ssNik4pIL6s9EZQ54r3kSB0nplDYm6uvs
         ocNg1lh1vTW4tt/eQsI/+dIK7a0sBxpDbBXsB0UyWQnlABMAn1HrmuZBsgCMd4xVgIAO
         JuKHA2C2tPn/JnJKhAeLLV2Q95g7OLYmzW/QTQwctVHzv9EiXPj5sM0Ae+H4ESUm7eOp
         wPqhZ9lraEkI318CfZHgmvHykiUp3WB/FpwILXQMiotSKeYmmkDT4VHAJMU0sDNNoXS9
         fG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287060; x=1685879060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+bbaqSd9YZw2df9CDJeO5CzvhDoNZKC+TExeyLVHVM=;
        b=lDKPQuAExwjdjoFfRHif8qGRgXe+2/6mLNF8Y/zd16ExD7VYFvtHvTpPLRxLTWQIRJ
         jYvrSMTSlZxo2Efz6dFjrbYhd652VsxFpkE5B1Hkz//znCOAHwlIIH5NVkdjMk8WG9il
         OyqxCalbc376gGeMS7cGm5hz0Td6iWhse5d2VPBq6Q+vEzH05AA98OwfkU7whARr4gX1
         jw4/PEzyEa61OpqhT/HZE4PTae4RsiLT2SYQWAEVnTN/qWXSoRxQL2LaHCObOx2Uv5Zv
         ccz2bKFvVRLNgDM2/11FJoSVoua2ZGi9otZcuVYP63J9rM1bTOmVTOyXEUiMbUFts6YI
         GyZA==
X-Gm-Message-State: AC+VfDxfNqOBJexHTr/ZSvdBwdOC0eb1XpcrXqUIjU/7QbEkSlQg/nb4
        gdZvWCuLaO03c3WVvhCj/wBPhTIMzFmUI09kUkGVYkgVFQTbAsCu
X-Google-Smtp-Source: ACHHUZ6SHz84O73zKP9Yy6AHUeXGlZzm6X0nJSFvuDnVARhjK67UwKJwqrCAXy0Bs0su7Zm9qan0CNeUH5U5Vc905oA=
X-Received: by 2002:ad4:5cce:0:b0:5ed:d3d:405 with SMTP id iu14-20020ad45cce000000b005ed0d3d0405mr1487502qvb.34.1683287059877;
 Fri, 05 May 2023 04:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230430165807.472798-1-hdegoede@redhat.com> <20230430165807.472798-19-hdegoede@redhat.com>
 <20230504165307.tydqlk6sml7sp5qe@pengutronix.de> <CAHp75VdgFFk=q-=ZDiKwV02Tin19ZSmSS=fhwgRrE6v48s-u0w@mail.gmail.com>
 <20230505092111.qknupa2vooi7mqwl@pengutronix.de>
In-Reply-To: <20230505092111.qknupa2vooi7mqwl@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 May 2023 14:43:43 +0300
Message-ID: <CAHp75VcqY0+GWXriA8qzdjY-_zMO_9sAXYxR3nxEaajQfWX5Ag@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] platform/x86: lenovo-yogabook: Add keyboard
 backlight control to platform driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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

On Fri, May 5, 2023 at 12:21=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, May 05, 2023 at 12:07:02PM +0300, Andy Shevchenko wrote:
> > On Thu, May 4, 2023 at 7:53=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Sun, Apr 30, 2023 at 06:58:06PM +0200, Hans de Goede wrote:

...

> > > I don't know much about x86, but I think the table belongs to where t=
his
> > > "80862289:00" device is created.
> >
> > Just for your information, it's in drivers/acpi/acpi_lpss.c.
>
> Compared to drivers/platform/x86/lenovo-yogabook-wmi.c this file is
> never compiled as a module and so patch #1 would become unnecessary.
>
> That file also already has a pwm_lookup table.

TBH, Hans knows nowadays much better what those drivers do and why the
split was done this way. If he thinks that it's needed, I will trust
his word.

--=20
With Best Regards,
Andy Shevchenko
