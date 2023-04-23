Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9486EC258
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Apr 2023 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjDWU62 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Apr 2023 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWU61 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 Apr 2023 16:58:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C88F7
        for <linux-pwm@vger.kernel.org>; Sun, 23 Apr 2023 13:58:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-956ff2399c9so598605166b.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Apr 2023 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682283505; x=1684875505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY5GmMnxqaIW+YsbqRgEPcpd7ww+Ak1Qib0SWHWH38U=;
        b=qjC5ZhUiwTYk+IzeiX0eotOTUeAuIyB5rrQd1lJfL7dGhD0BlpBXliVMYu5PGOGsUe
         TE++dICoxPlTTE/cdPkljxRLAM615ZqfbJT8fDbT4DzM/Nj1HDuzh6Vvnfh7ZW3kQscf
         RVDdGKy8kOXBPxr69sKomibLalXErGB1ePvh+t872Yv63tz5UItdEbEr1G6Yu4sRH0Y4
         JrjmugIk+7VRCEc84WmSHv2AF9prr3kSvTQulGyygHPlnB9uBz1H6Bueuv7iG1r2jnhS
         AnzlT+azFRG4idYjskLTSnuFK4SkGQZMDUsGCADfvGmdMlgpVMOj4IRmRIn6Plj3T9Yx
         hQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682283505; x=1684875505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY5GmMnxqaIW+YsbqRgEPcpd7ww+Ak1Qib0SWHWH38U=;
        b=GjQUyLqXvs3gt37KGRfB16z/LKElf9cJjMfl7mCy0TaSCtdtIMvROJzx6deM5LLu0u
         RUFr4XO4/R7dIjJ8klDx5CWJsG2tpJKDE5vUzo02kyT1WqRYYxKpylO32JZBw3K/gYwt
         ZrZTsLOLG2SZo7GpWQXtZP5VgobrkTYFaY1MWlK8rnGZaQkiHaKFxN/zrMvDSw7HsXUn
         0015KicshRM/SVhnlm1RT4ObuD5q5UE7LegiwFhcXemIsEuonoOTSr74mFin7ZyxSIsI
         S6ppdSgbIi5ApdyuFoFZy9WA6KEjNXdATOU5rRsk1ldQAk33MmA1GTwbNqWu+gkNvWP2
         mv3A==
X-Gm-Message-State: AAQBX9e0AnujpsnOijvft2BVG9dK8tBaYqg+oVXciCc5CRTXJRwwbVsh
        T0FHxFVDa5E5m3yjelcLO/OhN9nbjR7ulF9IMQO6XV6U
X-Google-Smtp-Source: AKy350ZsmjTPL0vzoiJJX7Vfs3uXUqDV4mDqCzlplxejwNy1QwSj4RRBsAguoR0i09W3HWLKB/9X1f3F6LwVdKFmdvw=
X-Received: by 2002:a17:906:1498:b0:94f:322d:909c with SMTP id
 x24-20020a170906149800b0094f322d909cmr8440339ejc.34.1682283504786; Sun, 23
 Apr 2023 13:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com> <ca531c1a-3c62-5fb1-6765-68ec1e541483@linaro.org>
 <73a52391-b380-e491-0e96-5c51c7be487c@gmail.com> <22b6f870-8dfd-c01b-a7cd-383a9d9ece20@linaro.org>
 <872b3270-8319-6b4d-9d52-1da0b58d4e19@gmail.com> <229e20ef-6e99-6d52-b0e6-a357a184b6af@linaro.org>
 <87f14a9d-f341-d694-f567-7f9e78666b5d@gmail.com>
In-Reply-To: <87f14a9d-f341-d694-f567-7f9e78666b5d@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 22:58:13 +0200
Message-ID: <CAFBinCAF4oc+FoG8CtQhpSHSAkODQFXGbt5OvtprGSb4s+fWqg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock framework
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     neil.armstrong@linaro.org, Jerome Brunet <jbrunet@baylibre.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 19, 2023 at 9:58=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
[...]
> > This is a hack based on current clock values, either explicitly support=
 a code path
> > where pre_div =3D 0 or if you can't do that with CCF implement the pinc=
trl way to handle this,
> > which is the cleanest.
> >
> To make it explicit we could request ULONG_MAX as rate instead of 1GHz, t=
his would imply
> choosing mux parent with highest rate and pre_div =3D 0. Up to you whethe=
r this would be
> acceptable.
I like the idea of using ULONG_MAX as I first had to think about why
you chose 1GHz in the driver.

> AFAICS pinctrl would need quite some DTS changes, and it's not my area of=
 expertise.
> So it would be open who can implement this.
My opinion is that this can be done in a separate patch. We need to
work on this whole thing anyways as you mentioned that newer SoCs
(from what I understand: G12A onwards) have a dedicated "constant
output" bit which will make the pinctrl solution unnecessary (at least
based on how I understand it).


Best regards,
Martin
