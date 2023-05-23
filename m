Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBB70E6DC
	for <lists+linux-pwm@lfdr.de>; Tue, 23 May 2023 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbjEWUvr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 May 2023 16:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbjEWUvo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 May 2023 16:51:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13FE1A8
        for <linux-pwm@vger.kernel.org>; Tue, 23 May 2023 13:51:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so528205a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 23 May 2023 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684875095; x=1687467095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZundmrewKh0bipWQd+lfQPNPSXZ9mgJNRAPtylqIpw=;
        b=Q3pRVYpapK/e7nkypEKxw7JxlSQP3eSbJ445xrlrZJGJ3w9bRAq3t1exfcZ5OR6YPZ
         0ulvHLDuA2zQN3j5NET5X2a6ZsPORlKw2KCvHcNSAlV9OKKlrvBld2EkfgZvb1Mzwge7
         fBx7DQcXayW2SJf3ckI8mZ2Jd7+TIKnR/iCmlKR2aNbQUNpyc0PnYgfirqyAYT6sbtPo
         dCcLbe40SGEsfyEBjvwhZzBISyonGHDy4zSv6cSZ9lpm/dd325Fm1r8JNWgE6kFh0dek
         ZeMCZB0ZCXlbTEsCiNR+DdLdZi7DtXKB0pDaUhHYUGNrZF/m/Dmuain7jaUBRLR024z1
         jimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875095; x=1687467095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZundmrewKh0bipWQd+lfQPNPSXZ9mgJNRAPtylqIpw=;
        b=UQ70X/5+439xl4ofkLhiKG3rKpzwWOg9q1xYadn2vFGzOKi1HkUMXLmLGo4iw2BpH0
         7rlBqfq47Hzm68zPYSIzLhxqWpM//9qzmTprFA2V8FBMA4sRni3C7MXB6sUCP836+ks+
         lAWKFZNk6e3ND5Zvu7yu6tOTfJqZZ93lRWppiGtX5PVxGK3I3m8hWYiVsCFJqyvE/YTo
         NycewBNKlVEWFykPN/yC3cETtCm77sYyV6ske5FFlZWZ3bWuGVyqhw3BYGU20i05ok0f
         o/IKfhnvxAxJbGI1MHLAbvyUWbkVRQ/wPgFGPKpQKjqf+DD0QQdDDZ1aR0qYsWCrAudF
         zaVA==
X-Gm-Message-State: AC+VfDy2NONEJ4crCRSLaVNtOmgHL0VRn61NEPywKMzTSdn5QyBFhx7T
        beZPg7s41B9Rtt+viEysmXYxHhscA1chIg3g8k4=
X-Google-Smtp-Source: ACHHUZ7MG7hcNaLhcgRMHzstW10kI2Qf9okU+o4Y5CQ8cOzkKjjiuZsIfJnrE0pqRbZjOE/7UMDBvJEQ4SeZfGeFzVc=
X-Received: by 2002:a17:907:6288:b0:969:b2e2:4f3b with SMTP id
 nd8-20020a170907628800b00969b2e24f3bmr14435843ejc.51.1684875095098; Tue, 23
 May 2023 13:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <1d1a8ede-e789-bc4d-2dcd-9d06d2df4061@gmail.com>
 <CAFBinCCeh1eUo1=pfqmp4F7UsuKZ--cja-16mCqBhV-cgodzqw@mail.gmail.com> <f6b93fcc-ca5a-43ae-729d-38338ba411bc@gmail.com>
In-Reply-To: <f6b93fcc-ca5a-43ae-729d-38338ba411bc@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 23 May 2023 22:51:24 +0200
Message-ID: <CAFBinCDdDcFaekrdC33_cO_TngRhMTgqgpFR2ELjEcavd-8SyA@mail.gmail.com>
Subject: Re: [PATCH] pwm: pwm-meson: fix handling of period/duty if greater
 than UINT_MAX
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 15, 2023 at 10:32=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> On 08.05.2023 21:46, Martin Blumenstingl wrote:
> > On Wed, May 3, 2023 at 9:58=E2=80=AFPM Heiner Kallweit <hkallweit1@gmai=
l.com> wrote:
> >>
> >> state->period/duty are of type u64, and if their value is greater than
> >> UINT_MAX, then the cast to uint will cause problems. Fix this by
> >> changing the type of the respective local variables to u64.
> >>
> >> Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity interna=
lly")
> >> Cc: stable@vger.kernel.org
> >> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Not sure about the process in pwm subsystem: When will these patches make
> it to linux-next? Because I'd like to submit follow-ups with a dependency
> only after pending patches have been applied.
I'm also not sure. Personally I would take all patches that fix the
existing driver code, bundle them into a series and re-send that
(collecting all Reviewed-by, etc. along the way). The idea is to make
Thierry's life easier as he just has to apply the series (no need to
worry about the patch order, ...).
