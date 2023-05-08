Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2E6FB7B5
	for <lists+linux-pwm@lfdr.de>; Mon,  8 May 2023 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjEHTtW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 May 2023 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjEHTtD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 May 2023 15:49:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634A8A6A
        for <linux-pwm@vger.kernel.org>; Mon,  8 May 2023 12:47:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-956ff2399c9so939715466b.3
        for <linux-pwm@vger.kernel.org>; Mon, 08 May 2023 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683575180; x=1686167180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NtJxceVAbEagHvQtUU9/qw+tYoFv4N/txoDVssCgCY=;
        b=PxHUOLMaMdGfRYeHzqC2wYDoWjXRpm1f2e+OpkGY/IVYOpni6P2/+XRHr1Oa8NpucF
         Fmbu8D+5W8p89HBU0s1l1XPv9Uya20spJPnsjK+4om0CYUMz6RRgw5KGEohWu9qxL9Td
         RzX/iu64/mt66fBU04jb4L4cFRpU+6l49tkaGmzBkko43m4HIm1Ef1dxPRl8oYkSDIX+
         t77D80MJHGyKKF4MzDlBGeJfUhR3mAyuKAtPIIRF8ZFEPT00KPOAQ4wXszfxU/LZhrwz
         S94xOhZvrR979cWDFePjBVOcChyiU00KzYIDteXTC3no2sv4U1wALe6WutizM7PL8ZjB
         WfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575180; x=1686167180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NtJxceVAbEagHvQtUU9/qw+tYoFv4N/txoDVssCgCY=;
        b=hL5Be9lzlMXLUg93UOONJI7LP0qXrrgn2EDr+zHyDLMzF29XRgSrmLrvbljc64ZvKL
         JMQH6ZbaQ8I2nhcWLRXQniwnW03lkCizgfBytz9NtQB6SrvybOYbtt0HbMgQnlglO2T5
         N7dMo6XuJfOzyTiwJSqbPJB9M+sXjY8z0zUR66jInD0dCcVJEBkyOTzO8m7+rn2dFwTR
         vsiBwRdjwx85LTXdDUXjbmrclLOgL/2XDGYPY7OEpTIDOMZkOUfPXcrAgaANbkmU7L7Q
         zbPDjtw1DkVaucplMrzydsuh9Wb6Ego04nH0xKioEaWEDMtPqtiBo7OxIWvNkvBu3ziV
         sUpg==
X-Gm-Message-State: AC+VfDxK0nqA7ElfcXK1GCP5epfIv8YcO4WJ+MjuYbV0E2hGYuzypu9S
        qiHyV7ASF3AiSSccHvhGLdDPt7uwXpzJGOt12Bo=
X-Google-Smtp-Source: ACHHUZ6yOwrYoQ+snTUAwTEeCmMFhkQc3bfTdJ4HXRbhf28HnR2TFi3FxXit9EFwPnHMgLuEh4FYTajknvxnLZaFpzo=
X-Received: by 2002:a17:907:2cc5:b0:92b:69cd:34c7 with SMTP id
 hg5-20020a1709072cc500b0092b69cd34c7mr9808555ejc.40.1683575179927; Mon, 08
 May 2023 12:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <1d1a8ede-e789-bc4d-2dcd-9d06d2df4061@gmail.com>
In-Reply-To: <1d1a8ede-e789-bc4d-2dcd-9d06d2df4061@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 8 May 2023 21:46:09 +0200
Message-ID: <CAFBinCCeh1eUo1=pfqmp4F7UsuKZ--cja-16mCqBhV-cgodzqw@mail.gmail.com>
Subject: Re: [PATCH] pwm: pwm-meson: fix handling of period/duty if greater
 than UINT_MAX
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 3, 2023 at 9:58=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> state->period/duty are of type u64, and if their value is greater than
> UINT_MAX, then the cast to uint will cause problems. Fix this by
> changing the type of the respective local variables to u64.
>
> Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally=
")
> Cc: stable@vger.kernel.org
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
