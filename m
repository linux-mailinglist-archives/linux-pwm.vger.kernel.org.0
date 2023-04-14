Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD56E2131
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjDNKoP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjDNKoO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 06:44:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2820E3584
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 03:44:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so16961831wrb.9
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681469046; x=1684061046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1Mx0G1Wi3Wja8qB0WUph0r603HKwZrefEqAcTGE6Jo=;
        b=iX9Y4vtyU3Dor44fU8MPc9+r3GFr+5QmwwnvrDfsUY0eM+B27G0WQs8qlzd8NoLr/O
         ukeOOLxTycVwDGn1nwJ3HPkcnxh6ESSMMdL/Bq4FJ0crtkhLcfgngOcQcYUFsM38lEfO
         jN9eaRNgzC3YHauiXGYByWC/XHt9klV9jy1tVU4Wq+mREXlctDnbwn2MTq+T8FUx7duB
         BbeFiOqx16xrp8534R0v2GlS0KMwWJ/XULd5xyHaUElyLmBr9zyTgvjSVTbm1Ya0FGwl
         4ujLRaP55/tp5HuHQwuQdBVZ3bMP8+MgZhT1cOq1RJT0I2fAVGD7fn8KxnL/993f4FBv
         GgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469046; x=1684061046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1Mx0G1Wi3Wja8qB0WUph0r603HKwZrefEqAcTGE6Jo=;
        b=BYtlLKo8emRworXbr3MakhEj181Im0NHgUfW7WtPyzlkWAdxFkdVeF037iQFrGWwx8
         mu/oUqhzoWLW3J13pdLPm4RoLeBCcWiBWa6JXJh+d/67yZ/ZWGnjOvy+8duKe8lTTTf/
         JUCJIkw0ktIK2ueSoPscOt6V62SP6k0l3mC/n85bhCDKzLhxvPJ3/sEHGaZuyMpv5Ofu
         2yVHTIu9wO63mLQaHVUwfIiB+ORecGkOQ3LusbmeBiE+9ft9sy+8MaV/gs/I6XuQUNVx
         70JKXfcTTE84BXMyZgoZ/bqtNIqTxsDvhCN40m84r6NS4mC2rSZ+M7TmaLSpPcOWAHSl
         a4eg==
X-Gm-Message-State: AAQBX9fp2mJKNbT5/W/IQvjdA1oH0YcwDvZHqu6OKV0231bXSJP9Rt/y
        z+He4O6qoQhQWUtZMp74iIoLS5ga+Ac6Tve+w7s6Lpww
X-Google-Smtp-Source: AKy350ZdhUr2Cpv0QHQOKhb5hcKeT9l3GdwL9KHI+fokT6KZ9h2S4CQ6s52YrBj9GPrXlZ/eOQJer5A0SLN8ZhKSt5o=
X-Received: by 2002:a5d:4248:0:b0:2ce:ac97:6f51 with SMTP id
 s8-20020a5d4248000000b002ceac976f51mr927386wrr.13.1681469046398; Fri, 14 Apr
 2023 03:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230412115636.3533366-1-u.kleine-koenig@pengutronix.de>
 <ZDfLyP5bP0PdBS1J@orome> <ZDfMF3wAfbd-1y-Z@orome> <ZDfMtB_lakGPDsZZ@orome> <20230413113829.pm32b3mdnyu477gi@pengutronix.de>
In-Reply-To: <20230413113829.pm32b3mdnyu477gi@pengutronix.de>
From:   Thierry Reding <thierry.reding@gmail.com>
Date:   Fri, 14 Apr 2023 12:43:55 +0200
Message-ID: <CA+PwDYexBPsZYZ0-SVgOJMOHYUJTjq0Adu8xxm0vap3S_LYKLw@mail.gmail.com>
Subject: Re: [PATCH] pwm: Delete deprecated functions pwm_request() and pwm_free()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
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

On Thu, Apr 13, 2023 at 01:38:29PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Apr 13, 2023 at 11:34:44AM +0200, Thierry Reding wrote:
> > On Thu, Apr 13, 2023 at 11:32:07AM +0200, Thierry Reding wrote:
> > > On Thu, Apr 13, 2023 at 11:30:48AM +0200, Thierry Reding wrote:
> > > > On Wed, Apr 12, 2023 at 01:56:36PM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > Since commit 5a7fbe452ad9 ("backlight: pwm_bl: Drop support for l=
egacy PWM
> > > > > probing") the last user of pwm_request() and pwm_free() is gone. =
So remove
> > > > > these functions that were deprecated over 10 years ago in commit
> > > > > 8138d2ddbcca ("pwm: Add table-based lookup for static mappings").
> > > > >
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
.de>
> > > > > ---
> > > > >  Documentation/driver-api/pwm.rst | 13 ++++-----
> > > > >  drivers/pwm/core.c               | 49 --------------------------=
------
> > > > >  include/linux/pwm.h              | 13 ---------
> > > > >  3 files changed, 5 insertions(+), 70 deletions(-)
> > > >
> > > > There seem to be two more occurrences of pwm_free() in
> > > > drivers/pwm/core.c, but I think they can trivially be replaced by
> > > > pwm_put(). I can do that while applying, but let me know if you don=
't
> > > > agree.
> > >
> > > I also get warnings about pwm_to_device() now being unused, so I'll
> > > remove that one along with these.
> >
> > With pwm_to_device() gone, there's now also no purpose in the pwm_tree
> > radix tree, so let me try to drop that as well.
>
> Huh, it seems I was too sloppy here. Thanks for cleaning up after me.
> Feel free to grab authorship of your result, given that you seem to have
> done more than me now.

I've applied this now, thanks.

Thierry
